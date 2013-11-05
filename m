From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] git_connect: factor out discovery of the protocol and
 its parts
Date: Tue, 05 Nov 2013 20:39:22 +0100
Message-ID: <5279496A.2090202@kdbg.org>
References: <201311042220.50178.tboegi@web.de> <52789AE5.2010702@viscovery.net> <52794882.2020108@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 05 20:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdmTJ-00082J-UW
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 20:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab3KETjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 14:39:25 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:31280 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752140Ab3KETjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 14:39:25 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E53181300B8;
	Tue,  5 Nov 2013 20:39:23 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C1FA319F3EE;
	Tue,  5 Nov 2013 20:39:22 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <52794882.2020108@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237339>

git_connect has grown large due to the many different protocols syntaxes
that are supported. Move the part of the function that parses the URL to
connect to into a separate function for readability.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Apart from this "simplification", the protocol parsing code is a complete
mystery to me. There is more potential for simplification because
git_proxy_connect() and git_tcp_connect() do their own host+port parsing.


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
1.8.4.33.gd68f7e8
