From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v4 07/11] connect: make parse_connect_url() return the user part of the url as a separate value
Date: Tue,  3 May 2016 17:50:48 +0900
Message-ID: <1462265452-32360-8-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 10:52:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axW4L-0005On-T2
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 10:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbcECIvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 04:51:55 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:51952 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755680AbcECIvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 04:51:03 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1axW2e-0008R1-Ho; Tue, 03 May 2016 17:50:52 +0900
X-Mailer: git-send-email 2.8.1.16.gaa70619.dirty
In-Reply-To: <1462265452-32360-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293344>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index 8813f90..e95e385 100644
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
@@ -650,13 +652,20 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 
 	get_host_and_port(&host, &port);
 
-	if (*host && !port) {
+	if (*host) {
 		/* The host might contain a user:password string, ignore it
 		 * when searching for the port again */
 		char *end_user = strrchr(host, '@');
-		port = get_port(end_user ? end_user : host);
+		if (end_user) {
+			*end_user = '\0';
+			user = host;
+			host = end_user + 1;
+		}
 	}
+	if (!port)
+		port = get_port(host);
 
+	*ret_user = user ? xstrdup(user) : NULL;
 	*ret_host = xstrdup(host);
 	*ret_port = port ? xstrdup(port) : NULL;
 	*ret_path = path;
@@ -680,7 +689,7 @@ static struct child_process no_fork = CHILD_PROCESS_INIT;
 struct child_process *git_connect(int fd[2], const char *url,
 				  const char *prog, int flags)
 {
-	char *host, *port, *path;
+	char *user, *host, *port, *path;
 	struct child_process *conn = &no_fork;
 	enum protocol protocol;
 	struct strbuf cmd = STRBUF_INIT;
@@ -690,11 +699,14 @@ struct child_process *git_connect(int fd[2], const char *url,
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
@@ -801,7 +813,15 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, putty ? "-P" : "-p");
 				argv_array_push(&conn->args, port);
 			}
-			argv_array_push(&conn->args, host);
+			if (user) {
+				struct strbuf userandhost = STRBUF_INIT;
+				strbuf_addstr(&userandhost, user);
+				strbuf_addch(&userandhost, '@');
+				strbuf_addstr(&userandhost, host);
+				argv_array_push(&conn->args, userandhost.buf);
+				strbuf_release(&userandhost);
+			} else
+				argv_array_push(&conn->args, host);
 		} else {
 			transport_check_allowed("file");
 		}
@@ -814,6 +834,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		fd[1] = conn->in;  /* write to child's stdin */
 		strbuf_release(&cmd);
 	}
+	free(user);
 	free(host);
 	free(port);
 	free(path);
-- 
2.8.1.16.gaa70619.dirty
