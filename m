From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH 2/2] GIT: Listen on IPv6 as well, if available.
Date: Thu, 21 Jul 2005 09:10:49 -0400 (EDT)
Organization: USAGI/WIDE Project
Message-ID: <20050721.091049.46807257.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: yoshfuji@wide.ad.jp
X-From: git-owner@vger.kernel.org Thu Jul 21 15:11:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dvaoi-0005dG-RQ
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 15:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVGUNKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 09:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVGUNKE
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 09:10:04 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:29188 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261778AbVGUNKC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2005 09:10:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 7E22F33D27; Thu, 21 Jul 2005 22:10:50 +0900 (JST)
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

Listen on IPv6 as well, if available.

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -3,8 +3,8 @@
 #include <signal.h>
 #include <sys/wait.h>
 #include <sys/socket.h>
+#include <netdb.h>
 #include <netinet/in.h>
-#include <arpa/inet.h>
 
 static const char daemon_usage[] = "git-daemon [--inetd | --port=n]";
 
@@ -79,15 +79,15 @@ static unsigned int children_deleted = 0
 
 struct child {
 	pid_t pid;
-	int addrlen;
-	struct sockaddr_in address;
+	socklen_t addrlen;
+	struct sockaddr_storage address;
 } live_child[MAX_CHILDREN];
 
-static void add_child(int idx, pid_t pid, struct sockaddr_in *addr, int addrlen)
+static void add_child(int idx, pid_t pid, struct sockaddr *addr, socklen_t addrlen)
 {
 	live_child[idx].pid = pid;
 	live_child[idx].addrlen = addrlen;
-	live_child[idx].address = *addr;
+	memcpy(&live_child[idx].address, addr, addrlen);
 }
 
 /*
@@ -177,7 +177,7 @@ static void check_max_connections(void)
 	}
 }
 
-static void handle(int incoming, struct sockaddr_in *addr, int addrlen)
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	pid_t pid = fork();
 
@@ -219,37 +219,102 @@ static void child_handler(int signo)
 
 static int serve(int port)
 {
-	int sockfd;
-	struct sockaddr_in addr;
+	struct addrinfo hints, *ai0, *ai;
+	int gai;
+	int socknum = 0, *socklist = NULL;
+	int maxfd = -1;
+	fd_set fds_init, fds;
+	char pbuf[NI_MAXSERV];
 
 	signal(SIGCHLD, child_handler);
-	sockfd = socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
-	if (sockfd < 0)
-		die("unable to open socket (%s)", strerror(errno));
-	memset(&addr, 0, sizeof(addr));
-	addr.sin_port = htons(port);
-	addr.sin_family = AF_INET;
-	if (bind(sockfd, (void *)&addr, sizeof(addr)) < 0)
-		die("unable to bind to port %d (%s)", port, strerror(errno));
-	if (listen(sockfd, 5) < 0)
-		die("unable to listen to port %d (%s)", port, strerror(errno));
+
+	sprintf(pbuf, "%d", port);
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_family = AF_UNSPEC;
+	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_protocol = IPPROTO_TCP;
+	hints.ai_flags = AI_PASSIVE;
+
+	gai = getaddrinfo(NULL, pbuf, &hints, &ai0);
+	if (gai)
+		die("getaddrinfo() failed: %s\n", gai_strerror(gai));
+
+	FD_ZERO(&fds_init);
+
+	for (ai = ai0; ai; ai = ai->ai_next) {
+		int sockfd;
+		int *newlist;
+#ifdef IPV6_V6ONLY
+		int on = 1;
+#endif
+		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
+		if (sockfd < 0)
+			continue;
+
+#ifdef IPV6_V6ONLY
+		if (ai->ai_family == AF_INET6) {
+			setsockopt(sockfd, IPPROTO_IPV6, IPV6_V6ONLY,
+				   &on, sizeof(on));
+			/* Note: error is not fatal */
+		}
+#endif
+
+		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
+			close(sockfd);
+			continue;	/* not fatal */
+		}
+		if (listen(sockfd, 5) < 0) {
+			close(sockfd);
+			continue;	/* not fatal */
+		}
+
+		newlist = realloc(socklist, sizeof(int) * (socknum + 1));
+		if (!newlist)
+			die("memory allocation failed: %s", strerror(errno));
+
+		socklist = newlist;
+		socklist[socknum++] = sockfd;
+
+		FD_SET(sockfd, &fds_init);
+		if (maxfd < sockfd)
+			maxfd = sockfd;
+	}
+
+	freeaddrinfo(ai0);
+
+	if (socknum == 0)
+		die("unable to allocate any listen sockets on port %u", port);
 
 	for (;;) {
-		struct sockaddr_in in;
-		socklen_t addrlen = sizeof(in);
-		int incoming = accept(sockfd, (void *)&in, &addrlen);
-
-		if (incoming < 0) {
-			switch (errno) {
-			case EAGAIN:
-			case EINTR:
-			case ECONNABORTED:
-				continue;
-			default:
-				die("accept returned %s", strerror(errno));
+		struct sockaddr_storage ss;
+		socklen_t sslen = sizeof(ss);
+
+		int i;
+		fds = fds_init;
+		
+		if (select(maxfd + 1, &fds, NULL, NULL, NULL) == -1) {
+			/* warning? */
+			continue;
+		}
+
+		for (i = 0; i < socknum; i++) {
+			int sockfd = socklist[i];
+
+			if (FD_ISSET(sockfd, &fds)) {
+				int incoming = accept(sockfd, (struct sockaddr *)&ss, &sslen);
+				if (incoming < 0) {
+					switch (errno) {
+					case EAGAIN:
+					case EINTR:
+					case ECONNABORTED:
+						continue;
+					default:
+						die("accept returned %s", strerror(errno));
+					}
+				}
+				handle(incoming, (struct sockaddr *)&ss, sslen);
 			}
 		}
-		handle(incoming, &in, addrlen);
 	}
 }
 

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
