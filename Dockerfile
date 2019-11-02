FROM alpine:20190925

LABEL MAINTAINER="shikong <wudimenghuan@gmail.com>"

ENV GLIBC_VERSION=2.30-r0

RUN apk update && \
	apk --no-cache add wget libstdc++ tzdata && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	echo 'Asia/Shanghai' >  /etc/timezone && \
	wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
	wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk && \
	wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk && \
 	apk --no-cache add glibc-${GLIBC_VERSION}.apk && \
	apk --no-cache add glibc-bin-${GLIBC_VERSION}.apk && \
	mkdir -p /tmp && \
	mkdir -p /rrshare && \
	mkdir -p /opt/work/store && \
	wget -q http://appdown.rrys.tv/rrshareweb_centos7.tar.gz -O /tmp/rrshareweb_centos7.tar.gz && \
	tar -zxvf /tmp/rrshareweb_centos7.tar.gz -C /rrshare/ && \
	rm -rf /tmp/rrshareweb_centos7.tar.gz && \
	apk del wget tzdata && \
	rm -rf /glibc-${GLIBC_VERSION}.apk && \
	rm -rf /glibc-bin-${GLIBC_VERSION}.apk

WORKDIR /
VOLUME ["/opt/work/store"]
EXPOSE 3001 6714 30210

CMD ["sh", "-c", "/rrshare/rrshareweb/rrshareweb"]
