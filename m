Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE7620A26
	for <e@80x24.org>; Fri, 22 Sep 2017 12:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbdIVMEa (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 08:04:30 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdIVMEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 08:04:25 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MQ8It-1e0Zl81Xu7-005Kao; Fri, 22
 Sep 2017 14:04:21 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/4] t7503: add tests for pre-merge-hook
Date:   Fri, 22 Sep 2017 14:04:15 +0200
Message-Id: <381fe8facbbc1667d655572fcff5d6eb5f0e07fc.1506081120.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.909.g0fa57a0913
In-Reply-To: <cover.1506081120.git.git@grubix.eu>
References: <cover.1506081120.git.git@grubix.eu>
X-Provags-ID: V03:K0:7F1Ve15TJ33YIA69tgvR8rEEZ3IYbM5zRCJLH4xAbkU48FAOT0S
 HXyKtoaehnbhImx1gMjraSoPglRircBxC6Px09xyBBOIM3C52nIC22Nrmg8T9HGV0PkzUjh
 1rDcRPr7/I5WzTCx1l2Xmg9scih3WasKkg6oUV/DRAMf0toSgS9yLRn4rTs0wT1ZxIzWRoz
 F8bAGfhVzw1SKVtX2p6kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ru5pDXsWpdE=:aWwQviZ66yw1m93+UwT0Cp
 fC2F4C4LjLZXrPo0+FpH3fdWak/sropO/eh7PGbHduw1pzXCDmPbDgkK3YnDXsAkU9KfrhEyq
 FEAZRhsjjhH9rZw9d9nhIpSUmgybkgUJsuUAy1KnlWUbSh7OSfAKRaBWyWjZZTJhqfW8pMPMp
 1pmCCBm0DIKTxA2FJGKEgxtovEviCaN1a61UsdZTuha6VRTwrbJJY81c/R+pD/wygqdACYII6
 6XcNrB7chFcaW4vEfrxF1EnyWgywB4Dq2dcFxouWvb95QLHT8pNQzDigZcJtWNb+NPhy+7XAC
 N61+RhcfP9cMzZHDg3eaZ0mdzynDIzaZlljZybNJF7C5PL2HzlX7EF3CsBVtObVYDZlZkmX2Z
 Bt+5SvzVadDbRSFvqQd16Ry4A9mLY8uwZqUr53hHiW6YGoe8yDC6VcdTUA9MwU528q3qIYfZO
 ly4+0Y1GBFTrvqbochwepIb61a1VW70VoHoiKg2zeQDp/GN6aISkKDNwuIOOrRQZlaAEnN7JL
 QSg4RL/erqh2MqCVNU38KoKKucMilu6XFZzniQONVKVFmepNsHRMx3zhujt5gkNTJphtNbEHB
 l9fk+FrONmAOOjJMYYODnxFKiPpX7Tn3MHAhMTUKCyZ6+LIIlZxGM0/ZwTTbp7AfshuWLl7aY
 9dast1ekLS3QbQHpPtApk4zePR0buGgPoF8uTK5R3vZjAaZCCJF5Tq0pZeZQ+Sj+fAdKhUaCI
 8qa5bn7o7RUWChO4AlZgmm0Iktodb3tcj4RC+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael J Gruber <git@drmicha.warpmail.net>

Add tests which make sure that the pre-merge-hook is called when
present, allows/disallows merge commits depending on its return value
and is suppressed by "--no-verify".

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 t/t7503-pre-commit-hook.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b39d..36ae87f7ef 100755
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
2.14.1.909.g0fa57a0913

