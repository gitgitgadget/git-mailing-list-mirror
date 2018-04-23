Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93C11F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932676AbeDWXl7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932725AbeDWXkZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4F5E460B3C;
        Mon, 23 Apr 2018 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526824;
        bh=Lucp4rbIIoMgFAleG2ELhxQjAaZtThYcLAD+etwMhzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=h7uNvjbMNG/zuVKQGF5E7kF1VQfBsyo6K6yrZVUJM5bfRgNg2j2wbnc6WFoXDYhpM
         f2TLEAdwC/mBd9lrBg6VM12o+taU5c6xamjOkkqi9aWRqKk4ypcR7XYGXQGqlyz6WZ
         Lpee8V5IwaMPZ9fEoe+h3TdHnuzYdVCLzqQ8E6JhJkks18HQ5IrKwp8MSAWjAmYM9D
         Kx3venY+/l2/R0MNr5ee9VNpB6QFHp/U3/nTUwh/llyKwZUrmraldOIVJNyhxNGRKx
         o8W6Ht0Kda16it9yz7c6/sufuFs1Sk+ggV++ofonK+Q6JU+FoI/pKxDLtdo/8q83Hf
         Zvkq9aP8l3Eq8yjV+pT2c8KVznNxvVXs9togv2CvHvY2ZIrFj12gluJsdnUa1/Ofxu
         Cijjeroqzvawue/STTGyZvU2dFBANx0tDhPq4SnhhkrW/dSQBqcx5koI3OVtemmmMd
         vYYrwvIWZVO6wIl1Rxx8ye+C0v968WSS1YK+N4ZLN1DP+N4bifg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 18/41] index-pack: abstract away hash function constant
Date:   Mon, 23 Apr 2018 23:39:28 +0000
Message-Id: <20180423233951.276447-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code for reading certain pack v2 offsets had a hard-coded 5
representing the number of uint32_t words that we needed to skip over.
Specify this value in terms of a value from the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d81473e722..c1f94a7da6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1543,12 +1543,13 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 {
 	const uint32_t *idx1, *idx2;
 	uint32_t i;
+	const uint32_t hashwords = the_hash_algo->rawsz / sizeof(uint32_t);
 
 	/* The address of the 4-byte offset table */
 	idx1 = (((const uint32_t *)p->index_data)
 		+ 2 /* 8-byte header */
 		+ 256 /* fan out */
-		+ 5 * p->num_objects /* 20-byte SHA-1 table */
+		+ hashwords * p->num_objects /* object ID table */
 		+ p->num_objects /* CRC32 table */
 		);
 
