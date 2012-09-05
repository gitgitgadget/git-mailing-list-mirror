From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/3] t7503: add tests for pre-merge-hook
Date: Wed,  5 Sep 2012 15:39:11 +0200
Message-ID: <9794b51187bd02662b84597edcea5911fd5b41f3.1346851864.git.git@drmicha.warpmail.net>
References: <cover.1346851863.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 15:39:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9FpF-0008Eq-N7
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 15:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690Ab2IENjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 09:39:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51652 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753324Ab2IENjS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 09:39:18 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2B9E920C55
	for <git@vger.kernel.org>; Wed,  5 Sep 2012 09:39:18 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 05 Sep 2012 09:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=x+ABN/uOou/GnUE2bFAzz/7jy
	HY=; b=MMdNPgRjrLt2a3ch/NI6kJisVpSCHNJ9Fg9WI/JnO1eBSqL1z0edVKK2g
	efWPV2cepPL1rrwi9uRrk0BZeTtzCYXwm4P6rLZ+karz7AT2DRDpYfx3mJkN9H06
	FIZ3CN9ifKMY2xyzqjRQkhklGA3saZznJ10ToSFnerTYUYL9VI=
X-Sasl-enc: N9xVyIyzOlW/37EQNddda6+pOC2USbNJn0DzlWJ81hx4 1346852357
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A50AC4836EE;
	Wed,  5 Sep 2012 09:39:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.406.gafd3f81
In-Reply-To: <cover.1346851863.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204824>

Add tests which make sure that the pre-merge-hook is called when
present, allows/disallows merge commits depending on its return value
and is suppressed by "--no-verify".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7503-pre-commit-hook.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b..36ae87f 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -1,9 +1,22 @@
 #!/bin/sh
 
-test_description='pre-commit hook'
+test_description='pre-commit and pre-merge hooks'
 
 . ./test-lib.sh
 
+test_expect_success 'root commit' '
+
+	echo "root" > file &&
+	git add file &&
+	git commit -m "zeroth" &&
+	git checkout -b side &&
+	echo "foo" > foo &&
+	git add foo &&
+	git commit -m "make it non-ff" &&
+	git checkout master
+
+'
+
 test_expect_success 'with no hook' '
 
 	echo "foo" > file &&
@@ -12,6 +25,14 @@ test_expect_success 'with no hook' '
 
 '
 
+test_expect_success 'with no hook (merge)' '
+
+	git checkout side &&
+	git merge -m "merge master" master &&
+	git checkout master
+
+'
+
 test_expect_success '--no-verify with no hook' '
 
 	echo "bar" > file &&
@@ -20,15 +41,25 @@ test_expect_success '--no-verify with no hook' '
 
 '
 
+test_expect_success '--no-verify with no hook (merge)' '
+
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master
+
+'
+
 # now install hook that always succeeds
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
 HOOK="$HOOKDIR/pre-commit"
+MERGEHOOK="$HOOKDIR/pre-merge"
 mkdir -p "$HOOKDIR"
 cat > "$HOOK" <<EOF
 #!/bin/sh
 exit 0
 EOF
 chmod +x "$HOOK"
+cp -p "$HOOK" "$MERGEHOOK"
 
 test_expect_success 'with succeeding hook' '
 
@@ -38,6 +69,14 @@ test_expect_success 'with succeeding hook' '
 
 '
 
+test_expect_success 'with succeeding hook (merge)' '
+
+	git checkout side &&
+	git merge -m "merge master" master &&
+	git checkout master
+
+'
+
 test_expect_success '--no-verify with succeeding hook' '
 
 	echo "even more" >> file &&
@@ -46,11 +85,20 @@ test_expect_success '--no-verify with succeeding hook' '
 
 '
 
+test_expect_success '--no-verify with succeeding hook (merge)' '
+
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master
+
+'
+
 # now a hook that fails
 cat > "$HOOK" <<EOF
 #!/bin/sh
 exit 1
 EOF
+cp -p "$HOOK" "$MERGEHOOK"
 
 test_expect_success 'with failing hook' '
 
@@ -68,6 +116,22 @@ test_expect_success '--no-verify with failing hook' '
 
 '
 
+test_expect_success 'with failing hook (merge)' '
+
+	git checkout side &&
+	test_must_fail git merge -m "merge master" master &&
+	git checkout master
+
+'
+
+test_expect_success '--no-verify with failing hook (merge)' '
+
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master
+
+'
+
 chmod -x "$HOOK"
 test_expect_success POSIXPERM 'with non-executable hook' '
 
-- 
1.7.12.406.gafd3f81
