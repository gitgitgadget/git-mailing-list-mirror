From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: History over-simplification
Date: Sun, 23 Sep 2007 00:46:28 -0400
Message-ID: <20070923044628.GA3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 06:46:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZJMm-0004FP-As
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 06:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbXIWEqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 00:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbXIWEqm
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 00:46:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47932 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbXIWEql (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 00:46:41 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IZJMU-0005kI-Au; Sun, 23 Sep 2007 00:46:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C5DC220FBAE; Sun, 23 Sep 2007 00:46:28 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58950>

This is an interesting problem for me.  We had a bad merge in the
repository that produced this particular gitk graph:

  http://www.spearce.org/2007/07/ugly-gitk.gif

The project maintainer tried to locate the commits that altered
a given file with `gitk -- path` and found only one commit
(the introduction of the path) but expected to at least find
a modification from a side branch.  What he was looking for
specifically was the merge (or revert) that threw away that
side branch's change as the change wasn't supposed to have been
reverted/lost.

He knew what the commit from the side branch was (the author of
it still had a branch pointing at the commit).  But try finding
the proper child commit in gitk without a path limiter in that
graph I link to above.  If you don't remember what a mess it is,
click through briefly to refresh your memory.  The path limiter is
really required here to boil the graph down to something a human
can reason with.

Adding in --full-history *almost* gave us the data he needed.
It did find the modification on the side branch but it couldn't
point to the child commit which reverted the path.  It turns
out the bad change was an octopus merge commit done incorrectly.
Yes, really.  Don't bother telling me how bad octopus merges are.
This problem happens in a two parent merge as well.

Below is a test which shows the problem.  Without the associated
patch to revision.c we cannot find the ours merge that trashed the
side branch's change.  In this toy repository its no big deal to
find the ours merge and figure out what happened.  In the production
repository we were looking at above its impossible without support
from Git.

I don't really like the patch to revision.c because it winds up
showing trivial merges too.  What I really want is to have the
"--full-history" option include a merge if either of the following
is true:

 a) The resulting path does not match _any_ of the parents.  We
    already handle this case correctly in revision.c and correctly
    show the "evil" merge.

 b) The resulting path matches one of the parents but not one of
    the others.  In such a case the merge should still be output if
    a 3-way read-tree would not have chosen this result by default.

The problem is computing b) from within the revision walker.
You can't compute the merge bases while inside the inner loop of the
revision walker itself, its already busy and the flags are already
in-use on all objects.  Worse commit parents are being rewritten
in ways that may break merge base computation.  Oh, and lets not
even talk about how expensive that merge base computation is if we
were to perform it on every merge.  :-\

Thoughts?


diff --git a/revision.c b/revision.c
index 33d092c..aca62a6 100644
--- a/revision.c
+++ b/revision.c
@@ -365,7 +365,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		}
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
-	if (tree_changed && !tree_same)
+	if (tree_changed && (!tree_same || !revs->simplify_history))
 		commit->object.flags |= TREECHANGE;
 }
 
diff --git a/t/t6008-rev-list-toosimple.sh b/t/t6008-rev-list-toosimple.sh
new file mode 100755
index 0000000..696b057
--- /dev/null
+++ b/t/t6008-rev-list-toosimple.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='test git-rev-list history over simplification'
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo BASE >content &&
+	git add content &&
+	git commit -m BASE &&
+	base=$(git rev-parse --verify HEAD) &&
+
+	test_tick &&
+	git checkout -b side &&
+	echo SIDE >content &&
+	git commit -m SIDE content &&
+	side=$(git rev-parse --verify HEAD) &&
+
+	test_tick &&
+	git checkout master &&
+	echo OTHER >other &&
+	git add other &&
+	git commit -m OTHER &&
+
+	test_tick &&
+	git merge -s ours side &&
+	keep=$(git rev-parse --verify HEAD) &&
+	test OTHER = $(git cat-file blob HEAD:other) &&
+	test BASE = $(git cat-file blob HEAD:content)
+'
+
+cat >expect <<EOF
+$keep
+$base
+$side
+EOF
+test_expect_success 'revert merge in history' '
+	git rev-list --full-history HEAD -- content >actual &&
+	git diff expect actual
+'
+
+test_done

-- 
Shawn.
