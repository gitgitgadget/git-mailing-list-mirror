From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] git-add: introduce --edit (to edit the diff vs. the index)
Date: Wed, 8 Apr 2009 23:30:24 +0200 (CEST)
Message-ID: <61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 08 23:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrfL0-0006dW-AH
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 23:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757933AbZDHV1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 17:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756316AbZDHV1w
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 17:27:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:43973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756028AbZDHV1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 17:27:51 -0400
Received: (qmail invoked by alias); 08 Apr 2009 21:27:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 08 Apr 2009 23:27:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aQ1BdeLga48IukiiiA+F5kgohsie4IGq7qj/gmu
	jBt+8FChb8KMHq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1239225986u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116124>

With "git add -e [<files>]", Git will fire up an editor with the current
diff relative to the index (i.e. what you would get with "git diff
[<files>]").

Now you can edit the patch as much as you like, including adding/removing
lines, editing the text, whatever.  Make sure, though, that the first
character of the hunk lines is still a space, a plus or a minus.

After you closed the editor, Git will adjust the line counts of the hunks 
if necessary, thanks to the --recount option of apply, and commit the 
patch.  Except if you deleted everything, in which case nothing happens 
(for obvious reasons).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I actually promised myself not to resend this patch, but a 
	certain guy who has a hat now asked for it.

 Documentation/git-add.txt |   11 ++++-
 builtin-add.c             |   59 +++++++++++++++++++++++-
 t/t3702-add-edit.sh       |  109 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 4 deletions(-)
 create mode 100755 t/t3702-add-edit.sh

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ce71838..25e6667 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--all | [--update | -u]] [--intent-to-add | -N]
+	  [--edit | -e] [--all | [--update | -u]] [--intent-to-add | -N]
 	  [--refresh] [--ignore-errors] [--] <filepattern>...
 
 DESCRIPTION
@@ -76,6 +76,15 @@ OPTIONS
 	bypassed and the 'patch' subcommand is invoked using each of
 	the specified filepatterns before exiting.
 
+-e, \--edit::
+	Open the diff vs. the index in an editor and let the user
+	edit it.  After the editor was closed, adjust the hunk headers
+	and apply the patch to the index.
++
+*NOTE*: Obviously, if you change anything else than the first character
+on lines beginning with a space or a minus, the patch will no longer
+apply.
+
 -u::
 --update::
 	Update only files that git already knows about, staging modified
diff --git a/builtin-add.c b/builtin-add.c
index cb67d2c..e931974 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -10,12 +10,14 @@
 #include "cache-tree.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "diff.h"
+#include "revision.h"
 
 static const char * const builtin_add_usage[] = {
 	"git add [options] [--] <filepattern>...",
 	NULL
 };
-static int patch_interactive, add_interactive;
+static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
 
 static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
@@ -187,6 +189,51 @@ int interactive_add(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+int edit_patch(int argc, const char **argv, const char *prefix)
+{
+	char *file = xstrdup(git_path("ADD_EDIT.patch"));
+	const char *apply_argv[] = { "apply", "--recount", "--cached",
+		file, NULL };
+	struct child_process child;
+	struct rev_info rev;
+	int out;
+	struct stat st;
+
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+
+	if (read_cache() < 0)
+		die ("Could not read the index");
+
+	init_revisions(&rev, prefix);
+	rev.diffopt.context = 7;
+
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	out = open(file, O_CREAT | O_WRONLY, 0644);
+	if (out < 0)
+		die ("Could not open '%s' for writing.", file);
+	rev.diffopt.file = fdopen(out, "w");
+	rev.diffopt.close_file = 1;
+	if (run_diff_files(&rev, 0))
+		die ("Could not write patch");
+
+	launch_editor(file, NULL, NULL);
+
+	if (stat(file, &st))
+		die("Could not stat '%s'", file);
+	if (!st.st_size)
+		die("Empty patch. Aborted.");
+
+	memset(&child, 0, sizeof(child));
+	child.git_cmd = 1;
+	child.argv = apply_argv;
+	if (run_command(&child))
+		die ("Could not apply '%s'", file);
+
+	unlink(file);
+	return 0;
+}
+
 static struct lock_file lock_file;
 
 static const char ignore_error[] =
@@ -201,6 +248,7 @@ static struct option builtin_add_options[] = {
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
+	OPT_BOOLEAN('e', "edit", &edit_interactive, "super-interactive patching"),
 	OPT_BOOLEAN('f', "force", &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked files"),
 	OPT_BOOLEAN('N', "intent-to-add", &intent_to_add, "record only the fact that the path will be added later"),
@@ -251,14 +299,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int require_pathspec;
 
 	argc = parse_options(argc, argv, builtin_add_options,
-			  builtin_add_usage, 0);
+			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
-		exit(interactive_add(argc, argv, prefix));
+		exit(interactive_add(argc - 1, argv + 1, prefix));
 
 	git_config(add_config, NULL);
 
+	if (edit_interactive)
+		return(edit_patch(argc, argv, prefix));
+	argc--;
+	argv++;
+
 	if (addremove && take_worktree_changes)
 		die("-A and -u are mutually incompatible");
 	if ((addremove || take_worktree_changes) && !argc) {
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
new file mode 100755
index 0000000..7262786
--- /dev/null
+++ b/t/t3702-add-edit.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='add -e basic tests'
+. ./test-lib.sh
+
+
+cat > file << EOF
+LO, praise of the prowess of people-kings
+of spear-armed Danes, in days long sped,
+we have heard, and what honor the athelings won!
+Oft Scyld the Scefing from squadroned foes,
+from many a tribe, the mead-bench tore,
+awing the earls. Since erst he lay
+friendless, a foundling, fate repaid him:
+for he waxed under welkin, in wealth he throve,
+till before him the folk, both far and near,
+who house by the whale-path, heard his mandate,
+gave him gifts:  a good king he!
+EOF
+
+test_expect_success 'setup' '
+
+	git add file &&
+	test_tick &&
+	git commit -m initial file
+
+'
+
+cat > expected-patch << EOF
+diff --git a/file b/file
+index b9834b5..0b8f197 100644
+--- a/file
++++ b/file
+@@ -1,11 +1,3 @@
+-LO, praise of the prowess of people-kings
+-of spear-armed Danes, in days long sped,
+-we have heard, and what honor the athelings won!
+-Oft Scyld the Scefing from squadroned foes,
+-from many a tribe, the mead-bench tore,
+-awing the earls. Since erst he lay
+-friendless, a foundling, fate repaid him:
+-for he waxed under welkin, in wealth he throve,
+-till before him the folk, both far and near,
+-who house by the whale-path, heard his mandate,
+-gave him gifts:  a good king he!
++#!$SHELL_PATH
++mv -f "\$1" orig-patch &&
++mv -f patch "\$1"
+EOF
+
+cat > patch << EOF
+diff --git a/file b/file
+index b9834b5..ef6e94c 100644
+--- a/file
++++ b/file
+@@ -3,1 +3,333 @@ of spear-armed Danes, in days long sped,
+ we have heard, and what honor the athelings won!
++
+ Oft Scyld the Scefing from squadroned foes,
+@@ -2,7 +1,5 @@ awing the earls. Since erst he lay
+ friendless, a foundling, fate repaid him:
++
+ for he waxed under welkin, in wealth he throve,
+EOF
+
+cat > expected << EOF
+diff --git a/file b/file
+index b9834b5..ef6e94c 100644
+--- a/file
++++ b/file
+@@ -1,10 +1,12 @@
+ LO, praise of the prowess of people-kings
+ of spear-armed Danes, in days long sped,
+ we have heard, and what honor the athelings won!
++
+ Oft Scyld the Scefing from squadroned foes,
+ from many a tribe, the mead-bench tore,
+ awing the earls. Since erst he lay
+ friendless, a foundling, fate repaid him:
++
+ for he waxed under welkin, in wealth he throve,
+ till before him the folk, both far and near,
+ who house by the whale-path, heard his mandate,
+EOF
+
+echo "#!$SHELL_PATH" >fake-editor.sh
+cat >> fake-editor.sh <<\EOF
+mv -f "$1" orig-patch &&
+mv -f patch "$1"
+EOF
+
+test_set_editor "$(pwd)/fake-editor.sh"
+chmod a+x fake-editor.sh
+
+test_expect_success 'add -e' '
+
+	cp fake-editor.sh file &&
+	git add -e &&
+	test_cmp fake-editor.sh file &&
+	test_cmp orig-patch expected-patch &&
+	git diff --cached > out &&
+	test_cmp out expected
+
+'
+
+test_done
-- 
1.6.2.1.613.g25746
