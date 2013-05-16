From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 11/15] simplify-merges: drop merge from irrelevant side branch
Date: Thu, 16 May 2013 18:32:37 +0300
Message-ID: <1368718361-27859-12-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:33:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0BQ-0003uH-AB
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab3EPPdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:33:17 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:50293 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752786Ab3EPPdP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:33:15 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id EBB0010540EE
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:13 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:13 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:10 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18173713347787985129
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500016/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224578>

Reimplement commit 4b7f53da on top of the new simplify-merges
infrastructure, tightening the condition to only consider root parents;
the original version incorrectly dropped parents that were TREESAME to
anything.

Original log message follows.

The merge simplification rule stated in 6546b59 (revision traversal:
show full history with merge simplification, 2008-07-31) still
treated merge commits too specially.  Namely, in a history with this
shape:

	---o---o---M
	          /
         x---x---x

where three 'x' were on a history completely unrelated to the main
history 'o' and do not touch any of the paths we are following, we
still said that after simplifying all of the parents of M, 'x'
(which is the leftmost 'x' that rightmost 'x simplifies down to) and
'o' (which would be the last commit on the main history that touches
the paths we are following) are independent from each other, and
both need to be kept.

That is incorrect; when the side branch 'x' never touches the paths,
it should be removed to allow M to simplify down to the last commit
on the main history that touches the paths.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 Documentation/rev-list-options.txt | 34 +++++++++++++++++++++-------------
 revision.c                         | 26 +++++++++++++++++++++++++-
 t/t6012-rev-list-simplify.sh       |  2 +-
 3 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index f41e865..b462f17 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -342,13 +342,13 @@ In the following, we will always refer to the same example history to
 illustrate the differences between simplification settings.  We assume
 that you are filtering for a file `foo` in this commit graph:
 -----------------------------------------------------------------------
-	  .-A---M---N---O---P
-	 /     /   /   /   /
-	I     B   C   D   E
-	 \   /   /   /   /
-	  `-------------'
+	  .-A---M---N---O---P---Q
+	 /     /   /   /   /   /
+	I     B   C   D   E   Y
+	 \   /   /   /   /   /
+	  `-------------'   X
 -----------------------------------------------------------------------
-The horizontal line of history A---P is taken to be the first parent of
+The horizontal line of history A---Q is taken to be the first parent of
 each merge.  The commits are:
 
 * `I` is the initial commit, in which `foo` exists with contents
@@ -369,6 +369,10 @@ each merge.  The commits are:
 * `E` changes `quux` to "xyzzy", and its merge `P` combines the
   strings to "quux xyzzy".  `P` is TREESAME to `O`, but not to `E`.
 
+* `X` is an indpendent root commit that added a new file `side`, and `Y`
+  modified it. `Y` is TREESAME to `X`. Its merge `Q` added `side` to `P`, and
+  `Q` is TREESAME to `P`, but not to `Y`.
+
 'rev-list' walks backwards through history, including or excluding
 commits based on whether '\--full-history' and/or parent rewriting
 (via '\--parents' or '\--children') are used.  The following settings
@@ -409,7 +413,7 @@ parent lines.
 	the example, we get
 +
 -----------------------------------------------------------------------
-	I  A  B  N  D  O  P
+	I  A  B  N  D  O  P  Q
 -----------------------------------------------------------------------
 +
 `M` was excluded because it is TREESAME to both parents.  `E`,
@@ -430,7 +434,7 @@ Along each parent, prune away commits that are not included
 themselves.  This results in
 +
 -----------------------------------------------------------------------
-	  .-A---M---N---O---P
+	  .-A---M---N---O---P---Q
 	 /     /   /   /   /
 	I     B   /   D   /
 	 \   /   /   /   /
@@ -440,7 +444,7 @@ themselves.  This results in
 Compare to '\--full-history' without rewriting above.  Note that `E`
 was pruned away because it is TREESAME, but the parent list of P was
 rewritten to contain `E`'s parent `I`.  The same happened for `C` and
-`N`.
+`N`, and `X`, `Y` and `Q`.
 
 In addition to the above settings, you can change whether TREESAME
 affects inclusion:
@@ -470,9 +474,9 @@ history according to the following rules:
 * Set `C'` to `C`.
 +
 * Replace each parent `P` of `C'` with its simplification `P'`.  In
-  the process, drop parents that are ancestors of other parents, and
-  remove duplicates, but take care to never drop all parents that
-  we are TREESAME to.
+  the process, drop parents that are ancestors of other parents or that are
+  root commits TREESAME to an empty tree, and remove duplicates, but take care
+  to never drop all parents that we are TREESAME to.
 +
 * If after this parent rewriting, `C'` is a root or merge commit (has
   zero or >1 parents), a boundary commit, or !TREESAME, it remains.
@@ -490,7 +494,7 @@ The effect of this is best shown by way of comparing to
 	  `---------'
 -----------------------------------------------------------------------
 +
-Note the major differences in `N` and `P` over '--full-history':
+Note the major differences in `N`, `P` and `Q` over '--full-history':
 +
 --
 * `N`'s parent list had `I` removed, because it is an ancestor of the
@@ -498,6 +502,10 @@ Note the major differences in `N` and `P` over '--full-history':
 +
 * `P`'s parent list similarly had `I` removed.  `P` was then
   removed completely, because it had one parent and is TREESAME.
++
+* `Q`'s parent list had `Y` simplified to `X`. `X` was then removed, because it
+  was a TREESAME root. `Q` was then removed completely, because it had one
+  parent and is TREESAME.
 --
 
 Finally, there is a fifth simplification mode available:
diff --git a/revision.c b/revision.c
index 62f399c..4f7446c 100644
--- a/revision.c
+++ b/revision.c
@@ -2136,6 +2136,22 @@ static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
 	return marked;
 }
 
+static int mark_treesame_root_parents(struct rev_info *revs, struct commit *commit)
+{
+	struct commit_list *p;
+	int marked = 0;
+
+	for (p = commit->parents; p; p = p->next) {
+		struct commit *parent = p->item;
+		if (!parent->parents && (parent->object.flags & TREESAME)) {
+			parent->object.flags |= TMP_MARK;
+			marked++;
+		}
+	}
+
+	return marked;
+}
+
 /*
  * Awkward naming - this means one parent we are TREESAME to.
  * cf mark_treesame_root_parents: root parents that are TREESAME (to an
@@ -2301,10 +2317,18 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	 *     /    /		o: a commit that touches the paths;
 	 * ---o----'
 	 *
-	 * Detect and simplify this case.
+	 * Further, a merge of an independent branch that doesn't
+	 * touch the path will reduce to a treesame root parent:
+	 *
+	 *  ----o----X		X: the commit we are looking at;
+	 *          /		o: a commit that touches the paths;
+	 *         r		r: a root commit not touching the paths
+	 *
+	 * Detect and simplify both cases.
 	 */
 	if (1 < cnt) {
 		int marked = mark_redundant_parents(revs, commit);
+		marked += mark_treesame_root_parents(revs, commit);
 		if (marked)
 			marked -= leave_one_treesame_to_parent(revs, commit);
 		if (marked)
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 4e55872..57ce239 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -110,7 +110,7 @@ check_result 'L K J I H G F E D C B A' --full-history
 check_result 'K I H E C B A' --full-history -- file
 check_result 'K I H E C B A' --full-history --topo-order -- file
 check_result 'K I H E C B A' --full-history --date-order -- file
-check_outcome failure 'I E C B A' --simplify-merges -- file
+check_result 'I E C B A' --simplify-merges -- file
 check_result 'I B A' -- file
 check_result 'I B A' --topo-order -- file
 check_result 'H' --first-parent -- another-file
-- 
1.8.3.rc0.28.g4b02ef5
