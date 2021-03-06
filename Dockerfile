# This Dockerfile is used to build an image containing Minecraft Tekkit
FROM openjdk:8u171-jre-alpine
LABEL maintainer "three52"

RUN apk add --no-cache -U \
          openssl \
          imagemagick \
          lsof \
          su-exec \
          shadow \
          bash \
          curl iputils wget \
          git \
          jq \
          mysql-client \
          python python-dev py2-pip
          
# Add user minecraft
RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 777 /data /mods /config /plugins \
  && chown minecraft:minecraft /data /config /mods /plugins /home/minecraft

#Download Tekkit Legends
RUN wget -O /tmp/tekkit.zip http://servers.technicpack.net/Technic/servers/tekkitmain/Tekkit_Server_v1.2.9g.zip
RUN unzip /tmp/tekkit.zip -d /data
RUN chmod +x /data/launch.sh

VOLUME ["/data"]
EXPOSE 25565

WORKDIR /data
ENTRYPOINT ["/bin/sh","/data/launch.sh"]
