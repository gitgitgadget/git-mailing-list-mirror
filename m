From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH amend 08/14] Add infrastructure to run a function asynchronously.
Date: Sun, 14 Oct 2007 19:08:45 +0200
Message-ID: <200710141908.45779.johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at> <1192305984-22594-8-git-send-email-johannes.sixt@telecom.at> <1192305984-22594-9-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 14 19:09:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih6xY-0007u7-NN
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 19:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbXJNRIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 13:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbXJNRIu
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 13:08:50 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:45513 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbXJNRIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 13:08:49 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 3A7D1BF7B8;
	Sun, 14 Oct 2007 19:08:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6300358CE9;
	Sun, 14 Oct 2007 19:08:46 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <1192305984-22594-9-git-send-email-johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60870>

This adds start_async() and finish_async(), which runs a function
asynchronously. Communication with the caller happens only via pipes.
For this reason, this implementation forks off a child process that runs
the function.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

This is the same as submitted previously except it uses close_pair()
to close the pipe in an error patch and improves the comments in
run-command.h.

-- Hannes

 run-command.c |   52 ++++++++++++++++++++++++++++++++++++++++++++--------
 run-command.h |   22 ++++++++++++++++++++++
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index d00c03b..db02f75 100644
--- a/run-command.c
+++ b/run-command.c
@@ -127,16 +127,11 @@ int start_command(struct child_process *cmd)
 	return 0;
 }
 
-int finish_command(struct child_process *cmd)
+static int wait_or_whine(pid_t pid)
 {
-	if (cmd->close_in)
-		close(cmd->in);
-	if (cmd->close_out)
-		close(cmd->out);
-
 	for (;;) {
 		int status, code;
-		pid_t waiting = waitpid(cmd->pid, &status, 0);
+		pid_t waiting = waitpid(pid, &status, 0);
 
 		if (waiting < 0) {
 			if (errno == EINTR)
@@ -144,7 +139,7 @@ int finish_command(struct child_process *cmd)
 			error("waitpid failed (%s)", strerror(errno));
 			return -ERR_RUN_COMMAND_WAITPID;
 		}
-		if (waiting != cmd->pid)
+		if (waiting != pid)
 			return -ERR_RUN_COMMAND_WAITPID_WRONG_PID;
 		if (WIFSIGNALED(status))
 			return -ERR_RUN_COMMAND_WAITPID_SIGNAL;
@@ -158,6 +153,15 @@ int finish_command(struct child_process *cmd)
 	}
 }
 
+int finish_command(struct child_process *cmd)
+{
+	if (cmd->close_in)
+		close(cmd->in);
+	if (cmd->close_out)
+		close(cmd->out);
+	return wait_or_whine(cmd->pid);
+}
+
 int run_command(struct child_process *cmd)
 {
 	int code = start_command(cmd);
@@ -200,3 +204,35 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	cmd.env = env;
 	return run_command(&cmd);
 }
+
+int start_async(struct async *async)
+{
+	int pipe_out[2];
+
+	if (pipe(pipe_out) < 0) {
+		return error("cannot create pipe: %s", strerror(errno));
+	}
+
+	async->pid = fork();
+	if (async->pid < 0) {
+		error("fork (async) failed: %s", strerror(errno));
+		close_pair(pipe_out);
+		return -1;
+	}
+	if (!async->pid) {
+		close(pipe_out[0]);
+		exit(!!async->proc(pipe_out[1], async->data));
+	}
+	async->out = pipe_out[0];
+	close(pipe_out[1]);
+	return 0;
+}
+
+int finish_async(struct async *async)
+{
+	int ret = 0;
+
+	if (wait_or_whine(async->pid))
+		ret = error("waitpid (async) failed");
+	return ret;
+}
diff --git a/run-command.h b/run-command.h
index 35b9fb6..94e1e9d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -43,4 +43,26 @@ int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
  */
 int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env);
 
+/*
+ * The purpose of the following functions is to feed a pipe by running
+ * a function asynchronously and providing output that the caller reads.
+ *
+ * It is expected that no synchronization and mutual exclusion between
+ * the caller and the feed function is necessary so that the function
+ * can run in a thread without interfering with the caller.
+ */
+struct async {
+	/*
+	 * proc writes to fd and closes it;
+	 * returns 0 on success, non-zero on failure
+	 */
+	int (*proc)(int fd, void *data);
+	void *data;
+	int out;	/* caller reads from here and closes it */
+	pid_t pid;
+};
+
+int start_async(struct async *async);
+int finish_async(struct async *async);
+
 #endif
-- 
1.5.3.2.141.g48f10
