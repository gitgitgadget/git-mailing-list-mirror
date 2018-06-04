Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50711F517
	for <e@80x24.org>; Mon,  4 Jun 2018 23:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeFDXwu (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 19:52:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33208 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751361AbeFDXws (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 19:52:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E3EF660747;
        Mon,  4 Jun 2018 23:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528156367;
        bh=PcJuYidAeHjX9v5OR8x0/GYHk2EhNh7OlicpjGiAJE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vwg0WClTvUgdZs37A4V85N7+36uZuCBNEuqGT1A7QhfUhkA+SDRjyEnC3bU+NvTg/
         wfjlLQF4avbxfwoPIf85g21qixui55kngWlkF4YazUT/bk6yt8N5xwXS1Ihef9Ao6x
         H2rd4OqC2A2JdoGR1GCZ8buFgRm573wZHCg54F+GiOqeS1UA3UxNDlTMP1DE0kvHf3
         MI3t+ottR5YatBC2C7MuaOtgaTz8ei4ZzmHgCeHYD8luem5IT0KkC5ouLlYw57qFlT
         ge0MOMiO/xs2dn6ZvAu6cWOnpSoDiNewSLh9gsund2nLgL0F1u86A5g0KSCnzTAaJC
         06onbsRQLYMy2Ho/tFiilzKs3zwnr340UgSeyd01KKZmXZRaIUsDkneMDA2lsycGdz
         cjQbaeaMAJPXD14+q3zQWe+5afLhe1AWoTc0TZ8kmWRwEZAVkyE9KhFbZmFONzdr05
         yR9g0TBwpMjAvSaF2IFUQ2QrMxjiWa7N/f4fecraYB517Bq7IQF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 05/10] t0064: make hash size independent
Date:   Mon,  4 Jun 2018 23:52:24 +0000
Message-Id: <20180604235229.279814-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.1.1185.g55be947832
In-Reply-To: <20180604235229.279814-1-sandals@crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
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
index 67484502a0..ab230179d2 100755
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
+	root=$(test_translate 555555555555555555555555555555555555555 \
+		555555555555555555555555555555555555555555555555555555555555555) &&
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
