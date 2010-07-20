From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH 4/4] Add interactive mode to git-shell for user-friendliness
Date: Tue, 20 Jul 2010 01:16:12 -0400
Message-ID: <1279602972-1264-5-git-send-email-gdb@mit.edu>
References: <1279602972-1264-1-git-send-email-gdb@mit.edu>
Cc: Greg Brockman <gdb@mit.edu>
To: j.sixt@viscovery.net, git@vger.kernel.org, gitster@pobox.com,
	avarab@gmail.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 20 07:17:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob5CZ-0001ZB-Ss
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 07:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab0GTFQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 01:16:45 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:63539 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753813Ab0GTFQn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 01:16:43 -0400
X-AuditID: 12074422-b7bb6ae0000009fa-eb-4c45313b7fa7
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id 24.C4.02554.B31354C4; Tue, 20 Jul 2010 01:16:44 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o6K5Gf1s007998;
	Tue, 20 Jul 2010 01:16:41 -0400
Received: from localhost (STRATTON-FIVE-FIFTY-FOUR.MIT.EDU [18.187.7.43])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6K5GeHA001125;
	Tue, 20 Jul 2010 01:16:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279602972-1264-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAARUsJJY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151301>

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 shell.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/shell.c b/shell.c
index fe1fe73..142d201 100644
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
@@ -50,6 +52,56 @@ static char *make_cmd(const char *prog)
 	return prefix;
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
@@ -84,15 +136,26 @@ int main(int argc, char **argv)
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
 
 	prog = argv[2];
 	prog_cpy = xstrdup(prog);
-- 
1.7.0.4
