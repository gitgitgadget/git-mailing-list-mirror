From: "Josh England" <jjengla@sandia.gov>
Subject: [PATCH] post-merge hook and related tests
Date: Tue, 25 Sep 2007 16:49:22 -0600
Message-ID: <1190760563-32453-2-git-send-email-jjengla@sandia.gov>
References: <1190760563-32453-1-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Josh England" <jjengla@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 00:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJEK-00046D-0r
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 00:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbXIYWt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 18:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbXIYWt6
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 18:49:58 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:3448 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbXIYWt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 18:49:57 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 25 Sep 2007 16:49:45 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from ES24SNLNT.srn.sandia.gov (ec06snlnt.sandia.gov
 [134.253.164.50] (may be forged)) by mailgate.sandia.gov (
 8.14.0/8.14.0) with ESMTP id l8PMnjZU009500 for <git@vger.kernel.org>;
 Tue, 25 Sep 2007 16:49:45 -0600
Received: from ef01snlnt.srn.sandia.gov ([134.253.164.107]) by
 ES24SNLNT.srn.sandia.gov with Microsoft SMTPSVC(6.0.3790.3959); Tue, 25
 Sep 2007 16:49:45 -0600
Received: from truth ([134.253.45.6]) by ef01snlnt.srn.sandia.gov with
 Microsoft SMTPSVC(6.0.3790.3959); Tue, 25 Sep 2007 16:49:45 -0600
Received: by truth (sSMTP sendmail emulation); Tue, 25 Sep 2007 16:49:23
 -0600
X-Mailer: git-send-email 1.5.3.2.89.g296e
In-Reply-To: <1190760563-32453-1-git-send-email-jjengla@sandia.gov>
X-OriginalArrivalTime: 25 Sep 2007 22:49:45.0639 (UTC)
 FILETIME=[5E708B70:01C7FFC6]
X-TMWD-Spam-Summary: TS=20070925224946; SEV=2.2.2; DFV=B2007092518;
 IFV=2.0.4,4.0-9; AIF=B2007092518; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230372E34364639393038412E303031363A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092518_5.02.0125_4.0-9
X-WSS-ID: 6AE74F033HO3445749-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59187>

Signed-off-by: Josh England <jjengla@sandia.gov>
---
 git-merge.sh               |   13 ++++++++++
 t/t5402-post-merge-hook.sh |   56 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100644 t/t5402-post-merge-hook.sh

diff --git a/git-merge.sh b/git-merge.sh
index 3a01db0..66e48b3 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -97,6 +97,19 @@ finish () {
 		fi
 		;;
 	esac
+
+	# Run a post-merge hook
+        if test -x "$GIT_DIR"/hooks/post-merge
+        then
+	    case "$squash" in
+	    t)
+                "$GIT_DIR"/hooks/post-merge 1
+		;;
+	    '')
+                "$GIT_DIR"/hooks/post-merge 0
+		;;
+	    esac
+        fi
 }
 
 merge_name () {
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
new file mode 100644
index 0000000..2a7a097
--- /dev/null
+++ b/t/t5402-post-merge-hook.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Josh England
+#
+
+test_description='Test the post-merge hook.'
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo Data for commit0. >a &&
+	git update-index --add a &&
+	tree0=$(git write-tree) &&
+	commit0=$(echo setup | git commit-tree $tree0) &&
+	echo Changed data for commit1. >a &&
+	git update-index a &&
+	tree1=$(git write-tree) &&
+	commit1=$(echo modify | git commit-tree $tree1 -p $commit0) &&
+        git update-ref refs/heads/master $commit0 &&     
+	git-clone ./. clone1 &&
+	GIT_DIR=clone1/.git git update-index --add a &&
+	git-clone ./. clone2 &&
+	GIT_DIR=clone2/.git git update-index --add a
+'
+
+for clone in 1 2; do 
+    cat >clone${clone}/.git/hooks/post-merge <<'EOF'
+#!/bin/sh
+echo $@ >> $GIT_DIR/post-merge.args
+EOF
+    chmod u+x clone${clone}/.git/hooks/post-merge
+done
+
+test_expect_failure 'post-merge does not run for up-to-date ' '
+        GIT_DIR=clone1/.git git merge $commit0 &&
+ 	test -e clone1/.git/post-merge.args
+'
+
+test_expect_success 'post-merge runs as expected ' '
+        GIT_DIR=clone1/.git git merge $commit1 &&
+ 	test -e clone1/.git/post-merge.args
+'
+
+test_expect_success 'post-merge from normal merge receives the right argument ' '
+        grep 0 clone1/.git/post-merge.args
+'
+
+test_expect_success 'post-merge from squash merge runs as expected ' '
+        GIT_DIR=clone2/.git git merge --squash $commit1 &&
+ 	test -e clone2/.git/post-merge.args
+'
+
+test_expect_success 'post-merge from squash merge receives the right argument ' '
+        grep 1 clone2/.git/post-merge.args
+'
+
+test_done
-- 
1.5.3.2.89.g296e
