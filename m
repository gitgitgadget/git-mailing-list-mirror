Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E861F97F
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJIFLC (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49306 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbeJIFLC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0FFB260784;
        Mon,  8 Oct 2018 21:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035832;
        bh=lcsHrRbs9M9fE7mF3WbALYaLs6cR//wh6ye8QfwrUM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WRNHhkWXkV25j4WllKlJSXosHcZURJudcuNGTQMGZflRz+IrTQPKDkhSAohxldvRW
         0jOBiyTimKA5e0l/B28a+kMwVzDHwjV99d6RpFgoFuv4ZaYcE1L9FXi5VJ3ig78yv4
         yuPBdaYjqPAJeGwpRCmiGYj2ny0XLwCDKLFWN8pMnfQWR4ltpTVxdMGyfMFRXLhwsA
         PTUmnMB4ptWD/UJSqJ1D0rYLfToP6rJawMHc3bu5Q0/6SNwz2dYVJii4YiWYUxtQFX
         +9dwlNIZO2Auat4eeJbgxf/FBo2cqOIUckaKePNKlsqjM1esiCH/RHW5fszR0HN8An
         hU6+/H6Jhe5fLYA4XWzeBMO37lX0TJJmJBMLYvIVmqY2eFB+ouHl16DrRYJkxOc+AC
         Yad3EFNDc1cpzRmsUyy8RcaiYXv97bouNrw25yPlJhh8NZ5AEJfTY824oIZkjO8SJ4
         lNJbPeb/UvyQ22xWlN/CexgEWXfniDx4N7Uyzv3kzYvdqpygtBk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/14] pack-revindex: express constants in terms of the_hash_algo
Date:   Mon,  8 Oct 2018 21:56:52 +0000
Message-Id: <20181008215701.779099-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Express the various constants used in terms of the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-revindex.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index bb521cf7fb..3756ec71a8 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -122,13 +122,14 @@ static void create_pack_revindex(struct packed_git *p)
 	unsigned num_ent = p->num_objects;
 	unsigned i;
 	const char *index = p->index_data;
+	const unsigned hashsz = the_hash_algo->rawsz;
 
 	ALLOC_ARRAY(p->revindex, num_ent + 1);
 	index += 4 * 256;
 
 	if (p->index_version > 1) {
 		const uint32_t *off_32 =
-			(uint32_t *)(index + 8 + p->num_objects * (20 + 4));
+			(uint32_t *)(index + 8 + p->num_objects * (hashsz + 4));
 		const uint32_t *off_64 = off_32 + p->num_objects;
 		for (i = 0; i < num_ent; i++) {
 			uint32_t off = ntohl(*off_32++);
@@ -142,16 +143,16 @@ static void create_pack_revindex(struct packed_git *p)
 		}
 	} else {
 		for (i = 0; i < num_ent; i++) {
-			uint32_t hl = *((uint32_t *)(index + 24 * i));
+			uint32_t hl = *((uint32_t *)(index + (hashsz + 4) * i));
 			p->revindex[i].offset = ntohl(hl);
 			p->revindex[i].nr = i;
 		}
 	}
 
-	/* This knows the pack format -- the 20-byte trailer
+	/* This knows the pack format -- the hash trailer
 	 * follows immediately after the last object data.
 	 */
-	p->revindex[num_ent].offset = p->pack_size - 20;
+	p->revindex[num_ent].offset = p->pack_size - hashsz;
 	p->revindex[num_ent].nr = -1;
 	sort_revindex(p->revindex, num_ent, p->pack_size);
 }
