Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 781931F404
	for <e@80x24.org>; Mon,  3 Sep 2018 23:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeIDDrz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 23:47:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43986 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbeIDDrz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Sep 2018 23:47:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 606C360756;
        Mon,  3 Sep 2018 23:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536017132;
        bh=x3KYa/ksG5OV9MpWWBr1lE1vw1WCpcfylSBqtjueFb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vafplDf+i0HOALog7zk7RRxx6b4ioqslnK/NUPn69Em1GZYjznslFNCp+OSPPq/xr
         tKRNH60zJ96pc//f+KTWyZlUu0fxTBZOwWd3rFVWJ5vW1cntqA/uofjxqeaBsGe0/p
         +bLsRcuJ476U4h5b5YCgrL5G/WNL0rR6AfeWD6ExwfLqLbPLM8czHa11cBf2Y7Grxg
         YuO6Ku12KEyPqvAz/HkP54L6Hd5c4tTKBrX/rPhERmVsTFklBzN+KsTYUVvj1rvyOM
         NsJxKRJGw0ARC8ResG+8ReQL4M9R31oaGblTOEX0zEvAVe/OVxHplUj82sPLLJSBtB
         KM7u649ojR/JWYHveq4Y/mxrYn3/z9QiOYEMx4E5Uh73oC+qW0+/ZJfZVsxSMPKYsO
         VkZeuuVi9+ZkRLEbgbpVZnsLc8I8vIm37EhNKwaV9+qoGhcxpCG6IVzTT47CaeAlqB
         xjc722EC8tqnsWaTX9elYK+yqM8J/U+L3J4OCdis5hQEJHBGp3Y
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/12] t0000: use hash translation table
Date:   Mon,  3 Sep 2018 23:25:05 +0000
Message-Id: <20180903232515.336397-3-sandals@crustytoothpaste.net>
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

If the hash we're using is 32 bytes in size, attempting to insert a
20-byte object name won't work.  Since these are synthesized objects
that are almost all zeros, look them up in a translation table.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0000-basic.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b94221b951..a9dc534048 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1015,12 +1015,13 @@ test_expect_success SHA1 'validate object ID for a known tree' '
 
 test_expect_success 'put invalid objects into the index' '
 	rm -f .git/index &&
-	cat >badobjects <<-\EOF &&
-	100644 blob 1000000000000000000000000000000000000000	dir/file1
-	100644 blob 2000000000000000000000000000000000000000	dir/file2
-	100644 blob 3000000000000000000000000000000000000000	dir/file3
-	100644 blob 4000000000000000000000000000000000000000	dir/file4
-	100644 blob 5000000000000000000000000000000000000000	dir/file5
+	suffix=$(echo $ZERO_OID | sed -e "s/^.//") &&
+	cat >badobjects <<-EOF &&
+	100644 blob $(test_oid 001)	dir/file1
+	100644 blob $(test_oid 002)	dir/file2
+	100644 blob $(test_oid 003)	dir/file3
+	100644 blob $(test_oid 004)	dir/file4
+	100644 blob $(test_oid 005)	dir/file5
 	EOF
 	git update-index --index-info <badobjects
 '
