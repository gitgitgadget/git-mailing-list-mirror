From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Fix git-stash apply --index
Date: Sat, 28 Jul 2007 00:02:06 -0700
Message-ID: <7v3az9ui35.fsf@assigned-by-dhcp.cox.net>
References: <7vbqdxui72.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 09:02:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEgK7-0004hT-Oe
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 09:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345AbXG1HCM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 03:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757293AbXG1HCL
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 03:02:11 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34183 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757265AbXG1HCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 03:02:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728070209.SVQU1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 03:02:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Uv281X0011kojtg0000000; Sat, 28 Jul 2007 03:02:08 -0400
In-Reply-To: <7vbqdxui72.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 27 Jul 2007 23:59:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53998>

Two bugs that made the command practically unusable were fixed
with this.

 - A stash created with a clean index does not have any
   difference between the base tree and the index tree.
   Trying to apply the diff between them to the index would
   error out with "No changes".  Even when the user asked to
   unstash with --index, do not bother with --index action if
   the base tree and the index tree match.

 - After successfully performing the working tree merge, the
   index was reloaded from an earlier state of unstashed index
   with "read-tree"; this left all the paths cache dirty.  By
   moving the call to git-status after this read-tree, match the
   cached stat information in the index.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 0073e9d..873e7be 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -128,19 +128,24 @@ apply_stash () {
 	c_tree=$(git write-tree) ||
 		die 'Cannot apply a stash in the middle of a merge'
 
+	# stash records the work tree, and is a merge between the
+	# base commit (first parent) and the index tree (second parent).
 	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@") &&
 	w_tree=$(git rev-parse --verify "$s:") &&
-	b_tree=$(git rev-parse --verify "$s^:") ||
+	b_tree=$(git rev-parse --verify "$s^1:") &&
+	i_tree=$(git rev-parse --verify "$s^2:") ||
 		die "$*: no valid stashed state found"
 
-	test -z "$unstash_index" || {
+	unstashed_index_tree=
+	if test -n "$unstash_index" && test "$b_tree" != "$i_tree"
+	then
 		git diff --binary $s^2^..$s^2 | git apply --cached
 		test $? -ne 0 &&
 			die 'Conflicts in index. Try without --index.'
 		unstashed_index_tree=$(git-write-tree) ||
 			die 'Could not save index tree'
 		git reset
-	}
+	fi
 
 	eval "
 		GITHEAD_$w_tree='Stashed changes' &&
@@ -157,13 +162,19 @@ apply_stash () {
 		git read-tree --reset $c_tree &&
 		git update-index --add --stdin <"$a" ||
 			die "Cannot unstage modified files"
-		git-status
 		rm -f "$a"
-		test -z "$unstash_index" || git read-tree $unstashed_index_tree
+		if test -n "$unstashed_index_tree"
+		then
+			git read-tree "$unstashed_index_tree"
+		fi
+		git status || :
 	else
 		# Merge conflict; keep the exit status from merge-recursive
 		status=$?
-		test -z "$unstash_index" || echo 'Index was not unstashed.' >&2
+		if test -n "$unstash_index"
+		then
+			echo >&2 'Index was not unstashed.'
+		fi
 		exit $status
 	fi
 }
-- 
1.5.3.rc3.16.g9f04-dirty
