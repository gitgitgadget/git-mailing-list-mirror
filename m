From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH 2/3] Add interactive mode to git-shell for user-friendliness
Date: Wed, 21 Jul 2010 11:15:54 -0400
Message-ID: <1279725355-23016-3-git-send-email-gdb@mit.edu>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
Cc: Greg Brockman <gdb@mit.edu>
To: j.sixt@viscovery.net, gitster@pobox.com, avarab@gmail.com,
	jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 17:16:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obb2L-0005U8-Sm
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 17:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab0GUPQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 11:16:23 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:56930 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752742Ab0GUPQV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 11:16:21 -0400
X-AuditID: 12074422-b7bb6ae0000009fa-70-4c470f473e91
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id 37.39.02554.74F074C4; Wed, 21 Jul 2010 11:16:23 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o6LFGKCe019125;
	Wed, 21 Jul 2010 11:16:20 -0400
Received: from localhost (dhcp-18-111-45-125.dyn.mit.edu [18.111.45.125])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6LFGI5u005831;
	Wed, 21 Jul 2010 11:16:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279725355-23016-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAARVG5Hc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151401>

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 shell.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/shell.c b/shell.c
index 34159c4..f839b53 100644
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
@@ -83,15 +135,26 @@ int main(int argc, char **argv)
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
 
 	prog = xstrdup(argv[2]);
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
-- 
1.7.0.4
