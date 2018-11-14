Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3373C1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeKNOLo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:11:44 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54406 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbeKNOLo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 09:11:44 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D34216045B;
        Wed, 14 Nov 2018 04:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542168618;
        bh=NFvtjdRG1QzWJYu9wdtYoH5bFtAz8zZYwdbpPpxYfls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zhr4S67QNBOdjVNrNLlTSCCpyMH7cI0t9S65Wh4YhsiotriPvetouR6gkcdYhAimy
         scGUlq3DRmELybj8gtxPq8cFVGFx9FyB0psDavfDmBOx4t9NDjxv4SMNxphmnoZg55
         py8IAaAA1ZaDS3NcaqnonqGPhJrl8fGAcN9Dk9XBuAMjYMF+seoTmfRCCeOe5DvOua
         /KKgedqLnTxXw1Vd8mLnIm5uGK1XOPJ27+reqcT6CVq8dEnJyIKz97+DRVEOznhaJs
         SeVDUB//5uZoFTOkp+FR/Dv1g9exiNMZzarbTG2gF/GdXoOKYtcNR68FHFDBBoz1Pe
         /TffIV8GGKmGSteezo1wfVCIRb9F71MzRDLW2a/Gcdd1GJ3vgnOrXeBp5wLww69QH3
         dDMh+RjKzlqanWexCG05sZQUMZnJxaIBA5kT+bOGahezEQgdbJqNWduL7rUw7cVsXZ
         aNp9Gf5/42Yecf+I3BEKnJ8/AcNCD2KeKHg6u06uKmSUPXjIYPb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 05/12] t: add basic tests for our SHA-1 implementation
Date:   Wed, 14 Nov 2018 04:09:31 +0000
Message-Id: <20181114040938.517289-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245
In-Reply-To: <20181114040938.517289-1-sandals@crustytoothpaste.net>
References: <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181114040938.517289-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have in the past had some unfortunate endianness issues with some
SHA-1 implementations we ship, especially on big-endian machines.  Add
an explicit test using the test helper to catch these issues and point
them out prominently.  This test can also be used as a staging ground
for people testing additional algorithms to verify that their
implementations are working as expected.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0015-hash.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 t/t0015-hash.sh

diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
new file mode 100755
index 0000000000..884fe5acd1
--- /dev/null
+++ b/t/t0015-hash.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='test basic hash implementation'
+. ./test-lib.sh
+
+
+test_expect_success 'test basic SHA-1 hash values' '
+	test-tool sha1 </dev/null >actual &&
+	grep da39a3ee5e6b4b0d3255bfef95601890afd80709 actual &&
+	printf "a" | test-tool sha1 >actual &&
+	grep 86f7e437faa5a7fce15d1ddcb9eaeaea377667b8 actual &&
+	printf "abc" | test-tool sha1 >actual &&
+	grep a9993e364706816aba3e25717850c26c9cd0d89d actual &&
+	printf "message digest" | test-tool sha1 >actual &&
+	grep c12252ceda8be8994d5fa0290a47231c1d16aae3 actual &&
+	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha1 >actual &&
+	grep 32d10c7b8cf96570ca04ce37f2a19d84240d3a89 actual &&
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+		test-tool sha1 >actual &&
+	grep 34aa973cd4c4daa4f61eeb2bdbad27316534016f actual &&
+	printf "blob 0\0" | test-tool sha1 >actual &&
+	grep e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 actual &&
+	printf "blob 3\0abc" | test-tool sha1 >actual &&
+	grep f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f actual &&
+	printf "tree 0\0" | test-tool sha1 >actual &&
+	grep 4b825dc642cb6eb9a060e54bf8d69288fbee4904 actual
+'
+
+test_done
