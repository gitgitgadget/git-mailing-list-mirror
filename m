Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5DC1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeH2EvW (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:51:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37226 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727166AbeH2EvV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:51:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EDD0960756;
        Wed, 29 Aug 2018 00:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504225;
        bh=+AvPjesH55ladKz/wolGwjozOgjvL4HB6udDh5ZPT/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xl+poQ4xYjVYxCMVYxBPX7xOz+kO9xyFpZCoWWChRqe61ZqLvv+XReEbjTnqPcY2t
         Pr+or+hn2ySo2oqYeHOGvFN0C0w3v9PDcfJkIk5ZHllgAM61UgtaVgU7j/59BNGHRw
         NhQ5gepxozOytRvNCEyJpmXtNqMhS01ySHcrfhsab3Rgdsja3eTRmH4Yvr3UqFDxPh
         gHHZkr6FLncxCx8tsPgmgqdavXxvjNPn1LwDVqa9/RpBGGAyLjmRbFWEaS0/DcFGZn
         WpFhtUSKQpzVGzrNVivLtWyCdeVFPyOap59a4Wr5QIhPYH7MpCBAGX1a7z9yVS/P53
         asMaOVOFFx3s5Za65UPvQCDxwEbauAP15sEpOBG5/X+p6+CVXYaBZVgCB/mLplsNET
         z0l8jQRw4C87i42UW1AKrAyWn/bb3MfQtHM3VvUEfVSOdnGxyvYVARskfWgJ2p6D2m
         DvOuqYp5KhTB3k7ic9BAkW3qKom2pSTXX6Q936tEsOn1WbZS6bi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 04/11] t0002: abstract away SHA-1 specific constants
Date:   Wed, 29 Aug 2018 00:56:35 +0000
Message-Id: <20180829005642.980617-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005642.980617-1-sandals@crustytoothpaste.net>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
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
