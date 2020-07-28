Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8520EC43463
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FD820829
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gMC1E9Su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgG1Xfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40962 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730303AbgG1Xf3 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:29 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 34B3760CF8;
        Tue, 28 Jul 2020 23:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979298;
        bh=GOwWURZWcS80hrBtH5tnhZJpLhQbfrdP5Wk4iblxXNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gMC1E9SukentgxQn+lsCa9Ogs1Fym3V7Tasnif+0D5/cwGb/1RePAbjWzk4lCTxSi
         Fb2mm9YgH+m3l3Q7ZmC+9MrQhZXeNouRX/5dgghNnfkmXUq7ZpLgHJjuGY6kaq2k57
         Ci7c5ZJZb7ctPE9FULi2nZdcS51RtrL8010ZiqAqEKAO+fKTlg30JJ8Sninhh0NTWF
         Ax7hbzn9ZurNbUEkqJAxIN/M0R1yvAChpdu9GCzovADluuo/w026dQN+iUJtSYPNi2
         Tta8Jzakw4NlsfwT44om0ytq3pdLxNGvZnOXnwfmMr/C8K+pPKNGRIAyDHaOnacyh9
         tb//wwmy2Ug8hy4lP4PA2bGfzpr2T80jX76Ujc1dHEDaa2mU3f4AYGxNIf5qHWTZZq
         2i8ep92nXO1CbAp1ciYlPVOReiIrCDY+412YAN8hY+kgJLmePVFeEtDkngJXjuZpcu
         HTOyDq+u+xsuhKboR6QKw8P4YXH411AxcKUtH8nzYC//5AjKpbD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 07/39] t6301: make hash size independent
Date:   Tue, 28 Jul 2020 23:34:14 +0000
Message-Id: <20200728233446.3066485-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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
