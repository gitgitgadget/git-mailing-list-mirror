Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB99D1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 23:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfDZXv6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 19:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfDZXv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 19:51:58 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC53B206C1;
        Fri, 26 Apr 2019 23:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556322717;
        bh=Vyy8QSkjtPbkZIzeDatyi+NkMeFvg8i09w7D3q4/T3w=;
        h=From:To:Cc:Subject:Date:From;
        b=BgiH/MQtOZX2Vn5aZ3ARbFrhZM2rFV+/9u5XiSg/+hi7QPBaDjXNhyEl8GEYEVIf5
         S9bChmTPWBaWzjL/5+QiQjSUvJDwmOQT51MCqE/zzBolnNwM40J8qtAu+rlYDsUP0z
         TtRhaZH04CwSiPVyzeOSvj8sJq0H4bwZRLRZVP1U=
From:   Stephen Boyd <sboyd@kernel.org>
To:     git@vger.kernel.org
Cc:     Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH 1/2] format-patch: Inform user that patch-id generation is unstable
Date:   Fri, 26 Apr 2019 16:51:56 -0700
Message-Id: <20190426235157.106350-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried out 'git format-patch --base' with a set of commits that
modifies more than one file. It turns out that the way this command is
implemented it actually uses the unstable version of patch-id instead of
the stable version that's documented. When I tried to modify the
existing test to use 'git patch-id --stable' vs. 'git patch-id
--unstable' I found that it didn't matter, the test still passed.

Let's expand on the test here so it is a little more complicated and
then use that to show that the patch-id generation is actually unstable
vs. stable. Update the documentation as well.

Cc: Xiaolong Ye <xiaolong.ye@intel.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/git-format-patch.txt |  2 +-
 t/t4014-format-patch.sh            | 36 +++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1af85d404f51..e8cc792e7f5d 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -583,7 +583,7 @@ of 'base commit' in topological order before the patches can be applied.
 The 'base commit' is shown as "base-commit: " followed by the 40-hex of
 the commit object name.  A 'prerequisite patch' is shown as
 "prerequisite-patch-id: " followed by the 40-hex 'patch id', which can
-be obtained by passing the patch through the `git patch-id --stable`
+be obtained by passing the patch through the `git patch-id --unstable`
 command.
 
 Imagine that on top of the public commit P, you applied well-known
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b6e2fdbc4410..e82c6c7d9177 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -36,8 +36,27 @@ test_expect_success setup '
 	git checkout master &&
 	git diff-tree -p C2 | git apply --index &&
 	test_tick &&
-	git commit -m "Master accepts moral equivalent of #2"
+	git commit -m "Master accepts moral equivalent of #2" &&
 
+	git checkout side &&
+	git checkout -b patchid &&
+	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >file2 &&
+	for i in 1 2 3 A 4 B C 7 8 9 10 D E F 5 6; do echo "$i"; done >file3 &&
+	for i in 8 9 10; do echo "$i"; done >file &&
+	git add file file2 file3 &&
+	test_tick &&
+	git commit -m "patchid 1" &&
+	for i in 4 A B 7 8 9 10; do echo "$i"; done >file2 &&
+	for i in 8 9 10 5 6; do echo "$i"; done >file3 &&
+	git add file2 file3 &&
+	test_tick &&
+	git commit -m "patchid 2" &&
+	for i in 10 5 6; do echo "$i"; done >file &&
+	git add file &&
+	test_tick &&
+	git commit -m "patchid 3" &&
+
+	git checkout master
 '
 
 test_expect_success "format-patch --ignore-if-in-upstream" '
@@ -1559,16 +1578,23 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 '
 
 test_expect_success 'format-patch --base' '
-	git checkout side &&
+	git checkout patchid &&
 	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual1 &&
 	git format-patch --stdout --base=HEAD~3 HEAD~.. | tail -n 7 >actual2 &&
 	echo >expected &&
 	echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --unstable | awk "{print \$1}")" >>expected &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --unstable | awk "{print \$1}")" >>expected &&
 	signature >> expected &&
 	test_cmp expected actual1 &&
-	test_cmp expected actual2
+	test_cmp expected actual2 &&
+	echo >fail &&
+	echo "base-commit: $(git rev-parse HEAD~3)" >>fail &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>fail &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>fail &&
+	signature >> fail &&
+	! test_cmp fail actual1 &&
+	! test_cmp fail actual2
 '
 
 test_expect_success 'format-patch --base errors out when base commit is in revision list' '
-- 
Sent by a computer through tubes

