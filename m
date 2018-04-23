Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5980E1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeDWXmU (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:42:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932700AbeDWXkO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0EABD6099D;
        Mon, 23 Apr 2018 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526813;
        bh=v661Dj6jG2rZyiQy4CqGx8/qPKaaJeSOHruBnrZ6TOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=baLL0oK7mTFQhjUlN3cq1EctTQZMjCY/5CqogYkwhgvdbQfNnxJR6/0WVBjUtcgg2
         geTXhIM49QQGn5sDgoTChzixgYd2CU+H7ZVY/OdZZrGb/kszAGW8vnFNM+A33ppljt
         II8s+N8g4y1nEj5uq3wrLs9F8VswYltERnLEnx4YrfbJLfwIgZZHYXE4t0ZtPfLoAd
         c5s3cHKODWSCj2jnY5UyszetseG029NsKxwKnOtwbRlcVJj16JFSnD3PZgftLnw1X+
         VS8ZObBR6P0iO40xsyiFSbUA/XefUIJSCAhmDP+cGPodKC230R+imlAHANeB4+ABUI
         cfLTcxwL4igDqpV10lfQtbjT6zs+gvial13q0R/Nl5mKHtUpMd7pJ9whPMxjfcVYlI
         I0XFVeM41uE4hXlwy1ac1JA1WFr/ED8o9VHlKlfVO9vvVCIxZyU1pgNGkLrKk856ql
         XRA13WkhHWSrBoW24d4gDAdxsaNsjXJQjuuoCMpBDGsrlsj2cSY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 08/41] packfile: abstract away hash constant values
Date:   Mon, 23 Apr 2018 23:39:18 +0000
Message-Id: <20180423233951.276447-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several instances of the constant 20 and 20-based values in
the packfile code.  Abstract away dependence on SHA-1 by using the
values from the_hash_algo instead.

Use unsigned values for temporary constants to provide the compiler with
more information about what kinds of values it should expect.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 packfile.c | 66 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/packfile.c b/packfile.c
index 84acd405e0..b7bc4eab17 100644
--- a/packfile.c
+++ b/packfile.c
@@ -84,6 +84,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 	uint32_t version, nr, i, *index;
 	int fd = git_open(path);
 	struct stat st;
+	const unsigned int hashsz = the_hash_algo->rawsz;
 
 	if (fd < 0)
 		return -1;
@@ -92,7 +93,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		return -1;
 	}
 	idx_size = xsize_t(st.st_size);
-	if (idx_size < 4 * 256 + 20 + 20) {
+	if (idx_size < 4 * 256 + hashsz + hashsz) {
 		close(fd);
 		return error("index file %s is too small", path);
 	}
@@ -129,11 +130,11 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		/*
 		 * Total size:
 		 *  - 256 index entries 4 bytes each
-		 *  - 24-byte entries * nr (20-byte sha1 + 4-byte offset)
-		 *  - 20-byte SHA1 of the packfile
-		 *  - 20-byte SHA1 file checksum
+		 *  - 24-byte entries * nr (object ID + 4-byte offset)
+		 *  - hash of the packfile
+		 *  - file checksum
 		 */
-		if (idx_size != 4*256 + nr * 24 + 20 + 20) {
+		if (idx_size != 4*256 + nr * (hashsz + 4) + hashsz + hashsz) {
 			munmap(idx_map, idx_size);
 			return error("wrong index v1 file size in %s", path);
 		}
@@ -142,16 +143,16 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		 * Minimum size:
 		 *  - 8 bytes of header
 		 *  - 256 index entries 4 bytes each
-		 *  - 20-byte sha1 entry * nr
+		 *  - object ID entry * nr
 		 *  - 4-byte crc entry * nr
 		 *  - 4-byte offset entry * nr
-		 *  - 20-byte SHA1 of the packfile
-		 *  - 20-byte SHA1 file checksum
+		 *  - hash of the packfile
+		 *  - file checksum
 		 * And after the 4-byte offset table might be a
 		 * variable sized table containing 8-byte entries
 		 * for offsets larger than 2^31.
 		 */
-		unsigned long min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
+		unsigned long min_size = 8 + 4*256 + nr*(hashsz + 4 + 4) + hashsz + hashsz;
 		unsigned long max_size = min_size;
 		if (nr)
 			max_size += (nr - 1)*8;
@@ -444,10 +445,11 @@ static int open_packed_git_1(struct packed_git *p)
 {
 	struct stat st;
 	struct pack_header hdr;
-	unsigned char sha1[20];
-	unsigned char *idx_sha1;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	unsigned char *idx_hash;
 	long fd_flag;
 	ssize_t read_result;
+	const unsigned hashsz = the_hash_algo->rawsz;
 
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
@@ -507,15 +509,15 @@ static int open_packed_git_1(struct packed_git *p)
 			     " while index indicates %"PRIu32" objects",
 			     p->pack_name, ntohl(hdr.hdr_entries),
 			     p->num_objects);
-	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
+	if (lseek(p->pack_fd, p->pack_size - hashsz, SEEK_SET) == -1)
 		return error("end of packfile %s is unavailable", p->pack_name);
-	read_result = read_in_full(p->pack_fd, sha1, sizeof(sha1));
+	read_result = read_in_full(p->pack_fd, hash, hashsz);
 	if (read_result < 0)
 		return error_errno("error reading from %s", p->pack_name);
-	if (read_result != sizeof(sha1))
+	if (read_result != hashsz)
 		return error("packfile %s signature is unavailable", p->pack_name);
-	idx_sha1 = ((unsigned char *)p->index_data) + p->index_size - 40;
-	if (hashcmp(sha1, idx_sha1))
+	idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
+	if (hashcmp(hash, idx_hash))
 		return error("packfile %s does not match index", p->pack_name);
 	return 0;
 }
@@ -530,7 +532,7 @@ static int open_packed_git(struct packed_git *p)
 
 static int in_window(struct pack_window *win, off_t offset)
 {
-	/* We must promise at least 20 bytes (one hash) after the
+	/* We must promise at least one full hash after the
 	 * offset is available from this window, otherwise the offset
 	 * is not actually in this window and a different window (which
 	 * has that one hash excess) must be used.  This is to support
@@ -538,7 +540,7 @@ static int in_window(struct pack_window *win, off_t offset)
 	 */
 	off_t win_off = win->offset;
 	return win_off <= offset
-		&& (offset + 20) <= (win_off + win->len);
+		&& (offset + the_hash_algo->rawsz) <= (win_off + win->len);
 }
 
 unsigned char *use_pack(struct packed_git *p,
@@ -555,7 +557,7 @@ unsigned char *use_pack(struct packed_git *p,
 	 */
 	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
 		die("packfile %s cannot be accessed", p->pack_name);
-	if (offset > (p->pack_size - 20))
+	if (offset > (p->pack_size - the_hash_algo->rawsz))
 		die("offset beyond end of packfile (truncated pack?)");
 	if (offset < 0)
 		die(_("offset before end of packfile (broken .idx?)"));
@@ -675,7 +677,8 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	p->pack_size = st.st_size;
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
-	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
+	if (path_len < the_hash_algo->hexsz ||
+	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->sha1))
 		hashclr(p->sha1);
 	return p;
 }
@@ -1028,7 +1031,8 @@ const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
 
 	for (p = the_repository->objects->packed_git; p; p = p->next)
 		for (i = 0; i < p->num_bad_objects; i++)
-			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
+			if (!hashcmp(sha1,
+				     p->bad_object_sha1 + the_hash_algo->rawsz * i))
 				return p;
 	return NULL;
 }
@@ -1066,7 +1070,7 @@ static off_t get_delta_base(struct packed_git *p,
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		base_offset = find_pack_entry_one(base_info, p);
-		*curpos += 20;
+		*curpos += the_hash_algo->rawsz;
 	} else
 		die("I am totally screwed");
 	return base_offset;
@@ -1671,6 +1675,7 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
 {
 	const unsigned char *index_fanout = p->index_data;
 	const unsigned char *index_lookup;
+	const unsigned int hashsz = the_hash_algo->rawsz;
 	int index_lookup_width;
 
 	if (!index_fanout)
@@ -1678,10 +1683,10 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
 
 	index_lookup = index_fanout + 4 * 256;
 	if (p->index_version == 1) {
-		index_lookup_width = 24;
+		index_lookup_width = hashsz + 4;
 		index_lookup += 4;
 	} else {
-		index_lookup_width = 20;
+		index_lookup_width = hashsz;
 		index_fanout += 8;
 		index_lookup += 8;
 	}
@@ -1694,6 +1699,7 @@ const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 					    uint32_t n)
 {
 	const unsigned char *index = p->index_data;
+	const unsigned int hashsz = the_hash_algo->rawsz;
 	if (!index) {
 		if (open_pack_index(p))
 			return NULL;
@@ -1703,10 +1709,10 @@ const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 		return NULL;
 	index += 4 * 256;
 	if (p->index_version == 1) {
-		return index + 24 * n + 4;
+		return index + (hashsz + 4) * n + 4;
 	} else {
 		index += 8;
-		return index + 20 * n;
+		return index + hashsz * n;
 	}
 }
 
@@ -1738,12 +1744,13 @@ void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
 off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 {
 	const unsigned char *index = p->index_data;
+	const unsigned int hashsz = the_hash_algo->rawsz;
 	index += 4 * 256;
 	if (p->index_version == 1) {
-		return ntohl(*((uint32_t *)(index + 24 * n)));
+		return ntohl(*((uint32_t *)(index + (hashsz + 4) * n)));
 	} else {
 		uint32_t off;
-		index += 8 + p->num_objects * (20 + 4);
+		index += 8 + p->num_objects * (hashsz + 4);
 		off = ntohl(*((uint32_t *)(index + 4 * n)));
 		if (!(off & 0x80000000))
 			return off;
@@ -1814,7 +1821,8 @@ static int fill_pack_entry(const struct object_id *oid,
 	if (p->num_bad_objects) {
 		unsigned i;
 		for (i = 0; i < p->num_bad_objects; i++)
-			if (!hashcmp(oid->hash, p->bad_object_sha1 + 20 * i))
+			if (!hashcmp(oid->hash,
+				     p->bad_object_sha1 + the_hash_algo->rawsz * i))
 				return 0;
 	}
 
