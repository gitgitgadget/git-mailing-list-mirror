Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C6A1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeCYTVY (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751980AbeCYTVS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ED1E16099A;
        Sun, 25 Mar 2018 19:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005674;
        bh=pKqeSHPfPqVYzPgFmf0UcP421s6AAm/3Q6IYVUQIAyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ue8k+uYMGNtN0EB5OTODOY8XE4giVg3q+04Xu+JWslKY5TRUSqm+ec+s0RqZAOdPE
         /Eky/3ZdJbGctDl+k/w3+/za4rIOu/lrPhfDWObV0sQfNxQ4Qvw9nc79oSmdNkbBEZ
         /vOy2TZ61oQR350bkiT7DQ/PCzG4F/GCd0Z+PWJKKkBeCZkAbVAC63bn7g6lv0H8z3
         EuIzy/hlwCKMlfM5A2kSzR8jsniy/7AgdhZCIQYOhokWW8woW7d1j0nFHT6omRUQm/
         lMLS0e7zzRnNR8W86C1IetkfCy8T/jSmQtLe98vM7cjtxYJsU6OzjJC8dbWOMbIosr
         jM+zcp3loAnCQkpPjbPk4jNlkZ+8vTuXa7TRhgIyP4eUfavnu29aX36bCcQBWi6XdI
         leOC0vBqS3aIgOovxsnTw5wdMBNTC36pFV3kxpGRmn2DUz0V0YfIsimGC4pLDNPZb0
         sg8i4j04IIsNvX5MeWrBFReRha9ioWnkREdtU5WOMw9k061InU3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 04/10] t1405: sort reflog entries in a hash-independent way
Date:   Sun, 25 Mar 2018 19:20:49 +0000
Message-Id: <20180325192055.841459-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test enumerates reflog entries in an arbitrary order and then sorts
them.  For SHA-1, this produces results that happen to sort in
alphabetical order, but for other hash algorithms they sort differently.
Ensure we sort the reflog entries in a hash-independent way by sorting
on the ref name instead of the object ID.  Remove an assumption about
the length of a hash by using cut with the delimiter and field options
instead of the character range option.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1405-main-ref-store.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index e8115df5ba..a1e243a05c 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -45,7 +45,7 @@ test_expect_success 'rename_refs(master, new-master)' '
 '
 
 test_expect_success 'for_each_ref(refs/heads/)' '
-	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
+	$RUN for-each-ref refs/heads/ | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	master 0x0
 	new-master 0x0
@@ -71,7 +71,7 @@ test_expect_success 'verify_ref(new-master)' '
 '
 
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | sort | cut -c 42- >actual &&
+	$RUN for-each-reflog | sort -k2 | cut -c 42- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	refs/heads/master 0x0
