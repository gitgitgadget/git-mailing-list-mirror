From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: [PATCH] add inetd mode to git daemon
Date: Thu, 14 Jul 2005 11:31:33 +0400
Message-ID: <20050714075726.9004.qmail@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, snake@penza-gsm.ru
X-From: git-owner@vger.kernel.org Thu Jul 14 09:59:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsybg-0000t6-5H
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 09:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVGNH56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 03:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbVGNH56
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 03:57:58 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:6092 "HELO
	penza-gsm.ru") by vger.kernel.org with SMTP id S262952AbVGNH5o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 03:57:44 -0400
Received: (qmail 9032 invoked by uid 1000); 14 Jul 2005 07:57:43 -0000
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Adds --inetd command line argument that makes server run in inetd mode.

Signed-off-by: Alexey Nezhdanov <snake@penza-gsm.ru>
---

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -3,7 +3,7 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 
-static const char daemon_usage[] = "git-daemon [--port=n]";
+static const char daemon_usage[] = "git-daemon [--inetd | --port=n]";
 
 static int upload(char *dir, int dirlen)
 {
@@ -37,11 +37,21 @@ static int execute(char *line, int len)
 	return -1;
 }
 
-static void handle(int incoming, struct sockaddr_in *addr, int addrlen)
+static int handle_stdio()
 {
 	static char line[1000];
 	int len;
 
+	len = packet_read_line(0, line, sizeof(line));
+
+	if (len && line[len-1] == '\n')
+		line[--len] = 0;
+
+	return execute(line, len);
+}
+
+static void handle(int incoming, struct sockaddr_in *addr, int addrlen)
+{
 	if (fork()) {
 		close(incoming);
 		return;
@@ -50,12 +60,8 @@ static void handle(int incoming, struct 
 	dup2(incoming, 0);
 	dup2(incoming, 1);
 	close(incoming);
-	len = packet_read_line(0, line, sizeof(line));
-
-	if (len && line[len-1] == '\n')
-		line[--len] = 0;
 
-	exit(execute(line, len));
+	exit(handle_stdio());
 }
 
 static int serve(int port)
@@ -97,6 +103,7 @@ int main(int argc, char **argv)
 {
 	int port = DEFAULT_GIT_PORT;
 	int i;
+	int inetd_mode = 0;
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -110,8 +117,17 @@ int main(int argc, char **argv)
 				continue;
 			}
 		}
+
+		if (!strncmp(arg, "--inetd", 7)) {
+			inetd_mode = 1;
+			continue;
+		}
+
 		usage(daemon_usage);
 	}
 
-	return serve(port);
+	if (inetd_mode)
+		return handle_stdio();
+	else
+		return serve(port);
 }
