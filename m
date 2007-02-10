From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Sat, 10 Feb 2007 13:13:57 -0500
Message-ID: <20070210181357.GE25607@thunk.org>
References: <20070209014852.GA13207@thunk.org> <1171123504783-git-send-email-tytso@mit.edu> <11711235041527-git-send-email-tytso@mit.edu> <11711235042388-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 19:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFwjk-0003rE-OY
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 19:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbXBJSOB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 13:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbXBJSOB
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 13:14:01 -0500
Received: from THUNK.ORG ([69.25.196.29]:53102 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbXBJSOB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 13:14:01 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HFwof-0002g6-Lv; Sat, 10 Feb 2007 13:19:18 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HFwjV-0005Al-VE; Sat, 10 Feb 2007 13:13:57 -0500
Content-Disposition: inline
In-Reply-To: <11711235042388-git-send-email-tytso@mit.edu>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39250>

Here's a revised patch which fixes a stupid spelling typo in the
documentation.  ("eqvuialent" --> "equivalent")

>From c16544aa786b0fb244fd974a22831a1210286ec5 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 10 Feb 2007 10:50:58 -0500
Subject: [PATCH] Allow aliases to expand to shell commands

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
index c43d4ff..fc08396 100644
--- a/git.c
+++ b/git.c
@@ -159,6 +159,16 @@ static int handle_alias(int *argcp, const char ***argv)
 	alias_command = (*argv)[0];
 	git_config(git_alias_config);
 	if (alias_string) {
+		if (alias_string[0] == '!') {
+			trace_printf("trace: alias to shell cmd: %s => %s\n",
+				     alias_command, alias_string+1);
+			ret = system(alias_string+1);
+			if (ret >= 0 && WIFEXITED(ret) && 
+			    WEXITSTATUS(ret) != 127)
+				exit(WEXITSTATUS(ret));
+			die("Failed to run '%s' when expanding alias '%s'\n", 
+			    alias_string, alias_command);
+		}
 		count = split_cmdline(alias_string, &new_argv);
 		option_count = handle_options(&new_argv, &count);
 		memmove(new_argv - option_count, new_argv,
-- 
1.5.0.rc4.2.g4249
