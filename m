X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Documentation/git-commit.txt
Date: Fri, 08 Dec 2006 03:20:32 -0800
Message-ID: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 11:20:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33686>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsdmS-0006eB-O2 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 12:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S938039AbWLHLUe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 06:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938041AbWLHLUe
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 06:20:34 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44343 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S938039AbWLHLUd (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 06:20:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208112032.TLRR18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Fri, 8
 Dec 2006 06:20:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id wBLj1V0071kojtg0000000; Fri, 08 Dec 2006
 06:20:43 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I attempted to rewrite the git-commit documentation.

I think I went overboard and ended up not using the word
"index", but eradicating the word was not my intention.  I think
we should hint how the index is used to implement the semantics
somewhere near the end where it is not distracting to ordinary
users but is accessbile by people who are interested in the
plumbing-Porcelain interface. 

---

  The following patch will _not_ apply as is, as I sprinkled a lot
  of annotations in it, but you should be able to run

          sed -e '/^|/d'

  on it to make it apply if you want.

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 517a86b..50e8fd0 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -14,25 +14,111 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Updates the index file for given paths, or all modified files if
-'-a' is specified, and makes a commit object.  The command specified
-by either the VISUAL or EDITOR environment variables are used to edit
-the commit log message.
|
| General idea; (1) we do not have to say "index" in Porcelain-ish
| documentation.  (2) we should have a separate ENVIRONMENT section
| at the end as all UNIX manpage does.
|
+Records a tree state as a new commit object.  The command is
+used for both recording your own changes and recording the
+result of manual resolution of a conflicted merge.
+
+When recoring your own work, the contents of modified files in
+your working tree are staged with gitlink:git-add[1].  Removal
+of a file are staged with gitlink:git-rm[1].  After building the
+state to be committed incrementally with these commands, `git
+commit` (without any pathname parameter) is used to record what
+has been staged so far.  This is the most basic form of the
+command.  An example:
|
| Give examples early and abundance of them.  Mention add and rm
| as staging commands; technically mv is also a staging command but
| this manpage is not about various ways to stage things, but
| making a commit out of staged state, so omit it.
|
+
+------------
+$ edit hello.c
+$ git rm goodbye.c
+$ git add hello.c
+$ git commit
+------------
+
+////////////
+We should fix 'git rm' to remove goodbye.c from both index and
+working tree for the above example.
+////////////
+
+Instead of staging files after each individual change, you can
+tell `git commit` to notice the changes to the tracked files in
+your working tree and do corresponding `git add` and `git rm`
+for you.  That is, this example does the same as the earlier
+example if there is no other change in your working tree:
+
+------------
+$ edit hello.c
+$ rm goodbye.c
+$ git commit -a
+------------
+
+The command `git commit -a` first looks at your working tree,
+notices that you have modified hello.c and removed goodbye.c,
+and performs necessary `git add` and `git rm` for you.
+
+After staging changes to many files, you can alter the order the
+changes are recorded in, by giving pathnames to `git commit`.
+When pathnames are given, the command makes a commit that
+only records the changes made to the named paths:
+
+------------
+$ edit hello.c hello.h
+$ git add hello.c hello.h
+$ edit Makefile
+$ git commit Makefile
+------------
+
+This makes a commit that records the modification to `Makefile`.
+The changes staged for `hello.c` and `hello.h` are not included
+in the resulting commit.  However, their changes are not lost --
+they are still staged and merely held back.  After the above
+sequence, if you do:
+
+------------
+$ git commit
+------------
+
+this second commit would record the changes to `hello.c` and
+`hello.h` as expected.
+
+
+After a merge (initiated by either gitlink:git-merge[1] or
+gitlink:git-pull[1]) stops because of conflicts, cleanly merged
+paths are already staged to be committed for you, and paths that
+conflicted are left in unmerged state.  You would have to first
+check which paths are conflicting with gitlink:git-ls-files[1]
+and after fixing them manually in your working tree, you would
+stage the result as usual with gitlink:git-add[1]:
+
+------------
+$ git ls-files -u
+100644 c87c61af00c6d2cd7212240e26089e24b90bbe05 1	hello.c
+100644 646b6e73318e04cfff7b20abd5d06be424bce503 2	hello.c
+100644 44b1ce4c6b56348e1661b60fc923cb80cb44d4ff 3	hello.c
+$ edit hello.c
+$ git add hello.c
+------------
|
| Obviously 'ls-files -u' is a plumbing so we might want to give an
| equivalent Porcelain.  We could say 'git status' and have the
| reader look for "unmerged:", which might be better.  I dunno.
|
+
+After resolving conflicts and staging the result, `git ls-files -u`
+would stop mentioning the conflicted path.  When you are done,
+run `git commit` to finally record the merge:
+
+------------
+$ git commit
+------------
+
+As with the case to record your own changes, you can use `-a`
+option to save typing.  One difference is that during a merge
+resolution, you cannot use `git commit` with pathnames to
+alter the order the changes are committed, because the merge
+should be recorded as a single commit.  In fact, the command
+refuses to run when given pathnames (but see `-i` option).
|
| "con paths" form is really about 'alter the order of things
| that are committed', in other words 'you may have started 
| staging but we let you split what is staged'.  Once the reader
| understands it, it should be natural why we cannot use "paths"
| during a merge resolution.
|
 
-Several environment variable are used during commits.  They are
-documented in gitlink:git-commit-tree[1].
-
-
-This command can run `commit-msg`, `pre-commit`, and
-`post-commit` hooks.  See link:hooks.html[hooks] for more
-information.
|
| In addition to ENVIRONMENT, many Porcelain-ish can invoke
| hooks, and we should have HOOKS section at the same location
| across manpages so people can expect where to find them.
| I just chose them to be at the end.
|

 
 OPTIONS
 -------
 -a|--all::
-	Update all paths in the index file.  This flag notices
-	files that have been modified and deleted, but new files
-	you have not told git about are not affected.
+	Tell the command to automatically stage files that have
+	been modified and deleted, but new files you have not
+	told git about are not affected.
|
| No need to say "index", although I do not think we should
| avoid the word.
|
 
 -c or -C <commit>::
 	Take existing commit object, and reuse the log message
@@ -55,16 +141,13 @@ OPTIONS
 -s|--signoff::
 	Add Signed-off-by line at the end of the commit message.
 
--v|--verify::
-	Look for suspicious lines the commit introduces, and
-	abort committing if there is one.  The definition of
-	'suspicious lines' is currently the lines that has
-	trailing whitespaces, and the lines whose indentation
-	has a SP character immediately followed by a TAB
-	character.  This is the default.
-
--n|--no-verify::
-	The opposite of `--verify`.
+--no-verify::
+	By default, the command looks for suspicious lines the
+	commit introduces, and aborts committing if there is one.
+	The definition of 'suspicious lines' is currently the
+	lines that has trailing whitespaces, and the lines whose
+	indentation has a SP character immediately followed by a
+	TAB character.  This option turns off the check.
|
| The --verify option does not exist anymore.  This is an independent fix.
| We do not yet describe --verbose (and real '-v') in the
| current page, which is quite BAD.  It shows the diff between HEAD
| and what is being committed.
|
 
 -e|--edit::
 	The message taken from file with `-F`, command line with
@@ -95,16 +177,16 @@ but can be used to amend a merge commit.
 --
 
 -i|--include::
-	Instead of committing only the files specified on the
-	command line, update them in the index file and then
-	commit the whole index.  This is the traditional
-	behavior.
+	Before making a commit out of staged contents so far,
+	stage the contents of paths given on the command line
+	as well.  This is usually not what you want unless you
+	are concluding a conflicted merge.
 
 -o|--only::
-	Commit only the files specified on the command line.
-	This format cannot be used during a merge, nor when the
-	index and the latest commit does not match on the
-	specified paths to avoid confusion.
+	Commit only the files specified on the command line;
+	this is the default when pathnames are given on the
+	command line, so you usually do not have to give this
+	option.  This format cannot be used during a merge.
 
 \--::
 	Do not interpret any more arguments as options.
@@ -118,46 +200,16 @@ If you make a commit and then found a mistake immediately after
 that, you can recover from it with gitlink:git-reset[1].
 
 
-Discussion
-----------
-
-`git commit` without _any_ parameter commits the tree structure
-recorded by the current index file.  This is a whole-tree commit
-even the command is invoked from a subdirectory.
-
-`git commit --include paths...` is equivalent to
-
-	git update-index --remove paths...
-	git commit
-
-That is, update the specified paths to the index and then commit
-the whole tree.
-
-`git commit paths...` largely bypasses the index file and
-commits only the changes made to the specified paths.  It has
-however several safety valves to prevent confusion.
-
-. It refuses to run during a merge (i.e. when
-  `$GIT_DIR/MERGE_HEAD` exists), and reminds trained git users
-  that the traditional semantics now needs -i flag.
-
-. It refuses to run if named `paths...` are different in HEAD
-  and the index (ditto about reminding).  Added paths are OK.
-  This is because an earlier `git diff` (not `git diff HEAD`)
-  would have shown the differences since the last `git
-  update-index paths...` to the user, and an inexperienced user
-  may mistakenly think that the changes between the index and
-  the HEAD (i.e. earlier changes made before the last `git
-  update-index paths...` was done) are not being committed.
-
-. It reads HEAD commit into a temporary index file, updates the
-  specified `paths...` and makes a commit.  At the same time,
-  the real index file is also updated with the same `paths...`.
-
-`git commit --all` updates the index file with _all_ changes to
-the working tree, and makes a whole-tree commit, regardless of
-which subdirectory the command is invoked in.
|
| Lose this section that only talks about implementation detail
| and expect the readers to understand the behaviour from it.
| The audience when the page was originally written were well
| versed in plumbing and the above technical description
| conveyed what we wanted to say in very precise terms, but that
| was only because git was very young.
|

+ENVIRONMENT VARIABLES
+---------------------
+The command specified by either the VISUAL or EDITOR environment
+variables are used to edit the commit log message.
 
+HOOKS
+-----
+This command can run `commit-msg`, `pre-commit`, and
+`post-commit` hooks.  See link:hooks.html[hooks] for more
+information.
 
 Author
 ------
