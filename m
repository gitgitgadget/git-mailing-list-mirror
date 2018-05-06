Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49BE4200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeEFXTd (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41176 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751932AbeEFXSv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 216BC60761;
        Sun,  6 May 2018 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648729;
        bh=FCTPTIFRUvYhmbGC3a1Eb4kphiInS3UuNkTC1km+FN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=iW2J8G6aAS4dSvC9GdNb3vxm0EwWWwlDef7Gh0WJTAHrmITD+yrxdxRqYg2mrBeRt
         8QQZkPcsYEQBlF3cUqowMqH/W3D48l3sbGI1lQbxdoT2Len48fNDNaP59c16ULeElP
         /fMUGv6DOnFePmBvkq8ZgJ+L4sqTUXNswvqzk9MB3uUyuNJlAOVAXEd5yxtIDcGjCU
         +BkE9h/1mBFvPgGt0PQfwDQA+gr8b9jzWay2q4ZaMuAqv3x28Kjqs5FRarLRImv+qy
         yv3ZaDk3CngUAMlqkuEYI94kB+XWb1DaCJuRFbsznNDs1L5JLz5N1GWs/ddjkpFO5H
         JFy8lo4bWzUtAvquMnMlNj0h7o05Ylucx0wzM7fTjQ3YHkBljijtDDcEBz0/ItpyGk
         lRVEwbNiZQP9XxYO++a0sezP7pxCLPT0Fg+l1z/LEP7bupDuiX+GcLjy6NMs7M+Rgu
         f8Ps8m/Ev4O4/rEK+IHZY6fc7QIVMWopcaRAw5TFpVL4lZf/mhG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 18/28] t4020: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:42 +0000
Message-Id: <20180506231752.975110-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
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
