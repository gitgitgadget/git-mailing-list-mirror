Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16FCF1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbeDWXkZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60532 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932680AbeDWXkP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:15 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 001D860B13;
        Mon, 23 Apr 2018 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526814;
        bh=nm/N6HFR8Gd5iS6dBoi2Z8kiST8wlHZFLB2Im1gXLkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=b/qOwIHR+Qq4D9LmLiaFM3k1H/Vpr1jICeyeu1W0g7vdpdwfk27W9ALC+PbGvorQb
         bfsQftWsxkMntIvnIMwSCBXYfowe0804rl1C7wUyiCyd2Fcz4bL3K2TsJElcZbvjhX
         +i4hR9pw1odULkArUPrWo3zTW6cMAZRoH6Nng5VEQzK+PDIlIeZLTCcMkdh1XHuvHh
         8wdPZNQJcPWFGRQG1aqweH07bchMsFJAPNbhrknoi6pR/e8ZWnGGdXCo21TF40WNw5
         hrfsrCn+4Bft9Ga8s2uBiyX93g4Sq5LVRxZ8XM+1PwlPXW2Kdu4hdKjs2bgjidv1se
         SsBhluNGCH4VRWqffnxplZkNlD/HYoVvzxIIeyQ/2PgjgiMYEOVUeds4yqyNkM3puw
         azS8tc5kVti39QlUf31TWNPfxcUGNC16djuQ1RHydU8b5sWGk1C51RZj0cigPmkdfS
         m1YqZYSjRmIVaEyvyf78N5+qILjhxe1AqHweiVeydymH7MwVQFi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 09/41] pack-objects: abstract away hash algorithm
Date:   Mon, 23 Apr 2018 23:39:19 +0000
Message-Id: <20180423233951.276447-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using hard-coded instances of the constant 20, use
the_hash_algo to look up the correct constant.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 907e112331..f014523613 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -264,6 +264,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	enum object_type type;
 	void *buf;
 	struct git_istream *st = NULL;
+	const unsigned hashsz = the_hash_algo->rawsz;
 
 	if (!usable_delta) {
 		if (entry->type == OBJ_BLOB &&
@@ -320,7 +321,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		dheader[pos] = ofs & 127;
 		while (ofs >>= 7)
 			dheader[--pos] = 128 | (--ofs & 127);
-		if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
+		if (limit && hdrlen + sizeof(dheader) - pos + datalen + hashsz >= limit) {
 			if (st)
 				close_istream(st);
 			free(buf);
@@ -332,19 +333,19 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	} else if (type == OBJ_REF_DELTA) {
 		/*
 		 * Deltas with a base reference contain
-		 * an additional 20 bytes for the base sha1.
+		 * additional bytes for the base object ID.
 		 */
-		if (limit && hdrlen + 20 + datalen + 20 >= limit) {
+		if (limit && hdrlen + hashsz + datalen + hashsz >= limit) {
 			if (st)
 				close_istream(st);
 			free(buf);
 			return 0;
 		}
 		hashwrite(f, header, hdrlen);
-		hashwrite(f, entry->delta->idx.oid.hash, 20);
-		hdrlen += 20;
+		hashwrite(f, entry->delta->idx.oid.hash, hashsz);
+		hdrlen += hashsz;
 	} else {
-		if (limit && hdrlen + datalen + 20 >= limit) {
+		if (limit && hdrlen + datalen + hashsz >= limit) {
 			if (st)
 				close_istream(st);
 			free(buf);
@@ -376,6 +377,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
+	const unsigned hashsz = the_hash_algo->rawsz;
 
 	if (entry->delta)
 		type = (allow_ofs_delta && entry->delta->idx.offset) ?
@@ -411,7 +413,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 		dheader[pos] = ofs & 127;
 		while (ofs >>= 7)
 			dheader[--pos] = 128 | (--ofs & 127);
-		if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
+		if (limit && hdrlen + sizeof(dheader) - pos + datalen + hashsz >= limit) {
 			unuse_pack(&w_curs);
 			return 0;
 		}
@@ -420,16 +422,16 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 		hdrlen += sizeof(dheader) - pos;
 		reused_delta++;
 	} else if (type == OBJ_REF_DELTA) {
-		if (limit && hdrlen + 20 + datalen + 20 >= limit) {
+		if (limit && hdrlen + hashsz + datalen + hashsz >= limit) {
 			unuse_pack(&w_curs);
 			return 0;
 		}
 		hashwrite(f, header, hdrlen);
-		hashwrite(f, entry->delta->idx.oid.hash, 20);
-		hdrlen += 20;
+		hashwrite(f, entry->delta->idx.oid.hash, hashsz);
+		hdrlen += hashsz;
 		reused_delta++;
 	} else {
-		if (limit && hdrlen + datalen + 20 >= limit) {
+		if (limit && hdrlen + datalen + hashsz >= limit) {
 			unuse_pack(&w_curs);
 			return 0;
 		}
@@ -752,7 +754,7 @@ static off_t write_reused_pack(struct hashfile *f)
 		die_errno("unable to seek in reused packfile");
 
 	if (reuse_packfile_offset < 0)
-		reuse_packfile_offset = reuse_packfile->pack_size - 20;
+		reuse_packfile_offset = reuse_packfile->pack_size - the_hash_algo->rawsz;
 
 	total = to_write = reuse_packfile_offset - sizeof(struct pack_header);
 
@@ -1438,7 +1440,7 @@ static void check_object(struct object_entry *entry)
 			if (reuse_delta && !entry->preferred_base)
 				base_ref = use_pack(p, &w_curs,
 						entry->in_pack_offset + used, NULL);
-			entry->in_pack_header_size = used + 20;
+			entry->in_pack_header_size = used + the_hash_algo->rawsz;
 			break;
 		case OBJ_OFS_DELTA:
 			buf = use_pack(p, &w_curs,
@@ -1850,7 +1852,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	/* Now some size filtering heuristics. */
 	trg_size = trg_entry->size;
 	if (!trg_entry->delta) {
-		max_size = trg_size/2 - 20;
+		max_size = trg_size/2 - the_hash_algo->rawsz;
 		ref_depth = 1;
 	} else {
 		max_size = trg_entry->delta_size;
