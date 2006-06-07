From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Refactor git_tcp_connect() functions a little.
Date: Tue, 06 Jun 2006 22:58:41 -0500
Message-ID: <E1FnpBp-00043u-Uc@jdl.com>
X-From: git-owner@vger.kernel.org Wed Jun 07 05:58:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnpBv-0004fW-MV
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 05:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWFGD6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 23:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWFGD6o
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 23:58:44 -0400
Received: from colo.jdl.com ([66.118.10.122]:43659 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750808AbWFGD6o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 23:58:44 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FnpBp-00043u-Uc
	for git@vger.kernel.org; Tue, 06 Jun 2006 22:58:43 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21427>

Add client side sending of "\0host=%s\0" extended
arg for git native protocol, backwards compatibly.

Signed-off-by: Jon Loeliger <jdl@jdl.com>
---
 connect.c |   42 ++++++++++++++++++++++++++++++++----------
 1 files changed, 32 insertions(+), 10 deletions(-)

I've tested this against an "old" daemon, and my new daemon
running on jdl.com that understands the new host=%s parameter.
Both appear to work still.

However, I don't have a setup to test a proxy connection,
and I left FIXME: down there asking the question if it is
even needed in this case as well.  I _think_ so, but I am
just not sure.  (It should be a straight pass-through to
another git: native protocol, right?)

And if it is needed there too, do you want to refactor
these two packet_writes() for commonality again?


diff --git a/connect.c b/connect.c
index 54f7bf7..3fa890d 100644
--- a/connect.c
+++ b/connect.c
@@ -322,7 +322,10 @@ #define STR(s)	STR_(s)
 
 #ifndef NO_IPV6
 
-static int git_tcp_connect(int fd[2], const char *prog, char *host, char *path)
+/*
+ * Returns a connected socket() fd, or else die()s.
+ */
+static int git_tcp_connect_sock(char *host)
 {
 	int sockfd = -1;
 	char *colon, *end;
@@ -356,7 +359,8 @@ static int git_tcp_connect(int fd[2], co
 		die("Unable to look up %s (%s)", host, gai_strerror(gai));
 
 	for (ai0 = ai; ai; ai = ai->ai_next) {
-		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
+		sockfd = socket(ai->ai_family,
+				ai->ai_socktype, ai->ai_protocol);
 		if (sockfd < 0)
 			continue;
 		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
@@ -372,15 +376,15 @@ static int git_tcp_connect(int fd[2], co
 	if (sockfd < 0)
 		die("unable to connect a socket (%s)", strerror(errno));
 
-	fd[0] = sockfd;
-	fd[1] = sockfd;
-	packet_write(sockfd, "%s %s\n", prog, path);
-	return 0;
+	return sockfd;
 }
 
 #else /* NO_IPV6 */
 
-static int git_tcp_connect(int fd[2], const char *prog, char *host, char *path)
+/*
+ * Returns a connected socket() fd, or else die()s.
+ */
+static int git_tcp_connect_sock(char *host)
 {
 	int sockfd = -1;
 	char *colon, *end;
@@ -407,7 +411,6 @@ static int git_tcp_connect(int fd[2], co
 		port = colon + 1;
 	}
 
-
 	he = gethostbyname(host);
 	if (!he)
 		die("Unable to look up %s (%s)", host, hstrerror(h_errno));
@@ -441,13 +444,29 @@ static int git_tcp_connect(int fd[2], co
 	if (sockfd < 0)
 		die("unable to connect a socket (%s)", strerror(errno));
 
+	return sockfd;
+}
+
+#endif /* NO_IPV6 */
+
+
+static int git_tcp_connect(int fd[2],
+			   const char *prog, char *host, char *path)
+{
+	int sockfd = git_tcp_connect_sock(host);
+
 	fd[0] = sockfd;
 	fd[1] = sockfd;
-	packet_write(sockfd, "%s %s\n", prog, path);
+
+	/*
+	 * Separate original protocol components prog and path
+	 * from extended components with a NUL byte.
+	 */
+	packet_write(sockfd, "%s %s%chost=%s%c", prog, path, 0, host, 0);
+
 	return 0;
 }
 
-#endif /* NO_IPV6 */
 
 static char *git_proxy_command = NULL;
 static const char *rhost_name = NULL;
@@ -551,7 +570,10 @@ static int git_proxy_connect(int fd[2], 
 	fd[1] = pipefd[1][1];
 	close(pipefd[0][1]);
 	close(pipefd[1][0]);
+
+	/* FIXME: Does this need %chost=%s%c tacked on here too? */
 	packet_write(fd[1], "%s %s\n", prog, path);
+
 	return pid;
 }
 
-- 
1.4.0.rc1.ga6a5-dirty
