Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5806D1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfHRUGC (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:06:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58064 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727268AbfHRUF5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3A4C860781;
        Sun, 18 Aug 2019 20:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158755;
        bh=WzigPSVVN4u10GU1kmnt9CH5axRxxANaRXi5LDeFA+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=decMw4qFvM4iks+QYRIvV6RJkYCgRP2nVhq7nbY7IFMNBBRQJKFsPwgEpnZWZoRzr
         zZ7YIzxFjdEQ0TTZhh7FsJQyrxZNLsufkYEt6e7GdHvVsXyocBXU0UWAftjBW3ywvv
         PFEus1LR4tPA8wp3oybzmZZ02SjIYYn9eTz8DRFCQAOix8ldSysQ4WOd/sNSyKogyU
         f+4qTcojEdG2lgnLoNOewA2TG0LPOxhDu4saIEdRcR6PeYZTnuDvkVZc6+vygn+UGH
         3C1hcdw3HemwzJ1MtH0fJXzlVwOl3OtgxODWgbTkGf6Yz6X9hWksQ90R3FSK7lwPkq
         6+q92VuDhjV+5oVjEhNKf/AhMa5yY8jt4FWouVlF5WkB1UL8dKhMOmAAL2YaYLGKqA
         IAKBlRM+pH/mE8Cj7bnPvP/vwwwWtkW2p/mjzoJutf2UlL1viZpt/71M4cYWRO5y75
         qjyN5U9uELkDAZ1JZkFNdzyOm7H8uyleMGtT++y57D1Bej5KqWu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 26/26] midx: switch to using the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:27 +0000
Message-Id: <20190818200427.870753-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the hash size, use the_hash_algo to look up the
hash size at runtime.  Remove the #define constant which was used to
hold the hash length, since writing the expression with the_hash_algo
provide enough documentary value on its own.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 midx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/midx.c b/midx.c
index d649644420..f29afc0d2d 100644
--- a/midx.c
+++ b/midx.c
@@ -19,8 +19,7 @@
 #define MIDX_BYTE_NUM_PACKS 8
 #define MIDX_HASH_VERSION 1
 #define MIDX_HEADER_SIZE 12
-#define MIDX_HASH_LEN 20
-#define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
+#define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
 
 #define MIDX_MAX_CHUNKS 5
 #define MIDX_CHUNK_ALIGNMENT 4
@@ -93,7 +92,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
 	if (hash_version != MIDX_HASH_VERSION)
 		die(_("hash version %u does not match"), hash_version);
-	m->hash_len = MIDX_HASH_LEN;
+	m->hash_len = the_hash_algo->rawsz;
 
 	m->num_chunks = m->data[MIDX_BYTE_NUM_CHUNKS];
 
@@ -234,7 +233,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result)
 {
 	return bsearch_hash(oid->hash, m->chunk_oid_fanout, m->chunk_oid_lookup,
-			    MIDX_HASH_LEN, result);
+			    the_hash_algo->rawsz, result);
 }
 
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
@@ -928,7 +927,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OBJECTOFFSETS;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_HASH_LEN;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * the_hash_algo->rawsz;
 
 	cur_chunk++;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_CHUNK_OFFSET_WIDTH;
@@ -976,7 +975,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				break;
 
 			case MIDX_CHUNKID_OIDLOOKUP:
-				written += write_midx_oid_lookup(f, MIDX_HASH_LEN, entries, nr_entries);
+				written += write_midx_oid_lookup(f, the_hash_algo->rawsz, entries, nr_entries);
 				break;
 
 			case MIDX_CHUNKID_OBJECTOFFSETS:
