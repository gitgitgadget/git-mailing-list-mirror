Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FA321847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753641AbeEBA1u (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37796 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753414AbeEBA0x (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D619F60129;
        Wed,  2 May 2018 00:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220812;
        bh=DZhruOF5rbSf2cqXyaMYj/k+UKraeUEAFhQTrRrek6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DUBGl3D1nD7tsmnM4+gyGBIdr7QGL9vn3d8OWfBvtubxPDCafiIHEsxfnDwFkQGb8
         VaVhdYWT8mat5PRI2tP+qXs6wHt22/1Cg+S+1lb5wEWRa9VaY6yobD/Z23UwhXTtB9
         sP2gtcXXeP2lGJi7Zto7EpFRdoI4VbODHKIoceWzhq3kgXFRPMvfLl4eXvQbSFQ72e
         uvyYzratjeU6uAM593Oz+VAnwRYZpMdGf75S1BNrZqFs/4cumjGLjdO7BZ+6wyKSM3
         5Sc2jQDhBmk6+Uqo3gh+WkdNnbIewltuNoQ4zxeMjVmyTCR8qQ0Zgv4yKBmtejSWbj
         5mG9phVjtzNU7KZMsHWrRNNaigqbFDMvpCu5FpvJEal+kgUv6nsogF2ZGRIDjKEJgH
         /gsAOuHF4WSdxLUI8ZTHj0FU6/OMrA88nwtk8Ak8RknmZwxV5quF8y/FMtkTfep3t2
         OoYlj2dBlpErASsQZKzVT6jLNeKBGyDdZPxA86LFvaibUWQovKn
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 29/42] merge: convert empty tree constant to the_hash_algo
Date:   Wed,  2 May 2018 00:25:57 +0000
Message-Id: <20180502002610.915892-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid dependency on a particular hash algorithm, convert a use of
EMPTY_TREE_SHA1_HEX to use the_hash_algo->empty_tree instead.  Since
both branches now use oid_to_hex, condense the if statement into a
ternary.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 merge.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/merge.c b/merge.c
index f06a4773d4..5186cb6156 100644
--- a/merge.c
+++ b/merge.c
@@ -11,10 +11,7 @@
 
 static const char *merge_argument(struct commit *commit)
 {
-	if (commit)
-		return oid_to_hex(&commit->object.oid);
-	else
-		return EMPTY_TREE_SHA1_HEX;
+	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
 }
 
 int index_has_changes(struct strbuf *sb)
