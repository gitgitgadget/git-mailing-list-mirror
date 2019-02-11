Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474081F453
	for <e@80x24.org>; Mon, 11 Feb 2019 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBKViW (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 16:38:22 -0500
Received: from ikke.info ([178.21.113.177]:48966 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfBKViW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 16:38:22 -0500
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 3216A4400C5; Mon, 11 Feb 2019 22:38:21 +0100 (CET)
Received: from epsilon.home.ikke.info (epsilon [10.8.0.2])
        by vps892.directvps.nl (Postfix) with ESMTP id 3B70A4400BD;
        Mon, 11 Feb 2019 22:38:20 +0100 (CET)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Kevin Daudt <me@ikke.info>
Subject: [PATCH] t0028: fix wrong octal values for BOM in setup
Date:   Mon, 11 Feb 2019 22:38:18 +0100
Message-Id: <20190211213818.4941-1-me@ikke.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The setup code uses octal values with printf to generate a BOM for
UTF-16/32 BE/LE. It specifically uses '\777' to emit a 0xff byte. This
relies on the fact that most shells truncate the value above 0o377.

Ash however interprets '\777' as '\77' + a literal '7', resulting in an
invalid BOM.

Fix this by using the proper value of 0xff: '\377'.

Signed-off-by: Kevin Daudt <me@ikke.info>
---
I do wonder why this code is using octal values in the first place,
rather than using hex values.

 t/t0028-working-tree-encoding.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 8936ba6757..c6b68c22ca 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -49,12 +49,12 @@ test_expect_success 'setup test files' '
 	# BOM tests
 	printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
 	printf "a\0b\0c\0"                         >nobom.utf16le.raw &&
-	printf "\376\777\0a\0b\0c"                 >bebom.utf16be.raw &&
-	printf "\777\376a\0b\0c\0"                 >lebom.utf16le.raw &&
+	printf "\376\377\0a\0b\0c"                 >bebom.utf16be.raw &&
+	printf "\377\376a\0b\0c\0"                 >lebom.utf16le.raw &&
 	printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw &&
 	printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw &&
-	printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
-	printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&
+	printf "\0\0\376\377\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
+	printf "\377\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&
 
 	# Add only UTF-16 file, we will add the UTF-32 file later
 	cp test.utf16.raw test.utf16 &&
-- 
2.19.1

