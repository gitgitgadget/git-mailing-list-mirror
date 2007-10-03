From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 2/5] Use start_command() in git_connect() instead of explicit fork/exec.
Date: Wed,  3 Oct 2007 22:09:37 +0200
Message-ID: <1191442180-15905-3-git-send-email-johannes.sixt@telecom.at>
References: <200709302340.17644.johannes.sixt@telecom.at>
 <1191442180-15905-1-git-send-email-johannes.sixt@telecom.at>
 <1191442180-15905-2-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 03 22:10:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdAXa-0003Ig-Va
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbXJCUJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbXJCUJp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:09:45 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:33597 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbXJCUJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:09:42 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id EC83D10B324;
	Wed,  3 Oct 2007 22:09:40 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1191442180-15905-2-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59877>

The child process handling is delegated to start_command() and
finish_command().

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 connect.c |  103 ++++++++++++++++++++++++++++--------------------------------
 1 files changed, 48 insertions(+), 55 deletions(-)

diff --git a/connect.c b/connect.c
index 458a502..bb55d19 100644
--- a/connect.c
+++ b/connect.c
@@ -482,11 +482,12 @@ struct child_process *git_connect(int fd[2], char *url,
 	char *host, *path = url;
 	char *end;
 	int c;
-	int pipefd[2][2];
 	struct child_process *conn;
 	enum protocol protocol = PROTO_LOCAL;
 	int free_path = 0;
 	char *port = NULL;
+	const char **arg;
+	struct strbuf cmd;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -572,73 +573,65 @@ struct child_process *git_connect(int fd[2], char *url,
 		return NULL;
 	}
 
-	if (pipe(pipefd[0]) < 0 || pipe(pipefd[1]) < 0)
-		die("unable to create pipe pair for communication");
 	conn = xcalloc(1, sizeof(*conn));
-	conn->pid = fork();
-	if (conn->pid < 0)
-		die("unable to fork");
-	if (!conn->pid) {
-		struct strbuf cmd;
-
-		strbuf_init(&cmd, MAX_CMD_LEN);
-		strbuf_addstr(&cmd, prog);
-		strbuf_addch(&cmd, ' ');
-		sq_quote_buf(&cmd, path);
-		if (cmd.len >= MAX_CMD_LEN)
-			die("command line too long");
-
-		dup2(pipefd[1][0], 0);
-		dup2(pipefd[0][1], 1);
-		close(pipefd[0][0]);
-		close(pipefd[0][1]);
-		close(pipefd[1][0]);
-		close(pipefd[1][1]);
-		if (protocol == PROTO_SSH) {
-			const char *ssh, *ssh_basename;
-			ssh = getenv("GIT_SSH");
-			if (!ssh) ssh = "ssh";
-			ssh_basename = strrchr(ssh, '/');
-			if (!ssh_basename)
-				ssh_basename = ssh;
-			else
-				ssh_basename++;
 
-			if (!port)
-				execlp(ssh, ssh_basename, host, cmd.buf, NULL);
-			else
-				execlp(ssh, ssh_basename, "-p", port, host,
-				       cmd.buf, NULL);
+	strbuf_init(&cmd, MAX_CMD_LEN);
+	strbuf_addstr(&cmd, prog);
+	strbuf_addch(&cmd, ' ');
+	sq_quote_buf(&cmd, path);
+	if (cmd.len >= MAX_CMD_LEN)
+		die("command line too long");
+
+	conn->in = conn->out = -1;
+	conn->argv = arg = xcalloc(6, sizeof(*arg));
+	if (protocol == PROTO_SSH) {
+		const char *ssh = getenv("GIT_SSH");
+		if (!ssh) ssh = "ssh";
+
+		*arg++ = ssh;
+		if (port) {
+			*arg++ = "-p";
+			*arg++ = port;
 		}
-		else {
-			unsetenv(ALTERNATE_DB_ENVIRONMENT);
-			unsetenv(DB_ENVIRONMENT);
-			unsetenv(GIT_DIR_ENVIRONMENT);
-			unsetenv(GIT_WORK_TREE_ENVIRONMENT);
-			unsetenv(GRAFT_ENVIRONMENT);
-			unsetenv(INDEX_ENVIRONMENT);
-			execlp("sh", "sh", "-c", cmd.buf, NULL);
-		}
-		die("exec failed");
+		*arg++ = host;
+	}
+	else {
+		/* remove these from the environment */
+		const char *env[] = {
+			ALTERNATE_DB_ENVIRONMENT,
+			DB_ENVIRONMENT,
+			GIT_DIR_ENVIRONMENT,
+			GIT_WORK_TREE_ENVIRONMENT,
+			GRAFT_ENVIRONMENT,
+			INDEX_ENVIRONMENT,
+			NULL
+		};
+		conn->env = env;
+		*arg++ = "sh";
+		*arg++ = "-c";
 	}
-	fd[0] = pipefd[0][0];
-	fd[1] = pipefd[1][1];
-	close(pipefd[0][1]);
-	close(pipefd[1][0]);
+	*arg++ = cmd.buf;
+	*arg = NULL;
+
+	if (start_command(conn))
+		die("unable to fork");
+
+	fd[0] = conn->out; /* read from child's stdout */
+	fd[1] = conn->in;  /* write to child's stdin */
 	if (free_path)
 		free(path);
+	strbuf_release(&cmd);
 	return conn;
 }
 
 int finish_connect(struct child_process *conn)
 {
+	int code;
 	if (conn == NULL)
 		return 0;
 
-	while (waitpid(conn->pid, NULL, 0) < 0) {
-		if (errno != EINTR)
-			return -1;
-	}
+	code = finish_command(conn);
+	free(conn->argv);
 	free(conn);
-	return 0;
+	return code;
 }
-- 
1.5.3.3.1134.gee562
