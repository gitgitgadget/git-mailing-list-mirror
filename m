From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow environment variables to be unset in the processes started by run_command
Date: Wed, 23 May 2007 22:21:39 +0200
Message-ID: <20070523202139.GC2554@steel.home>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <20070521090339.GH942MdfPADPa@greensroom.kotnet.org> <20070521224828.GA10890@steel.home> <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net> <20070522214754.GD30871@steel.home> <7v1wh88prw.fsf@assigned-by-dhcp.cox.net> <20070522231442.GM30871@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 22:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqxL6-0008Na-TA
	for gcvg-git@gmane.org; Wed, 23 May 2007 22:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398AbXEWUVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 16:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757446AbXEWUVl
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 16:21:41 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:52618 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757398AbXEWUVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 16:21:41 -0400
Received: from tigra.home (Fa87d.f.strato-dslnet.de [195.4.168.125])
	by post.webmailer.de (fruni mo11) (RZmta 6.7)
	with ESMTP id 8002acj4NJevYF ; Wed, 23 May 2007 22:21:39 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3E262277BD;
	Wed, 23 May 2007 22:21:39 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 19A9AD195; Wed, 23 May 2007 22:21:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070522231442.GM30871@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVo8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48172>

To unset a variable, just specify its name, without "=". For example:

    const char *env[] = {"GIT_DIR=.git", "PWD", NULL};
    const char *argv[] = {"git-ls-files", "-s", NULL};
    int err = run_command_v_opt_cd_env(argv, RUN_GIT_CMD, ".", env);

The PWD will be unset before executing git-ls-files.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Wed, May 23, 2007 01:14:42 +0200:
> > Because you _scan_ the whole string in your patch to see if it
> > ends with = anyway, a trivial improvement would be to do:
> > 
> > 	if (strchr(cmd->env, '='))
> >                 putenv(cmd->env);
> > 	else
> >         	unsetenv(cmd->env);
> 
> I like this one. The env field in struct child_process and run_command
> will have to mention it in comments (in run-command.h), it's kind of
> special.
> 

 run-command.c |    8 ++++++--
 run-command.h |    5 +++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 605aa1e..3b1899e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -77,8 +77,12 @@ int start_command(struct child_process *cmd)
 			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
 			    cmd->dir, strerror(errno));
 		if (cmd->env) {
-			for (; *cmd->env; cmd->env++)
-				putenv((char*)*cmd->env);
+			for (; *cmd->env; cmd->env++) {
+				if (strchr(*cmd->env, '='))
+					putenv((char*)*cmd->env);
+				else
+					unsetenv(*cmd->env);
+			}
 		}
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
diff --git a/run-command.h b/run-command.h
index af1e0bf..7958eb1 100644
--- a/run-command.h
+++ b/run-command.h
@@ -35,6 +35,11 @@ int run_command(struct child_process *);
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 int run_command_v_opt(const char **argv, int opt);
 int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
+
+/*
+ * env (the environment) is to be formatted like environ: "VAR=VALUE".
+ * To unset an environment variable use just "VAR".
+ */
 int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env);
 
 #endif
-- 
1.5.2.67.gbd3c2
