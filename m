Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3210B1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeEMCZw (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45328 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751879AbeEMCZu (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BAA2560742;
        Sun, 13 May 2018 02:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178349;
        bh=FCTPTIFRUvYhmbGC3a1Eb4kphiInS3UuNkTC1km+FN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kLV0faioYV39hbr1BaRczI8aIICKUjS6CB61TIA/bTDQNP42KG9QhqOIx47yL01Ye
         N8thqDE8IUwFWSjflPrQzAZEah+O5d7ZIkAKgmagJQF5G+3TZUlzoYjaWJxqmsTOP1
         w/4Uq1Dhh6J78ITtWYNiNvoEx63UoZ2+17BgSnRdtZu+74hrktdU8I+SYUpS+cNl2z
         lDQqIzr4UscO3yE8TV5HXFcwmGvkSi/oj3/Jyn7Wd6k4RRv1D1EkOdxCYN3HC4rR+Y
         IoT5t4tfBQBmXllrsCXuGB19H0M0AX1Ynqwefo+baoPRHNaeNsbsQdJYm1azjH8eGY
         jJBYR6Q46S1raxeRv4DF6rfGfMZswkbHKJyfSsMpjSqW9aihoYe2CukxrYafQZGc3A
         URGelG+J+QTBD3Zc2Xa+8sSApV60mfjriQ0NJEtXFtj6oFpJt0AJnWjrsWywoNBuZK
         xH7BM0BcLwB5zYsGxYkv3Tb3o1+QOjgBbWyAhVZCHWMm2n69sjF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 18/28] t4020: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:28 +0000
Message-Id: <20180513022438.60003-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4020-diff-external.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 49d3f54b29..fd2140700e 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -13,6 +13,7 @@ test_expect_success setup '
 
 	test_tick &&
 	echo second >file &&
+	before=$(git rev-parse --short $(git hash-object file)) &&
 	git add file &&
 	git commit -m second &&
 
@@ -180,9 +181,12 @@ test_expect_success 'no diff with -diff' '
 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
 
 test_expect_success 'force diff with "diff"' '
+	after=$(git rev-parse --short $(git hash-object file)) &&
 	echo >.gitattributes "file diff" &&
 	git diff >actual &&
-	test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
+	sed -e "s/^index .*/index $before..$after 100644/" \
+		"$TEST_DIRECTORY"/t4020/diff.NUL >expected-diff &&
+	test_cmp expected-diff actual
 '
 
 test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
@@ -237,7 +241,7 @@ test_expect_success 'diff --cached' '
 	git update-index --assume-unchanged file &&
 	echo second >file &&
 	git diff --cached >actual &&
-	test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
+	test_cmp expected-diff actual
 '
 
 test_expect_success 'clean up crlf leftovers' '
