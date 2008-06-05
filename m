From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] git-add: introduce --edit (to edit the diff vs. the
 index)
Date: Thu, 5 Jun 2008 11:17:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051116360.21190@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 05 12:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4CZL-0003Ub-Fs
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 12:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbYFEKSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 06:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754750AbYFEKSv
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 06:18:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:60261 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753859AbYFEKSu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 06:18:50 -0400
Received: (qmail invoked by alias); 05 Jun 2008 10:18:48 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp057) with SMTP; 05 Jun 2008 12:18:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VcLUXBwlV/E3PF4OJI04m5x3oyjH98M5LL8TUSL
	dwNm6ARCbh8cCF
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806051115570.21190@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83895>


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

	This was too useful to let slip by.  I even committed it using 
	"git add -e <files>" several times!

	Anyway, bed time.

 Documentation/git-add.txt |    9 ++++++-
 builtin-add.c             |   49 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 3 deletions(-)

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
index 1da22ee..05ae40d 100644
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
@@ -186,6 +186,50 @@ int interactive_add(int argc, const char **argv, const char *prefix)
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
+	if (!st.st_size) {
+		fprintf(stderr, "Empty patch. Aborted.\n");
+		return 0;
+	}
+
+	execl_git_cmd("apply", "--fixup-line-counts", "--cached",
+			lock.filename, NULL);
+
+	return 1;
+}
+
 static struct lock_file lock_file;
 
 static const char ignore_error[] =
@@ -200,6 +244,7 @@ static struct option builtin_add_options[] = {
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
+	OPT_BOOLEAN('e', "edit", &edit_interactive, "super-interactive patching"),
 	OPT_BOOLEAN('f', NULL, &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
@@ -226,6 +271,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
+	if (edit_interactive)
+		return(edit_patch(argc, argv, prefix));
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
-- 
1.5.6.rc1.181.gb439d
