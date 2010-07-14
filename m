From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH/RFC 4/4] Add interactive mode to git-shell for user-friendliness
Date: Tue, 13 Jul 2010 23:01:15 -0400
Message-ID: <1279076475-27730-5-git-send-email-gdb@mit.edu>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Greg Brockman <gdb@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 05:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYsJE-0001Tv-Fq
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 05:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab0GNDGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 23:06:45 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:58170 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755504Ab0GNDGn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 23:06:43 -0400
X-AuditID: 1209190f-b7bd9ae0000009fe-e2-4c3d2895135a
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id F9.C4.02558.5982D3C4; Tue, 13 Jul 2010 23:01:41 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o6E31fr9030246;
	Tue, 13 Jul 2010 23:01:41 -0400
Received: from localhost (EASTCAMPUS-NINE-NINETY-FOUR.MIT.EDU [18.238.6.227])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6E31eKl005150;
	Tue, 13 Jul 2010 23:01:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279076475-27730-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAARUsJJY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150961>

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 shell.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/shell.c b/shell.c
index 3fee0ed..9f80226 100644
--- a/shell.c
+++ b/shell.c
@@ -1,8 +1,11 @@
+#include <stdio.h>
+
 #include "cache.h"
 #include "quote.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
 
+#define MAX_LINE_LEN 128
 #define COMMAND_DIR "git-shell-commands"
 
 static int do_generic_cmd(const char *me, char *arg)
@@ -41,6 +44,26 @@ static int is_valid_cmd_name(const char *cmd)
 	return cmd[strcspn(cmd, "./")] == '\0';
 }
 
+static int run(const char *prog)
+{
+	pid_t pid, res;
+	int w;
+	pid = fork();
+	if (pid == -1) {
+		perror("fork");
+		exit(-1);
+	} else if ( pid == 0 ) {
+		execl(prog, prog, (char *) NULL);
+		if (prog[0] != '\0')
+			fprintf(stderr, "unrecognized command '%s'\n", prog);
+		exit(127);
+	} else {
+		do {
+			res = waitpid (pid, &w, 0);
+		} while (res == -1 && errno == EINTR);
+	}
+}
+
 
 static struct commands {
 	const char *name;
@@ -56,6 +79,7 @@ static struct commands {
 int main(int argc, char **argv)
 {
 	char *prog;
+	char line[MAX_LINE_LEN];
 	struct commands *cmd;
 	int devnull_fd;
 
@@ -81,8 +105,30 @@ int main(int argc, char **argv)
 	 * We do not accept anything but "-c" followed by "cmd arg",
 	 * where "cmd" is a very limited subset of git commands.
 	 */
-	else if (argc != 3 || strcmp(argv[1], "-c"))
-		die("What do you think I am? A shell?");
+	else if (argc != 3 || strcmp(argv[1], "-c")) {
+		if (chdir(COMMAND_DIR))
+			die("Sorry, the interactive git-shell is not enabled");
+		for (;;) {
+			printf("git> ");
+			if (fgets(line, MAX_LINE_LEN, stdin) == NULL) {
+				printf("\n");
+				exit(0);
+			}
+
+			if (line[strlen(line) - 1] == '\n')
+				line[strlen(line) - 1] = '\0';
+
+			if (!strcmp(line, "quit") || !strcmp(line, "logout") ||
+				   !strcmp(line, "exit")) {
+				exit(0);
+			} else if (!strcmp(line, "")) {
+			} else if (is_valid_cmd_name(line)) {
+				run(line);
+			} else {
+				fprintf(stderr, "invalid command format '%s'\n", line);
+			}
+		};
+	}
 
 	prog = argv[2];
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
-- 
1.7.0.4
