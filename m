From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation/git-merge.txt: Partial rewrite of How Merge
	Works
Date: Sat, 19 Jul 2008 20:17:22 +0200
Message-ID: <20080719181356.4114.91569.stgit@localhost>
References: <7vprpa67e4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 19 20:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKH0s-0008RT-Uv
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 20:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbYGSSRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 14:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755128AbYGSSRe
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 14:17:34 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:59631 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755120AbYGSSRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 14:17:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 420252ACCA2;
	Sat, 19 Jul 2008 20:17:22 +0200 (CEST)
In-Reply-To: <7vprpa67e4.fsf@gitster.siamese.dyndns.org>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89123>

The git-merge documentation's "HOW MERGE WORKS" section is confusingly
composed and actually omits the most interesting part, the merging of
the arguments into HEAD itself, surprisingly not actually mentioning
the fast-forward merge anywhere.

This patch replaces the "[NOTE]" screenful of highly technical details
by a single sentence summing up the interesting information, and instead
explains how are the arguments compared with HEAD and the three possible
inclusion states that are named "Already up-to-date", "Fast-forward"
and "True merge". It also makes it clear that the rest of the section
talks only about the true merge situation, and slightly expands the
talk on solving conflicts.

Junio initiated the removal of the Note screenful altogether and
offered many stylistical fixes.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

> But what I was wondering was if we have given the users enough clues to
> tell if the above is the right action.  If merge started and conflicted,
> then forgetting about it and keep going is _not_ the right thing, and the
> user needs to be able to tell these two very distinct cases apart.

I think that this is already obvious from both the documentation and
git-merge output; I'm not sure what to improve further on this.

I did make some minor tweaks in the conflict resolution part, though.
I hope this would be the final patch revision. :-)

 Documentation/git-merge.txt |   76 ++++++++++++++++---------------------------
 1 files changed, 29 insertions(+), 47 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 019e4ca..a7487d3 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -57,50 +57,31 @@ HOW MERGE WORKS
 
 A merge is always between the current `HEAD` and one or more
 commits (usually, branch head or tag), and the index file must
-exactly match the
-tree of `HEAD` commit (i.e. the contents of the last commit) when
-it happens.  In other words, `git diff --cached HEAD` must
-report no changes.
-
-[NOTE]
-This is a bit of a lie.  In certain special cases, your index is
-allowed to be different from the tree of the `HEAD` commit.  The most
-notable case is when your `HEAD` commit is already ahead of what
-is being merged, in which case your index can have arbitrary
-differences from your `HEAD` commit.  Also, your index entries
-may have differences from your `HEAD` commit that match
-the result of a trivial merge (e.g. you received the same patch
-from an external source to produce the same result as what you are
-merging).  For example, if a path did not exist in the common
-ancestor and your head commit but exists in the tree you are
-merging into your repository, and if you already happen to have
-that path exactly in your index, the merge does not have to
-fail.
-
-Otherwise, merge will refuse to do any harm to your repository
-(that is, it may fetch the objects from remote, and it may even
-update the local branch used to keep track of the remote branch
-with `git pull remote rbranch:lbranch`, but your working tree,
-`.git/HEAD` pointer and index file are left intact).  In addition,
-merge always sets `.git/ORIG_HEAD` to the original state of HEAD so
-a problematic merge can be removed by using `git reset ORIG_HEAD`.
-
-You may have local modifications in the working tree files.  In
-other words, 'git-diff' is allowed to report changes.
-However, the merge uses your working tree as the working area,
-and in order to prevent the merge operation from losing such
-changes, it makes sure that they do not interfere with the
-merge. Those complex tables in read-tree documentation define
-what it means for a path to "interfere with the merge".  And if
-your local modifications interfere with the merge, again, it
-stops before touching anything.
-
-So in the above two "failed merge" case, you do not have to
-worry about loss of data --- you simply were not ready to do
-a merge, so no merge happened at all.  You may want to finish
-whatever you were in the middle of doing, and retry the same
-pull after you are done and ready.
-
+match the tree of `HEAD` commit (i.e. the contents of the last commit)
+when it starts out.  In other words, `git diff --cached HEAD` must
+report no changes.  (One exception is when the changed index
+entries are already in the same state that would result from
+the merge anyway.)
+
+Three kinds of merge can happen:
+
+* The merged commit is already contained in `HEAD`. This is the
+  simplest case, called "Already up-to-date."
+
+* `HEAD` is already contained in the merged commit. This is the
+  most common case especially when involved through 'git pull':
+  you are tracking an upstream repository, committed no local
+  changes and now you want to update to a newer upstream revision.
+  Your `HEAD` (and the index) is updated to at point the merged
+  commit, without creating an extra merge commit.  This is
+  called "Fast-forward".
+
+* Both the merged commit and `HEAD` are independent and must be
+  tied together by a merge commit that has them both as its parents.
+  The rest of this section describes this "True merge" case.
+
+The chosen merge strategy merges the two commits into a single
+new source tree.
 When things cleanly merge, these things happen:
 
 1. The results are updated both in the index file and in your
@@ -142,12 +123,13 @@ After seeing a conflict, you can do two things:
 
  * Decide not to merge.  The only clean-up you need are to reset
    the index file to the `HEAD` commit to reverse 2. and to clean
-   up working tree changes made by 2. and 3.; 'git-reset' can
+   up working tree changes made by 2. and 3.; 'git-reset --hard' can
    be used for this.
 
  * Resolve the conflicts.  `git diff` would report only the
-   conflicting paths because of the above 2. and 3.  Edit the
-   working tree files into a desirable shape, 'git-add' or 'git-rm'
+   conflicting paths because of the above 2. and 3.
+   Edit the working tree files into a desirable shape
+   ('git mergetool' can ease this task), 'git-add' or 'git-rm'
    them, to make the index file contain what the merge result
    should be, and run 'git-commit' to commit the result.
 
