From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git wrapper: add --git-path=<path> and --bare options
Date: Tue, 25 Jul 2006 20:24:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607252022370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607251926190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607251042120.29649@g5.osdl.org>
 <Pine.LNX.4.63.0607251952000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jul 25 20:24:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Ra0-0006UZ-R7
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 20:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWGYSYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 14:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWGYSYZ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 14:24:25 -0400
Received: from mail.gmx.net ([213.165.64.21]:50407 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750832AbWGYSYY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 14:24:24 -0400
Received: (qmail invoked by alias); 25 Jul 2006 18:24:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 25 Jul 2006 20:24:23 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0607251952000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24182>


With this, you can say

	git --bare repack -a -d

inside a bare repository, and it will actually work. While at it,
also move the --version, --help and --exec-path options to the
handle_options() function.

While at documenting the new options, also document the --paginate
option.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
	The change in builtin-help.c is not only clean, but is also
	necessary for t0000 on cygwin.

	I have to run off now, but will answer your comments in
	about three hours.

 Documentation/git.txt |   12 ++++++
 builtin-help.c        |    2 +
 git.c                 |   93 +++++++++++++++++++++++++------------------------
 3 files changed, 60 insertions(+), 47 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index ce30581..29aebe9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -8,7 +8,8 @@ git - the stupid content tracker
 
 SYNOPSIS
 --------
-'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ARGS]
+'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
+	[--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]
 
 DESCRIPTION
 -----------
@@ -41,6 +42,15 @@ OPTIONS
 	environment variable. If no path is given 'git' will print
 	the current setting and then exit.
 
+-p|--paginate::
+	Pipe all output into 'less' (or if set, $PAGER).
+
+--git-dir=<path>::
+	Set the path to the repository. This can also be controlled by
+	setting the GIT_DIR environment variable.
+
+--bare::
+	Same as --git-path=`pwd`.
 
 FURTHER DOCUMENTATION
 ---------------------
diff --git a/builtin-help.c b/builtin-help.c
index 335fe5f..bc1b4da 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -229,7 +229,7 @@ int cmd_version(int argc, const char **a
 
 int cmd_help(int argc, const char **argv, char **envp)
 {
-	const char *help_cmd = argv[1];
+	const char *help_cmd = argc > 1 ? argv[1] : NULL;
 	if (!help_cmd)
 		cmd_usage(0, git_exec_path(), NULL);
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a"))
diff --git a/git.c b/git.c
index 8d7c644..e4b2174 100644
--- a/git.c
+++ b/git.c
@@ -44,10 +44,44 @@ static int handle_options(const char*** 
 		if (cmd[0] != '-')
 			break;
 
-		if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
+		/*
+		 * For legacy reasons, the "version" and "help"
+		 * commands can be written with "--" prepended
+		 * to make them look like flags.
+		 */
+		if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version"))
+			break;
+
+		/*
+		 * Check remaining flags (which by now must be
+		 * "--exec-path", but maybe we will accept
+		 * other arguments some day)
+		 */
+		if (!strncmp(cmd, "--exec-path", 11)) {
+			cmd += 11;
+			if (*cmd == '=')
+				git_set_exec_path(cmd + 1);
+			else {
+				puts(git_exec_path());
+				exit(0);
+			}
+		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			setup_pager();
-		} else
-			die ("Unknown option: %s", cmd);
+		} else if (!strcmp(cmd, "--git-dir")) {
+			if (*argc < 1)
+				return -1;
+			setenv("GIT_DIR", (*argv)[1], 1);
+			(*argv)++;
+			(*argc)--;
+		} else if (!strncmp(cmd, "--git-dir=", 10)) {
+			setenv("GIT_DIR", cmd + 10, 1);
+		} else if (!strcmp(cmd, "--bare")) {
+			static char git_dir[1024];
+			setenv("GIT_DIR", getcwd(git_dir, 1024), 1);
+		} else {
+			fprintf(stderr, "Unknown option: %s\n", cmd);
+			cmd_usage(0, NULL, NULL);
+		}
 
 		(*argv)++;
 		(*argc)--;
@@ -294,50 +328,19 @@ int main(int argc, const char **argv, ch
 		die("cannot handle %s internally", cmd);
 	}
 
-	/* Default command: "help" */
-	cmd = "help";
-
 	/* Look for flags.. */
-	while (argc > 1) {
-		argv++;
-		argc--;
-
-		handle_options(&argv, &argc);
-			
-		cmd = *argv;
-
-		if (strncmp(cmd, "--", 2))
-			break;
-
-		cmd += 2;
-
-		/*
-		 * For legacy reasons, the "version" and "help"
-		 * commands can be written with "--" prepended
-		 * to make them look like flags.
-		 */
-		if (!strcmp(cmd, "help"))
-			break;
-		if (!strcmp(cmd, "version"))
-			break;
-
-		/*
-		 * Check remaining flags (which by now must be
-		 * "--exec-path", but maybe we will accept
-		 * other arguments some day)
-		 */
-		if (!strncmp(cmd, "exec-path", 9)) {
-			cmd += 9;
-			if (*cmd == '=') {
-				git_set_exec_path(cmd + 1);
-				continue;
-			}
-			puts(git_exec_path());
-			exit(0);
-		}
-		cmd_usage(0, NULL, NULL);
+	argv++;
+	argc--;
+	handle_options(&argv, &argc);
+	if (argc > 0) {
+		if (!strncmp(argv[0], "--", 2))
+			argv[0] += 2;
+	} else {
+		/* Default command: "help" */
+		argv[0] = "help";
+		argc = 1;
 	}
-	argv[0] = cmd;
+	cmd = argv[0];
 
 	/*
 	 * We search for git commands in the following order:
-- 
1.4.2.rc1.g8b0c5
