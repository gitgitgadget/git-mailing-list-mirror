Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81471F404
	for <e@80x24.org>; Mon,  3 Sep 2018 23:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeIDDr7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 23:47:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44006 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbeIDDr6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Sep 2018 23:47:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C656D6075B;
        Mon,  3 Sep 2018 23:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536017134;
        bh=+AvPjesH55ladKz/wolGwjozOgjvL4HB6udDh5ZPT/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=c10B3EOgsyafDlaEakxPEPAj+MmiB46gdT33VCq09rxcyGJhZ/ewCRtEtS3QHheXc
         qLw3kpa0IUWj5VvsmVZhMB/kUOlO9HKNXWZgZwnFQAh3OAtTgVO469i+gw4W+JpAKZ
         LTz75kgRTXXK1guPkqFMDJQeDY3J8SWrH8a492c4T6hopyVRaInDOi3p6aCWnKyJjl
         MGNN5Z0WAUoMM24dXV/TSkH0hL9mMHZh1qRa7GsiDNJT8SjsXaZ0kyFJW0UJyuGbL8
         zd0ZNDe2GvcNt3V1SGUlYqfp57EILPrP79BsFll5TIu+KhLbQUIMaOa+iFqfDB2Moo
         XyKpPAHet99LsR7c89FKuIOT70Jq5gQ71LaDjVZkN+QCRKv9fO6lcmf+5b+WTb0Rt2
         kKYxNFmdWWZmD3f/xf6K5d026oAF9NPhmGJ1H22JwJjtSNCH8NcrplocTifIazXVK+
         ExvgzkorBwkdk6nXNPLEj1C0xWX9s9M6TAyLB5hEY/61e+A/enY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 04/12] t0002: abstract away SHA-1 specific constants
Date:   Mon,  3 Sep 2018 23:25:07 +0000
Message-Id: <20180903232515.336397-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180903232515.336397-1-sandals@crustytoothpaste.net>
References: <20180903232515.336397-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0002-gitfile.sh | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 3691023d51..0aa9908ea1 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -92,11 +92,12 @@ test_expect_success 'enter_repo non-strict mode' '
 		mv .git .realgit &&
 		echo "gitdir: .realgit" >.git
 	) &&
+	head=$(git -C enter_repo rev-parse HEAD) &&
 	git ls-remote enter_repo >actual &&
-	cat >expected <<-\EOF &&
-	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	cat >expected <<-EOF &&
+	$head	HEAD
+	$head	refs/heads/master
+	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
 '
@@ -106,21 +107,23 @@ test_expect_success 'enter_repo linked checkout' '
 		cd enter_repo &&
 		git worktree add  ../foo refs/tags/foo
 	) &&
+	head=$(git -C enter_repo rev-parse HEAD) &&
 	git ls-remote foo >actual &&
-	cat >expected <<-\EOF &&
-	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	cat >expected <<-EOF &&
+	$head	HEAD
+	$head	refs/heads/master
+	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'enter_repo strict mode' '
+	head=$(git -C enter_repo rev-parse HEAD) &&
 	git ls-remote --upload-pack="git upload-pack --strict" foo/.git >actual &&
-	cat >expected <<-\EOF &&
-	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	cat >expected <<-EOF &&
+	$head	HEAD
+	$head	refs/heads/master
+	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
 '
