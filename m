From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Mon, 21 Jan 2013 13:00:11 +0100
Message-ID: <1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 13:00:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxG3X-0008BR-I1
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 13:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab3AUMA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 07:00:28 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52361 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab3AUMA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 07:00:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0LC0ISO032002
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2013 13:00:19 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1TxG31-0004ce-VH; Mon, 21 Jan 2013 13:00:19 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1TxG31-0000xE-Qw; Mon, 21 Jan 2013 13:00:19 +0100
X-Mailer: git-send-email 1.8.0.319.g8abfee4
In-Reply-To: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Jan 2013 13:00:19 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0LC0ISO032002
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1359374421.0361@C4kGQcAvGcSPGo0EqdKX8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214113>

Most git commands that can be used with our without a filepattern are
tree-wide by default, the filepattern being used to restrict their scope.
A few exceptions are: 'git grep', 'git clean', 'git add -u' and 'git add -A'.

The inconsistancy of 'git add -u' and 'git add -A' are particularly
problematic since other 'git add' subcommands (namely 'git add -p' and
'git add -e') are tree-wide by default.

Flipping the default now is unacceptable, so this patch starts training
users to type explicitely 'git add -u|-A :/' or 'git add -u|-A .', to prepare
for the next steps:

* forbid 'git add -u|-A' without filepattern (like 'git add' without
  option)

* much later, maybe, re-allow 'git add -u|-A' without filepattern, with a
  tree-wide scope.

A nice side effect of this patch is that it makes the :/ special
filepattern easier to discover for users.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Junio C Hamano <gitster@pobox.com> writes:

> The first step of "git add -u" migration plan would be to warn when
> no argument is given and update all the existing index entries, and
> give the same advise to use either "." or ":/".  Keep this for three
> cycles: 3 * (8 to 10 weeks per cycle) = 27 weeks ~ 1/2 year.

The first step should look like this patch. The message remains vague
about the next steps ("change in a future Git version", no mention of
the exact change nor of the exact version in which it will happen),
but I'm fine with refining it (perhaps this could be a 2.0 change,
like the change to push.default?).

 Documentation/git-add.txt |  7 ++++---
 builtin/add.c             | 30 +++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index fd9e36b..5333559 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -107,9 +107,10 @@ apply to the index. See EDITING PATCHES below.
 	from the index if the corresponding files in the working tree
 	have been removed.
 +
-If no <filepattern> is given, default to "."; in other words,
-update all tracked files in the current directory and its
-subdirectories.
+If no <filepattern> is given, the current version of Git defaults to
+"."; in other words, update all tracked files in the current directory
+and its subdirectories. This default will change in a future version
+of Git, hence the form without <filepattern> should not be used.
 
 -A::
 --all::
diff --git a/builtin/add.c b/builtin/add.c
index e664100..e6eb829 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -373,6 +373,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
+	const char *option_with_implicit_dot = NULL;
 
 	git_config(add_config, NULL);
 
@@ -392,7 +393,34 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die(_("-A and -u are mutually incompatible"));
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
-	if ((addremove || take_worktree_changes) && !argc) {
+	if (addremove)
+		option_with_implicit_dot = "--all";
+	if (take_worktree_changes)
+		option_with_implicit_dot = "--update";
+	if (option_with_implicit_dot && !argc) {
+		/*
+		 * To be consistant with "git add -p" and most Git
+		 * commands, we should default to being tree-wide, but
+		 * this is not the original behavior and can't be
+		 * changed until users trained themselves not to type
+		 * "git add -u" or "git add -A". For now, we warn and
+		 * keep the old behavior. Later, this warning can be
+		 * turned into a die(...), and eventually we may
+		 * reallow the command with a new behavior.
+		 */
+		warning(_("The behavior of 'git add %s' with no path argument will change in a future\n"
+			  "Git version and shouldn't be used anymore.  To add content for the whole tree, run:\n"
+			  "\n"
+			  "  git add %s :/\n"
+			  "\n"
+			  "To restrict the command to the current directory, run:\n"
+			  "\n"
+			  "  git add %s .\n"
+			  "\n"
+			  "With the current Git version, the command is restricted to the current directory."),
+			option_with_implicit_dot,
+			option_with_implicit_dot,
+			option_with_implicit_dot);
 		static const char *here[2] = { ".", NULL };
 		argc = 1;
 		argv = here;
-- 
1.8.0.319.g8abfee4
