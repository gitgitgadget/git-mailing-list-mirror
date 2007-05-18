From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add run_command_v_opt_cd: chdir into a directory before exec
Date: Sat, 19 May 2007 00:20:15 +0200
Message-ID: <20070518222015.GE10475@steel.home>
References: <11795163053812-git-send-email-skimo@liacs.nl> <1179516307425-git-send-email-skimo@liacs.nl> <20070518220014.GD10475@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 00:20:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpAoM-000353-AO
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763310AbXERWUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763340AbXERWUT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:20:19 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:28044 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763310AbXERWUR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:20:17 -0400
Received: from tigra.home (Fc8ca.f.strato-dslnet.de [195.4.200.202])
	by post.webmailer.de (klopstock mo54) (RZmta 6.5)
	with ESMTP id F0478bj4IKOgrf ; Sat, 19 May 2007 00:20:16 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 39E7D277BD;
	Sat, 19 May 2007 00:20:15 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1CF5FD195; Sat, 19 May 2007 00:20:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070518220014.GD10475@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0t1E=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47668>

It can make code simplier (no need to preserve cwd) and safer
(no chance the cwd of the current process is accidentally forgotten).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Alex Riesen, Sat, May 19, 2007 00:00:14 +0200:
> skimo@liacs.nl, Fri, May 18, 2007 21:24:58 +0200:
> > +	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
> > +		die("Unable to read current working directory");
> > +
> > +	if (chdir(path))
> > +		die("Cannot move to '%s'", path);
> > +
> 
> How about modifying run_command to chdir after fork?
> 
> You'd save the hassle of save/restoring cwd and don't mess up process'
> context (which is always a good idea to preserve). The code'd be
> simplier, too.
> 

something like this

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
1.5.2.rc3.83.gbbb0
