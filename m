From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] Documentation: rev-list-options: clarify history simplification with paths
Date: Sun, 10 Aug 2008 15:44:00 +0200
Message-ID: <1218375840-4292-1-git-send-email-trast@student.ethz.ch>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 15:45:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSBEM-0005Fv-GC
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 15:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbYHJNn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 09:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbYHJNn4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 09:43:56 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:57896 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbYHJNnz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 09:43:55 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 10 Aug 2008 15:43:53 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 10 Aug 2008 15:43:53 +0200
X-Mailer: git-send-email 1.6.0.rc2.29.g7ec81
X-OriginalArrivalTime: 10 Aug 2008 13:43:53.0698 (UTC) FILETIME=[20F2F420:01C8FAEF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91839>

This is an attempt to rewrite the documentation for --full-history,
--simplify-merges, and --sparse for clarity.

--prune-merges does not exist yet, but would be intended to restore
the default behavior over possible earlier --full-history and
--simplify-merges.

WARNING: Does not match current code behavior.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is fallout from my investigation of rev-list during the
filter-branch topic.  I found the descriptions quite unhelpful, and
investigated commit logs and empiric behavior a bit.

The problem is, rev-list behaves quite erratically if one mixes
--sparse, --full-history and --parents in combinations.

With the history from the patch, i.e.

  $ git log --graph --pretty=oneline --abbrev-commit --decorate
  *-.   e0083e6... (refs/heads/master) Merge branches 'side' and 'unrelated'
  |\ \
  | | * b3127f4... (refs/heads/unrelated) d: unrelated
  | * | 984aa48... (refs/heads/side) C: dir=B
  | |/
  * | aad9982... B: dir
  |/
  * b60c459... A: dir
  * ad7052b... initial

where only commits with 'dir' touch the 'dir' subdirectory, and C=B in
terms of diffs, a few unexpected things happen.  (I manually applied
--abbrev-commit to rev-list output to make it fit in less columns.)

As noted in the patch, I would expect the default pruning to simplify
the history to 'o -- A -- B -- m' (drop parent 'd' because the entire
sideline is non-touching; drop parent 'C' because it is the same as
'B'), and then have --dense decide to drop 'o' and 'm' because they
are not touching.  The output agrees:

  $ git rev-list --pretty=oneline HEAD -- dir
  aad9982... B: dir
  b60c459... A: dir

Also, --sparse tends to support this two-pass simplification theory:

  $ git rev-list --pretty=oneline --sparse HEAD -- dir
  e0083e6... Merge branches 'side' and 'unrelated'
  aad9982... B: dir
  b60c459... A: dir
  ad7052b... initial

Now according to current docs, --full-history should turn off removing
"merges which didn't change anything at all at some child", but still
"simplify away merges that didn't change anything at all into either
child."  How does being a merge have anything to do with it's
_children_?  So I read this as saying that a merge is removed iff it
agrees with all _parents_.  However, despite having a merge that is
different relative to its third parent, it is dropped:

  $ g rev-list --pretty=oneline --full-history HEAD -- dir
  984aa48... C: dir=B
  aad9982... B: dir
  b60c459... A: dir

But --parents --full-history magically revives the merge:

  $ git rev-list --pretty=oneline --parents --full-history HEAD -- dir
  e0083e6... aad9982... 984aa48... b60c459... Merge branches 'side' and 'unrelated'
  984aa48... b60c459... C: dir=B
  aad9982... b60c459... B: dir
  b60c459... A: dir

One quickly verifies that --sparse --full-history shows everything, as
it should.

More to the point, --simplify-merges actually shows the merge when
--full-history does not, resulting in

  $ git rev-list --pretty=oneline --simplify-merges HEAD -- dir
  e0083e6... Merge branches 'side' and 'unrelated'
  984aa48... C: dir=B
  aad9982... B: dir
  b60c459... A: dir

despite the commit message (90818fdc) claiming that it is an
additional simplification on top of --full-history, and should
therefore output at most as many commits.  --parents seems to agree
that the simplification is working right:

  $ git rev-list --pretty=oneline --parents --simplify-merges HEAD -- dir
  e0083e6... aad9982... 984aa48... Merge branches 'side' and 'unrelated'
  984aa48... b60c459... C: dir=B
  aad9982... b60c459... B: dir
  b60c459... A: dir

(Note that it dropped the third unrelated parent.)

Furthermore, with --sparse the same turns into

  $ git rev-list --pretty=oneline --sparse --parents --simplify-merges HEAD -- dir
  e0083e6... aad9982... 984aa48... b3127f4... Merge branches 'side' and 'unrelated'
  b3127f4... b60c459... d: unrelated
  984aa48... b60c459... C: dir=B
  aad9982... b60c459... B: dir
  b60c459... ad7052b... A: dir
  ad7052b... initial

So it didn't simplify away the parent 'd' after all, even though
90818fdc (in the second * bullet) does not mention any criterion that
would make 'd' its own replacement.  (I would actually expect it to
replace 'd' with 'initial' on that ancestor line, and subsequently
prune that parent because it is redundant.)

So if anyone read this mail up to this point:  Which of these are
actual bugs?  Which of them are a misunderstanding on my part?

Thanks for your time,

Thomas


 Documentation/rev-list-options.txt |   97 ++++++++++++++++++++++++++++-------
 1 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ee6822a..0eaefd2 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -191,20 +191,6 @@ endif::git-rev-list[]
 
 	Stop when a given path disappears from the tree.
 
---full-history::
-
-	Show also parts of history irrelevant to current state of given
-	paths. This turns off history simplification, which removed merges
-	which didn't change anything at all at some child. It will still actually
-	simplify away merges that didn't change anything at all into either
-	child.
-
---simplify-merges::
-
-	Simplify away commits that did not change the given paths, similar
-	to `--full-history`, and further remove merges none of whose
-	parent history changes the given paths.
-
 --no-merges::
 
 	Do not print commits with more than one parent.
@@ -287,18 +273,89 @@ See also linkgit:git-reflog[1].
 	Output uninteresting commits at the boundary, which are usually
 	not shown.
 
+--
+
+History Simplification
+~~~~~~~~~~~~~~~~~~~~~~
+
+When optional paths are given, 'git-rev-list' simplifies merge and
+non-merge commits separately.  First, all non-merge commits that do
+not touch the given paths are marked as such.  We'll call them
+'non-touching' commits, and all other commits 'touching'.
+
+Second, merges are simplified.  You can choose three levels.  We
+illustrate the strategies with the following example history, where
+touching commits are shown with capital letters and both B and C
+contain the same changes:
+
+-----------------------------------------------------------------------
+	o -- A -- B -- m
+	     |\	      /|
+	     | \- C -/ |
+	     \	       /
+	      \-- d --/
+-----------------------------------------------------------------------
+
+--prune-merges::
+
+	This is the default.  A merge is has its parents rewritten as
+	follows:
++
+	* All parents that do not have any touching ancestors are
+	  removed.
++
+	* Of a set of parents that agree on the path contents, only
+	  the first is kept.
++
+In our example, we get the following:
++
+-----------------------------------------------------------------------
+	o -- A -- B -- m
+-----------------------------------------------------------------------
+
+--simplify-merges::
+
+	For each commit C, compute its replacement in the final history:
++
+* First compute the replacements of all parents of C, and
+  rewrite C to have these parents.  Then remove parents that
+  are either identical to or ancestors of an existing parent.
++
+* If, after this simplification, the commit is touching, a root or
+  merge commit, or marked as uninteresting, it remains.
++
+In the example, history is simplified as follows.  (Note that while
+'o' remains, it will not be output with '\--dense'.)
++
+-----------------------------------------------------------------------
+	o -- A -- B -- m
+	      \	      /
+	       \- C -/
+-----------------------------------------------------------------------
+
+--full-history::
+
+	Do not simplify merges at all.  Their ancestor lines are still
+	only shown if they have any touching commits, but the merges
+	themselves are always output.
+
+Finally the simplified history is output.  You can control which
+commits are shown:
+
 --dense::
+
+	Hide all non-touching non-merge commits.  This is the default.
+
 --sparse::
 
-When optional paths are given, the default behaviour ('--dense') is to
-only output commits that changes at least one of them, and also ignore
-merges that do not touch the given paths.
+	Output all commits.  (Still subject to merge simplification
+	and count and age limitations.)
 
-Use the '--sparse' flag to makes the command output all eligible commits
-(still subject to count and age limitation), but apply merge
-simplification nevertheless.
 
 ifdef::git-rev-list[]
+Bisection Helpers
+~~~~~~~~~~~~~~~~~
+
 --bisect::
 
 Limit output to the one commit object which is roughly halfway between
-- 
1.6.0.rc2.29.g7ec81
