Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2633C352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DFD20838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="R/vESHk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgBGAxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:44 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55608 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbgBGAxm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:42 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 20D1B60FC6;
        Fri,  7 Feb 2020 00:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036821;
        bh=zEcYRufKTMG0X7QOklAWPu7ixUXsYrAW9gPxl//bI1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=R/vESHk8qXiSqJc4+PkUXN3zmUGOdcESky6RFaGm6niU0H10wQEU+BM5YHgHKJi3r
         FiFxCZHdHq+P3+/l8J1D3Jaa2z8EJiaq7kgftnRB/3+ZrlcdXQJn1N8UWfJlvY6oc6
         fWRVvyg753WeRDEnLr3WqOQkvt4XsMIlPJtz9CyxtCIJDRkQ3oinaqmp87kvC8J8u0
         4y2pssUx8N3AH8ZT3kD2rVEMgC/CwAGD3OyAT0dfRrzSUd3/RPAeAaEhYWUfnBLuEA
         oOK33rv4+SK6VY3Rip98XaPxg3ec1ydf4LXRidJ/3wcw5ulqai1tCTkz/8lCn5r2op
         a0b/yMNNkaG7RcoAUX6Jx9jNcMEdxrPaK2QWG62p2H80lhYLnmz/vjrSfehZ1dw9yq
         3gdfX9zZ9CWNIXHZm7uyPhGSQ+jxJJ/BuKadHtCxa3IEvX73GXzMwTXarSo85mQj34
         0y2w8/ZUpUXGM57Bz/2JYTr6HFqqFnXaBRx84J5wYXCuyrP2zh4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 18/21] t5703: make test work with SHA-256
Date:   Fri,  7 Feb 2020 00:52:51 +0000
Message-Id: <20200207005254.1495851-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test used an object ID which was 40 hex characters in length,
causing the test not only not to pass, but to hang, when run with
SHA-256 as the hash.  Change this value to a fixed dummy object ID using
test_oid_init and test_oid.

Furthermore, ensure we extract an object ID of the appropriate length
using cut with fields instead of a fixed length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5703-upload-pack-ref-in-want.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 1424fabd4a..8aeeaac509 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -19,7 +19,7 @@ get_actual_commits () {
 		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
-	grep commit objs | cut -c-40 | sort >actual_commits
+	grep commit objs | cut -d" " -f1 | sort >actual_commits
 }
 
 check_output () {
@@ -37,6 +37,7 @@ check_output () {
 #             \ | /
 #               a
 test_expect_success 'setup repository' '
+	test_oid_init &&
 	test_commit a &&
 	git checkout -b o/foo &&
 	test_commit b &&
@@ -333,7 +334,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master 1234567890123456789012345678901234567890 &&
+	inconsistency master $(test_oid numeric) &&
 	test_must_fail git -C local fetch 2>err &&
 	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
 '
@@ -342,7 +343,7 @@ test_expect_success 'server is initially ahead - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master 1234567890123456789012345678901234567890 &&
+	inconsistency master $(test_oid numeric) &&
 	git -C local fetch &&
 
 	git -C "$REPO" rev-parse --verify master >expected &&
