From: skimo@liacs.nl
Subject: [PATCH 21/22] run-command: optionally redirect stderr to /dev/null
Date: Thu, 24 May 2007 00:23:10 +0200
Message-ID: <1179958993242-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:23:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFC-0003Mx-NP
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956AbXEWWXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756944AbXEWWXm
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:23:42 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33744 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756433AbXEWWXf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:35 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNMIo011620;
	Thu, 24 May 2007 00:23:27 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 9586C7DDB3; Thu, 24 May 2007 00:23:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48188>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 run-command.c |    4 ++++
 run-command.h |    8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index d5b8ba2..a620be3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -73,6 +73,9 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		}
 
+		if (cmd->no_stderr)
+			dup_devnull(2);
+
 		if (cmd->dir && chdir(cmd->dir))
 			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
 			    cmd->dir, strerror(errno));
@@ -151,6 +154,7 @@ static void prepare_run_command_v_opt(struct child_process *cmd,
 	cmd->argv = argv;
 	cmd->no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
 	cmd->no_stdout = opt & RUN_COMMAND_NO_STDOUT ? 1 : 0;
+	cmd->no_stderr = opt & RUN_COMMAND_NO_STDERR ? 1 : 0;
 	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
 	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
 	cmd->clear_git_env = opt & RUN_COMMAND_CLEAR_GIT_ENV ? 1 : 0;
diff --git a/run-command.h b/run-command.h
index e3e897a..85770e0 100644
--- a/run-command.h
+++ b/run-command.h
@@ -21,6 +21,7 @@ struct child_process {
 	unsigned close_out:1;
 	unsigned no_stdin:1;
 	unsigned no_stdout:1;
+	unsigned no_stderr:1;
 	unsigned git_cmd:1; /* if this is to be git sub-command */
 	unsigned stdout_to_stderr:1;
 	unsigned clear_git_env:1;
@@ -32,9 +33,10 @@ int run_command(struct child_process *);
 
 #define RUN_COMMAND_NO_STDIN 		(1 << 0)
 #define RUN_COMMAND_NO_STDOUT 		(1 << 1)
-#define RUN_GIT_CMD			(1 << 2)	/* git sub-command */
-#define RUN_COMMAND_STDOUT_TO_STDERR 	(1 << 3)
-#define RUN_COMMAND_CLEAR_GIT_ENV	(1 << 4)
+#define RUN_COMMAND_NO_STDERR 		(1 << 2)
+#define RUN_GIT_CMD			(1 << 3)	/* git sub-command */
+#define RUN_COMMAND_STDOUT_TO_STDERR 	(1 << 4)
+#define RUN_COMMAND_CLEAR_GIT_ENV	(1 << 5)
 int run_command_v_opt(const char **argv, int opt);
 int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
 
-- 
1.5.2.784.g5532e
