From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v8 6/9] connect: make parse_connect_url() return the user part of the url as a separate value
Date: Fri, 27 May 2016 11:27:53 +0900
Message-ID: <20160527022756.22904-7-mh@glandium.org>
References: <20160527022756.22904-1-mh@glandium.org>
Cc: git@vger.kernel.org, tboegi@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 27 04:28:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67Vm-0005KM-94
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbcE0C2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:28:22 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40412 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932269AbcE0C2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:28:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b67VE-0005yR-S6; Fri, 27 May 2016 11:27:56 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160527022756.22904-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295715>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 54 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/connect.c b/connect.c
index 4be06f4..0819c25 100644
--- a/connect.c
+++ b/connect.c
@@ -588,11 +588,13 @@ static char *get_port(char *host)
  * Extract protocol and relevant parts from the specified connection URL.
  * The caller must free() the returned strings.
  */
-static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
-				       char **ret_port, char **ret_path)
+static enum protocol parse_connect_url(const char *url_orig, char **ret_user,
+				       char **ret_host, char **ret_port,
+				       char **ret_path)
 {
 	char *url;
 	char *host, *path;
+	const char *user = NULL;
 	const char *port = NULL;
 	char *end;
 	int separator = '/';
@@ -650,23 +652,31 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 
 	get_host_and_port(&host, &port);
 
-	if (*host && !port) {
+	if (*host) {
 		/*
-		 * get_host_and_port does not return a port in the
-		 * [host:port]:path case. In that case, it is called with
-		 * "[host:port]" and returns "host:port" and NULL.
-		 * To support this undocumented legacy we still need to split
-		 * the port.
-		 * "host:port" may also look like "user@host:port". As the
-		 * `user` portion tends to be less strict than `host:port`,
-		 * we first put it out of the equation: since a hostname
-		 * cannot contain a '@', we start from the last '@' in the
-		 * string.
+		 * At this point, the host part may look like user@host:port.
+		 * As the `user` portion tends to be less strict than
+		 * `host:port`, we first put it out of the equation: since a
+		 * hostname cannot contain a '@', we start from the last '@'
+		 * in the string.
 		 */
 		char *end_user = strrchr(host, '@');
-		port = get_port(end_user ? end_user : host);
+		if (end_user) {
+			*end_user = '\0';
+			user = host;
+			host = end_user + 1;
+		}
 	}
+	/*
+	 * get_host_and_port does not return a port in the [host:port]:path
+	 * case. In that case, it is called with "[host:port]" and returns
+	 * "host:port" and NULL.
+	 * To support this undocumented legacy we still need to split the port.
+	 */
+	if (!port)
+		port = get_port(host);
 
+	*ret_user = user ? xstrdup(user) : NULL;
 	*ret_host = xstrdup(host);
 	*ret_port = port ? xstrdup(port) : NULL;
 	*ret_path = path;
@@ -690,7 +700,7 @@ static struct child_process no_fork = CHILD_PROCESS_INIT;
 struct child_process *git_connect(int fd[2], const char *url,
 				  const char *prog, int flags)
 {
-	char *host, *port, *path;
+	char *user, *host, *port, *path;
 	struct child_process *conn = &no_fork;
 	enum protocol protocol;
 	struct strbuf cmd = STRBUF_INIT;
@@ -700,11 +710,14 @@ struct child_process *git_connect(int fd[2], const char *url,
 	 */
 	signal(SIGCHLD, SIG_DFL);
 
-	protocol = parse_connect_url(url, &host, &port, &path);
+	protocol = parse_connect_url(url, &user, &host, &port, &path);
 	if (flags & CONNECT_DIAG_URL) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
-		printf("Diag: userandhost=%s\n", host ? host : "NULL");
+		if (user)
+			printf("Diag: userandhost=%s@%s\n", user, host);
+		else
+			printf("Diag: userandhost=%s\n", host ? host : "NULL");
 		printf("Diag: port=%s\n", port ? port : "NONE");
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
@@ -813,7 +826,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, putty ? "-P" : "-p");
 				argv_array_push(&conn->args, port);
 			}
-			argv_array_push(&conn->args, host);
+			if (user)
+				argv_array_pushf(&conn->args, "%s@%s",
+						 user, host);
+			else
+				argv_array_push(&conn->args, host);
 		} else {
 			transport_check_allowed("file");
 		}
@@ -826,6 +843,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		fd[1] = conn->in;  /* write to child's stdin */
 		strbuf_release(&cmd);
 	}
+	free(user);
 	free(host);
 	free(port);
 	free(path);
-- 
2.8.3
