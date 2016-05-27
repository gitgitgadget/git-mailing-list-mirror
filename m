From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v8 2/9] connect: call get_host_and_port() earlier
Date: Fri, 27 May 2016 11:27:49 +0900
Message-ID: <20160527022756.22904-3-mh@glandium.org>
References: <20160527022756.22904-1-mh@glandium.org>
Cc: git@vger.kernel.org, tboegi@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 27 04:28:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67Vs-0005Ne-JP
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbcE0C2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:28:20 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40442 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932273AbcE0C2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:28:03 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b67VE-0005yJ-L0; Fri, 27 May 2016 11:27:56 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160527022756.22904-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295717>

Currently, get_host_and_port() is called in git_connect() for the ssh
protocol, and in git_tcp_connect_sock() for the git protocol. Instead
of doing this, just call it from a single place, right after
parse_connect_url(), and pass the host and port separately to
git_*_connect() functions.

We however preserve hostandport, at least for now.

Note that in git_tcp_connect_sock, the port was set to "<none>" in a
case that never can happen, so that code path was removed.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/connect.c b/connect.c
index 6e520c3..d5af65f 100644
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
@@ -672,7 +669,8 @@ static struct child_process no_fork = CHILD_PROCESS_INIT;
 struct child_process *git_connect(int fd[2], const char *url,
 				  const char *prog, int flags)
 {
-	char *hostandport, *path;
+	char *hostandport, *path, *host;
+	const char *port = NULL;
 	struct child_process *conn = &no_fork;
 	enum protocol protocol;
 	struct strbuf cmd = STRBUF_INIT;
@@ -683,6 +681,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 	signal(SIGCHLD, SIG_DFL);
 
 	protocol = parse_connect_url(url, &hostandport, &path);
+	host = xstrdup(hostandport);
+	get_host_and_port(&host, &port);
 	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
@@ -707,9 +707,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 * cannot connect.
 		 */
 		if (git_use_proxy(hostandport))
-			conn = git_proxy_connect(fd, hostandport);
+			conn = git_proxy_connect(fd, host, port);
 		else
-			git_tcp_connect(fd, hostandport, flags);
+			git_tcp_connect(fd, host, port, flags);
 		/*
 		 * Separate original protocol components prog and path
 		 * from extended host header with a NUL byte.
@@ -737,10 +737,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
 			int putty = 0, tortoiseplink = 0;
-			char *ssh_host = hostandport;
-			const char *port = NULL;
 			transport_check_allowed("ssh");
-			get_host_and_port(&ssh_host, &port);
 
 			/*
 			 * get_host_and_port does not return a port in the
@@ -750,16 +747,17 @@ struct child_process *git_connect(int fd[2], const char *url,
 			 * to split the port.
 			 */
 			if (!port)
-				port = get_port(ssh_host);
+				port = get_port(host);
 
 			if (flags & CONNECT_DIAG_URL) {
 				printf("Diag: url=%s\n", url ? url : "NULL");
 				printf("Diag: protocol=%s\n", prot_name(protocol));
-				printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
+				printf("Diag: userandhost=%s\n", host ? host : "NULL");
 				printf("Diag: port=%s\n", port ? port : "NONE");
 				printf("Diag: path=%s\n", path ? path : "NULL");
 
 				free(hostandport);
+				free(host);
 				free(path);
 				free(conn);
 				return NULL;
@@ -805,7 +803,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, putty ? "-P" : "-p");
 				argv_array_push(&conn->args, port);
 			}
-			argv_array_push(&conn->args, ssh_host);
+			argv_array_push(&conn->args, host);
 		} else {
 			transport_check_allowed("file");
 		}
@@ -819,6 +817,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		strbuf_release(&cmd);
 	}
 	free(hostandport);
+	free(host);
 	free(path);
 	return conn;
 }
-- 
2.8.3
