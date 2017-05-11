FROM ubuntu:xenial

#Update the image with essentials
RUN apt-get update && apt-get install -y build-essential

#Install Curl and Git
RUN apt-get install -y git curl

#Get the latest Docker Version
RUN COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`

#Install Docker
RUN curl -sSL https://get.docker.com/ | bash && \
    apt-get install -y docker-engine && \
    usermod -aG docker root

#Install Docker-Machine
RUN curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && \
    chmod +x /tmp/docker-machine && \
    cp /tmp/docker-machine /usr/local/bin/docker-machine

#Install Docker-Compose
RUN COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1` && \
    sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose" && \
    chmod +x /usr/local/bin/docker-compose && \
    sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

#Install docker-cleanup
RUN cd /tmp && \
    git clone https://gist.github.com/76b450a0c986e576e98b.git && \
    cd 76b450a0c986e576e98b && \
    mv docker-cleanup /usr/local/bin/docker-cleanup && \
    chmod +x /usr/local/bin/docker-cleanup
