From: "Josh England" <jjengla@sandia.gov>
Subject: [PATCH] post-checkout hook, tests, and docs
Date: Wed, 26 Sep 2007 15:31:01 -0600
Message-ID: <1190842261-9750-1-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Josh England" <jjengla@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 23:31:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaeTy-0001U6-Hd
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 23:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761374AbXIZVbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 17:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbXIZVbj
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 17:31:39 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:1786 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbXIZVbi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 17:31:38 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Wed, 26 Sep 2007 15:31:24 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from ES23SNLNT.srn.sandia.gov (ec04snlnt.sandia.gov
 [134.253.164.156] (may be forged)) by mailgate.sandia.gov (
 8.14.0/8.14.0) with ESMTP id l8QLVOSJ008533 for <git@vger.kernel.org>;
 Wed, 26 Sep 2007 15:31:24 -0600
Received: from ef01snlnt.srn.sandia.gov ([134.253.164.107]) by
 ES23SNLNT.srn.sandia.gov with Microsoft SMTPSVC(6.0.3790.3959); Wed, 26
 Sep 2007 15:31:25 -0600
Received: from truth ([134.253.45.6]) by ef01snlnt.srn.sandia.gov with
 Microsoft SMTPSVC(6.0.3790.3959); Wed, 26 Sep 2007 15:31:23 -0600
Received: by truth (sSMTP sendmail emulation); Wed, 26 Sep 2007 15:31:01
 -0600
X-Mailer: git-send-email 1.5.3.2.90.g6069e-dirty
X-OriginalArrivalTime: 26 Sep 2007 21:31:24.0013 (UTC)
 FILETIME=[967719D0:01C80084]
X-TMWD-Spam-Summary: TS=20070926213127; SEV=2.2.2; DFV=B2007092618;
 IFV=2.0.4,4.0-9; AIF=B2007092618; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230362E34364641434641462E303036323A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092618_5.02.0125_4.0-9
X-WSS-ID: 6AE410263HO3571590-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59250>

Updated post-checkout hook to take a flag specifying whether the checkout is
a branch checkout or a file checkout (from the index).

Signed-off-by: Josh England <jjengla@sandia.gov>
---
 Documentation/hooks.txt       |   14 ++++++++
 git-checkout.sh               |   12 +++++++
 t/t5403-post-checkout-hook.sh |   74 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100755 t/t5403-post-checkout-hook.sh

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 58b9547..f110162 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -87,6 +87,20 @@ parameter, and is invoked after a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git-commit`.
 
+post-checkout
+-----------
+
+This hook is invoked when a `git-checkout` is run after having updated the
+worktree.  The hook is given three parameters: the ref of the previous HEAD,
+the ref of the new HEAD (which may or may not have changed), and a flag
+indicating whether the checkout was a branch checkout (changing branches,
+flag=1) or a file checkout (retrieving a file from the index, flag=0).
+This hook cannot affect the outcome of `git-checkout`.
+
+This hook can be used to perform repository validity checks, auto-display
+differences from the previous HEAD if different, or set working dir metadata
+properties.
+
 post-merge
 -----------
 
diff --git a/git-checkout.sh b/git-checkout.sh
index 17f4392..8993920 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -137,6 +137,13 @@ Did you intend to checkout '$@' which can not be resolved as commit?"
 	git ls-files --error-unmatch -- "$@" >/dev/null || exit
 	git ls-files -- "$@" |
 	git checkout-index -f -u --stdin
+
+        # Run a post-checkout hook -- the HEAD does not change so the
+        # current HEAD is passed in for both args
+	if test -x "$GIT_DIR"/hooks/post-checkout; then
+	    "$GIT_DIR"/hooks/post-checkout $old $old 0
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
+        "$GIT_DIR"/hooks/post-checkout $old $new 1
+fi
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
new file mode 100755
index 0000000..e656aa1
--- /dev/null
+++ b/t/t5403-post-checkout-hook.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Josh England
+#
+
+test_description='Test the post-checkout hook.'
+. ./test-lib.sh
+
+test_expect_success setup '
+	 echo Data for commit0. >a &&
+	 echo Data for commit0. >b &&
+	 git update-index --add a &&
+	 git update-index --add b &&
+	 tree0=$(git write-tree) &&
+	 commit0=$(echo setup | git commit-tree $tree0) &&
+        git update-ref refs/heads/master $commit0 &&
+	 git-clone ./. clone1 &&
+	 git-clone ./. clone2 &&
+        GIT_DIR=clone2/.git git branch -a new2 &&
+        echo Data for commit1. >clone2/b &&
+	 GIT_DIR=clone2/.git git add clone2/b &&
+	 GIT_DIR=clone2/.git git commit -m new2
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
+        test -e clone1/.git/post-checkout.args
+'
+
+test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
+        old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
+        new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
+        flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
+        test $old = $new -a $flag == 1
+'
+
+test_expect_success 'post-checkout runs as expected ' '
+        GIT_DIR=clone1/.git git checkout master &&
+        test -e clone1/.git/post-checkout.args
+'
+
+test_expect_success 'post-checkout args are correct with git checkout -b ' '
+        GIT_DIR=clone1/.git git checkout -b new1 &&
+        old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
+        new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
+        flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
+        test $old = $new -a $flag == 1
+'
+
+test_expect_success 'post-checkout receives the right args with HEAD changed ' '
+        GIT_DIR=clone2/.git git checkout new2 &&
+        old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
+        new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
+        flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+        test $old != $new -a $flag == 1
+'
+
+test_expect_success 'post-checkout receives the right args when not switching branches ' '
+        GIT_DIR=clone2/.git git checkout master b &&
+        old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
+        new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
+        flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+        test $old == $new -a $flag == 0
+'
+
+test_done
-- 
1.5.3.2.90.g6069e-dirty
