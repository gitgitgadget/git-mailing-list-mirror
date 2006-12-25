From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/5] git-add: add ignored files when asked explicitly.
Date: Mon, 25 Dec 2006 03:13:45 -0800
Message-ID: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 25 12:13:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gynm9-0003nr-NM
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 12:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbWLYLNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 06:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbWLYLNr
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 06:13:47 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48112 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbWLYLNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 06:13:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061225111346.FXBH25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 Dec 2006 06:13:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2zDz1W00B1kojtg0000000; Mon, 25 Dec 2006 06:13:59 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35386>

One thing many people found confusing about git-add was that a
file whose name matches an ignored pattern could not be added to
the index.  With this, such a file can be added by explicitly
spelling its name to git-add.

Fileglobs and recursive behaviour do not add ignored files to
the index.  That is, if a pattern '*.o' is in .gitignore, and
two files foo.o, bar/baz.o are in the working tree:

    $ git add foo.o
    $ git add '*.o'
    $ git add bar

Only the first form adds foo.o to the index.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-add.txt |   11 ++++++++---
 builtin-add.c             |   11 ++++++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index d86c0e7..a8ed459 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -25,8 +25,9 @@ the commit.
 The 'git status' command can be used to obtain a summary of what is included
 for the next commit.
 
-This command only adds non-ignored files, to add ignored files use
-"git update-index --add".
+This command can be used to add ignored files, but they have to be
+explicitly and exactly specified from the command line.  File globbing
+and recursive behaviour do not add ignored files.
 
 Please see gitlink:git-commit[1] for alternative ways to add content to a
 commit.
@@ -35,7 +36,11 @@ commit.
 OPTIONS
 -------
 <file>...::
-	Files to add content from.
+	Files to add content from.  Fileglobs (e.g. `*.c`) can
+	be given to add all matching files.  Also a
+	leading directory name (e.g. `dir` to add `dir/file1`
+	and `dir/file2`) can be given to add all files in the
+	directory, recursively.
 
 -n::
         Don't actually add the file(s), just show if they exist.
diff --git a/builtin-add.c b/builtin-add.c
index f306f82..389c106 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -25,7 +25,14 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 	i = dir->nr;
 	while (--i >= 0) {
 		struct dir_entry *entry = *src++;
-		if (!match_pathspec(pathspec, entry->name, entry->len, prefix, seen)) {
+		int how = match_pathspec(pathspec, entry->name, entry->len,
+					 prefix, seen);
+		/*
+		 * ignored entries can be added with exact match,
+		 * but not with glob nor recursive.
+		 */
+		if (!how ||
+		    (entry->ignored_entry && how != MATCHED_EXACTLY)) {
 			free(entry);
 			continue;
 		}
@@ -54,6 +61,8 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec)
 
 	/* Set up the default git porcelain excludes */
 	memset(dir, 0, sizeof(*dir));
+	if (pathspec)
+		dir->show_both = 1;
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
 	if (!access(path, R_OK))
-- 
1.4.4.3.g50da
