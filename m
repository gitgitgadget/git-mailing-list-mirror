From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 4/4] t7503: add tests for pre-commit hook (merge)
Date: Thu,  6 Sep 2012 16:25:58 +0200
Message-ID: <084ade976d944576da58c8334ffec5e47b209421.1346939542.git.git@drmicha.warpmail.net>
References: <50487F8A.4050803@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 16:26:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9d2H-0002Lq-TS
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab2IFO0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 10:26:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33333 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756083Ab2IFO0H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 10:26:07 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5C06620B35;
	Thu,  6 Sep 2012 10:26:07 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 06 Sep 2012 10:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Bg
	qPPC5ml/V0VcsdS1D9FX/uIgs=; b=FaWWy35i8OeaXlp/U60uA2gNJUhs3xzSQ+
	aeNyhx02KeKM8NHXww339d/4hrkNIJKO34Utdv4I6KsZL+QXEdrTlvt8i83r1sZN
	FNnLFJGrwejk84fnvRVV94H2U6YFq+qen2484MKvt47oOzAoovHpurbtYMhijzVV
	CGMRnAbjk=
X-Sasl-enc: y2fPM2+XIrthkfl4Wv9y07xgEPsxERvGGPhhZ16Z94iz 1346941566
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EC47B8E0217;
	Thu,  6 Sep 2012 10:26:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.406.gafd3f81
In-Reply-To: <50487F8A.4050803@alum.mit.edu>
In-Reply-To: <cover.1346939542.git.git@drmicha.warpmail.net>
References: <cover.1346939542.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204889>

Add tests which make sure that the pre-commit hook is called by 'git
merge' when merge.usePreCommitHook is set, allows/disallows merge
commits depending on its return value and is suppressed by
"--no-verify".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7503-pre-commit-hook.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b..e4d324d 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -4,6 +4,19 @@ test_description='pre-commit hook'
 
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
@@ -20,6 +41,14 @@ test_expect_success '--no-verify with no hook' '
 
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
@@ -29,6 +58,7 @@ cat > "$HOOK" <<EOF
 exit 0
 EOF
 chmod +x "$HOOK"
+git config merge.usePreCommitHook true
 
 test_expect_success 'with succeeding hook' '
 
@@ -38,6 +68,14 @@ test_expect_success 'with succeeding hook' '
 
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
@@ -46,6 +84,14 @@ test_expect_success '--no-verify with succeeding hook' '
 
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
@@ -68,6 +114,22 @@ test_expect_success '--no-verify with failing hook' '
 
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
