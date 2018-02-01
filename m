Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33AD31F404
	for <e@80x24.org>; Thu,  1 Feb 2018 02:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932221AbeBACTL (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 21:19:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58584 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932212AbeBACTH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 21:19:07 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0CB0B61390;
        Thu,  1 Feb 2018 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517451546;
        bh=1EPdlOKXwQjoMwPTByzKUBIQz5vvBTr+46nXHRxF7Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CFgdBiyOjrvxdWyJqumcOx1a9qAYYvh3Y0pgWvEVRGXJl2N8Ep7HnArKLQpp8t3I3
         iSinyjbtzNJfgw1zzEcjY0anGFjylYLMJBqT1vXNoTTFtsR97dlCqg3Hhzzk4CO8Bh
         s4rOMw117K0g22afbh1t4DX/EzM+Ndnt2rbm5YnX0h87DTwT1/zLAksaKfbExjPECb
         qDj0wNel2d+2hV03YToc/B2lf1d+1sPD2uUq8T14uJJvWeYlpGNATrd7cPwrOZs6Hl
         gNPPMF+Bl5khoF23vT7/W0+ZGGs5pvH5aqbhm6NS2WxGhpIYO65oG5IcNujsN6kEHi
         KO85BU8JAsO9ogarA5ivQlZrTVRujDW9TNslgJkOQ1lrS/mg/dGRdlxU2ItUbXLGl4
         Vjhwyu7x4IewfPGQYH2XrrR/P/i7Mbt9+StNGbrRn7OGZr6mdT2jseICl2nKcY1pTX
         tFI339hCTAUO4rkVJGVAxGMBBXjNBYc1RVWWWjYuWgN3uMGJtvs
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/12] fast-import: switch various uses of SHA-1 to the_hash_algo
Date:   Thu,  1 Feb 2018 02:18:42 +0000
Message-Id: <20180201021848.533188-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180201021848.533188-1-sandals@crustytoothpaste.net>
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch various uses of explicit calls to SHA-1 to use the_hash_algo.
Convert various uses of 20 and the GIT_SHA1 constants as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b70ac025e0..f20f30ab62 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1092,15 +1092,15 @@ static int store_object(
 	unsigned char hdr[96];
 	struct object_id oid;
 	unsigned long hdrlen, deltalen;
-	git_SHA_CTX c;
+	git_hash_ctx c;
 	git_zstream s;
 
 	hdrlen = xsnprintf((char *)hdr, sizeof(hdr), "%s %lu",
 			   typename(type), (unsigned long)dat->len) + 1;
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, hdrlen);
-	git_SHA1_Update(&c, dat->buf, dat->len);
-	git_SHA1_Final(oid.hash, &c);
+	the_hash_algo->init_fn(&c);
+	the_hash_algo->update_fn(&c, hdr, hdrlen);
+	the_hash_algo->update_fn(&c, dat->buf, dat->len);
+	the_hash_algo->final_fn(oid.hash, &c);
 	if (oidout)
 		oidcpy(oidout, &oid);
 
@@ -1118,11 +1118,13 @@ static int store_object(
 		return 1;
 	}
 
-	if (last && last->data.buf && last->depth < max_depth && dat->len > 20) {
+	if (last && last->data.buf && last->depth < max_depth
+		&& dat->len > the_hash_algo->rawsz) {
+
 		delta_count_attempts_by_type[type]++;
 		delta = diff_delta(last->data.buf, last->data.len,
 			dat->buf, dat->len,
-			&deltalen, dat->len - 20);
+			&deltalen, dat->len - the_hash_algo->rawsz);
 	} else
 		delta = NULL;
 
@@ -1231,7 +1233,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	struct object_id oid;
 	unsigned long hdrlen;
 	off_t offset;
-	git_SHA_CTX c;
+	git_hash_ctx c;
 	git_zstream s;
 	struct sha1file_checkpoint checkpoint;
 	int status = Z_OK;
@@ -1246,8 +1248,8 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 
 	hdrlen = xsnprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
 
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, out_buf, hdrlen);
+	the_hash_algo->init_fn(&c);
+	the_hash_algo->update_fn(&c, out_buf, hdrlen);
 
 	crc32_begin(pack_file);
 
@@ -1265,7 +1267,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 			if (!n && feof(stdin))
 				die("EOF in data (%" PRIuMAX " bytes remaining)", len);
 
-			git_SHA1_Update(&c, in_buf, n);
+			the_hash_algo->update_fn(&c, in_buf, n);
 			s.next_in = in_buf;
 			s.avail_in = n;
 			len -= n;
@@ -1291,7 +1293,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		}
 	}
 	git_deflate_end(&s);
-	git_SHA1_Final(oid.hash, &c);
+	the_hash_algo->final_fn(oid.hash, &c);
 
 	if (oidout)
 		oidcpy(oidout, &oid);
@@ -1350,11 +1352,11 @@ static void *gfi_unpack_entry(
 {
 	enum object_type type;
 	struct packed_git *p = all_packs[oe->pack_id];
-	if (p == pack_data && p->pack_size < (pack_size + 20)) {
+	if (p == pack_data && p->pack_size < (pack_size + the_hash_algo->rawsz)) {
 		/* The object is stored in the packfile we are writing to
 		 * and we have modified it since the last time we scanned
 		 * back to read a previously written object.  If an old
-		 * window covered [p->pack_size, p->pack_size + 20) its
+		 * window covered [p->pack_size, p->pack_size + rawsz) its
 		 * data is stale and is not valid.  Closing all windows
 		 * and updating the packfile length ensures we can read
 		 * the newly written data.
@@ -1362,13 +1364,13 @@ static void *gfi_unpack_entry(
 		close_pack_windows(p);
 		sha1flush(pack_file);
 
-		/* We have to offer 20 bytes additional on the end of
+		/* We have to offer rawsz bytes additional on the end of
 		 * the packfile as the core unpacker code assumes the
 		 * footer is present at the file end and must promise
-		 * at least 20 bytes within any window it maps.  But
+		 * at least rawsz bytes within any window it maps.  But
 		 * we don't actually create the footer here.
 		 */
-		p->pack_size = pack_size + 20;
+		p->pack_size = pack_size + the_hash_algo->rawsz;
 	}
 	return unpack_entry(p, oe->idx.offset, &type, sizep);
 }
@@ -2204,7 +2206,7 @@ static void construct_path_with_fanout(const char *hex_sha1,
 		unsigned char fanout, char *path)
 {
 	unsigned int i = 0, j = 0;
-	if (fanout >= 20)
+	if (fanout >= the_hash_algo->rawsz)
 		die("Too large fanout (%u)", fanout);
 	while (fanout) {
 		path[i++] = hex_sha1[j++];
@@ -2212,8 +2214,8 @@ static void construct_path_with_fanout(const char *hex_sha1,
 		path[i++] = '/';
 		fanout--;
 	}
-	memcpy(path + i, hex_sha1 + j, GIT_SHA1_HEXSZ - j);
-	path[i + GIT_SHA1_HEXSZ - j] = '\0';
+	memcpy(path + i, hex_sha1 + j, the_hash_algo->hexsz - j);
+	path[i + the_hash_algo->hexsz - j] = '\0';
 }
 
 static uintmax_t do_change_note_fanout(
