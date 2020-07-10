Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411B3C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F80E2073A
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KnXwzVm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGJCss (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40418 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbgGJCse (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:34 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8B24F60A6A;
        Fri, 10 Jul 2020 02:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349310;
        bh=uCrnGBdS9Lu9BL/q9uR2rKu9/6DjL6gl4ER0ChIeMFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KnXwzVm7lqdu1Dg120F1gH32SaFsQdo3f82iVNOQ+iyMRYaMCZkQOiHdjhVppQSu9
         ytdw0T/r9vsh225kAH+ZSAdopbHUGS0r7ZQbeWF2ssm9ky1vrY7YLi4a9pcYpR9BIH
         za2Y1Jx7ra/R+G7Cp8zw5JXnPtklZLarGkECBtWrhQGZZf4ERdcP15oKN6LaWhuidm
         kwIbNw1HOtJCFCopfm8LmYdasaQwMN9yHFoPzIgx2zyXXhT3tE0vrLw9ubwswu9Dbd
         PD1bVFmFiT16zw6az3RC6/Vb/BFO4uLSfrgihW6jBjPKPeLW8MFa8Bina88Aj2fM7I
         pT/I719orbRrQgD8nUkPgxzQU/HV5tpJhhwwt0SuFOzKJ1I20h8KGnIKwFF7QhbbAG
         ddE9oRs0wizDGxpUxyvET5s8eDBAr5Ro49CJmY8cTGN1PU5Ag7BEZfxJL/iovmOIF1
         nG6Qkyef0yk9U6EZ9QLqqrV+M3sdFpft0yTyXPh6uVsAHp3H4hc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 16/38] t7506: avoid checking for SHA-1-specific constants
Date:   Fri, 10 Jul 2020 02:47:06 +0000
Message-Id: <20200710024728.3100527-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test to sanitize the diffs and strip out object IDs from
them, as it does for other object IDs, since we are not interested in
the particular values used.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7506-status-submodule.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 08629a6e70..3fcb44767f 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -22,6 +22,10 @@ sanitize_output () {
 	mv output2 output
 }
 
+sanitize_diff () {
+	sed -e "/^index [0-9a-f,]*\.\.[0-9a-f]*/d" "$1"
+}
+
 
 test_expect_success 'setup' '
 	test_create_repo_with_commit sub &&
@@ -269,7 +273,6 @@ short_sha1_merge_sub1=$(cd sub1 && git rev-parse --short HEAD)
 short_sha1_merge_sub2=$(cd sub2 && git rev-parse --short HEAD)
 cat >diff_expect <<\EOF
 diff --cc .gitmodules
-index badaa4c,44f999a..0000000
 --- a/.gitmodules
 +++ b/.gitmodules
 @@@ -1,3 -1,3 +1,9 @@@
@@ -286,7 +289,6 @@ EOF
 
 cat >diff_submodule_expect <<\EOF
 diff --cc .gitmodules
-index badaa4c,44f999a..0000000
 --- a/.gitmodules
 +++ b/.gitmodules
 @@@ -1,3 -1,3 +1,9 @@@
@@ -306,7 +308,8 @@ test_expect_success 'diff with merge conflict in .gitmodules' '
 		cd super &&
 		git diff >../diff_actual 2>&1
 	) &&
-	test_cmp diff_expect diff_actual
+	sanitize_diff diff_actual >diff_sanitized &&
+	test_cmp diff_expect diff_sanitized
 '
 
 test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
@@ -314,7 +317,8 @@ test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
 		cd super &&
 		git diff --submodule >../diff_submodule_actual 2>&1
 	) &&
-	test_cmp diff_submodule_expect diff_submodule_actual
+	sanitize_diff diff_submodule_actual >diff_sanitized &&
+	test_cmp diff_submodule_expect diff_sanitized
 '
 
 # We'll setup different cases for further testing:
