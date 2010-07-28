From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCHv4 1/3] Allow creation of arbitrary git-shell commands
Date: Wed, 28 Jul 2010 00:43:02 -0700
Message-ID: <1280302984-1752-2-git-send-email-gdb@mit.edu>
References: <1280302984-1752-1-git-send-email-gdb@mit.edu>
To: jrnieder@gmail.com, j.sixt@viscovery.net, avarab@gmail.com,
	gitster@pobox.com, git@vger.kernel.org, gdb@mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 28 09:43:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe1Ir-00013z-MC
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661Ab0G1Hnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 03:43:43 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:57488 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752740Ab0G1Hnl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 03:43:41 -0400
X-AuditID: 12074425-b7bfeae000000a0d-d1-4c4fdfafbce8
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 53.3F.02573.FAFDF4C4; Wed, 28 Jul 2010 03:43:43 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o6S7he4L023789;
	Wed, 28 Jul 2010 03:43:40 -0400
Received: from localhost (76-191-199-59.dsl.dynamic.sonic.net [76.191.199.59])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6S7hclp020117;
	Wed, 28 Jul 2010 03:43:39 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280302984-1752-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAARVhuzw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152049>

This provides a mechanism for the server to expose custom
functionality to clients.  My particular use case is that I would like
a way of discovering all repositories available for cloning.  A
client that clones via

  git clone user@example.com

can invoke a command by

  ssh user@example.com $command

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 shell.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 41 insertions(+), 2 deletions(-)

This patch differs from its v3 version by the addition of a 'cd_to_homedir' method
and a call to it prior to running any commands in git-shell-commands.  This ensures
that all commands are run out of $HOME/git-shell-commands.

diff --git a/shell.c b/shell.c
index e4864e0..88b29aa 100644
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
@@ -33,6 +35,28 @@ static int do_cvs_cmd(const char *me, char *arg)
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
+	char *prefix = xmalloc((strlen(prog) + strlen(COMMAND_DIR) + 2));
+	strcpy(prefix, COMMAND_DIR);
+	strcat(prefix, "/");
+	strcat(prefix, prog);
+	return prefix;
+}
+
+static void cd_to_homedir(void) {
+	struct passwd *pw = getpwuid(geteuid());
+	if (pw == NULL)
+		die("could not retrieve user's passwd entry");
+	if (chdir(pw->pw_dir) == -1)
+		die("could not chdir to user's home directory");
+}
 
 static struct commands {
 	const char *name;
@@ -48,6 +72,7 @@ static struct commands {
 int main(int argc, char **argv)
 {
 	char *prog;
+	const char **user_argv;
 	struct commands *cmd;
 	int devnull_fd;
 
@@ -76,7 +101,7 @@ int main(int argc, char **argv)
 	else if (argc != 3 || strcmp(argv[1], "-c"))
 		die("What do you think I am? A shell?");
 
-	prog = argv[2];
+	prog = xstrdup(argv[2]);
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
@@ -99,5 +124,19 @@ int main(int argc, char **argv)
 		}
 		exit(cmd->exec(cmd->name, arg));
 	}
-	die("unrecognized command '%s'", prog);
+
+	cd_to_homedir();
+	if (split_cmdline(prog, &user_argv) != -1) {
+		if (is_valid_cmd_name(user_argv[0])) {
+			prog = make_cmd(user_argv[0]);
+			user_argv[0] = prog;
+			execv(user_argv[0], (char *const *) user_argv);
+		}
+		free(prog);
+		free(user_argv);
+		die("unrecognized command '%s'", argv[2]);
+	} else {
+		free(prog);
+		die("invalid command format '%s'", argv[2]);
+	}
 }
-- 
1.7.0.4
