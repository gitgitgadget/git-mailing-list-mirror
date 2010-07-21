From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH 1/3] Allow creation of arbitrary git-shell commands
Date: Wed, 21 Jul 2010 11:15:53 -0400
Message-ID: <1279725355-23016-2-git-send-email-gdb@mit.edu>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
Cc: Greg Brockman <gdb@mit.edu>
To: j.sixt@viscovery.net, gitster@pobox.com, avarab@gmail.com,
	jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 17:16:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obb2L-0005U8-AQ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 17:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0GUPQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 11:16:20 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:56930 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752517Ab0GUPQT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 11:16:19 -0400
X-AuditID: 12074422-b7bb6ae0000009fa-58-4c470f43f4de
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id 86.39.02554.34F074C4; Wed, 21 Jul 2010 11:16:19 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o6LFGHQJ019919;
	Wed, 21 Jul 2010 11:16:17 -0400
Received: from localhost (dhcp-18-111-45-125.dyn.mit.edu [18.111.45.125])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6LFGGx2005819;
	Wed, 21 Jul 2010 11:16:16 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279725355-23016-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAARVG5Hc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151399>

This provides a mechanism for the server to expose custom
functionality to clients.  My particular use case is that I would like
a way of discovering all repositories available for cloning.  A
client that clones via

  git clone user@example.com

can invoke a command by

  ssh user@example.com $command

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 shell.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/shell.c b/shell.c
index e4864e0..34159c4 100644
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
+	char *prefix = xmalloc((strlen(prog) + strlen(COMMAND_DIR) + 2));
+	strcpy(prefix, COMMAND_DIR);
+	strcat(prefix, "/");
+	strcat(prefix, prog);
+	return prefix;
+}
 
 static struct commands {
 	const char *name;
@@ -48,6 +64,7 @@ static struct commands {
 int main(int argc, char **argv)
 {
 	char *prog;
+	const char **user_argv;
 	struct commands *cmd;
 	int devnull_fd;
 
@@ -76,7 +93,7 @@ int main(int argc, char **argv)
 	else if (argc != 3 || strcmp(argv[1], "-c"))
 		die("What do you think I am? A shell?");
 
-	prog = argv[2];
+	prog = xstrdup(argv[2]);
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
@@ -99,5 +116,18 @@ int main(int argc, char **argv)
 		}
 		exit(cmd->exec(cmd->name, arg));
 	}
-	die("unrecognized command '%s'", prog);
+
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
