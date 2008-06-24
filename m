From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/3] git-add: introduce --edit (to edit the diff vs. the index)
Date: Tue, 24 Jun 2008 20:08:22 +0100
Message-ID: <200806242108.24207.trast@student.ethz.ch>
References: <20080624050901.GA19224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 21:12:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDwS-0004MQ-1a
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYFXTL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYFXTL1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:11:27 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:52328 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359AbYFXTLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:11:25 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 21:11:19 +0200
Received: from [192.168.0.2] ([84.75.156.10]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 21:11:18 +0200
In-Reply-To: <20080624050901.GA19224@sigill.intra.peff.net>
Content-Disposition: inline
X-OriginalArrivalTime: 24 Jun 2008 19:11:18.0869 (UTC) FILETIME=[14F7E850:01C8D62E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86114>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With "git add -e [<files>]", Git will fire up an editor with the current
diff relative to the index (i.e. what you would get with "git diff
[<files>]").

Now you can edit the patch as much as you like, including adding/removing
lines, editing the text, whatever.  Make sure, though, that the first
character of the hunk lines is still a space, a plus or a minus.

After you closed the editor, Git will adjust the line counts of the
hunks if necessary, thanks to the --fixup-line-counts option of apply,
and commit the patch.  Except if you deleted everything, in which case
nothing happens (for obvious reasons).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-add.txt |   12 ++++-
 builtin-add.c             |   55 +++++++++++++++++++-
 t/t3702-add-edit.sh       |  126 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100755 t/t3702-add-edit.sh

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index b8e3fa6..c6de028 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--update | -u] [--refresh] [--ignore-errors] [--]
+	  [--edit | -e] [--update | -u] [--refresh] [--ignore-errors] [--]
 	  <filepattern>...
 
 DESCRIPTION
@@ -76,6 +76,16 @@ OPTIONS
 	bypassed and the 'patch' subcommand is invoked using each of
 	the specified filepatterns before exiting.
 
+-e::
+--edit::
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
index 9930cf5..b9e9a17 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -19,7 +19,7 @@ static const char * const builtin_add_usage[] = {
 	"git-add [options] [--] <filepattern>...",
 	NULL
 };
-static int patch_interactive = 0, add_interactive = 0;
+static int patch_interactive = 0, add_interactive = 0, edit_interactive = 0;
 static int take_worktree_changes;
 
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
@@ -186,6 +186,56 @@ int interactive_add(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+int edit_patch(int argc, const char **argv, const char *prefix)
+{
+	char *file = xstrdup(git_path("ADD_EDIT.patch"));
+	const char *apply_argv[] = { "apply", "--recount", "--cached",
+		file, NULL };
+	struct child_process child;
+	int result = 0, ac;
+	struct stat st;
+
+	memset(&child, 0, sizeof(child));
+	child.argv = xcalloc(sizeof(const char *), (argc + 5));
+	ac = 0;
+	child.git_cmd = 1;
+	child.argv[ac++] = "diff-files";
+	child.argv[ac++] = "--no-color";
+	child.argv[ac++] = "-p";
+	child.argv[ac++] = "--";
+	if (argc) {
+		const char **pathspec = validate_pathspec(argc, argv, prefix);
+		if (!pathspec)
+			return -1;
+		memcpy(&(child.argv[ac]), pathspec, sizeof(*argv) * argc);
+		ac += argc;
+	}
+	child.argv[ac] = NULL;
+	child.out = open(file, O_CREAT | O_WRONLY, 0644);
+	result = child.out < 0 && error("Could not write to '%s'", file);
+
+	if (!result)
+		result = run_command(&child);
+	free(child.argv);
+
+	launch_editor(file, NULL, NULL);
+
+	if (!result)
+		result = stat(file, &st) && error("Could not stat '%s'", file);
+	if (!result && !st.st_size)
+		result = error("Empty patch. Aborted.");
+
+	memset(&child, 0, sizeof(child));
+	child.git_cmd = 1;
+	child.argv = apply_argv;
+	if (!result)
+		result = run_command(&child) &&
+			error("Could not apply '%s'", file);
+	if (!result)
+		unlink(file);
+	return result;
+}
+
 static struct lock_file lock_file;
 
 static const char ignore_error[] =
@@ -202,6 +252,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
 	OPT_BOOLEAN('f', "force", &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked files"),
+	OPT_BOOLEAN('e', "edit", &edit_interactive, "super-interactive patching"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files which cannot be added because of errors"),
 	OPT_END(),
@@ -226,6 +277,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
+	if (edit_interactive)
+		return(edit_patch(argc, argv, prefix));
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
new file mode 100755
index 0000000..decf727
--- /dev/null
+++ b/t/t3702-add-edit.sh
@@ -0,0 +1,126 @@
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
+	git diff --cached > out &&
+	test_cmp out expected
+
+'
+
+cat > patch << EOF
+diff --git a/file b/file
+--- a/file
++++ b/file
+@@ -1,1 +1,1 @@
+ gave him gifts:  a good king he!
++
+EOF
+
+test_expect_success 'add -e adds to the end of the file' '
+
+	test_tick &&
+	git commit -m update &&
+	git checkout &&
+	git add -e &&
+	git diff --cached > out &&
+	test "" = "$(git show :file | tail -n 1)"
+
+'
+
+cat > patch << EOF
+diff --git a/file b/file
+--- a/file
++++ b/file
+@@ -1,1 +1,1 @@
++
+ LO, praise of the prowess of people-kings
+EOF
+
+test_expect_success 'add -e adds to the beginning of the file' '
+
+	test_tick &&
+	git commit -m update &&
+	git checkout &&
+	git add -e &&
+	git diff --cached > out &&
+	test "" = "$(git show :file | head -n 1)"
+
+'
+
+test_done
-- 
1.5.6.84.ge5c1
