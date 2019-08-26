Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F201F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfHZBoM (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729064AbfHZBoK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:10 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D6CD160784;
        Mon, 26 Aug 2019 01:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783849;
        bh=99RdzmeZuXBMWE7I62G1cTehTZHTAN8mv28au5hvcEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=EYFBn5g0FISaRSVH63Dq/Ktr05HsrhYVXlUMpTrFOCEWil9UXMDCdZ8EX7J8XyTxN
         73N8+AChPm8ASS6yarMB/KjcEqT2nF311YrNw6pbHP/AloUZZwIyG2Q+2k7FluxXbS
         cXlvMe+OMt6U86c4QEUoKIN3tfJZVsPeQByzHvVJZznbGBlnvwbpibPkkh1pz35lRU
         MLKyUlj3usK/nxLD1wEAHceaSYYABz3e7eE+a3weuAODYfmyNvUkTEj0BcFO7cv3wM
         x5Ivz7yLaLFpUfkmI9xoixQqqMZV+4xNz0F7p30QnjIzINp0QLd1eq6reYmiy0sS6A
         LeTyLjzOj7t+MqxVrcWhc9rAuY7Sr5/G+gVgbq6Vz4rofNZuUDUdA454aklIBUNKus
         k7W+fx4pKUZQ+tY9ONEi/NrbNgS2qBORQz0Dc7yo3BYy/NQfe+uPgm9HUTRHGNtT0j
         jA1zy5YvFrR/uovaTfS4RgpGS1V5YHR9bG0HMquib+O+q7B5U7n
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 08/14] t3506: make hash independent
Date:   Mon, 26 Aug 2019 01:43:38 +0000
Message-Id: <20190826014344.16008-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test uses a hard-coded object ID to ensure that the result of
cherry-pick --ff is correct.  Use test_oid to make this work for both
SHA-1 and SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3506-cherry-pick-ff.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index 127dd0082f..9d5adbc130 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -16,7 +16,11 @@ test_expect_success setup '
 	git add file1 &&
 	test_tick &&
 	git commit -m "second" &&
-	git tag second
+	git tag second &&
+	test_oid_cache <<-EOF
+	cp_ff sha1:1df192cd8bc58a2b275d842cede4d221ad9000d1
+	cp_ff sha256:e70d6b7fc064bddb516b8d512c9057094b96ce6ff08e12080acc4fe7f1d60a1d
+	EOF
 '
 
 test_expect_success 'cherry-pick using --ff fast forwards' '
@@ -102,7 +106,7 @@ test_expect_success 'cherry pick a root commit with --ff' '
 	git add file2 &&
 	git commit --amend -m "file2" &&
 	git cherry-pick --ff first &&
-	test "$(git rev-parse --verify HEAD)" = "1df192cd8bc58a2b275d842cede4d221ad9000d1"
+	test "$(git rev-parse --verify HEAD)" = "$(test_oid cp_ff)"
 '
 
 test_expect_success 'cherry-pick --ff on unborn branch' '
