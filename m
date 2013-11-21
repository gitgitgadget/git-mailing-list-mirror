From: Torsten =?iso-8859-1?q?B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v6 04/10] git_connect: factor out discovery of the protocol and its parts
Date: Thu, 21 Nov 2013 21:39:50 +0100
Message-ID: <201311212139.51214.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 21:40:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjb2f-0008Pd-AL
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab3KUUj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:39:58 -0500
Received: from mout.web.de ([212.227.15.4]:59223 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861Ab3KUUj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:39:57 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LbrUu-1VICFj46ya-00jIs8 for <git@vger.kernel.org>; Thu,
 21 Nov 2013 21:39:56 +0100
X-Provags-ID: V03:K0:SM2DJC/85R/uHrG8EpjAsCZY7N7Fdp8jNtYwim1LG9K+wPxruhb
 cbBF+WTqH2PhUiV89YFwGCEE0UpVskYASTI+kLbmPwscXU8tPlpTETtma36YGMhDTINEjMJ
 ek7Ikk5cAiaa7/E/WqcpbFr4NhOuW0Ua8+VNBUWdqe7T4QVe4icNKixZQcYRRA2roGJXhmi
 NHtux2iD0WqgDa5F+X9CQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238144>

git_connect has grown large due to the many different protocols syntaxes
that are supported. Move the part of the function that parses the URL to
connect to into a separate function for readability.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 connect.c | 80 ++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 27 deletions(-)

diff --git a/connect.c b/connect.c
index 6cc1f8d..a6cf345 100644
--- a/connect.c
+++ b/connect.c
@@ -543,37 +543,20 @@ static char *get_port(char *host)
 	return NULL;
 }
 
-static struct child_process no_fork;
-
 /*
- * This returns a dummy child_process if the transport protocol does not
- * need fork(2), or a struct child_process object if it does.  Once done,
- * finish the connection with finish_connect() with the value returned from
- * this function (it is safe to call finish_connect() with NULL to support
- * the former case).
- *
- * If it returns, the connect is successful; it just dies on errors (this
- * will hopefully be changed in a libification effort, to return NULL when
- * the connection failed).
+ * Extract protocol and relevant parts from the specified connection URL.
+ * The caller must free() the returned strings.
  */
-struct child_process *git_connect(int fd[2], const char *url_orig,
-				  const char *prog, int flags)
+static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
+				       char **ret_port, char **ret_path)
 {
 	char *url;
 	char *host, *path;
 	char *end;
 	int c;
-	struct child_process *conn = &no_fork;
 	enum protocol protocol = PROTO_LOCAL;
 	int free_path = 0;
 	char *port = NULL;
-	const char **arg;
-	struct strbuf cmd = STRBUF_INIT;
-
-	/* Without this we cannot rely on waitpid() to tell
-	 * what happened to our children.
-	 */
-	signal(SIGCHLD, SIG_DFL);
 
 	if (is_url(url_orig))
 		url = url_decode(url_orig);
@@ -645,6 +628,49 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	if (protocol == PROTO_SSH && host != url)
 		port = get_port(end);
 
+	*ret_host = xstrdup(host);
+	if (port)
+		*ret_port = xstrdup(port);
+	else
+		*ret_port = NULL;
+	if (free_path)
+		*ret_path = path;
+	else
+		*ret_path = xstrdup(path);
+	free(url);
+	return protocol;
+}
+
+static struct child_process no_fork;
+
+/*
+ * This returns a dummy child_process if the transport protocol does not
+ * need fork(2), or a struct child_process object if it does.  Once done,
+ * finish the connection with finish_connect() with the value returned from
+ * this function (it is safe to call finish_connect() with NULL to support
+ * the former case).
+ *
+ * If it returns, the connect is successful; it just dies on errors (this
+ * will hopefully be changed in a libification effort, to return NULL when
+ * the connection failed).
+ */
+struct child_process *git_connect(int fd[2], const char *url,
+				  const char *prog, int flags)
+{
+	char *host, *path;
+	struct child_process *conn = &no_fork;
+	enum protocol protocol;
+	char *port;
+	const char **arg;
+	struct strbuf cmd = STRBUF_INIT;
+
+	/* Without this we cannot rely on waitpid() to tell
+	 * what happened to our children.
+	 */
+	signal(SIGCHLD, SIG_DFL);
+
+	protocol = parse_connect_url(url, &host, &port, &path);
+
 	if (protocol == PROTO_GIT) {
 		/* These underlying connection commands die() if they
 		 * cannot connect.
@@ -666,9 +692,9 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 			     prog, path, 0,
 			     target_host, 0);
 		free(target_host);
-		free(url);
-		if (free_path)
-			free(path);
+		free(host);
+		free(port);
+		free(path);
 		return conn;
 	}
 
@@ -709,9 +735,9 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	fd[0] = conn->out; /* read from child's stdout */
 	fd[1] = conn->in;  /* write to child's stdin */
 	strbuf_release(&cmd);
-	free(url);
-	if (free_path)
-		free(path);
+	free(host);
+	free(port);
+	free(path);
 	return conn;
 }
 
-- 
1.8.4.457.g424cb08
