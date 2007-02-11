From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/2] Allow aliases to expand to shell commands
Date: Sat, 10 Feb 2007 19:33:58 -0500
Message-ID: <1171154038770-git-send-email-tytso@mit.edu>
References: <11711540383470-git-send-email-tytso@mit.edu> <1171154038778-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 01:34:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG2fR-0007w2-5U
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 01:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbXBKAeG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 19:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbXBKAeF
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 19:34:05 -0500
Received: from THUNK.ORG ([69.25.196.29]:58108 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289AbXBKAeB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 19:34:01 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HG2kR-0003fU-EL; Sat, 10 Feb 2007 19:39:19 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HG2fG-0002Ab-Vo; Sat, 10 Feb 2007 19:33:58 -0500
X-Mailer: git-send-email 1.5.0.rc4.2.g4249
In-Reply-To: <1171154038778-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39267>

If the alias expansion is prefixed with an exclamation point, treat
it as a shell command which is run using system(3).

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/config.txt |    6 ++++++
 git.c                    |   10 ++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e650af..e6e9409 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -222,6 +222,12 @@ alias.*::
 	spaces, the usual shell quoting and escaping is supported.
 	quote pair and a backslash can be used to quote them.
 
+	If the alias expansion is prefixed with an exclamation point,
+	it will be treated as a shell command.  For example, defining
+	"alias.new = !gitk --all --not ORIG_HEAD", the invocation 
+	"git new" is equivalent to running the shell command 
+	"gitk --all --not ORIG_HEAD".
+
 apply.whitespace::
 	Tells `git-apply` how to handle whitespaces, in the same way
 	as the '--whitespace' option. See gitlink:git-apply[1].
diff --git a/git.c b/git.c
index c43d4ff..2f10d50 100644
--- a/git.c
+++ b/git.c
@@ -159,6 +159,16 @@ static int handle_alias(int *argcp, const char ***argv)
 	alias_command = (*argv)[0];
 	git_config(git_alias_config);
 	if (alias_string) {
+		if (alias_string[0] == '!') {
+			trace_printf("trace: alias to shell cmd: %s => %s\n",
+				     alias_command, alias_string + 1);
+			ret = system(alias_string + 1);
+			if (ret >= 0 && WIFEXITED(ret) && 
+			    WEXITSTATUS(ret) != 127)
+				exit(WEXITSTATUS(ret));
+			die("Failed to run '%s' when expanding alias '%s'\n", 
+			    alias_string + 1, alias_command);
+		}
 		count = split_cmdline(alias_string, &new_argv);
 		option_count = handle_options(&new_argv, &count);
 		memmove(new_argv - option_count, new_argv,
-- 
1.5.0.rc4.2.g4249
