Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3336C4346A
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2CA207FC
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jfw/kWj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgG1Xft (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40974 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730413AbgG1Xfh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:37 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 20BCC609CF;
        Tue, 28 Jul 2020 23:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979303;
        bh=Bim6nM22V1FnBq0vFaPtCxlhtoicTjyB7iM0FKvI7bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jfw/kWj8BvNSFPJsOju0zcTNKq4upTWVDiNW8lVMoG7nHfszdXDNtlJPzgje+5qJY
         mzwfNjNOjEo976//R0B91DZxNprCUgY0uX3FzyxRTyyNhWpGkhMZU7PLxU4nK1Y605
         ku7yI+hqqQ0LmMt7nZ/kjEaufN3HIjavbPxKh/30Oxu7bTkD9mLqFVxNUYLWm2sA2q
         aTuGBEY8VwzGsXXJ2yGXL1Ecs9odVBoO4NFu+FMHg1ovd5JSOcRsPWobOP19vRYxLi
         KXcfIt3ZQNXTGd3zYblcYiEavLLGlG37m/FUAUyubmFmMtR9diPBBYJ5ERPeMrm/Sx
         W7Iwr42dZFH/IWh3hwyUnwjCxcm/GRA5SiuCEBdmEvMlEZvamJWmNzlMAj14JMMAab
         gMYQeDKqNwCBJcQ4lAMVIfMr3CTPlMyCoANj8mjLVt/DpTM/IprUGdqETvRek/M6My
         ujU5k937gNd2CbLXf+5sDYcS8t6FjN04BxOp0uj+KweMSno0v9w
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 18/39] t8002: make hash size independent
Date:   Tue, 28 Jul 2020 23:34:25 +0000
Message-Id: <20200728233446.3066485-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute the length of an object ID instead of hard-coding 40-based
values.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t8002-blame.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index eea048e52c..c3b70b025e 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -6,6 +6,10 @@ test_description='git blame'
 PROG='git blame -c'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
+test_expect_success 'setup' '
+	hexsz=$(test_oid hexsz)
+'
+
 test_expect_success 'blame untracked file in empty repo' '
 	>untracked &&
 	test_must_fail git blame untracked
@@ -105,17 +109,17 @@ test_expect_success 'blame --abbrev=<n> works' '
 '
 
 test_expect_success 'blame -l aligns regular and boundary commits' '
-	check_abbrev 40 -l HEAD &&
-	check_abbrev 39 -l ^HEAD
+	check_abbrev $hexsz         -l HEAD &&
+	check_abbrev $((hexsz - 1)) -l ^HEAD
 '
 
-test_expect_success 'blame --abbrev=40 behaves like -l' '
-	check_abbrev 40 --abbrev=40 HEAD &&
-	check_abbrev 39 --abbrev=40 ^HEAD
+test_expect_success 'blame --abbrev with full length behaves like -l' '
+	check_abbrev $hexsz         --abbrev=$hexsz HEAD &&
+	check_abbrev $((hexsz - 1)) --abbrev=$hexsz ^HEAD
 '
 
-test_expect_success '--no-abbrev works like --abbrev=40' '
-	check_abbrev 40 --no-abbrev
+test_expect_success '--no-abbrev works like --abbrev with full length' '
+	check_abbrev $hexsz --no-abbrev
 '
 
 test_expect_success '--exclude-promisor-objects does not BUG-crash' '
