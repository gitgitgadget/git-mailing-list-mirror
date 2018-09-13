Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17DE31F404
	for <e@80x24.org>; Thu, 13 Sep 2018 05:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeIMKZ7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 06:25:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54386 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeIMKZ7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 06:25:59 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8CF7B60745;
        Thu, 13 Sep 2018 05:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536815886;
        bh=x3KYa/ksG5OV9MpWWBr1lE1vw1WCpcfylSBqtjueFb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZEpVUJe8WhXNXfEWPAdW6rIBbZwy1p/nz5E3ecli3SYKbPtvy3cyrPX5sEDP5/R5q
         XXK7y1cp2DftMR5SikguqbneoLwB/8+nJnint0wdH8Hr/C1UTqOhcg5Cv6LpVU+7dq
         rGPu3/ckmGnepSGYyRuxZf/uqWUijNDdH39E90h2Cf16SUW4r6kPqIZlydC+ChR+mK
         Wk3tFnlKHr9Eozeh9vJQGCDE8bgXqLBL4ymMmXh3a8rqe1gywdv8H4pU6Gn/DuAVLL
         7CxY82xtPTiIHb46UBkAIr8uA5ftgKLj9VygEveAXQtvcV2KPMkKg5AyY6pbape+kI
         8ADL9ZIabJNJcZ+25gnr5BiCKlIf+GtwOXyBpqlQCqSVRBAgd0KDBMMOmFHU8ursPu
         GpzuiXecJuvGt6A9YTPlni5bHafRuB6DYK2Z+4VDjnTDGU9SuDS62qrWcxKcmbPfnM
         T5rWR9FpujJ34IxEieDun4bQl4nQKDKzE2Y/qfbmlyIgN0RU286
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 02/12] t0000: use hash translation table
Date:   Thu, 13 Sep 2018 05:17:32 +0000
Message-Id: <20180913051742.252276-3-sandals@crustytoothpaste.net>
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
