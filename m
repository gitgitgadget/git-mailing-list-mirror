From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCHv4 2/3] Add interactive mode to git-shell for user-friendliness
Date: Wed, 28 Jul 2010 00:43:03 -0700
Message-ID: <1280302984-1752-3-git-send-email-gdb@mit.edu>
References: <1280302984-1752-1-git-send-email-gdb@mit.edu>
To: jrnieder@gmail.com, j.sixt@viscovery.net, avarab@gmail.com,
	gitster@pobox.com, git@vger.kernel.org, gdb@mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 28 09:44:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe1JN-0001Jk-C5
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab0G1Hny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 03:43:54 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:43117 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754141Ab0G1Hnx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 03:43:53 -0400
X-AuditID: 1209190e-b7bbeae000000a09-dc-4c4fdfba5d83
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 7D.02.02569.ABFDF4C4; Wed, 28 Jul 2010 03:43:54 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o6S7hp1B023791;
	Wed, 28 Jul 2010 03:43:51 -0400
Received: from localhost (76-191-199-59.dsl.dynamic.sonic.net [76.191.199.59])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6S7hnGO020125;
	Wed, 28 Jul 2010 03:43:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280302984-1752-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAARVhuzw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152052>

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 shell.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 70 insertions(+), 6 deletions(-)

This patch differs from v3 by the addition of a 'cd_to_homedir' call prior to
spawning the shell.

diff --git a/shell.c b/shell.c
index 88b29aa..a40b839 100644
--- a/shell.c
+++ b/shell.c
@@ -2,8 +2,10 @@
 #include "quote.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
+#include "run-command.h"
 
 #define COMMAND_DIR "git-shell-commands"
+#define HELP_COMMAND COMMAND_DIR "/help"
 
 static int do_generic_cmd(const char *me, char *arg)
 {
@@ -58,6 +60,56 @@ static void cd_to_homedir(void) {
 		die("could not chdir to user's home directory");
 }
 
+static void run_shell(void)
+{
+	int done = 0;
+	static const char *help_argv[] = { HELP_COMMAND, NULL };
+	/* Print help if enabled */
+	run_command_v_opt(help_argv, RUN_SILENT_EXEC_FAILURE);
+
+	do {
+		struct strbuf line = STRBUF_INIT;
+		const char *prog;
+		char *full_cmd;
+		char *rawargs;
+		const char **argv;
+		int code;
+
+		fprintf(stderr, "git> ");
+		if (strbuf_getline(&line, stdin, '\n') == EOF) {
+			fprintf(stderr, "\n");
+			strbuf_release(&line);
+			break;
+		}
+		strbuf_trim(&line);
+		rawargs = strbuf_detach(&line, NULL);
+		if (split_cmdline(rawargs, &argv) == -1) {
+			free(rawargs);
+			continue;
+		}
+
+		prog = argv[0];
+		if (!strcmp(prog, "")) {
+		} else if (!strcmp(prog, "quit") || !strcmp(prog, "logout") ||
+			   !strcmp(prog, "exit") || !strcmp(prog, "bye")) {
+			done = 1;
+		} else if (is_valid_cmd_name(prog)) {
+			full_cmd = make_cmd(prog);
+			argv[0] = full_cmd;
+			code = run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE);
+			if (code == -1 && errno == ENOENT) {
+				fprintf(stderr, "unrecognized command '%s'\n", prog);
+			}
+			free(full_cmd);
+		} else {
+			fprintf(stderr, "invalid command format '%s'\n", prog);
+		}
+
+		free(argv);
+		free(rawargs);
+	} while (!done);
+}
+
 static struct commands {
 	const char *name;
 	int (*exec)(const char *me, char *arg);
@@ -91,15 +143,27 @@ int main(int argc, char **argv)
 	/*
 	 * Special hack to pretend to be a CVS server
 	 */
-	if (argc == 2 && !strcmp(argv[1], "cvs server"))
+	if (argc == 2 && !strcmp(argv[1], "cvs server")) {
 		argv--;
-
+	}
 	/*
-	 * We do not accept anything but "-c" followed by "cmd arg",
-	 * where "cmd" is a very limited subset of git commands.
+	 * Allow the user to run an interactive shell
 	 */
-	else if (argc != 3 || strcmp(argv[1], "-c"))
-		die("What do you think I am? A shell?");
+	else if (argc == 1) {
+		cd_to_homedir();
+		if (access(COMMAND_DIR, R_OK | X_OK) == -1)
+			die("Sorry, the interactive git-shell is not enabled");
+		run_shell();
+		exit(0);
+	}
+	/*
+	 * We do not accept any other modes except "-c" followed by
+	 * "cmd arg", where "cmd" is a very limited subset of git
+	 * commands or a command in the COMMAND_DIR
+	 */
+	else if (argc != 3 || strcmp(argv[1], "-c")) {
+		die("Run with no arguments or with -c cmd");
+	}
 
 	prog = xstrdup(argv[2]);
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
-- 
1.7.0.4
