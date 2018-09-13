Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960F81F404
	for <e@80x24.org>; Thu, 13 Sep 2018 05:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeIMK0M (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 06:26:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54436 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeIMK0L (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 06:26:11 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B8B8360745;
        Thu, 13 Sep 2018 05:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536815899;
        bh=MaLbypCB0V+jISHrkAv0NRCDwcLqyasejGJeuolSCvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ozQGQOqKq6mnLC9DF9soAl97t2ktYXIscfH3fc/zJ0yDzqj5GR7n/SCivkXNdZFJF
         aIYHzGAHzkGLnAjRjMV466VZdcAmHAVZfujDXkLLznaCWVluEZeOUt20prc5/gmeGp
         P2RoWajmMkm0oTW3t2djTATDNugbncII5sr4c9Ee5gBKYjf51pKyue/7EAF4wQ8Rdy
         xMgdjSqHhNIn0SANNmbsOhXzdNsX8OJQpaylZ7LhgxmX8z52un6oZAHKssDK2PuWRG
         LzBAweL39iX0xmEDYMjc++5Q7w0DVhK3tK0Y3ER/2H/OTggmehCPCwR/wSTPYhburE
         JfRKlhjICs4ipRNA+Ta80sKouRw+5LsVrQcQ5W9e1IIjd7fx4VuqJ2nJLB3StI8FZu
         Jo65vuH8U+9VQbRMx+fSEw4ri5D5NlZMTunnRv2w5izaS5+c3DcUHxOOtFIADuFyv7
         z/YDkb50YtWqYW/I206VyPkCQfcpUTPyqbodlndMDtDsA4RCnql
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 06/12] t0064: make hash size independent
Date:   Thu, 13 Sep 2018 05:17:36 +0000
Message-Id: <20180913051742.252276-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a
In-Reply-To: <20180913051742.252276-1-sandals@crustytoothpaste.net>
References: <20180913051742.252276-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute test values of the appropriate size instead of hard-coding
40-character values.  Rename the echo20 function to echoid, since the
values may be of varying sizes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0064-sha1-array.sh | 49 ++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
index 67484502a0..5dda570b9a 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-sha1-array.sh
@@ -3,30 +3,30 @@
 test_description='basic tests for the SHA1 array implementation'
 . ./test-lib.sh
 
-echo20 () {
+echoid () {
 	prefix="${1:+$1 }"
 	shift
 	while test $# -gt 0
 	do
-		echo "$prefix$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1"
+		echo "$prefix$ZERO_OID" | sed -e "s/00/$1/g"
 		shift
 	done
 }
 
 test_expect_success 'ordered enumeration' '
-	echo20 "" 44 55 88 aa >expect &&
+	echoid "" 44 55 88 aa >expect &&
 	{
-		echo20 append 88 44 aa 55 &&
+		echoid append 88 44 aa 55 &&
 		echo for_each_unique
 	} | test-tool sha1-array >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'ordered enumeration with duplicate suppression' '
-	echo20 "" 44 55 88 aa >expect &&
+	echoid "" 44 55 88 aa >expect &&
 	{
-		echo20 append 88 44 aa 55 &&
-		echo20 append 88 44 aa 55 &&
+		echoid append 88 44 aa 55 &&
+		echoid append 88 44 aa 55 &&
 		echo for_each_unique
 	} | test-tool sha1-array >actual &&
 	test_cmp expect actual
@@ -34,8 +34,8 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
 
 test_expect_success 'lookup' '
 	{
-		echo20 append 88 44 aa 55 &&
-		echo20 lookup 55
+		echoid append 88 44 aa 55 &&
+		echoid lookup 55
 	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -eq 1
@@ -43,8 +43,8 @@ test_expect_success 'lookup' '
 
 test_expect_success 'lookup non-existing entry' '
 	{
-		echo20 append 88 44 aa 55 &&
-		echo20 lookup 33
+		echoid append 88 44 aa 55 &&
+		echoid lookup 33
 	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -lt 0
@@ -52,9 +52,9 @@ test_expect_success 'lookup non-existing entry' '
 
 test_expect_success 'lookup with duplicates' '
 	{
-		echo20 append 88 44 aa 55 &&
-		echo20 append 88 44 aa 55 &&
-		echo20 lookup 55
+		echoid append 88 44 aa 55 &&
+		echoid append 88 44 aa 55 &&
+		echoid lookup 55
 	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -ge 2 &&
@@ -63,19 +63,24 @@ test_expect_success 'lookup with duplicates' '
 
 test_expect_success 'lookup non-existing entry with duplicates' '
 	{
-		echo20 append 88 44 aa 55 &&
-		echo20 append 88 44 aa 55 &&
-		echo20 lookup 66
+		echoid append 88 44 aa 55 &&
+		echoid append 88 44 aa 55 &&
+		echoid lookup 66
 	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -lt 0
 '
 
 test_expect_success 'lookup with almost duplicate values' '
+	# n-1 5s
+	root=$(echoid "" 55) &&
+	root=${root%5} &&
 	{
-		echo "append 5555555555555555555555555555555555555555" &&
-		echo "append 555555555555555555555555555555555555555f" &&
-		echo20 lookup 55
+		id1="${root}5" &&
+		id2="${root}f" &&
+		echo "append $id1" &&
+		echo "append $id2" &&
+		echoid lookup 55
 	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -eq 0
@@ -83,8 +88,8 @@ test_expect_success 'lookup with almost duplicate values' '
 
 test_expect_success 'lookup with single duplicate value' '
 	{
-		echo20 append 55 55 &&
-		echo20 lookup 55
+		echoid append 55 55 &&
+		echoid lookup 55
 	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -ge 0 &&
