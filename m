Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 836E81F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeCYTVO (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42478 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750782AbeCYTVM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0E2026099A;
        Sun, 25 Mar 2018 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005671;
        bh=PBDuPpeFHdlkWY554obEy+d5dRRaxSAPoeQdgJxJqk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UKbJXir0hic8UebHtg7MfD3i/j5lejSPH8ns6lLntQU0EwhPUSxLjXLsd/1qpKcoE
         NC4Puws8PW928ivef8/loNqYDRw94s+SkDPt8KR54GlW6biu7tdIvJlZ7TNOBsckpm
         d7n3fmF8BBw8LLkFR4/PN1Pkex//vt/nQODhat7pfrA9E7FuRR+XhZUiKx8rvPo6x+
         FRPMCRTmMCb/+LeWHGHUqkCLg+LWs8NQKQfYofAsLPacNr20z4PaTVy78BmTRKDp+D
         jiCPRTH9aJBRj9xkj+O3gofX6rg5Wn/LelQEwt3gKsZLzN5hQRSv2aV4gA1tm2639Q
         8lhTNDazytzcdwrcXb63Ts+zg0XCYTQAO5KQdDwTivYaAzgEgDAGYPOfNUh51KS5L0
         lQPKjb3tlRMtZjgjoL2vZdB4QnxeJ2GS2pOth0vzQyc1iyqG5x/QdIUue1rJC34ZlG
         UYl85GBOdXjfAVAuZCh7aZdKrNokPGib8UhXha6Iw3AvnMdzroj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 01/10] t1011: abstract away SHA-1-specific constants
Date:   Sun, 25 Mar 2018 19:20:46 +0000
Message-Id: <20180325192055.841459-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes the expected hash value dynamically
instead of relying on a hard-coded hash.  Hoist some code earlier in the
test to make this possible.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1011-read-tree-sparse-checkout.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index c167f606ca..0c6f48f302 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -15,8 +15,11 @@ test_description='sparse checkout tests
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
 test_expect_success 'setup' '
+	test_commit init &&
+	echo modified >>init.t &&
+
 	cat >expected <<-EOF &&
-	100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
+	100644 $(git hash-object init.t) 0	init.t
 	100644 $EMPTY_BLOB 0	sub/added
 	100644 $EMPTY_BLOB 0	sub/addedtoo
 	100644 $EMPTY_BLOB 0	subsub/added
@@ -28,8 +31,6 @@ test_expect_success 'setup' '
 	H subsub/added
 	EOF
 
-	test_commit init &&
-	echo modified >>init.t &&
 	mkdir sub subsub &&
 	touch sub/added sub/addedtoo subsub/added &&
 	git add init.t sub/added sub/addedtoo subsub/added &&
