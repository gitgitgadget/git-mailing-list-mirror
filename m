From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH 1/2] GIT: Try all addresses for given remote name
Date: Thu, 21 Jul 2005 09:10:36 -0400 (EDT)
Organization: USAGI/WIDE Project
Message-ID: <20050721.091036.01119516.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Thu Jul 21 15:10:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvaoO-0005X8-DE
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 15:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVGUNJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 09:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVGUNJu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 09:09:50 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:28164 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261769AbVGUNJt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2005 09:09:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 5888B33D27; Thu, 21 Jul 2005 22:10:37 +0900 (JST)
To: git@vger.kernel.org
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello.

Try all addresses for given remote name until it succeeds.
Also supports IPv6.

Signed-of-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

diff --git a/connect.c b/connect.c
--- a/connect.c
+++ b/connect.c
@@ -96,42 +96,57 @@ static enum protocol get_protocol(const 
 	die("I don't handle protocol '%s'", name);
 }
 
-static void lookup_host(const char *host, struct sockaddr *in)
-{
-	struct addrinfo *res;
-	int ret;
-
-	ret = getaddrinfo(host, NULL, NULL, &res);
-	if (ret)
-		die("Unable to look up %s (%s)", host, gai_strerror(ret));
-	*in = *res->ai_addr;
-	freeaddrinfo(res);
-}
+#define STR_(s)	# s
+#define STR(s)	STR_(s)
 
 static int git_tcp_connect(int fd[2], const char *prog, char *host, char *path)
 {
-	struct sockaddr addr;
-	int port = DEFAULT_GIT_PORT, sockfd;
-	char *colon;
-
-	colon = strchr(host, ':');
-	if (colon) {
-		char *end;
-		unsigned long n = strtoul(colon+1, &end, 0);
-		if (colon[1] && !*end) {
-			*colon = 0;
-			port = n;
+	int sockfd = -1;
+	char *colon, *end;
+	char *port = STR(DEFAULT_GIT_PORT);
+	struct addrinfo hints, *ai0, *ai;
+	int gai;
+
+	if (host[0] == '[') {
+		end = strchr(host + 1, ']');
+		if (end) {
+			*end = 0;
+			end++;
+			host++;
+		} else
+			end = host;
+	} else
+		end = host;
+	colon = strchr(end, ':');
+
+	if (colon)
+		port = colon + 1;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_protocol = IPPROTO_TCP;
+
+	gai = getaddrinfo(host, port, &hints, &ai);
+	if (gai)
+		die("Unable to look up %s (%s)", host, gai_strerror(gai));
+
+	for (ai0 = ai; ai; ai = ai->ai_next) {
+		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
+		if (sockfd < 0)
+			continue;
+		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
+			close(sockfd);
+			sockfd = -1;
+			continue;
 		}
+		break;
 	}
 
-	lookup_host(host, &addr);
-	((struct sockaddr_in *)&addr)->sin_port = htons(port);
+	freeaddrinfo(ai0);
 
-	sockfd = socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
 	if (sockfd < 0)
 		die("unable to create socket (%s)", strerror(errno));
-	if (connect(sockfd, (void *)&addr, sizeof(addr)) < 0)
-		die("unable to connect (%s)", strerror(errno));
+
 	fd[0] = sockfd;
 	fd[1] = sockfd;
 	packet_write(sockfd, "%s %s\n", prog, path);

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
