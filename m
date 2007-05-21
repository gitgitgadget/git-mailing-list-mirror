From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add ability to specify environment extension to run_command
Date: Tue, 22 May 2007 00:48:28 +0200
Message-ID: <20070521224828.GA10890@steel.home>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <20070521090339.GH942MdfPADPa@greensroom.kotnet.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Tue May 22 00:48:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqGgA-0005td-4C
	for gcvg-git@gmane.org; Tue, 22 May 2007 00:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbXEUWsc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 18:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985AbXEUWsc
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 18:48:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:59940 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956AbXEUWsb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 18:48:31 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (fruni mo59) (RZmta 6.5)
	with ESMTP id K02651j4LK4jG6 ; Tue, 22 May 2007 00:48:28 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9AD16277BD;
	Tue, 22 May 2007 00:48:28 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 21669D195; Tue, 22 May 2007 00:48:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070521090339.GH942MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48057>

There is no way to specify and override for the environment: there is
no visible user for it (yet, something in git-daemon could need it).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Sven Verdoolaege, Mon, May 21, 2007 11:03:39 +0200:
> Could you sign-off on this for me so I can use it my patch set?
> 

So here it is. On top of the previos patch regarding chdir before
exec. Junio, if needed, I can resend that first patch about chdir.

 run-command.c |   17 ++++++++++++++++-
 run-command.h |    2 ++
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index 043b570..605aa1e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -76,6 +76,10 @@ int start_command(struct child_process *cmd)
 		if (cmd->dir && chdir(cmd->dir))
 			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
 			    cmd->dir, strerror(errno));
+		if (cmd->env) {
+			for (; *cmd->env; cmd->env++)
+				putenv((char*)*cmd->env);
+		}
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
 		} else {
@@ -137,7 +141,8 @@ int run_command(struct child_process *cmd)
 }
 
 static void prepare_run_command_v_opt(struct child_process *cmd,
-				      const char **argv, int opt)
+				      const char **argv,
+				      int opt)
 {
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->argv = argv;
@@ -160,3 +165,13 @@ int run_command_v_opt_cd(const char **argv, int opt, const char *dir)
 	cmd.dir = dir;
 	return run_command(&cmd);
 }
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
index cbd7484..af1e0bf 100644
--- a/run-command.h
+++ b/run-command.h
@@ -17,6 +17,7 @@ struct child_process {
 	int in;
 	int out;
 	const char *dir;
+	const char *const *env;
 	unsigned close_in:1;
 	unsigned close_out:1;
 	unsigned no_stdin:1;
@@ -34,5 +35,6 @@ int run_command(struct child_process *);
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 int run_command_v_opt(const char **argv, int opt);
 int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
+int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env);
 
 #endif
-- 
1.5.2.rc3.112.gc1e43
