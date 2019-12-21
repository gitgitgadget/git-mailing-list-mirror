Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28613C2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC1E206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="h0tZjYmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLUTuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:17 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42000 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727384AbfLUTuM (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:12 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3A8A7607F0;
        Sat, 21 Dec 2019 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957811;
        bh=9yGHYf1/L7NFmFhBKJ623Nl1M3G4N44K42o4WNeBSJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=h0tZjYmMgzVFXD0lZJ2ZfVPrYPCON913vofb29Q3Q8RUX2QM86QyQX/Bn+iv4d5Ol
         d2vjb0J4tmHdp+NKS1ys+oGEx/XNGR7Eygu6d6bpY0S9WPc8EHSxdcqGmqsbuwuC+v
         /W90zsOH5SP0p2iPKWRuMTvZOPK+5JvItGV13bC2xGBGXvCOr+vo0XX9NMYtAfEaJn
         4SoUcmwRxBaoYrMr60WvmRr06s7osjPiNp/ZyOUaMFhBVH4gIB/SssenL0SIBG1EJP
         EsvW5A0h+lKCk4LzboPQmn+reDKjn2xCBOKbRrTiP49gN8eQOopPDJXYcaMnL5lvAZ
         Xk3lIkMet9gJWnvs20YYqcNrwXMJ5XzIbcGkwrFRHpXNa11pUMNS8yh7v4bfjppvka
         QJRgT3Gr4NRi1Arl10GC12pQR6B12D88GebLWtUCzbvgNUgZVAeZoq4U2i5KYb1JIp
         1peH+ZHANL2rTI4XABYx5k+VRwePLqMiBL+NeOBQJSj0dmAenff
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/20] t5504: make hash algorithm independent
Date:   Sat, 21 Dec 2019 19:49:28 +0000
Message-Id: <20191221194936.1346664-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding invalid object IDs in this test, use test_oid to
look up ones of the appropriate length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5504-fetch-receive-strict.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index fdfe179b11..645b4c78d3 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -4,6 +4,7 @@ test_description='fetch/receive strict mode'
 . ./test-lib.sh
 
 test_expect_success 'setup and inject "corrupt or missing" object' '
+	test_oid_init &&
 	echo hello >greetings &&
 	git add greetings &&
 	git commit -m greetings &&
@@ -144,11 +145,11 @@ test_expect_success 'fsck with no skipList input' '
 
 test_expect_success 'setup sorted and unsorted skipLists' '
 	cat >SKIP.unsorted <<-EOF &&
-	0000000000000000000000000000000000000004
-	0000000000000000000000000000000000000002
+	$(test_oid 004)
+	$(test_oid 002)
 	$commit
-	0000000000000000000000000000000000000001
-	0000000000000000000000000000000000000003
+	$(test_oid 001)
+	$(test_oid 003)
 	EOF
 	sort SKIP.unsorted >SKIP.sorted
 '
@@ -172,14 +173,14 @@ test_expect_success 'fsck with invalid or bogus skipList input' '
 test_expect_success 'fsck with other accepted skipList input (comments & empty lines)' '
 	cat >SKIP.with-comment <<-EOF &&
 	# Some bad commit
-	0000000000000000000000000000000000000001
+	$(test_oid 001)
 	EOF
 	test_must_fail git -c fsck.skipList=SKIP.with-comment fsck 2>err-with-comment &&
 	test_i18ngrep "missingEmail" err-with-comment &&
 	cat >SKIP.with-empty-line <<-EOF &&
-	0000000000000000000000000000000000000001
+	$(test_oid 001)
 
-	0000000000000000000000000000000000000002
+	$(test_oid 002)
 	EOF
 	test_must_fail git -c fsck.skipList=SKIP.with-empty-line fsck 2>err-with-empty-line &&
 	test_i18ngrep "missingEmail" err-with-empty-line
@@ -204,7 +205,7 @@ test_expect_success 'fsck with exhaustive accepted skipList input (various types
 	echo " # Comment after whitespace" >>SKIP.exhaustive &&
 	echo "$commit # Our bad commit (with leading whitespace and trailing comment)" >>SKIP.exhaustive &&
 	echo "# Some bad commit (leading whitespace)" >>SKIP.exhaustive &&
-	echo "  0000000000000000000000000000000000000001" >>SKIP.exhaustive &&
+	echo "  $(test_oid 001)" >>SKIP.exhaustive &&
 	git -c fsck.skipList=SKIP.exhaustive fsck 2>err &&
 	test_must_be_empty err
 '
