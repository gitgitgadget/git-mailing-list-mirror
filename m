Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ACBC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C67D207F5
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fwa4mmxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgG2XPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41160 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728175AbgG2XPV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7176F60D01;
        Wed, 29 Jul 2020 23:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064490;
        bh=b9bUS7ASmWEcHkzcZtNiMxLK+OEqpe/X1vkyxOqqPFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fwa4mmxxSNq08UOQwzBCHc2sQxt9P/v/+/2WUhYsLNxHKOn6e0YUzGPvIK5wSCMVm
         EHelrkf42iWUZhxqjjzIsurZGJYajkFvaaXxBSWrnyEcxwv5P5LCgDTs5WvlxmU1+7
         UBKIJi/TLBQ+2HaMH9V18CtQDSxoHvTk1P1sK2116dfAbz5wKcs2vwnpN9S5qowv86
         D7COSk43GR772xycPpUiBzRBDc8MwdSdgsKW9Kx+jSVqQa8mlGqCQY4sEF715yw94w
         gDXoxwhefoaKjeFKjxsqLb8ken57mwFUPq7idd04nkgF5HtJCBx2n78fN9zdfuPsJX
         GIwmpCCeifORTk52uVi43468RkgUDm2UD2cQ0VXEz9rWPubblPlLIRZyrPGCvdUAcb
         Bm+w751tHFlW3IMrxerRnflO0OhAGi0SsOTFX0g9ziu9xthaV6jh5UXzDUng82Mprj
         2mC+E0yUg1DH+2T93dT0sNcZxrAJbRb/9NTkgDmoM0f7EMlOY2I
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 10/39] t7003: compute appropriate length constant
Date:   Wed, 29 Jul 2020 23:13:59 +0000
Message-Id: <20200729231428.3658647-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a specific invalid hard-coded object ID, look one
up from the translation table.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7003-filter-branch.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e23de7d0b5..36477cb1f4 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -463,10 +463,11 @@ test_expect_success 'rewrite submodule with another content' '
 '
 
 test_expect_success 'replace submodule revision' '
+	invalid=$(test_oid numeric) &&
 	git reset --hard original &&
 	git filter-branch -f --tree-filter \
 	    "if git ls-files --error-unmatch -- submod > /dev/null 2>&1
-	     then git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 submod
+	     then git update-index --cacheinfo 160000 $invalid submod
 	     fi" HEAD &&
 	test $orig_head != $(git show-ref --hash --head HEAD)
 '
