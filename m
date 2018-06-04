Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1365B1F517
	for <e@80x24.org>; Mon,  4 Jun 2018 23:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeFDXxM (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 19:53:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33184 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751085AbeFDXwp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 19:52:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 458B560742;
        Mon,  4 Jun 2018 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528156364;
        bh=qBZhsaP40Y/4+vAh4A4XQviRmyeAqRqt0DK12b4Qk1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CHSefwmd0Uz/omFV6v+010RZjTJ6i6YOOE/QAOCruPqnntx+/P9s78hB6sjz2EcPF
         tGD/U1OeMqkgZpi4ke0XrZJAWjEGEBIXUl6gxsblzAB/JjrJm15vllGDjPfZHtfoZh
         lkH4g3vus/8RM3U37lpUgLQenItXuyPN+OZm14oOFgCTN1lwR2+Te8uD7zCek9fB8K
         oH74zBGJpdJe4PF3oNueJyuXYVmB2Q9S0tvR52FQMq0uzrR6TuRQajnnhStncTFO9U
         vZsnhJV+h1PXlKC25s/h1QArTYkfMiT+WjEueh531N7+NUzbhp2d7jyELq7v8JZK6t
         Psk1n7lHhrJmC5jth5p3YPsyTcB0snEVM+TcACt+vYiYJDJBA+R6TD0FhtQ3V2tvRt
         Qf9mqfJnVmIM+dJLrTAuuOkRWKt+P62BAjKHjJCNsiaA+0DX7ggYvD/B7l2tC/NJCl
         DgNClVLudhScLwvqwUKSgEsEkf+uaoOeE1VnwzSrkEdrJkNa4li
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 02/10] t0000: use hash translation table
Date:   Mon,  4 Jun 2018 23:52:21 +0000
Message-Id: <20180604235229.279814-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.1.1185.g55be947832
In-Reply-To: <20180604235229.279814-1-sandals@crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
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
index af61d083b4..27ef9ecab2 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -978,12 +978,13 @@ test_expect_success SHA1 'validate object ID for a known tree' '
 
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
+	100644 blob $(test_translate -f oid 001)	dir/file1
+	100644 blob $(test_translate -f oid 002)	dir/file2
+	100644 blob $(test_translate -f oid 003)	dir/file3
+	100644 blob $(test_translate -f oid 004)	dir/file4
+	100644 blob $(test_translate -f oid 005)	dir/file5
 	EOF
 	git update-index --index-info <badobjects
 '
