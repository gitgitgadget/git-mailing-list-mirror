From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3] add: warn when -u or -A is used without filepattern
Date: Mon, 28 Jan 2013 10:16:33 +0100
Message-ID: <1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqobg966cv.fsf@grenoble-inp.fr>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 28 10:17:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzkqM-0004SW-Am
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 10:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab3A1JRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 04:17:04 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48886 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754128Ab3A1JRC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 04:17:02 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0S9Gs5o028049
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Jan 2013 10:16:54 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Tzkpj-0008A2-7s; Mon, 28 Jan 2013 10:16:55 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Tzkpj-0002r9-3e; Mon, 28 Jan 2013 10:16:55 +0100
X-Mailer: git-send-email 1.8.1.1.440.g1d329bd.dirty
In-Reply-To: <vpqobg966cv.fsf@grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Jan 2013 10:16:54 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0S9Gs5o028049
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1359969416.49913@nukbYUG/nNTO/7pEOoa5Sg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214822>

Most git commands that can be used with our without a filepattern are
tree-wide by default, the filepattern being used to restrict their scope.
A few exceptions are: 'git grep', 'git clean', 'git add -u' and 'git add -A'.

The inconsistency of 'git add -u' and 'git add -A' are particularly
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

When the command is called from the root of the tree, there is no
ambiguity and no need to change the behavior, hence no need to warn.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Changes since v2:

* Typo consistant -> consistent

* Mention both short and long option names (Thanks Junio). I went for
  a two-lines display which I find a bit nicer to read than Junio's
  version, but I'm fine with both.

 Documentation/git-add.txt |  7 ++++---
 builtin/add.c             | 44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 4 deletions(-)

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
index 7cb6cca..7738025 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -321,6 +321,35 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
+static void warn_pathless_add(const char *option_name, const char *short_name) {
+	/*
+	 * To be consistent with "git add -p" and most Git
+	 * commands, we should default to being tree-wide, but
+	 * this is not the original behavior and can't be
+	 * changed until users trained themselves not to type
+	 * "git add -u" or "git add -A". For now, we warn and
+	 * keep the old behavior. Later, this warning can be
+	 * turned into a die(...), and eventually we may
+	 * reallow the command with a new behavior.
+	 */
+	warning(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
+		  "subdirectory of the tree will change in Git 2.0 and should not be used anymore.\n"
+		  "To add content for the whole tree, run:\n"
+		  "\n"
+		  "  git add %s :/\n"
+		  "  (or git add %s :/)\n"
+		  "\n"
+		  "To restrict the command to the current directory, run:\n"
+		  "\n"
+		  "  git add %s .\n"
+		  "  (or git add %s .)\n"
+		  "\n"
+		  "With the current Git version, the command is restricted to the current directory."),
+		option_name, short_name,
+		option_name, short_name,
+		option_name, short_name);
+}
+
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -331,6 +360,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
+	const char *option_with_implicit_dot = NULL;
+	const char *short_option_with_implicit_dot = NULL;
 
 	git_config(add_config, NULL);
 
@@ -350,8 +381,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die(_("-A and -u are mutually incompatible"));
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
-	if ((addremove || take_worktree_changes) && !argc) {
+	if (addremove) {
+		option_with_implicit_dot = "--all";
+		short_option_with_implicit_dot = "-A";
+	}
+	if (take_worktree_changes) {
+		option_with_implicit_dot = "--update";
+		short_option_with_implicit_dot = "-u";
+	}
+	if (option_with_implicit_dot && !argc) {
 		static const char *here[2] = { ".", NULL };
+		if (prefix)
+			warn_pathless_add(option_with_implicit_dot,
+					  short_option_with_implicit_dot);
 		argc = 1;
 		argv = here;
 	}
-- 
1.8.1.1.440.g1d329bd.dirty
