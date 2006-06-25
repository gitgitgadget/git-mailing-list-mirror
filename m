From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/3] rebase: cleanup rebasing with --merge
Date: Sat, 24 Jun 2006 18:29:48 -0700
Message-ID: <11511989922423-git-send-email-normalperson@yhbt.net>
References: <20060622110941.GA32261@hand.yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:30:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJRw-0002gX-C1
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWFYB3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWFYB3y
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:29:54 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55995 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964889AbWFYB3x (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:29:53 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1FEA67DC024;
	Sat, 24 Jun 2006 18:29:52 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 24 Jun 2006 18:29:52 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0.g937a
In-Reply-To: <20060622110941.GA32261@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22561>

We no longer have to recommit each patch to remove the parent
information we're rebasing since we're using the low-level merge
strategies directly instead of git-merge.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-rebase.sh |   33 +++++----------------------------
 1 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 53fb14e..a95ada6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,15 +59,16 @@ continue_merge () {
 
 	if test -n "`git-diff-index HEAD`"
 	then
+		printf "Committed: %0${prec}d" $msgnum
 		git-commit -C "`cat $dotest/current`"
 	else
-		echo "Previous merge succeeded automatically"
+		printf "Already applied: %0${prec}d" $msgnum
 	fi
+	echo ' '`git-rev-list --pretty=oneline -1 HEAD | \
+				sed 's/^[a-f0-9]\+ //'`
 
 	prev_head=`git-rev-parse HEAD^0`
-
 	# save the resulting commit so we can read-tree on it later
-	echo "$prev_head" > "$dotest/cmt.$msgnum.result"
 	echo "$prev_head" > "$dotest/prev_head"
 
 	# onto the next patch:
@@ -82,10 +83,7 @@ call_merge () {
 	rv=$?
 	case "$rv" in
 	0)
-		if test -n "`git-diff-index HEAD`"
-		then
-			git-commit -C "$cmt" || die "commit failed: $MRESOLVEMSG"
-		fi
+		return
 		;;
 	1)
 		test -d "$GIT_DIR/rr-cache" && git-rerere
@@ -103,27 +101,6 @@ call_merge () {
 }
 
 finish_rb_merge () {
-	set -e
-
-	msgnum=1
-	echo "Finalizing rebased commits..."
-	git-reset --hard "`cat $dotest/onto`"
-	end="`cat $dotest/end`"
-	while test "$msgnum" -le "$end"
-	do
-		git-read-tree `cat "$dotest/cmt.$msgnum.result"`
-		git-checkout-index -q -f -u -a
-		if test -n "`git-diff-index HEAD`"
-		then
-			git-commit -C "`cat $dotest/cmt.$msgnum`"
-			printf "Committed %0${prec}d" $msgnum
-		else
-			printf "Already applied: %0${prec}d" $msgnum
-		fi
-		echo ' '`git-rev-list --pretty=oneline -1 HEAD | \
-					sed 's/^[a-f0-9]\+ //'`
-		msgnum=$(($msgnum + 1))
-	done
 	rm -r "$dotest"
 	echo "All done."
 }
-- 
1.4.0.g937a
