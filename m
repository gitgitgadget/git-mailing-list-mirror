From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add ability to specify environment extension to run_command
Date: Tue, 22 May 2007 23:48:47 +0200
Message-ID: <20070522214847.GF30871@steel.home>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <20070521090339.GH942MdfPADPa@greensroom.kotnet.org> <20070521224828.GA10890@steel.home> <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net> <20070522214754.GD30871@steel.home> <20070522214823.GE30871@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 23:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqcDw-0002ZT-RZ
	for gcvg-git@gmane.org; Tue, 22 May 2007 23:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759195AbXEVVsy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 17:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759019AbXEVVsy
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 17:48:54 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:54949 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757991AbXEVVsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 17:48:53 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (klopstock mo42) (RZmta 6.5)
	with ESMTP id C04744j4MK9Bq1 ; Tue, 22 May 2007 23:48:51 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 102C2277BD;
	Tue, 22 May 2007 23:48:48 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0135DD195; Tue, 22 May 2007 23:48:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070522214823.GE30871@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48120>

There is no way to specify and override for the environment:
there'd be no user for it yet.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
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
1.5.2.51.g16099
