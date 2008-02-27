From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 18/40] Windows: Implement start_command().
Date: Wed, 27 Feb 2008 19:54:41 +0100
Message-ID: <1204138503-6126-19-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVa-00022R-42
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984AbYB0S4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756675AbYB0S4T
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:19 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40428 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445AbYB0SzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:09 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 3637E976D8;
	Wed, 27 Feb 2008 19:55:07 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, we have spawnv() variants to run a child process instead of
fork()/exec(). In order to attach pipe ends to stdin, stdout, and stderr,
we have to use this idiom:

    save1 = dup(1);
    dup2(pipe[1], 1);
    spawnv();
    dup2(save1, 1);
    close(pipe[1]);

assuming that the descriptors created by pipe() are not inheritable.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-compat-util.h |    8 +++++
 run-command.c     |   89 +++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 170c279..046891d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -608,6 +608,14 @@ void mingw_execvp(const char *cmd, char *const *argv);
 sig_handler_t mingw_signal(int sig, sig_handler_t handler);
 #define signal mingw_signal
 
+/*
+ * helpers
+ */
+
+char **copy_environ(void);
+void free_environ(char **env);
+char **env_setenv(char **env, const char *name);
+
 #endif /* __MINGW32__ */
 
 #endif
diff --git a/run-command.c b/run-command.c
index 476d00c..873f6d0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -53,17 +53,8 @@ int start_command(struct child_process *cmd)
 		cmd->err = fderr[0];
 	}
 
+#ifndef __MINGW32__
 	cmd->pid = fork();
-	if (cmd->pid < 0) {
-		if (need_in)
-			close_pair(fdin);
-		if (need_out)
-			close_pair(fdout);
-		if (need_err)
-			close_pair(fderr);
-		return -ERR_RUN_COMMAND_FORK;
-	}
-
 	if (!cmd->pid) {
 		if (cmd->no_stdin)
 			dup_devnull(0);
@@ -112,6 +103,84 @@ int start_command(struct child_process *cmd)
 		}
 		die("exec %s failed.", cmd->argv[0]);
 	}
+#else
+	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
+	const char *sargv0 = cmd->argv[0];
+	char **env = environ;
+	struct strbuf git_cmd;
+
+	if (cmd->no_stdin) {
+		s0 = dup(0);
+		dup_devnull(0);
+	} else if (need_in) {
+		s0 = dup(0);
+		dup2(fdin[0], 0);
+	} else if (cmd->in) {
+		s0 = dup(0);
+		dup2(cmd->in, 0);
+	}
+
+	if (cmd->no_stdout) {
+		s1 = dup(1);
+		dup_devnull(1);
+	} else if (cmd->stdout_to_stderr) {
+		s1 = dup(1);
+		dup2(2, 1);
+	} else if (need_out) {
+		s1 = dup(1);
+		dup2(fdout[1], 1);
+	} else if (cmd->out > 1) {
+		s1 = dup(1);
+		dup2(cmd->out, 1);
+	}
+
+	if (cmd->no_stderr) {
+		s2 = dup(2);
+		dup_devnull(2);
+	} else if (need_err) {
+		s2 = dup(2);
+		dup2(fderr[1], 2);
+	}
+
+	if (cmd->dir)
+		die("chdir in start_command() not implemented");
+	if (cmd->env) {
+		env = copy_environ();
+		for (; *cmd->env; cmd->env++)
+			env = env_setenv(env, *cmd->env);
+	}
+
+	if (cmd->git_cmd) {
+		strbuf_init(&git_cmd, 0);
+		strbuf_addf(&git_cmd, "git-%s", cmd->argv[0]);
+		cmd->argv[0] = git_cmd.buf;
+	}
+
+	cmd->pid = spawnvpe(_P_NOWAIT, cmd->argv[0], cmd->argv, (const char **)env);
+
+	if (cmd->env)
+		free_environ(env);
+	if (cmd->git_cmd)
+		strbuf_release(&git_cmd);
+
+	cmd->argv[0] = sargv0;
+	if (s0 >= 0)
+		dup2(s0, 0), close(s0);
+	if (s1 >= 0)
+		dup2(s1, 1), close(s1);
+	if (s2 >= 0)
+		dup2(s2, 2), close(s2);
+#endif
+
+	if (cmd->pid < 0) {
+		if (need_in)
+			close_pair(fdin);
+		if (need_out)
+			close_pair(fdout);
+		if (need_err)
+			close_pair(fderr);
+		return -ERR_RUN_COMMAND_FORK;
+	}
 
 	if (need_in)
 		close(fdin[0]);
-- 
1.5.4.1.126.ge5a7d
