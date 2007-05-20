From: skimo@liacs.nl
Subject: [PATCH 08/15] Add run_command_v_opt_cd: chdir into a directory before exec
Date: Sun, 20 May 2007 20:04:41 +0200
Message-ID: <1179684289307-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmq-0007La-Ou
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958AbXETSFK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757168AbXETSFK
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:10 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37214 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756958AbXETSFC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:05:02 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4r03007816;
	Sun, 20 May 2007 20:04:58 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 73C6C7DDA7; Sun, 20 May 2007 20:04:49 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47862>

From: Alex Riesen <raa.lkml@gmail.com>

It can make code simplier (no need to preserve cwd) and safer
(no chance the cwd of the current process is accidentally forgotten).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 run-command.c |   27 ++++++++++++++++++++++-----
 run-command.h |    2 ++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index eff523e..043b570 100644
--- a/run-command.c
+++ b/run-command.c
@@ -73,6 +73,9 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		}
 
+		if (cmd->dir && chdir(cmd->dir))
+			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
+			    cmd->dir, strerror(errno));
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
 		} else {
@@ -133,13 +136,27 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }
 
+static void prepare_run_command_v_opt(struct child_process *cmd,
+				      const char **argv, int opt)
+{
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->argv = argv;
+	cmd->no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
+	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
+	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
+}
+
 int run_command_v_opt(const char **argv, int opt)
 {
 	struct child_process cmd;
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.argv = argv;
-	cmd.no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
-	cmd.git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
-	cmd.stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
+	prepare_run_command_v_opt(&cmd, argv, opt);
+	return run_command(&cmd);
+}
+
+int run_command_v_opt_cd(const char **argv, int opt, const char *dir)
+{
+	struct child_process cmd;
+	prepare_run_command_v_opt(&cmd, argv, opt);
+	cmd.dir = dir;
 	return run_command(&cmd);
 }
diff --git a/run-command.h b/run-command.h
index 3680ef9..cbd7484 100644
--- a/run-command.h
+++ b/run-command.h
@@ -16,6 +16,7 @@ struct child_process {
 	pid_t pid;
 	int in;
 	int out;
+	const char *dir;
 	unsigned close_in:1;
 	unsigned close_out:1;
 	unsigned no_stdin:1;
@@ -32,5 +33,6 @@ int run_command(struct child_process *);
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 int run_command_v_opt(const char **argv, int opt);
+int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
 
 #endif
-- 
1.5.2.rc3.815.g8fc2
