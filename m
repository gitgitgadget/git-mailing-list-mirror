X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH take 3] make 'git add' a first class user friendly interface to
 the index
Date: Mon, 04 Dec 2006 11:13:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612041107060.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 4 Dec 2006 16:13:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33201>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrGRv-0000oc-17 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 17:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937063AbWLDQNm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 11:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937067AbWLDQNm
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 11:13:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10522 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937065AbWLDQNl (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 11:13:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9R00BK0BQR1Z70@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Mon,
 04 Dec 2006 11:13:40 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


This brings the power of the index up front using a proper mental model 
without talking about the index at all. See for example how all the 
technical discussion has been evacuated from the git-add man page.

   Any content to be committed must be added together.  Whether that 
   content comes from new files or modified files doesn't matter.  You 
   just need to "add" it, either with git-add, or by providing 
   git-commit with -a (for already known files only of course).

No need for a separate command to distinguish new vs modified files 
please. That would only screw the mental model everybody should have 
when using GIT.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

This time I incorporated the few remaining suggestions about 
formulation, etc.  I think it should be it.

 Documentation/git-add.txt  |   53 +++++++++++++++++++++++--------------------
 Documentation/tutorial.txt |   46 +++++++++++++++++++++++++++++++++-----
 builtin-add.c              |    6 ++--
 wt-status.c                |    2 +-
 4 files changed, 72 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 6342ea3..16fef1c 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -3,7 +3,7 @@ git-add(1)
 
 NAME
 ----
-git-add - Add files to the index file
+git-add - Add file contents to the changeset to be committed next
 
 SYNOPSIS
 --------
@@ -11,16 +11,31 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-A simple wrapper for git-update-index to add files to the index,
-for people used to do "cvs add".
+All the changed file contents to be committed together in a single set
+of changes must be "added" with the 'add' command before using the
+'commit' command.  This is not only for adding new files.  Even modified
+files must be added to the set of changes about to be committed. 
 
-It only adds non-ignored files, to add ignored files use
+This command can be performed multiple times before a commit. The added
+content corresponds to the state of specified file(s) at the time the
+'add' command is used. This means the 'commit' command will not consider
+subsequent changes to already added content if it is not added again before
+the commit.
+
+The 'git status' command can be used to obtain a summary of what is included
+for the next commit.
+
+This command only adds non-ignored files, to add ignored files use
 "git update-index --add".
 
+Please see gitlink:git-commit[1] for alternative ways to add content to a
+commit.
+
+
 OPTIONS
 -------
 <file>...::
-	Files to add to the index (see gitlink:git-ls-files[1]).
+	Files to add content from.
 
 -n::
         Don't actually add the file(s), just show if they exist.
@@ -34,27 +49,12 @@ OPTIONS
 	for command-line options).
 
 
-DISCUSSION
-----------
-
-The list of <file> given to the command is fed to `git-ls-files`
-command to list files that are not registered in the index and
-are not ignored/excluded by `$GIT_DIR/info/exclude` file or
-`.gitignore` file in each directory.  This means two things:
-
-. You can put the name of a directory on the command line, and
-  the command will add all files in it and its subdirectories;
-
-. Giving the name of a file that is already in index does not
-  run `git-update-index` on that path.
-
-
 EXAMPLES
 --------
 git-add Documentation/\\*.txt::
 
-	Adds all `\*.txt` files that are not in the index under
-	`Documentation` directory and its subdirectories.
+	Adds content from all `\*.txt` files under `Documentation`
+	directory and its subdirectories.
 +
 Note that the asterisk `\*` is quoted from the shell in this
 example; this lets the command to include the files from
@@ -62,15 +62,18 @@ subdirectories of `Documentation/` directory.
 
 git-add git-*.sh::
 
-	Adds all git-*.sh scripts that are not in the index.
+	Considers adding content from all git-*.sh scripts.
 	Because this example lets shell expand the asterisk
 	(i.e. you are listing the files explicitly), it does not
-	add `subdir/git-foo.sh` to the index.
+	consider `subdir/git-foo.sh`.
 
 See Also
 --------
+gitlink:git-status[1]
 gitlink:git-rm[1]
-gitlink:git-ls-files[1]
+gitlink:git-mv[1]
+gitlink:git-commit[1]
+gitlink:git-update-index[1]
 
 Author
 ------
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index fe4491d..361cb8e 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -87,14 +87,48 @@ thorough description.  Tools that turn commits into email, for
 example, use the first line on the Subject line and the rest of the
 commit in the body.
 
-To add a new file, first create the file, then
 
-------------------------------------------------
-$ git add path/to/new/file
-------------------------------------------------
+Git tracks content not files
+----------------------------
+
+With git you have to explicitly "add" all the changed _content_ you
+want to commit together. This can be done in a few different ways:
+
+1) By using 'git add <file_spec>...'
+ 
+   This can be performed multiple times before a commit.  Note that this
+   is not only for adding new files.  Even modified files must be
+   added to the set of changes about to be committed.  The "git status"
+   command gives you a summary of what is included so far for the
+   next commit.  When done you should use the 'git commit' command to
+   make it real.
+
+   Note: don't forget to 'add' a file again if you modified it after the
+   first 'add' and before 'commit'. Otherwise only the previous added
+   state of that file will be committed. This is because git tracks
+   content, so what you're really 'add'ing to the commit is the *content*
+   of the file in the state it is in when you 'add' it.
+
+2) By using 'git commit -a' directly
+
+   This is a quick way to automatically 'add' the content from all files
+   that were modified since the previous commit, and perform the actual
+   commit without having to separately 'add' them beforehand.  This will
+   not add content from new files i.e. files that were never added before.
+   Those files still have to be added explicitly before performing a
+   commit.
+
+But here's a twist. If you do 'git commit <file1> <file2> ...' then only
+the  changes belonging to those explicitly specified files will be
+committed, entirely bypassing the current "added" changes. Those "added"
+changes will still remain available for a subsequent commit though.
+
+However, for normal usage you only have to remember 'git add' + 'git commit'
+and/or 'git commit -a'.
+
 
-then commit as usual.  No special command is required when removing a
-file; just remove it, then tell `commit` about the file as usual.
+Viewing the changelog
+---------------------
 
 At any point you can view the history of your changes using
 
diff --git a/builtin-add.c b/builtin-add.c
index febb75e..b3f9206 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -94,9 +94,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
 
-	if (read_cache() < 0)
-		die("index file corrupt");
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -131,6 +128,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	if (read_cache() < 0)
+		die("index file corrupt");
+
 	for (i = 0; i < dir.nr; i++)
 		add_file_to_index(dir.entries[i]->name, verbose);
 
diff --git a/wt-status.c b/wt-status.c
index de1be5b..4b8b570 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -163,7 +163,7 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 	int i;
 	if (q->nr)
 		wt_status_print_header("Changed but not updated",
-				"use git-update-index to mark for commit");
+				"use git-add on files to include for commit");
 	for (i = 0; i < q->nr; i++)
 		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
 	if (q->nr)
-- 
1.4.4.1.gc419-dirty
