From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] allow commands to be executed in submodules
Date: Sun, 20 May 2007 20:14:33 +0200
Message-ID: <20070520181433.GA19668@steel.home>
References: <20070520153908.GF5412@admingilde.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sun May 20 20:14:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HppvU-0000Wv-A6
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757012AbXETSOg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757041AbXETSOg
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:14:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:51592 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756977AbXETSOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:14:35 -0400
Received: from tigra.home (Faeaf.f.strato-dslnet.de [195.4.174.175])
	by post.webmailer.de (mrclete mo30) (RZmta 6.5)
	with ESMTP id 904302j4KDsKvQ ; Sun, 20 May 2007 20:14:33 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 92870277BD;
	Sun, 20 May 2007 20:14:33 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5AECDD195; Sun, 20 May 2007 20:14:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520153908.GF5412@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jEE44=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47878>

Martin Waitz, Sun, May 20, 2007 17:39:08 +0200:
> Add an extra "submodule" field to struct child_process to be able to
> easily start commands which are to be executed in a submodule
> repository.

How about making it more generic by allowing to specify the directory
to change to and environment for subprocess? You probably will be able
to convert even some of existing code to your new run_command then
(merge_recursive in builtin-revert.c, for example).

Something like this, perhaps:

diff --git a/run-command.c b/run-command.c
index eff523e..605aa1e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -73,6 +73,13 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		}
 
+		if (cmd->dir && chdir(cmd->dir))
+			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
+			    cmd->dir, strerror(errno));
+		if (cmd->env) {
+			for (; *cmd->env; cmd->env++)
+				putenv((char*)*cmd->env);
+		}
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
 		} else {
@@ -133,13 +140,38 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }
 
+static void prepare_run_command_v_opt(struct child_process *cmd,
+				      const char **argv,
+				      int opt)
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
 	return run_command(&cmd);
 }
+
+int run_command_v_opt_cd(const char **argv, int opt, const char *dir)
+{
+	struct child_process cmd;
+	prepare_run_command_v_opt(&cmd, argv, opt);
+	cmd.dir = dir;
+	return run_command(&cmd);
+}
+
+int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env)
+{
+	struct child_process cmd;
+	prepare_run_command_v_opt(&cmd, argv, opt);
+	cmd.dir = dir;
+	cmd.env = env;
+	return run_command(&cmd);
+}
+
diff --git a/run-command.h b/run-command.h
index 3680ef9..af1e0bf 100644
--- a/run-command.h
+++ b/run-command.h
@@ -16,6 +16,8 @@ struct child_process {
 	pid_t pid;
 	int in;
 	int out;
+	const char *dir;
+	const char *const *env;
 	unsigned close_in:1;
 	unsigned close_out:1;
 	unsigned no_stdin:1;
@@ -32,5 +34,7 @@ int run_command(struct child_process *);
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 int run_command_v_opt(const char **argv, int opt);
+int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
+int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env);
 
 #endif
