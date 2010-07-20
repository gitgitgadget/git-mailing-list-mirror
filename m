From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH 1/4] Allow creation of arbitrary git-shell commands
Date: Tue, 20 Jul 2010 01:16:09 -0400
Message-ID: <1279602972-1264-2-git-send-email-gdb@mit.edu>
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
	id 1Ob5Ca-0001ZB-CQ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 07:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab0GTFQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 01:16:50 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:63123 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753813Ab0GTFQs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 01:16:48 -0400
X-AuditID: 1209190e-b7bbeae000000a09-3c-4c453141abc0
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 83.23.02569.141354C4; Tue, 20 Jul 2010 01:16:49 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o6K5GWID007374;
	Tue, 20 Jul 2010 01:16:34 -0400
Received: from localhost (STRATTON-FIVE-FIFTY-FOUR.MIT.EDU [18.187.7.43])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6K5GVhw001113;
	Tue, 20 Jul 2010 01:16:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279602972-1264-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAARUsJJY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151302>

This provides a mechanism for the server to expose custom
functionality to clients.  My particular use case is that I would like
a way of discovering all repositories available for cloning.  A
client that clones via

  git clone user@example.com

can invoke a command by

  ssh user@example.com $command

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 shell.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/shell.c b/shell.c
index e4864e0..fe1fe73 100644
--- a/shell.c
+++ b/shell.c
@@ -3,6 +3,8 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 
+#define COMMAND_DIR "git-shell-commands"
+
 static int do_generic_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];
@@ -33,6 +35,20 @@ static int do_cvs_cmd(const char *me, char *arg)
 	return execv_git_cmd(cvsserver_argv);
 }
 
+static int is_valid_cmd_name(const char *cmd)
+{
+	/* Test command contains no . or / characters */
+	return cmd[strcspn(cmd, "./")] == '\0';
+}
+
+static char *make_cmd(const char *prog)
+{
+	char *prefix = xmalloc((strlen(prog) + strlen(COMMAND_DIR) + 2) * sizeof(char));
+	strcpy(prefix, COMMAND_DIR);
+	strcat(prefix, "/");
+	strcat(prefix, prog);
+	return prefix;
+}
 
 static struct commands {
 	const char *name;
@@ -48,6 +64,8 @@ static struct commands {
 int main(int argc, char **argv)
 {
 	char *prog;
+	char *prog_cpy;
+	const char **user_argv;
 	struct commands *cmd;
 	int devnull_fd;
 
@@ -77,6 +95,7 @@ int main(int argc, char **argv)
 		die("What do you think I am? A shell?");
 
 	prog = argv[2];
+	prog_cpy = xstrdup(prog);
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
@@ -99,5 +118,25 @@ int main(int argc, char **argv)
 		}
 		exit(cmd->exec(cmd->name, arg));
 	}
-	die("unrecognized command '%s'", prog);
+
+	if (split_cmdline(prog, &user_argv) != -1) {
+		if (is_valid_cmd_name(user_argv[0])) {
+			prog  = make_cmd(user_argv[0]);
+			user_argv[0] = prog;
+			execv(user_argv[0], (char *const *) user_argv);
+			free(prog);
+		}
+		free(user_argv);
+		/*
+		 * split_cmdline modifies its argument in-place, so 'prog' now
+		 * holds the actual command name
+		 */
+		die("unrecognized command '%s'", prog_cpy);
+	} else {
+		/*
+		 * split_cmdline has clobbered prog and printed an
+		 * error message, so print the original
+		 */
+		die("invalid command format '%s'", prog_cpy);
+	}
 }
-- 
1.7.0.4
