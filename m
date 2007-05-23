From: skimo@liacs.nl
Subject: [PATCH 10/22] run-command: optionally clear git environment
Date: Thu, 24 May 2007 00:22:59 +0200
Message-ID: <11799589923790-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFs-0003VS-Q9
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384AbXEWWYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759423AbXEWWYL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:24:11 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33788 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757384AbXEWWXq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:46 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNGgv011567;
	Thu, 24 May 2007 00:23:21 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 6D6AE7DDA8; Thu, 24 May 2007 00:23:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48204>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 run-command.c |    9 +++++++++
 run-command.h |    2 ++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index 043b570..806af46 100644
--- a/run-command.c
+++ b/run-command.c
@@ -76,6 +76,14 @@ int start_command(struct child_process *cmd)
 		if (cmd->dir && chdir(cmd->dir))
 			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
 			    cmd->dir, strerror(errno));
+		if (cmd->clear_git_env) {
+			unsetenv(ALTERNATE_DB_ENVIRONMENT);
+			unsetenv(DB_ENVIRONMENT);
+			unsetenv(CONFIG_ENVIRONMENT);
+			unsetenv(GIT_DIR_ENVIRONMENT);
+			unsetenv(GRAFT_ENVIRONMENT);
+			unsetenv(INDEX_ENVIRONMENT);
+		}
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
 		} else {
@@ -144,6 +152,7 @@ static void prepare_run_command_v_opt(struct child_process *cmd,
 	cmd->no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
 	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
 	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
+	cmd->clear_git_env = opt & RUN_COMMAND_CLEAR_GIT_ENV ? 1 : 0;
 }
 
 int run_command_v_opt(const char **argv, int opt)
diff --git a/run-command.h b/run-command.h
index cbd7484..7724118 100644
--- a/run-command.h
+++ b/run-command.h
@@ -23,6 +23,7 @@ struct child_process {
 	unsigned no_stdout:1;
 	unsigned git_cmd:1; /* if this is to be git sub-command */
 	unsigned stdout_to_stderr:1;
+	unsigned clear_git_env:1;
 };
 
 int start_command(struct child_process *);
@@ -32,6 +33,7 @@ int run_command(struct child_process *);
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
+#define RUN_COMMAND_CLEAR_GIT_ENV	(1 << 3)
 int run_command_v_opt(const char **argv, int opt);
 int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
 
-- 
1.5.2.784.g5532e
