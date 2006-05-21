From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: (unknown)
Date: Sun, 21 May 2006 19:53:23 -0400
Message-ID: <1148255528.61d5d241.1@fieldses.org>
References: <1148255528.61d5d241.0@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 01:53:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhxju-00005a-FB
	for gcvg-git@gmane.org; Mon, 22 May 2006 01:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWEUXxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 19:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWEUXxf
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 19:53:35 -0400
Received: from mail.fieldses.org ([66.93.2.214]:34225 "EHLO
	puzzle.fieldses.org") by vger.kernel.org with ESMTP id S964951AbWEUXxe
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 19:53:34 -0400
Received: from bfields by puzzle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1Fhxjf-00066C-PA; Sun, 21 May 2006 19:53:23 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <1148255528.61d5d241.0@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20467>

>From nobody Mon Sep 17 00:00:00 2001
From: J. Bruce Fields <bfields@citi.umich.edu>
Date: Sun, 21 May 2006 16:54:05 -0400
Subject: [PATCH 2/3] tutorial: expanded discussion of commit history

Expand the history-browsing section of the tutorial a bit, in part to
address Junio's suggestion that we mention "git grep" and Linus's
complaint that people are missing the flexibility of the commandline
interfaces for selecting commits.

This reads a little more like a collection of examples than a
"tutorial", but maybe that's what people need at this point.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

bb2450ce2145bfdc5b3b7c967a5ed3571437f5d4
 Documentation/tutorial.txt |  165 ++++++++++++++++++++++++++++++--------------
 1 files changed, 112 insertions(+), 53 deletions(-)

bb2450ce2145bfdc5b3b7c967a5ed3571437f5d4
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index cd0f0df..4c298c6 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -288,103 +288,162 @@ Git can also be used in a CVS-like mode,
 that various users push changes to; see gitlink:git-push[1] and
 link:cvs-migration.html[git for CVS users].
 
-Keeping track of history
-------------------------
+Exploring history
+-----------------
 
-Git history is represented as a series of interrelated commits.  The
-most recent commit in the currently checked-out branch can always be
-referred to as HEAD, and the "parent" of any commit can always be
-referred to by appending a caret, "^", to the end of the name of the
-commit.  So, for example,
+Git history is represented as a series of interrelated commits.  We
+have already seen that the git log command can list those commits.
+Note that first line of each git log entry also gives a name for the
+commit:
 
 -------------------------------------
-git diff HEAD^ HEAD
+$ git log
+commit c82a22c39cbc32576f64f5c6b3f24b99ea8149c7
+Author: Junio C Hamano <junkio@cox.net>
+Date:   Tue May 16 17:18:22 2006 -0700
+
+    merge-base: Clarify the comments on post processing.
 -------------------------------------
 
-shows the difference between the most-recently checked-in state of
-the tree and the previous state, and
+We can give this name to git show to see the details about this
+commit.
 
 -------------------------------------
-git diff HEAD^^ HEAD^
+$ git show c82a22c39cbc32576f64f5c6b3f24b99ea8149c7
 -------------------------------------
 
-shows the difference between that previous state and the state two
-commits ago.  Also, HEAD~5 can be used as a shorthand for HEAD{caret}{caret}{caret}{caret}{caret},
-and more generally HEAD~n can refer to the nth previous commit.
-Commits representing merges have more than one parent, and you can
-specify which parent to follow in that case; see
-gitlink:git-rev-parse[1].
+But there other ways to refer to commits.  You can use any initial
+part of the name that is long enough to uniquely identify the commit:
 
-The name of a branch can also be used to refer to the most recent
-commit on that branch; so you can also say things like
+-------------------------------------
+$ git show c82a22c39c	# the first few characters of the name are
+			# usually enough
+$ git show HEAD		# the tip of the current branch
+$ git show experimental	# the tip of the "experimental" branch
+-------------------------------------
+
+Every commit has at least one "parent" commit, which points to the
+previous state of the project:
 
 -------------------------------------
-git diff HEAD experimental
+$ git show HEAD^  # to see the parent of HEAD
+$ git show HEAD^^ # to see the grandparent of HEAD
+$ git show HEAD~4 # to see the great-great grandparent of HEAD
 -------------------------------------
 
-to see the difference between the most-recently committed tree in
-the current branch and the most-recently committed tree in the
-experimental branch.
+Note that merge commits may have more than one parent:
+
+-------------------------------------
+$ git show HEAD^1 # show the first parent of HEAD (same as HEAD^)
+$ git show HEAD^2 # show the second parent of HEAD
+-------------------------------------
 
-But you may find it more useful to see the list of commits made in
-the experimental branch but not in the current branch, and
+You can also give commits names of your own; after running
 
 -------------------------------------
-git log HEAD..experimental
+$ git-tag v2.5 1b2e1d63ff
 -------------------------------------
 
-will do that, just as
+you can refer to 1b2e1d63ff by the name "v2.5".  If you intend to
+share this name with other people (for example, to identify a release
+version), you should create a "tag" object, and perhaps sign it; see
+gitlink:git-tag[1] for details.
+
+Any git command that needs to know a commit can take any of these
+names.  For example:
 
 -------------------------------------
-git log experimental..HEAD
+$ git diff v2.5 HEAD	 # compare the current HEAD to v2.5
+$ git branch stable v2.5 # start a new branch named "stable" based
+			 # at v2.5
+$ git reset --hard HEAD^ # reset your current branch and working
+			 # directory its state at HEAD^
 -------------------------------------
 
-will show the list of commits made on the HEAD but not included in
-experimental.
+Be careful with that last command: in addition to losing any changes
+in the working directory, it will also remove all later commits from
+this branch.  If this branch is the only branch containing those
+commits, they will be lost.  (Also, don't use "git reset" on a
+publicly-visible branch that other developers pull from, as git will
+be confused by history that disappears in this way.)
 
-You can also give commits convenient names of your own: after running
+The git grep command can search for strings in any version of your
+project, so
 
 -------------------------------------
-$ git-tag v2.5 HEAD^^
+$ git grep "hello" v2.5
 -------------------------------------
 
-you can refer to HEAD^^ by the name "v2.5".  If you intend to share
-this name with other people (for example, to identify a release
-version), you should create a "tag" object, and perhaps sign it; see
-gitlink:git-tag[1] for details.
+searches for all occurences of "hello" in v2.5.
 
-You can revisit the old state of a tree, and make further
-modifications if you wish, using git branch: the command
+If you leave out the commit name, git grep will search any of the
+files it manages in your current directory.  So
 
 -------------------------------------
-$ git branch stable-release v2.5
+$ git grep "hello"
 -------------------------------------
 
-will create a new branch named "stable-release" starting from the
-commit which you tagged with the name v2.5.
+is a quick way to search just the files that are tracked by git.
 
-You can reset the state of any branch to an earlier commit at any
-time with
+Many git commands also take sets of commits, which can be specified
+in a number of ways.  Here are some examples with git log:
 
 -------------------------------------
-$ git reset --hard v2.5
+$ git log v2.5..v2.6            # commits between v2.5 and v2.6
+$ git log v2.5..                # commits since v2.5
+$ git log --since="2 weeks ago" # commits from the last 2 weeks
+$ git log v2.5.. Makefile       # commits since v2.5 which modify
+				# Makefile
 -------------------------------------
 
-This will remove all later commits from this branch and reset the
-working tree to the state it had when the given commit was made.  If
-this branch is the only branch containing the later commits, those
-later changes will be lost.  Don't use "git reset" on a
-publicly-visible branch that other developers pull from, as git will
-be confused by history that disappears in this way.
+You can also give git log a "range" of commits where the first is not
+necessarily an ancestor of the second; for example, if the tips of
+the branches "stable-release" and "master" diverged from a common
+commit some time ago, then
+
+-------------------------------------
+$ git log stable..experimental
+-------------------------------------
+
+will list commits made in the experimental branch but not in the
+stable branch, while
+
+-------------------------------------
+$ git log experimental..stable
+-------------------------------------
+
+will show the list of commits made on the stable branch but not
+the experimental branch.
+
+The "git log" command has a weakness: it must present commits in a
+list.  When the history has lines of development that diverged and
+then merged back together, the order in which "git log" presents
+those commits is meaningless.
+
+Most projects with multiple contributors (such as the linux kernel,
+or git itself) have frequent merges, and gitk does a better job of
+visualizing their history.  For example,
+
+-------------------------------------
+$ gitk --since="2 weeks ago" drivers/
+-------------------------------------
+
+allows you to browse any commits from the last 2 weeks of commits
+that modified files under the "drivers" directory.
+
+Finally, most commands that take filenames will optionally allow you
+to precede any filename by a commit, to specify a particular version
+fo the file:
+
+-------------------------------------
+$ git diff v2.5:Makefile HEAD:Makefile.in
+-------------------------------------
 
 Next Steps
 ----------
 
 Some good commands to explore next:
 
-  * gitlink:git-diff[1]: This flexible command does much more than
-    we've seen in the few examples above.
-
   * gitlink:git-format-patch[1], gitlink:git-am[1]: These convert
     series of git commits into emailed patches, and vice versa,
     useful for projects such as the linux kernel which rely heavily
-- 
1.3.3.gff62
