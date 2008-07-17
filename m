From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation/git-merge.txt: Expand the How Merge Works
	section
Date: Thu, 17 Jul 2008 18:29:32 +0200
Message-ID: <20080717162922.12081.96582.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 17 18:30:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWNL-0004Oq-8o
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 18:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043AbYGQQ3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 12:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbYGQQ3k
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 12:29:40 -0400
Received: from [212.249.11.140] ([212.249.11.140]:48795 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751351AbYGQQ3j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 12:29:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 3DDEE2AC73C;
	Thu, 17 Jul 2008 18:29:33 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88876>

The git-merge documentation's "HOW MERGE WORKS" section is confusingly
composed and actually omits the most interesting part, the merging of
the arguments into HEAD itself, surprisingly not actually mentioning
the fast-forward merge anywhere.

This patch moves the "[NOTE]" screenful of highly technical details
to a dedicated subsection at the end of the section, and instead
explains how are the arguments compard with HEAD and the three possible
inclusion states. When discussing merges, some term that describes the
situation when fast-forwarding did _not_ happen is frequently useful;
this patch proposes "true merge" for that. It also makes it clear that
the rest of the section talks only about the true merge situation.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-merge.txt |   93 +++++++++++++++++++++++++++----------------
 foo                         |    1 
 2 files changed, 59 insertions(+), 35 deletions(-)
 create mode 100644 foo

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 019e4ca..396f3ec 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -61,46 +61,28 @@ exactly match the
 tree of `HEAD` commit (i.e. the contents of the last commit) when
 it happens.  In other words, `git diff --cached HEAD` must
 report no changes.
+(However, see the "Pre-flight requirements" subsection.)
 
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
+Three kinds of merge can happen:
 
-Otherwise, merge will refuse to do any harm to your repository
-(that is, it may fetch the objects from remote, and it may even
-update the local branch used to keep track of the remote branch
-with `git pull remote rbranch:lbranch`, but your working tree,
-`.git/HEAD` pointer and index file are left intact).  In addition,
-merge always sets `.git/ORIG_HEAD` to the original state of HEAD so
-a problematic merge can be removed by using `git reset ORIG_HEAD`.
+* The merged commit is already contained in `HEAD`. This is the
+  simplest case and only "Already up-to-date" is printed.
 
-You may have local modifications in the working tree files.  In
-other words, 'git-diff' is allowed to report changes.
-However, the merge uses your working tree as the working area,
-and in order to prevent the merge operation from losing such
-changes, it makes sure that they do not interfere with the
-merge. Those complex tables in read-tree documentation define
-what it means for a path to "interfere with the merge".  And if
-your local modifications interfere with the merge, again, it
-stops before touching anything.
+* `HEAD` is already contained in the merged commit. This is the
+  most common case especially when involved through 'git pull':
+  you are tracking an upstream repository, committed no local
+  changes and now you want to update to a newer upstream revision.
+  So-called "fast-forward merge" is performed, simply repointing
+  your `HEAD` (and index) to the merged commit; no extra merge
+  commit is created.
 
-So in the above two "failed merge" case, you do not have to
-worry about loss of data --- you simply were not ready to do
-a merge, so no merge happened at all.  You may want to finish
-whatever you were in the middle of doing, and retry the same
-pull after you are done and ready.
+* Both merged commit and `HEAD` are independent and must be
+  "tied together" by a merge commit, having them both as its parents;
+  this might be called a "true merge" and is described in the rest
+  of this section.
 
+The chosen merge strategy merges the two commits into a single
+new source tree.
 When things cleanly merge, these things happen:
 
 1. The results are updated both in the index file and in your
@@ -152,6 +134,47 @@ After seeing a conflict, you can do two things:
    should be, and run 'git-commit' to commit the result.
 
 
+Pre-flight requirements note
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+In certain special cases, your index is
+allowed to be different from the tree of the `HEAD` commit.  The most
+notable case is when your `HEAD` commit is already ahead of what
+is being merged, in which case your index can have arbitrary
+differences from your `HEAD` commit.  Also, your index entries
+may have differences from your `HEAD` commit that match
+the result of a trivial merge (e.g. you received the same patch
+from an external source to produce the same result as what you are
+merging).  For example, if a path did not exist in the common
+ancestor and your head commit but exists in the tree you are
+merging into your repository, and if you already happen to have
+that path exactly in your index, the merge does not have to
+fail.
+
+Other than that, merge will refuse to do any harm to your repository
+(that is, it may fetch the objects from remote, and it may even
+update the local branch used to keep track of the remote branch
+with `git pull remote rbranch:lbranch`, but your working tree,
+`.git/HEAD` pointer and index file are left intact).  In addition,
+merge always sets `.git/ORIG_HEAD` to the original state of HEAD so
+a problematic merge can be removed by using `git reset ORIG_HEAD`.
+
+You may have local modifications in the working tree files.  In
+other words, 'git-diff' is allowed to report changes.
+However, the merge uses your working tree as the working area,
+and in order to prevent the merge operation from losing such
+changes, it makes sure that they do not interfere with the
+merge. Those complex tables in read-tree documentation define
+what it means for a path to "interfere with the merge".  And if
+your local modifications interfere with the merge, again, it
+stops before touching anything.
+
+So in the above two "failed merge" case, you do not have to
+worry about loss of data --- you simply were not ready to do
+a merge, so no merge happened at all.  You may want to finish
+whatever you were in the middle of doing, and retry the same
+pull after you are done and ready.
+
+
 SEE ALSO
 --------
 linkgit:git-fmt-merge-msg[1], linkgit:git-pull[1],
diff --git a/foo b/foo
new file mode 100644
index 0000000..b4e94ec
--- /dev/null
+++ b/foo
@@ -0,0 +1 @@
+Thu Jul 17 17:30:53 CEST 2008
