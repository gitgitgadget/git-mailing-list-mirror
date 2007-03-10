From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/8] Start defining a more sophisticated run_command
Date: Sat, 10 Mar 2007 03:28:00 -0500
Message-ID: <20070310082800.GC4133@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 09:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPwwG-0003b1-ME
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 09:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933570AbXCJI2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 03:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933572AbXCJI2H
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 03:28:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60122 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933570AbXCJI2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 03:28:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPwvo-0003Zf-Tk; Sat, 10 Mar 2007 03:28:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8A6E620FBAE; Sat, 10 Mar 2007 03:28:00 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41856>

There are a number of places where we do some variation of
fork()+exec() but we also need to setup redirection in the process,
much like what run_command does for us already with its option flags.

It would be nice to reuse more of the run_command logic, especially
as that non-fork API helps us to port to odd platforms like Win32.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 run-command.c |   25 ++++++++++++++++++-------
 run-command.h |    9 +++++++++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index 94ace50..1fb7fa5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,26 +2,26 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 
-int run_command_v_opt(const char **argv, int flags)
+int run_command(struct child_process *cmd)
 {
 	pid_t pid = fork();
 
 	if (pid < 0)
 		return -ERR_RUN_COMMAND_FORK;
 	if (!pid) {
-		if (flags & RUN_COMMAND_NO_STDIN) {
+		if (cmd->no_stdin) {
 			int fd = open("/dev/null", O_RDWR);
 			dup2(fd, 0);
 			close(fd);
 		}
-		if (flags & RUN_COMMAND_STDOUT_TO_STDERR)
+		if (cmd->stdout_to_stderr)
 			dup2(2, 1);
-		if (flags & RUN_GIT_CMD) {
-			execv_git_cmd(argv);
+		if (cmd->git_cmd) {
+			execv_git_cmd(cmd->argv);
 		} else {
-			execvp(argv[0], (char *const*) argv);
+			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
-		die("exec %s failed.", argv[0]);
+		die("exec %s failed.", cmd->argv[0]);
 	}
 	for (;;) {
 		int status, code;
@@ -46,3 +46,14 @@ int run_command_v_opt(const char **argv, int flags)
 		return 0;
 	}
 }
+
+int run_command_v_opt(const char **argv, int opt)
+{
+	struct child_process cmd;
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv = argv;
+	cmd.no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
+	cmd.git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
+	cmd.stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
+	return run_command(&cmd);
+}
diff --git a/run-command.h b/run-command.h
index 2646d38..f9db2a7 100644
--- a/run-command.h
+++ b/run-command.h
@@ -10,6 +10,15 @@ enum {
 	ERR_RUN_COMMAND_WAITPID_NOEXIT,
 };
 
+struct child_process {
+	const char **argv;
+	unsigned no_stdin:1;
+	unsigned git_cmd:1; /* if this is to be git sub-command */
+	unsigned stdout_to_stderr:1;
+};
+
+int run_command(struct child_process *);
+
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
-- 
1.5.0.3.942.g299f
