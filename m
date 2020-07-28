Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A220C4346B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9CC2075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qTRF1boS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgG1Xfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40976 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730419AbgG1Xfh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:37 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8C74860CF4;
        Tue, 28 Jul 2020 23:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979303;
        bh=ESSekoAdRTmOfsf7qIhpt9ZyM67fkWjpVvr9uTkNfYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qTRF1boSmyXmiLnvsqUEvqdc7BXZsRxBb6i9uZ2vz5QE3IYp2/y45WAY8CKmlAb8T
         KR6Mvjh8UQPlNLq0BxwvjeHU4lomtAprzVW6cKn/rumOHyjlZFFIY5s/dDfjp8PJDo
         tWErp1TCiix7T8kg+/Im5mOSGL9B/yYOOgBlQ0vi4KCOIEtxwTdDwRTSz2oxbcQ3Jt
         dt0SCSgM3xq7+2XnY98iTg3eyOaj4BPZwdRxsZE0E1DfyZoNizo4AZbda7CmoyXk7e
         d08lq05o6IZ6MAiCmgX6eiOQhuzf48g8FOLjYCpk7PJASXTB7AiRA/fikzJJpWX8FI
         pljsaxAFEl6jXdV3kHfaUfUIhzkj32Hu6IsrweW684vqp+Jf3iAEAnLsKPvZdJsmpC
         laiIBRjD5C5ls0MF0zYb2BHDbJlPwB8AE2pJNpdUqo+aZvoWKzz4LHVIA336G80uoh
         Fd8BJgWS6nhf25XgaGf5wYRYKW66GnHqtLKlohdZ2svZhAWkWmG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 19/39] t8003: make hash size independent
Date:   Tue, 28 Jul 2020 23:34:26 +0000
Message-Id: <20200728233446.3066485-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One assertion in this test invokes git with core.abbrev set to "40".
Since we're expecting the full hash length, use test_oid to look up the
full hash length for the hash in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t8003-blame-corner-cases.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 9130b887d2..ebe79aa4ea 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -6,6 +6,7 @@ test_description='git blame corner cases'
 pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
 
 test_expect_success setup '
+	test_oid_init &&
 
 	echo A A A A A >one &&
 	echo B B B B B >two &&
@@ -306,7 +307,7 @@ test_expect_success 'blame coalesce' '
 	$oid 1) ABC
 	$oid 2) DEF
 	EOF
-	git -c core.abbrev=40 blame -s giraffe >actual &&
+	git -c core.abbrev=$(test_oid hexsz) blame -s giraffe >actual &&
 	test_cmp expect actual
 '
 
