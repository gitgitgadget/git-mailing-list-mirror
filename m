Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1131F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeHSVGu (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 17:06:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55060 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbeHSVGu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 17:06:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 109FD6081A;
        Sun, 19 Aug 2018 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534701272;
        bh=MaLbypCB0V+jISHrkAv0NRCDwcLqyasejGJeuolSCvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ghxqXxgMrCEY+48/AqP3DDQF9WPnBy4rTK6dxJ+C0ljgox+nhyzuHr/lf3II7O0gL
         TF8dB5auZy0GMdQV7erE5/cB3JxOXtdzhMiIScXBq9Q6ifIiwFR/5w4JFnnlVzGzcy
         Gb4BZO00sfd0iVERa80X1xLh3VGNHhyJRbW5lLH7xhYj2WuP3XjSezgNlvAuSlIycP
         xOu0SGwEPfvEODZgsST/zDXnoLc4vzpD1qhmjVCgUM3K2+NIEyBG6ipY56bn3ptJEa
         mYHnzJwuecphGTUxU+Qn1HV7KHDQo2E9wDMuU5iFA+J0guyqaJiYxZ5zDWxz63DAHp
         SrE7A6AD6wzO9cckRqG81JilLOVfucXEaMyCiVBm9IRJEF6Y4xm+75zLwYfvk97zaB
         9GMyu145+ykYcYF6X0b8YlCuNKwO7qrZop35HpizmV2a9qF7VXQknddtgc7Ov5Oe17
         Nn1IlE4TPXt3g3Oh4m+KcWTXwGtiXvu4UkwJ3cVRfqqA4KCvZm0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 06/11] t0064: make hash size independent
Date:   Sun, 19 Aug 2018 17:53:46 +0000
Message-Id: <20180819175351.449973-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45
In-Reply-To: <20180819175351.449973-1-sandals@crustytoothpaste.net>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
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
