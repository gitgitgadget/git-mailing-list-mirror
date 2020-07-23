Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53884C433E5
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5F12080D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FaHTfmo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbgGWBJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:09:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40488 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728607AbgGWBJx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:09:53 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 01F2E60CF4
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466593;
        bh=6vdJnTtdikEyvh2eoGCAUKW9eW10Iio5RbuTQEHrp4E=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=FaHTfmo+8t89lYxphlflhpZzuWe/czNeCKHb+uFMRAbl9qWRUUUrZsJdJGrpbMa3O
         90PvbtTvtBruOYHVtBYyC2c00B5+AEIrWVnG7u7EUACCoVhqoMb33F2TiGfTbk9pK6
         y3AC3rlnmPgesBtRaSBVJqczY8PG8JlSlSwiv8b+Hc/gaKRj8vYan9+IodTLh8VSc5
         aCiSlaVkhvqCgh2OsnRnxzJlZh/EoI6A7rdVdusLvBo2uuCstpdA2I0jwJUTxzn2QR
         T3/jIsourps7wHStK3xUuTsBZye3yjtJ902eqc//PFscK5pAb4EOsn7jLqG1P01CC7
         g/g14NFjg0mFP35x/obEjt3RC3C0p36lMMyKxTWnz33Dt82nBQPOw+HSuZmVeDSXGB
         Wt/SisTXVGZpi9KsrYrLYsBzBl/Oz4IO2RemxAmd+OQA4NgCygWNCBjRxdZRtzuwLm
         YepZ3+JFykkNAO9ebLpwaXsiH1/7Rc7zDJ/TPHjhagebnDScJDE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 05/39] t6100: make hash size independent
Date:   Thu, 23 Jul 2020 01:09:09 +0000
Message-Id: <20200723010943.2329634-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a constant 40, split the output of rev-list by
field.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6100-rev-list-in-order.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
index b2bb0a7f61..e934bc239c 100755
--- a/t/t6100-rev-list-in-order.sh
+++ b/t/t6100-rev-list-in-order.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup a commit history with trees, blobs' '
 
 test_expect_success 'rev-list --in-commit-order' '
 	git rev-list --in-commit-order --objects HEAD >actual.raw &&
-	cut -c 1-40 >actual <actual.raw &&
+	cut -d" " -f1 >actual <actual.raw &&
 
 	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
 		HEAD^{commit}
@@ -49,7 +49,7 @@ test_expect_success 'rev-list --in-commit-order' '
 
 test_expect_success 'rev-list lists blobs and trees after commits' '
 	git rev-list --objects HEAD >actual.raw &&
-	cut -c 1-40 >actual <actual.raw &&
+	cut -d" " -f1 >actual <actual.raw &&
 
 	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
 		HEAD^{commit}
