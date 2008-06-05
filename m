From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 2/2] git-add: introduce --edit (to edit the diff vs. the
 index)
Date: Thu, 5 Jun 2008 17:20:46 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051720300.21190@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 18:23:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4IF3-0004LM-2c
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 18:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760558AbYFEQWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 12:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759723AbYFEQWS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 12:22:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:36138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761018AbYFEQWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 12:22:14 -0400
Received: (qmail invoked by alias); 05 Jun 2008 16:22:12 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 05 Jun 2008 18:22:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ZUap5I5GZ0ZINMox8rlKHTTgbe5TEbtbjiK5zT7
	7c7UK0W3+w64Rw
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806051719170.21190@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83942>


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
---
 Documentation/git-add.txt |    9 ++++-
 builtin-add.c             |   47 ++++++++++++++++++++++++-
 t/t3702-add-edit.sh       |   86 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 3 deletions(-)
 create mode 100755 t/t3702-add-edit.sh

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 1afd0c6..dd744f1 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -8,8 +8,8 @@ git-add - Add file contents to the index
 SYNOPSIS
 --------
 [verse]
-'git-add' [-n] [-v] [-f] [--interactive | -i] [--patch | -p] [-u] [--refresh]
-	  [--ignore-errors] [--] <filepattern>...
+'git-add' [-n] [-v] [-f] [--interactive | -i] [--patch | -p] [--edit | -e]
+	  [-u] [--refresh] [--ignore-errors] [--] <filepattern>...
 
 DESCRIPTION
 -----------
@@ -70,6 +70,11 @@ OPTIONS
 	bypassed and the 'patch' subcommand is invoked using each of
 	the specified filepatterns before exiting.
 
+-e, \--edit::
+	Open the diff vs. the index in an editor and let the user
+	edit it.  After the editor was closed, adjust the hunk headers
+	and apply the patch to the index.
+
 -u::
 	Update only files that git already knows about, staging modified
 	content for commit and marking deleted files for removal. This
diff --git a/builtin-add.c b/builtin-add.c
index 1da22ee..216f331 100644
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
@@ -186,6 +186,48 @@ int interactive_add(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+int edit_patch(int argc, const char **argv, const char *prefix)
+{
+	static struct lock_file lock;
+	struct child_process child;
+	int ac;
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
+	child.out = hold_lock_file_for_update(&lock, git_path("EDIT_PATCH"), 1);
+
+	if (run_command(&child))
+		return 1;
+	free(child.argv);
+
+	launch_editor(lock.filename, NULL, NULL);
+
+	if (stat(lock.filename, &st))
+		return 1;
+	if (!st.st_size)
+		die ("Empty patch. Aborted.");
+
+	execl_git_cmd("apply", "--ignore-hunk-headers", "--cached",
+			lock.filename, NULL);
+
+	return 1;
+}
+
 static struct lock_file lock_file;
 
 static const char ignore_error[] =
@@ -200,6 +242,7 @@ static struct option builtin_add_options[] = {
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
+	OPT_BOOLEAN('e', "edit", &edit_interactive, "super-interactive patching"),
 	OPT_BOOLEAN('f', NULL, &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
@@ -226,6 +269,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
+	if (edit_interactive)
+		return(edit_patch(argc, argv, prefix));
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
new file mode 100755
index 0000000..be2f4da
--- /dev/null
+++ b/t/t3702-add-edit.sh
@@ -0,0 +1,86 @@
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
+mv "$1" orig-patch &&
+mv patch "$1"
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
+test_done
-- 
1.5.6.rc1.181.gb439d
