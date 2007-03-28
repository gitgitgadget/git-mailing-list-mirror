From: Junio C Hamano <junkio@cox.net>
Subject: Sanity checking request
Date: Wed, 28 Mar 2007 02:57:20 -0700
Message-ID: <7vwt11itbz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 11:57:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWUuD-00064F-SK
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 11:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbXC1J5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 05:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbXC1J5W
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 05:57:22 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56173 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbXC1J5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 05:57:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328095722.RDQN373.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 28 Mar 2007 05:57:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id g9xL1W00K1kojtg0000000; Wed, 28 Mar 2007 05:57:21 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43367>

We've been saying that:

	git read-tree -m $tree

is a quicker way to do "git read-tree $tree" (i.e. populate the
index from a given tree), and except for the reuse of cached
stat info to gain performance, there is no difference.

Well, I think I broke it with fcc387d on May 17 2006, and I am
wondering what the correct way to fix that should be.  It
depends on how -u and -i options to git-read-tree are meant to
be used.

On one hand, one could argue that "git read-tree -m $tree"
should behave the same way as "git read-tree -m -u $tree" except
that it does not do the checkout part.  The in-code comment for
the -i option says "a merge will not even look at the working
tree", implying that it will without the option, so running
verify_update() and verify_absense() even though update option
is not explicitly passed (hence read-tree itself does not do the
checkout) might be the right thing to do.  Admittedly, when I
introduced the above breakage, I wasn't consciously making such
design decision (I was more interested in making two- and
three-tree case work).  Then "git read-tree -i -m $tree" would
become the new right way to do a quicker "git read-tree $tree"
if we take this route.

The only in-tree user of single-tree merge is in git-commit.  We
could do this:

diff --git a/git-commit.sh b/git-commit.sh
index 3656d60..292cf96 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -371,7 +371,7 @@ t,)
 		if test -z "$initial_commit"
 		then
 			cp "$THIS_INDEX" "$TMP_INDEX"
-			GIT_INDEX_FILE="$TMP_INDEX" git-read-tree -m HEAD
+			GIT_INDEX_FILE="$TMP_INDEX" git-read-tree -i -m HEAD
 		else
 			rm -f "$TMP_INDEX"
 		fi || exit


Alternatively, we could make -i implied for one-tree merge
unless -u is given, which is the attached.

What do you think?

-- >8 --
read-tree -m $TREE: do not look at working tree.

A merging single-tree read-tree has been advertised as a quicker
way to do the equivalent single-tree read-tree without any other
difference, but currently it looks at the working tree and does
bogus checks to detect if the paths have local changes and
such.  Disable them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 793eae0..2a1d3c8 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -236,6 +236,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		switch (stage - 1) {
 		case 1:
 			opts.fn = opts.prefix ? bind_merge : oneway_merge;
+			if (!opts.update)
+				opts.index_only = 1;
 			break;
 		case 2:
 			opts.fn = twoway_merge;
