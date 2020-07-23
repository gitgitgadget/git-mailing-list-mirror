Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AA2C43460
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E570F2053B
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TPJ1WPr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbgGWBK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387636AbgGWBKY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:24 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D85C7609CF
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466594;
        bh=GOwWURZWcS80hrBtH5tnhZJpLhQbfrdP5Wk4iblxXNY=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=TPJ1WPr4sLo0BvbAkupRRGTO045W1vYSquyMVGE0n0aEd/2GYmvb5r29GZNpDejo+
         U2/l8gUI2xcqGs7c/KMotQ9fB7G+CCFKPAadX4vNywhbkIG7li2bvMR2AxrkH5MYgY
         oCQYwHoGK8E7GHkQMRZRUbdspBBRNob0iqErQsHdzHpo+00OrYGLikAJtsXr8D94HN
         vvIy1EhDDWQzz/OhP+vtYcGrT5slGTyd1w8HmzsJ6Bezc+kISwz8bJFrYdcp+BDecS
         zzCdfSrg3cZSx5XSRiiqjDARTyB0cirYeyUtev1jC0QmjAcdABWcgi4RrKOj+yO8iK
         qpIUQBGzpnZM3kZjea67iYbyMnUrGDHfFKhx/9tSKjos5qiPrQeBTDjpVEia60dsLR
         wrRlluBBbtgJsCVj/VVnZdkzUG0lnz02MG52TKYOHGC4bkRogAGcoKMpxbd2oEm+Ql
         pbs+kjnEcBcOMMl947wvXpIMcjintD4Cz6x69KrePAXGlVagWhg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 07/39] t6301: make hash size independent
Date:   Thu, 23 Jul 2020 01:09:11 +0000
Message-Id: <20200723010943.2329634-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a fixed length example object ID in the test,
compute one using the translation tables.  Move a variable into the
setup block so that we can ensure the exit status of test_oid_init is
checked.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6301-for-each-ref-errors.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 49cc65bb58..d545a725a5 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -5,9 +5,10 @@ test_description='for-each-ref errors for broken refs'
 . ./test-lib.sh
 
 ZEROS=$ZERO_OID
-MISSING=abababababababababababababababababababab
 
 test_expect_success setup '
+	test_oid_init &&
+	MISSING=$(test_oid deadbeef) &&
 	git commit --allow-empty -m "Initial" &&
 	git tag testtag &&
 	git for-each-ref >full-list &&
