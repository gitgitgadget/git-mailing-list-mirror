From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 08/14] Add infrastructure to run a function asynchronously.
Date: Sat, 13 Oct 2007 22:06:18 +0200
Message-ID: <1192305984-22594-9-git-send-email-johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-3-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-4-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-5-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-6-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-7-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-8-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 13 22:08:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnH2-0008Ve-J1
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758529AbXJMUGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758414AbXJMUGt
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:06:49 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52589 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175AbXJMUG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:06:28 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id AC32613A770;
	Sat, 13 Oct 2007 22:06:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1192305984-22594-8-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60770>

This adds start_async() and finish_async(), which runs a function
asynchronously. Communication with the caller happens only via pipes.
For this reason, this implementation forks off a child process that runs
the function.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 run-command.c |   53 +++++++++++++++++++++++++++++++++++++++++++++--------
 run-command.h |   23 +++++++++++++++++++++++
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index d00c03b..111d584 100644
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
@@ -200,3 +204,36 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
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
+		close(pipe_out[0]);
+		close(pipe_out[1]);
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
index 35b9fb6..c5fd2fc 100644
--- a/run-command.h
+++ b/run-command.h
@@ -43,4 +43,27 @@ int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
  */
 int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env);
 
+/*
+ * The purpose of the following functions is to feed a pipe by running
+ * a function asynchronously and providing output that the call reads
+ * in a different pipe.
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
+	int out;	/* caller reads from this */
+	pid_t pid;
+};
+
+int start_async(struct async *async);
+int finish_async(struct async *async);
+
 #endif
-- 
1.5.3.3.1134.gee562
