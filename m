From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/3] rebase: allow --merge option to handle patches merged upstream
Date: Sat, 24 Jun 2006 18:29:47 -0700
Message-ID: <11511989902239-git-send-email-normalperson@yhbt.net>
References: <20060622110941.GA32261@hand.yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:30:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJRj-0002dn-Ex
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWFYB3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWFYB3w
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:29:52 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54971 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964888AbWFYB3w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:29:52 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D41667DC023;
	Sat, 24 Jun 2006 18:29:50 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 24 Jun 2006 18:29:50 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0.g937a
In-Reply-To: <20060622110941.GA32261@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22559>

Enhance t3401-rebase-partial to test with --merge as well as
the standard am -3 strategy.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-rebase.sh             |   15 +++++++++++----
 t/t3401-rebase-partial.sh |   13 ++++++++++++-
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9159477..53fb14e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -82,7 +82,10 @@ call_merge () {
 	rv=$?
 	case "$rv" in
 	0)
-		git-commit -C "$cmt" || die "commit failed: $MRESOLVEMSG"
+		if test -n "`git-diff-index HEAD`"
+		then
+			git-commit -C "$cmt" || die "commit failed: $MRESOLVEMSG"
+		fi
 		;;
 	1)
 		test -d "$GIT_DIR/rr-cache" && git-rerere
@@ -110,9 +113,13 @@ finish_rb_merge () {
 	do
 		git-read-tree `cat "$dotest/cmt.$msgnum.result"`
 		git-checkout-index -q -f -u -a
-		git-commit -C "`cat $dotest/cmt.$msgnum`"
-
-		printf "Committed %0${prec}d" $msgnum
+		if test -n "`git-diff-index HEAD`"
+		then
+			git-commit -C "`cat $dotest/cmt.$msgnum`"
+			printf "Committed %0${prec}d" $msgnum
+		else
+			printf "Already applied: %0${prec}d" $msgnum
+		fi
 		echo ' '`git-rev-list --pretty=oneline -1 HEAD | \
 					sed 's/^[a-f0-9]\+ //'`
 		msgnum=$(($msgnum + 1))
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 32dc9c5..360a670 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -37,7 +37,9 @@ test_expect_success \
 test_expect_success \
     'pick top patch from topic branch into master' \
     'git-cherry-pick my-topic-branch^0 &&
-     git-checkout -f my-topic-branch
+     git-checkout -f my-topic-branch &&
+     git-branch master-merge master &&
+     git-branch my-topic-branch-merge my-topic-branch
 '
 
 test_debug \
@@ -50,4 +52,13 @@ test_expect_success \
     'rebase topic branch against new master and check git-am did not get halted' \
     'git-rebase master && test ! -d .dotest'
 
+if test -z "$no_python"
+then
+    test_expect_success \
+	'rebase --merge topic branch that was partially merged upstream' \
+	'git-checkout -f my-topic-branch-merge &&
+	 git-rebase --merge master-merge &&
+	 test ! -d .git/.dotest-merge'
+fi
+
 test_done
-- 
1.4.0.g937a
