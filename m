From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] GIT: Try all addresses for given remote name
Date: Fri, 22 Jul 2005 22:36:13 -0700
Message-ID: <7v4qam5bjm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, <yoshfuji@linux-ipv6.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 07:36:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwCgS-0003me-W8
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 07:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVGWFgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 01:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVGWFgQ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 01:36:16 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:65492 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261526AbVGWFgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 01:36:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723053612.CZIH1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 01:36:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Date: 1121951436 -0400

Try all addresses for given remote name until it succeeds.
Also supports IPv6.

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
*** Linus, I am not ACKing Hideaki's other change on the
*** daemon.c side at this moment; Pasky raised two good points
*** and I expect Hideaki will resubmit (either modified or as
*** is).

 connect.c |   71 +++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 43 insertions(+), 28 deletions(-)

42210dd815647c3d4b71142a8a43de5a009485b2
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
-		die("unable to create socket (%s)", strerror(errno));
-	if (connect(sockfd, (void *)&addr, sizeof(addr)) < 0)
-		die("unable to connect (%s)", strerror(errno));
+		die("unable to connect a socket (%s)", strerror(errno));
+
 	fd[0] = sockfd;
 	fd[1] = sockfd;
 	packet_write(sockfd, "%s %s\n", prog, path);
