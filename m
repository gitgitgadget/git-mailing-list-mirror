From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCHv4 1/3] Allow creation of arbitrary git-shell commands
Date: Wed, 28 Jul 2010 17:31:01 -0700
Message-ID: <AANLkTim=iJUCZW+9Ttssnp=NpOpeQEhXsumCPw=HykX=@mail.gmail.com>
References: <1280302984-1752-1-git-send-email-gdb@mit.edu>
	<1280302984-1752-2-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: jrnieder@gmail.com, j.sixt@viscovery.net, avarab@gmail.com,
	gitster@pobox.com, git@vger.kernel.org, gdb@mit.edu
X-From: git-owner@vger.kernel.org Thu Jul 29 02:31:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeH1l-0002EI-Jk
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 02:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab0G2AbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 20:31:09 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:45778 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750889Ab0G2AbG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 20:31:06 -0400
X-AuditID: 12074422-b7bb6ae0000009fa-35-4c50cbc9cd3d
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id DA.B1.02554.9CBC05C4; Wed, 28 Jul 2010 20:31:05 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6T0V325020672
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 20:31:03 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6T0V2mB017386
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 20:31:03 -0400 (EDT)
Received: by iwn7 with SMTP id 7so5110258iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 17:31:01 -0700 (PDT)
Received: by 10.231.15.68 with SMTP id j4mr12935448iba.184.1280363461858; Wed, 
	28 Jul 2010 17:31:01 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Wed, 28 Jul 2010 17:31:01 -0700 (PDT)
In-Reply-To: <1280302984-1752-2-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAAxVg7SYVYaj1FWG7PA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152133>

This provides a mechanism for the server to expose custom
functionality to clients.  My particular use case is that I would like
a way of discovering all repositories available for cloning.  A
client that clones via

  git clone user@example.com

can invoke a command by

  ssh user@example.com $command

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 shell.c |   44 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 42 insertions(+), 2 deletions(-)

As discussed on-list, it should be fine to trust the value of HOME.
This patch differs from the previous only in the implementation of
cd_to_homedir.

diff --git a/shell.c b/shell.c
index e4864e0..1e6077d 100644
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
@@ -33,6 +35,29 @@ static int do_cvs_cmd(const char *me, char *arg)
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
+static void cd_to_homedir(void)
+{
+	char *home = getenv("HOME");
+	if (!home)
+		die("could not determine user's home directory; HOME is unset");
+	if (chdir(home) == -1)
+		die("could not chdir to user's home directory");
+}

 static struct commands {
 	const char *name;
@@ -48,6 +73,7 @@ static struct commands {
 int main(int argc, char **argv)
 {
 	char *prog;
+	const char **user_argv;
 	struct commands *cmd;
 	int devnull_fd;

@@ -76,7 +102,7 @@ int main(int argc, char **argv)
 	else if (argc != 3 || strcmp(argv[1], "-c"))
 		die("What do you think I am? A shell?");

-	prog = argv[2];
+	prog = xstrdup(argv[2]);
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
@@ -99,5 +125,19 @@ int main(int argc, char **argv)
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
