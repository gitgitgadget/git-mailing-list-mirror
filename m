From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 4/6] connect: pass separate host and port to git_tcp_connect and git_proxy_connect
Date: Sun,  1 May 2016 15:02:51 +0900
Message-ID: <1462082573-17992-5-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 08:03:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awkTT-00082c-GF
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 08:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbcEAGDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 02:03:06 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33606 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbcEAGDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 02:03:00 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1awkT0-0004h6-0y; Sun, 01 May 2016 15:02:54 +0900
X-Mailer: git-send-email 2.8.1.16.g58dac65.dirty
In-Reply-To: <1462082573-17992-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293141>

Instead of having each of them (and their callees) take a host:port
string and call get_host_and_port on it on their own, rely on the
get_host_and_port that already happens in git_connect and pass down
the separate host and port strings we got out of it.

Note that in git_tcp_connect_sock, the port was set to "<none>" in a
case that never can happen, so that code path was removed.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/connect.c b/connect.c
index 1c8ed6b..b3fce84 100644
--- a/connect.c
+++ b/connect.c
@@ -343,18 +343,16 @@ static const char *ai_name(const struct addrinfo *ai)
 /*
  * Returns a connected socket() fd, or else die()s.
  */
-static int git_tcp_connect_sock(char *host, int flags)
+static int git_tcp_connect_sock(const char *host, const char *port, int flags)
 {
 	struct strbuf error_message = STRBUF_INIT;
 	int sockfd = -1;
-	const char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
 	int cnt = 0;
 
-	get_host_and_port(&host, &port);
-	if (!*port)
-		port = "<none>";
+	if (!port)
+		port = STR(DEFAULT_GIT_PORT);
 
 	memset(&hints, 0, sizeof(hints));
 	if (flags & CONNECT_IPV4)
@@ -411,11 +409,10 @@ static int git_tcp_connect_sock(char *host, int flags)
 /*
  * Returns a connected socket() fd, or else die()s.
  */
-static int git_tcp_connect_sock(char *host, int flags)
+static int git_tcp_connect_sock(const char *host, const char *port, int flags)
 {
 	struct strbuf error_message = STRBUF_INIT;
 	int sockfd = -1;
-	const char *port = STR(DEFAULT_GIT_PORT);
 	char *ep;
 	struct hostent *he;
 	struct sockaddr_in sa;
@@ -423,7 +420,8 @@ static int git_tcp_connect_sock(char *host, int flags)
 	unsigned int nport;
 	int cnt;
 
-	get_host_and_port(&host, &port);
+	if (!port)
+		port = STR(DEFAULT_GIT_PORT);
 
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "Looking up %s ... ", host);
@@ -482,9 +480,10 @@ static int git_tcp_connect_sock(char *host, int flags)
 #endif /* NO_IPV6 */
 
 
-static void git_tcp_connect(int fd[2], char *host, int flags)
+static void git_tcp_connect(int fd[2], const char *host, const char *port,
+			    int flags)
 {
-	int sockfd = git_tcp_connect_sock(host, flags);
+	int sockfd = git_tcp_connect_sock(host, port, flags);
 
 	fd[0] = sockfd;
 	fd[1] = dup(sockfd);
@@ -550,18 +549,16 @@ static int git_use_proxy(const char *host)
 	return (git_proxy_command && *git_proxy_command);
 }
 
-static struct child_process *git_proxy_connect(int fd[2], char *host)
+static struct child_process *git_proxy_connect(int fd[2], const char *host,
+					       const char *port)
 {
-	const char *port = STR(DEFAULT_GIT_PORT);
 	struct child_process *proxy;
 
-	get_host_and_port(&host, &port);
-
 	proxy = xmalloc(sizeof(*proxy));
 	child_process_init(proxy);
 	argv_array_push(&proxy->args, git_proxy_command);
 	argv_array_push(&proxy->args, host);
-	argv_array_push(&proxy->args, port);
+	argv_array_push(&proxy->args, port ? port : STR(DEFAULT_GIT_PORT));
 	proxy->in = -1;
 	proxy->out = -1;
 	if (start_command(proxy))
@@ -696,9 +693,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 * cannot connect.
 		 */
 		if (git_use_proxy(host))
-			conn = git_proxy_connect(fd, hostandport);
+			conn = git_proxy_connect(fd, host, port);
 		else
-			git_tcp_connect(fd, hostandport, flags);
+			git_tcp_connect(fd, host, port, flags);
 		/*
 		 * Separate original protocol components prog and path
 		 * from extended host header with a NUL byte.
-- 
2.8.1.16.g58dac65.dirty
