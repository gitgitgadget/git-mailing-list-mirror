Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B85E1F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfHZBoW (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58344 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729137AbfHZBoV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B2DA06140E;
        Mon, 26 Aug 2019 01:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783860;
        bh=OskeKmdpZ9nLckrJUu3+POVkfA4cNtRkaT2wjBCy2qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=erWyl4wiZkc/0/Rnm0gEfDm2ULcY2/FSbXCyw88EAjIKT7cfqq4QOJIw2MQ1ZgZFu
         VPZ1SNp5E7LoG1m71gy9bQr41dtets1o5XmQ8ZMvTVz8HMNNLjUXLyWmqHr0w/Kwh2
         Ejc7Ky0qKrcijVKxjPLRh4NKCH5Nhz06oKDvsZTNhRNs/UfMY4XNOwC9rG1yUpIWMF
         zjdKlOj152VV2tlcOEOZTE/scLif1Qz+xLVk8tFPnmy7P5FvJldIIMtCIIrFBSJf7c
         357TZYbFttzaV8dkzbGdu/ytkPNbJCxk1WKc7g8fJ3jERr9M/pnia8JDSTXIfeiw/m
         hoMhbjsaaLyeY3vxozG9oudxQp7CnJ7ZHTmAxRPZDZqt+tWoM9faKfVGck6j4mjVwv
         26Dr8XTq7wakRu/7l/iuZHQx6ZMeMCfndHlolTR6S8kwZayD4eRs/5BiuslnEDtovE
         I5kaQIpQLGx9v2DuufpIVdBOdanc/Cyn3+auuV1uo6AzU5ijDW1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 14/14] t4009: make hash size independent
Date:   Mon, 26 Aug 2019 01:43:44 +0000
Message-Id: <20190826014344.16008-15-sandals@crustytoothpaste.net>
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

Instead of hard-coding object IDs, compute them and use those in the
comparison.  Note that the comparison code ignores the actual object
IDs, but does check that they're the right size, so computing them is
the easiest way to ensure that they are.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4009-diff-rename-4.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 3641fd84d6..b63bdf031f 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -14,6 +14,7 @@ test_expect_success \
     'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
+    orig=$(git hash-object COPYING) &&
     tree=$(git write-tree) &&
     echo $tree'
 
@@ -22,6 +23,8 @@ test_expect_success \
     'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
     sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
     rm -f COPYING &&
+    c1=$(git hash-object COPYING.1) &&
+    c2=$(git hash-object COPYING.2) &&
     git update-index --add --remove COPYING COPYING.?'
 
 # tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
@@ -31,11 +34,11 @@ test_expect_success \
 
 git diff-index -z -C $tree >current
 
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234
+cat >expected <<EOF
+:100644 100644 $orig $c1 C1234
 COPYING
 COPYING.1
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 R1234
+:100644 100644 $orig $c2 R1234
 COPYING
 COPYING.2
 EOF
@@ -57,10 +60,10 @@ test_expect_success \
 # about rezrov.
 
 git diff-index -z -C $tree >current
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 M
+cat >expected <<EOF
+:100644 100644 $orig $c2 M
 COPYING
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234
+:100644 100644 $orig $c1 C1234
 COPYING
 COPYING.1
 EOF
@@ -82,8 +85,8 @@ test_expect_success \
      git update-index --add --remove COPYING COPYING.1'
 
 git diff-index -z -C --find-copies-harder $tree >current
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234
+cat >expected <<EOF
+:100644 100644 $orig $c1 C1234
 COPYING
 COPYING.1
 EOF
