From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] start_command: do not clobber cmd->env on Windows code path
Date: Fri, 11 Sep 2009 19:40:08 +0200
Message-ID: <200909111940.08652.j6t@kdbg.org>
References: <200909092337.39885.j6t@kdbg.org> <1252560077-1725-1-git-send-email-snaury@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Alexey Borzenkov <snaury@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 19:40:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmA6e-0003kT-FX
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 19:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773AbZIKRkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 13:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755771AbZIKRkK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 13:40:10 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:61080 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766AbZIKRkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 13:40:09 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A24B01001A;
	Fri, 11 Sep 2009 19:40:09 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EC2EE435B8;
	Fri, 11 Sep 2009 19:40:08 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1252560077-1725-1-git-send-email-snaury@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128208>

Previously, it would not be possible to call start_command twice for the
same struct child_process that has env set.

The fix is achieved by moving the loop that modifies the environment block
into a helper function. This also allows us to make two other helper
functions static.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 We don't call start_command twice in a row anywhere in git.git, but
 msysgit has a patch that does, and with the next patch the buglet would
 be triggered.

 Even after this patch, other members of *cmd are clobbered, so it could
 be argued that this patch is unnecessary, but at least the Windows code
 path now keeps the same members that the Unix code path keeps, and it
 makes start_command easier to read by moving a loop into a helper.

 -- Hannes

 compat/mingw.c |   16 ++++++++++++++--
 compat/mingw.h |    3 +--
 run-command.c  |    7 ++-----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index bed4178..36ef8d3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -824,7 +824,7 @@ void mingw_execvp(const char *cmd, char *const *argv)
 	free_path_split(path);
 }
 
-char **copy_environ()
+static char **copy_environ(void)
 {
 	char **env;
 	int i = 0;
@@ -861,7 +861,7 @@ static int lookup_env(char **env, const char *name, size_t nmln)
 /*
  * If name contains '=', then sets the variable, otherwise it unsets it
  */
-char **env_setenv(char **env, const char *name)
+static char **env_setenv(char **env, const char *name)
 {
 	char *eq = strchrnul(name, '=');
 	int i = lookup_env(env, name, eq-name);
@@ -886,6 +886,18 @@ char **env_setenv(char **env, const char *name)
 	return env;
 }
 
+/*
+ * Copies global environ and adjusts variables as specified by vars.
+ */
+char **make_augmented_environ(const char *const *vars)
+{
+	char **env = copy_environ();
+
+	while (*vars)
+		env = env_setenv(env, *vars++);
+	return env;
+}
+
 /* this is the first function to call into WS_32; initialize it */
 #undef gethostbyname
 struct hostent *mingw_gethostbyname(const char *host)
diff --git a/compat/mingw.h b/compat/mingw.h
index 948de66..c43917c 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -222,9 +222,8 @@ void mingw_open_html(const char *path);
  * helpers
  */
 
-char **copy_environ(void);
+char **make_augmented_environ(const char *const *vars);
 void free_environ(char **env);
-char **env_setenv(char **env, const char *name);
 
 /*
  * A replacement of main() that ensures that argv[0] has a path
diff --git a/run-command.c b/run-command.c
index f3e7abb..ac314a5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -173,11 +173,8 @@ fail_pipe:
 
 	if (cmd->dir)
 		die("chdir in start_command() not implemented");
-	if (cmd->env) {
-		env = copy_environ();
-		for (; *cmd->env; cmd->env++)
-			env = env_setenv(env, *cmd->env);
-	}
+	if (cmd->env)
+		env = make_augmented_environ(cmd->env);
 
 	if (cmd->git_cmd) {
 		cmd->argv = prepare_git_cmd(cmd->argv);
-- 
1.6.5.rc0.28.gfb9b
