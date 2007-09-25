From: "Josh England" <jjengla@sandia.gov>
Subject: [PATCH] post-checkout hooks and related tests
Date: Tue, 25 Sep 2007 16:49:21 -0600
Message-ID: <1190760563-32453-1-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Josh England" <jjengla@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 00:50:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJEL-00046D-6M
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 00:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbXIYWuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 18:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbXIYWuD
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 18:50:03 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:1567 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbXIYWt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 18:49:58 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 25 Sep 2007 16:49:45 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from ES24SNLNT.srn.sandia.gov (ec06snlnt.sandia.gov
 [134.253.164.50] (may be forged)) by mailgate.sandia.gov (
 8.14.0/8.14.0) with ESMTP id l8PMnjZS009500 for <git@vger.kernel.org>;
 Tue, 25 Sep 2007 16:49:45 -0600
Received: from ef01snlnt.srn.sandia.gov ([134.253.164.107]) by
 ES24SNLNT.srn.sandia.gov with Microsoft SMTPSVC(6.0.3790.3959); Tue, 25
 Sep 2007 16:49:45 -0600
Received: from truth ([134.253.45.6]) by ef01snlnt.srn.sandia.gov with
 Microsoft SMTPSVC(6.0.3790.3959); Tue, 25 Sep 2007 16:49:45 -0600
Received: by truth (sSMTP sendmail emulation); Tue, 25 Sep 2007 16:49:23
 -0600
X-Mailer: git-send-email 1.5.3.2.89.g296e
X-OriginalArrivalTime: 25 Sep 2007 22:49:45.0545 (UTC)
 FILETIME=[5E623390:01C7FFC6]
X-TMWD-Spam-Summary: TS=20070925224946; SEV=2.2.2; DFV=B2007092518;
 IFV=2.0.4,4.0-9; AIF=B2007092518; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230332E34364639393038412E303031323A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092518_5.02.0125_4.0-9
X-WSS-ID: 6AE74F033HO3445748-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59188>

Signed-off-by: Josh England <jjengla@sandia.gov>
---
 git-checkout.sh               |   12 +++++++
 t/t5403-post-checkout-hook.sh |   70 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100755 t/t5403-post-checkout-hook.sh

diff --git a/git-checkout.sh b/git-checkout.sh
index 17f4392..78355eb 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -137,6 +137,13 @@ Did you intend to checkout '$@' which can not be resolved as commit?"
 	git ls-files --error-unmatch -- "$@" >/dev/null || exit
 	git ls-files -- "$@" |
 	git checkout-index -f -u --stdin
+
+        # Run a post-checkout hook -- the HEAD does not change so the
+	# current HEAD is passed in for both args
+	if test -x "$GIT_DIR"/hooks/post-checkout; then
+	    "$GIT_DIR"/hooks/post-checkout $old $old
+	fi
+
 	exit $?
 else
 	# Make sure we did not fall back on $arg^{tree} codepath
@@ -284,3 +291,8 @@ if [ "$?" -eq 0 ]; then
 else
 	exit 1
 fi
+
+# Run a post-checkout hook
+if test -x "$GIT_DIR"/hooks/post-checkout; then
+        "$GIT_DIR"/hooks/post-checkout $old $new
+fi
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
new file mode 100755
index 0000000..663f8d7
--- /dev/null
+++ b/t/t5403-post-checkout-hook.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Josh England
+#
+
+test_description='Test the post-checkout hook.'
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo Data for commit0. >a &&
+	echo Data for commit0. >b &&
+	git update-index --add a &&
+	git update-index --add b &&
+	tree0=$(git write-tree) &&
+	commit0=$(echo setup | git commit-tree $tree0) &&
+        git update-ref refs/heads/master $commit0 &&
+	git-clone ./. clone1 &&
+	git-clone ./. clone2 &&
+        GIT_DIR=clone2/.git git branch -a new2 &&
+       	echo Data for commit1. >clone2/b &&
+	GIT_DIR=clone2/.git git add clone2/b &&
+	GIT_DIR=clone2/.git git commit -m new2
+'
+
+for clone in 1 2; do 
+    cat >clone${clone}/.git/hooks/post-checkout <<'EOF'
+#!/bin/sh
+echo $@ > $GIT_DIR/post-checkout.args
+EOF
+    chmod u+x clone${clone}/.git/hooks/post-checkout
+done
+
+test_expect_success 'post-checkout runs as expected ' '
+        GIT_DIR=clone1/.git git checkout master &&
+ 	test -e clone1/.git/post-checkout.args
+'
+
+test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
+         old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
+         new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
+         test $old = $new
+'
+
+test_expect_success 'post-checkout runs as expected ' '
+        GIT_DIR=clone1/.git git checkout master &&
+ 	test -e clone1/.git/post-checkout.args
+'
+
+test_expect_success 'post-checkout args are correct with git checkout -b ' '
+        GIT_DIR=clone1/.git git checkout -b new1 &&
+        old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
+        new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
+        test $old = $new
+'
+
+test_expect_success 'post-checkout receives the right args with HEAD changed ' '
+        GIT_DIR=clone2/.git git checkout new2 &&
+        old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
+        new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
+        test $old != $new
+'
+
+test_expect_success 'post-checkout receives the right args when not switching branches ' '
+        GIT_DIR=clone2/.git git checkout master b &&
+        old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
+        new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
+        test $old == $new
+'
+
+test_done
-- 
1.5.3.2.89.g296e
