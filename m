From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/3] Documentation: rev-list-options: Rewrite simplification descriptions for clarity
Date: Tue, 12 Aug 2008 01:55:36 +0200
Message-ID: <eada6ecf77a858b2f1fe91c13c6a68b9d0351621.1218498923.git.trast@student.ethz.ch>
References: <ac1b3fe540b183acc8cdd87d36c55256cc56a204.1218498922.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 01:57:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KShG0-0003O6-Hx
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbYHKXzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbYHKXzz
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:55:55 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9004 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961AbYHKXzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:55:53 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 01:55:50 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 01:55:50 +0200
X-Mailer: git-send-email 1.6.0.rc2.56.g86ca
In-Reply-To: <ac1b3fe540b183acc8cdd87d36c55256cc56a204.1218498922.git.trast@student.ethz.ch>
In-Reply-To: <200808120151.56067.trast@student.ethz.ch>
References: <200808120151.56067.trast@student.ethz.ch>
X-OriginalArrivalTime: 11 Aug 2008 23:55:50.0682 (UTC) FILETIME=[C863D7A0:01C8FC0D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92029>

This completely rewrites the documentation of --full-history with lots
of examples.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/rev-list-options.txt |  153 ++++++++++++++++++++++++++++++++----
 1 files changed, 136 insertions(+), 17 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 83070ed..f8e5fb9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -43,11 +43,13 @@ endif::git-rev-list[]
 
 --parents::
 
-	Print the parents of the commit.
+	Print the parents of the commit.  Also enables parent
+	rewriting, see 'History Simplification' below.
 
 --children::
 
-	Print the children of the commit.
+	Print the children of the commit.  Also enables parent
+	rewriting, see 'History Simplification' below.
 
 ifdef::git-rev-list[]
 --timestamp::
@@ -191,14 +193,6 @@ endif::git-rev-list[]
 
 	Stop when a given path disappears from the tree.
 
---full-history::
-
-	Show also parts of history irrelevant to current state of a given
-	path. This turns off history simplification, which removed merges
-	which didn't change anything at all at some child. It will still actually
-	simplify away merges that didn't change anything at all into either
-	child.
-
 --no-merges::
 
 	Do not print commits with more than one parent.
@@ -281,18 +275,144 @@ See also linkgit:git-reflog[1].
 	Output uninteresting commits at the boundary, which are usually
 	not shown.
 
+--
+
+History Simplification
+~~~~~~~~~~~~~~~~~~~~~~
+
+When optional paths are given, 'git-rev-list' simplifies commits with
+various strategies, according to the options you have selected.
+
+Suppose you specified `foo` as the <paths>.  We shall call commits
+that modify `foo` !TREESAME, and the rest TREESAME.  (In a diff
+filtered for `foo`, they look different and equal, respectively.)
+
+In the following, we will always refer to the same example history to
+illustrate the differences between simplification settings.  We assume
+that you are filtering for a file `foo` in this commit graph:
+-----------------------------------------------------------------------
+	  .-A---M---N---O---P
+	 /     /   /   /   /
+	I     B   C   D   E
+	 \   /   /   /   /
+	  `-------------'
+-----------------------------------------------------------------------
+The horizontal line of history A--P is taken to be the first parent of
+each merge.  The commits are:
+
+* `I` is the initial commit, in which `foo` exists with contents
+  "asdf", and a file `quux` exists with contents "quux".  Initial
+  commits are compared to an empty tree, so `I` is !TREESAME.
+
+* In `A`, `foo` contains just "foo".
+
+* `B` contains the same change as `A`.  Its merge `M` is trivial and
+  hence TREESAME to all parents.
+
+* `C` does not change `foo`, but its merge `N` changes it to "foobar",
+  so it is not TREESAME to any parent.
+
+* `D` sets `foo` to "baz".  Its merge `O` combines the strings from
+  `N` and `D` to "foobarbaz"; i.e., it is not TREESAME to any parent.
+
+* `E` changes `quux` to "xyzzy", and its merge `P` combines the
+  strings to "quux xyzzy".  Despite appearing interesting, `P` is
+  TREESAME to all parents.
+
+'rev-list' walks backwards through history, including or excluding
+commits based on whether '\--full-history' and/or parent rewriting
+(via '\--parents' or '\--children') are used.  The following settings
+are available.
+
+Default mode::
+
+	Commits are included if they are not TREESAME to any parent
+	(though this can be changed, see '\--sparse' below).  If the
+	commit was a merge, and it was TREESAME to one parent, follow
+	only that parent.  (Even if there are several TREESAME
+	parents, follow only one of them.)  Otherwise, follow all
+	parents.
++
+This results in:
++
+-----------------------------------------------------------------------
+	  .-A---N---O
+	 /         /
+	I---------D
+-----------------------------------------------------------------------
++
+Note how the rule to only follow the TREESAME parent, if one is
+available, removed `B` from consideration entirely.  `C` was
+considered via `N`, but is TREESAME.  Root commits are compared to an
+empty tree, so `I` is !TREESAME.
++
+Parent/child relations are only visible with --parents, but that does
+not affect the commits selected in default mode, so we have shown the
+parent lines.
+
+--full-history without parent rewriting::
+
+	This mode differs from the default in one point: always follow
+	all parents of a merge, even if it is TREESAME to one of them.
+	Even if more than one side of the merge has commits that are
+	included, this does not imply that the merge itself is!  In
+	the example, we get
++
+-----------------------------------------------------------------------
+	I  A  B  N  D  O
+-----------------------------------------------------------------------
++
+`P` and `M` were excluded because they are TREESAME to a parent.  `E`,
+`C` and `B` were all walked, but only `B` was !TREESAME, so the others
+do not appear.
++
+Note that without parent rewriting, it is not really possible to talk
+about the parent/child relationships between the commits, so we show
+them disconnected.
+
+--full-history with parent rewriting::
+
+	Ordinary commits are only included if they are !TREESAME
+	(though this can be changed, see '\--sparse' below).
++
+Merges are always included.  However, their parent list is rewritten:
+Along each parent, prune away commits that are not included
+themselves.  This results in
++
+-----------------------------------------------------------------------
+	  .-A---M---N---O---P
+	 /     /   /   /   /
+	I     B   /   D   /
+	 \   /   /   /   /
+	  `-------------'
+-----------------------------------------------------------------------
++
+Compare to '\--full-history' without rewriting above.  Note that `E`
+was pruned away because it is TREESAME, but the parent list of P was
+rewritten to contain `E`'s parent `I`.  The same happened for `C` and
+`N`.  Note also that `P` was included despite being TREESAME.
+
+In addition to the above settings, you can change whether TREESAME
+affects inclusion:
+
 --dense::
+
+	Commits that are walked are included if they are not TREESAME
+	to any parent.
+
 --sparse::
 
-When optional paths are given, the default behaviour ('--dense') is to
-only output commits that changes at least one of them, and also ignore
-merges that do not touch the given paths.
+	All commits that are walked are included.
++
+Note that without '\--full-history', this still simplifies merges: if
+one of the parents is TREESAME, we follow only that one, so the other
+sides of the merge are never walked.
 
-Use the '--sparse' flag to makes the command output all eligible commits
-(still subject to count and age limitation), but apply merge
-simplification nevertheless.
 
 ifdef::git-rev-list[]
+Bisection Helpers
+~~~~~~~~~~~~~~~~~
+
 --bisect::
 
 Limit output to the one commit object which is roughly halfway between
@@ -342,7 +462,6 @@ after all the sorted commit objects, there will be the same text as if
 `--bisect-vars` had been used alone.
 endif::git-rev-list[]
 
---
 
 Commit Ordering
 ~~~~~~~~~~~~~~~
-- 
1.6.0.rc2.56.g86ca
