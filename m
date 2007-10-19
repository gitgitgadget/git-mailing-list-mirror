From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 08/14] Add infrastructure to run a function asynchronously.
Date: Fri, 19 Oct 2007 21:48:00 +0200
Message-ID: <1192823286-9654-9-git-send-email-johannes.sixt@telecom.at>
References: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-2-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-3-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-4-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-5-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-6-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-7-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-8-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iixqg-0002t3-1e
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565AbXJSTs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933103AbXJSTsZ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:48:25 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44511 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765895AbXJSTsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 15:48:10 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id E2AAF97D60;
	Fri, 19 Oct 2007 21:48:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.315.g2ce38
In-Reply-To: <1192823286-9654-8-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61756>

This adds start_async() and finish_async(), which runs a function
asynchronously. Communication with the caller happens only via pipes.
For this reason, this implementation forks off a child process that runs
the function.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
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
1.5.3.4.315.g2ce38
