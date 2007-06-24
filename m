From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Clean up internal command handling
Date: Sun, 24 Jun 2007 10:10:40 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706241008060.3593@woody.linux-foundation.org>
References: <87abuq1z6f.fsf@rho.meyering.net> <7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 19:11:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2VcP-00051A-Qe
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 19:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbXFXRLU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 13:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXFXRLU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 13:11:20 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59243 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751777AbXFXRLT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 13:11:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5OHAk1n026248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2007 10:10:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5OHAef9017953;
	Sun, 24 Jun 2007 10:10:40 -0700
In-Reply-To: <alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.061 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50803>


This should change no code at all, it just moves the definition of "struct 
cmd_struct" out, and then splits out the running of the right command into 
the "run_command()" function.

It also removes the long-unused 'envp' pointer passing.

This is just preparation for adding some more error checking.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

 git.c |   52 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/git.c b/git.c
index 29b55a1..6c728e4 100644
--- a/git.c
+++ b/git.c
@@ -216,14 +216,34 @@ const char git_version_string[] = GIT_VERSION;
  */
 #define NOT_BARE 	(1<<2)
 
-static void handle_internal_command(int argc, const char **argv, char **envp)
+struct cmd_struct {
+	const char *cmd;
+	int (*fn)(int, const char **, const char *);
+	int option;
+};
+
+static NORETURN void run_command(struct cmd_struct *p, int argc, const char **argv)
+{
+	const char *prefix;
+
+	prefix = NULL;
+	if (p->option & RUN_SETUP)
+		prefix = setup_git_directory();
+	if (p->option & USE_PAGER)
+		setup_pager();
+	if (p->option & NOT_BARE) {
+		if (is_bare_repository() || is_inside_git_dir())
+			die("%s must be run in a work tree", p->cmd);
+	}
+	trace_argv_printf(argv, argc, "trace: built-in: git");
+
+	exit(p->fn(argc, argv, prefix));
+}
+
+static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
-	static struct cmd_struct {
-		const char *cmd;
-		int (*fn)(int, const char **, const char *);
-		int option;
-	} commands[] = {
+	static struct cmd_struct commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NOT_BARE },
 		{ "annotate", cmd_annotate, RUN_SETUP | USE_PAGER },
 		{ "apply", cmd_apply },
@@ -307,25 +327,13 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
-		const char *prefix;
 		if (strcmp(p->cmd, cmd))
 			continue;
-
-		prefix = NULL;
-		if (p->option & RUN_SETUP)
-			prefix = setup_git_directory();
-		if (p->option & USE_PAGER)
-			setup_pager();
-		if ((p->option & NOT_BARE) &&
-				(is_bare_repository() || is_inside_git_dir()))
-			die("%s must be run in a work tree", cmd);
-		trace_argv_printf(argv, argc, "trace: built-in: git");
-
-		exit(p->fn(argc, argv, prefix));
+		run_command(p, argc, argv);
 	}
 }
 
-int main(int argc, const char **argv, char **envp)
+int main(int argc, const char **argv)
 {
 	const char *cmd = argv[0] ? argv[0] : "git-help";
 	char *slash = strrchr(cmd, '/');
@@ -358,7 +366,7 @@ int main(int argc, const char **argv, char **envp)
 	if (!prefixcmp(cmd, "git-")) {
 		cmd += 4;
 		argv[0] = cmd;
-		handle_internal_command(argc, argv, envp);
+		handle_internal_command(argc, argv);
 		die("cannot handle %s internally", cmd);
 	}
 
@@ -390,7 +398,7 @@ int main(int argc, const char **argv, char **envp)
 
 	while (1) {
 		/* See if it's an internal command */
-		handle_internal_command(argc, argv, envp);
+		handle_internal_command(argc, argv);
 
 		/* .. then try the external ones */
 		execv_git_cmd(argv);
