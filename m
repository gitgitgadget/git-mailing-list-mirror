Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D1741F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeA1P5n (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:57:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58384 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751733AbeA1P5f (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:57:35 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E6F1060402;
        Sun, 28 Jan 2018 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517155054;
        bh=/NB64pw0bO0agjWyvM2Nm7RGCC5z77I+QD0R7t41h6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=w5DwRYZku+5MG3Hx/9/uN92UKUY/4aEd+KlxsLHv7knvtc4Z+W6TNOIsJkPKzW4Hy
         cQoICEEb523ROkpcuUrkbzZuA+X3+ZR5M1DCMZnpk1fKo5K8XRXZrzwKEDzzvwM/dK
         7K5R48M82V90YugQ+SahYdjOlEt3Er1/jCub0axg+a+Fh5NObW6j/cAq6BkDySdD8h
         vXnKsHurNSzV7YK79R8ieCGhjm+vx5+fALVS0ec1ZB7bIYGuiap5dLCZflP8Za3/e9
         HxBiLmKuQ51gwgy97rPOgg2+Xg+fGpiAOZh6Q1s5huKaMpuBzlE2FU8tUdIZVa9zR+
         vel76mA3az+K7wQyl0u4cgonzt2z3xjc8g4LbjrmO3iwMuJlOOFkVMAHTDK3ILUS9J
         TbZtH/4DhyrtpEDQD5z0IWYbPeCF58HUJDqVLwbWOayw3hSJBV8Z5xIPNXyQ6DMMB4
         ViB2/7CgT7vMDLezNBvk7b3nLq80dCCnCOce0ilawF9mtKbF120
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 03/12] builtin/index-pack: improve hash function abstraction
Date:   Sun, 28 Jan 2018 15:57:13 +0000
Message-Id: <20180128155722.880805-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180128155722.880805-1-sandals@crustytoothpaste.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert several uses of unsigned char [20] to struct object_id and
convert various hard-coded constants and uses of SHA-1 functions to use
the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c | 90 ++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4c51aec81f..40c000aca8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -91,7 +91,7 @@ static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
 static off_t max_input_size;
 static unsigned deepest_delta;
-static git_SHA_CTX input_ctx;
+static git_hash_ctx input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd;
 static const char *curr_pack;
@@ -253,7 +253,7 @@ static void flush(void)
 	if (input_offset) {
 		if (output_fd >= 0)
 			write_or_die(output_fd, input_buffer, input_offset);
-		git_SHA1_Update(&input_ctx, input_buffer, input_offset);
+		the_hash_algo->update_fn(&input_ctx, input_buffer, input_offset);
 		memmove(input_buffer, input_buffer + input_offset, input_len);
 		input_offset = 0;
 	}
@@ -326,7 +326,7 @@ static const char *open_pack_file(const char *pack_name)
 		output_fd = -1;
 		nothread_data.pack_fd = input_fd;
 	}
-	git_SHA1_Init(&input_ctx);
+	the_hash_algo->init_fn(&input_ctx);
 	return pack_name;
 }
 
@@ -437,22 +437,22 @@ static int is_delta_type(enum object_type type)
 }
 
 static void *unpack_entry_data(off_t offset, unsigned long size,
-			       enum object_type type, unsigned char *sha1)
+			       enum object_type type, struct object_id *oid)
 {
 	static char fixed_buf[8192];
 	int status;
 	git_zstream stream;
 	void *buf;
-	git_SHA_CTX c;
+	git_hash_ctx c;
 	char hdr[32];
 	int hdrlen;
 
 	if (!is_delta_type(type)) {
 		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), size) + 1;
-		git_SHA1_Init(&c);
-		git_SHA1_Update(&c, hdr, hdrlen);
+		the_hash_algo->init_fn(&c);
+		the_hash_algo->update_fn(&c, hdr, hdrlen);
 	} else
-		sha1 = NULL;
+		oid = NULL;
 	if (type == OBJ_BLOB && size > big_file_threshold)
 		buf = fixed_buf;
 	else
@@ -469,8 +469,8 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 		stream.avail_in = input_len;
 		status = git_inflate(&stream, 0);
 		use(input_len - stream.avail_in);
-		if (sha1)
-			git_SHA1_Update(&c, last_out, stream.next_out - last_out);
+		if (oid)
+			the_hash_algo->update_fn(&c, last_out, stream.next_out - last_out);
 		if (buf == fixed_buf) {
 			stream.next_out = buf;
 			stream.avail_out = sizeof(fixed_buf);
@@ -479,15 +479,15 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 	if (stream.total_out != size || status != Z_STREAM_END)
 		bad_object(offset, _("inflate returned %d"), status);
 	git_inflate_end(&stream);
-	if (sha1)
-		git_SHA1_Final(sha1, &c);
+	if (oid)
+		the_hash_algo->final_fn(oid->hash, &c);
 	return buf == fixed_buf ? NULL : buf;
 }
 
 static void *unpack_raw_entry(struct object_entry *obj,
 			      off_t *ofs_offset,
-			      unsigned char *ref_sha1,
-			      unsigned char *sha1)
+			      struct object_id *ref_oid,
+			      struct object_id *oid)
 {
 	unsigned char *p;
 	unsigned long size, c;
@@ -515,8 +515,8 @@ static void *unpack_raw_entry(struct object_entry *obj,
 
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		hashcpy(ref_sha1, fill(20));
-		use(20);
+		hashcpy(ref_oid->hash, fill(the_hash_algo->rawsz));
+		use(the_hash_algo->rawsz);
 		break;
 	case OBJ_OFS_DELTA:
 		p = fill(1);
@@ -546,7 +546,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
 	}
 	obj->hdr_size = consumed_bytes - obj->idx.offset;
 
-	data = unpack_entry_data(obj->idx.offset, obj->size, obj->type, sha1);
+	data = unpack_entry_data(obj->idx.offset, obj->size, obj->type, oid);
 	obj->idx.crc32 = input_crc32;
 	return data;
 }
@@ -1119,11 +1119,11 @@ static void *threaded_second_pass(void *data)
  * - calculate SHA1 of all non-delta objects;
  * - remember base (SHA1 or offset) for all deltas.
  */
-static void parse_pack_objects(unsigned char *sha1)
+static void parse_pack_objects(unsigned char *hash)
 {
 	int i, nr_delays = 0;
 	struct ofs_delta_entry *ofs_delta = ofs_deltas;
-	unsigned char ref_delta_sha1[20];
+	struct object_id ref_delta_oid;
 	struct stat st;
 
 	if (verbose)
@@ -1133,8 +1133,8 @@ static void parse_pack_objects(unsigned char *sha1)
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		void *data = unpack_raw_entry(obj, &ofs_delta->offset,
-					      ref_delta_sha1,
-					      obj->idx.oid.hash);
+					      &ref_delta_oid,
+					      &obj->idx.oid);
 		obj->real_type = obj->type;
 		if (obj->type == OBJ_OFS_DELTA) {
 			nr_ofs_deltas++;
@@ -1142,7 +1142,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			ofs_delta++;
 		} else if (obj->type == OBJ_REF_DELTA) {
 			ALLOC_GROW(ref_deltas, nr_ref_deltas + 1, ref_deltas_alloc);
-			hashcpy(ref_deltas[nr_ref_deltas].sha1, ref_delta_sha1);
+			hashcpy(ref_deltas[nr_ref_deltas].sha1, ref_delta_oid.hash);
 			ref_deltas[nr_ref_deltas].obj_no = i;
 			nr_ref_deltas++;
 		} else if (!data) {
@@ -1160,10 +1160,10 @@ static void parse_pack_objects(unsigned char *sha1)
 
 	/* Check pack integrity */
 	flush();
-	git_SHA1_Final(sha1, &input_ctx);
-	if (hashcmp(fill(20), sha1))
+	the_hash_algo->final_fn(hash, &input_ctx);
+	if (hashcmp(fill(the_hash_algo->rawsz), hash))
 		die(_("pack is corrupted (SHA1 mismatch)"));
-	use(20);
+	use(the_hash_algo->rawsz);
 
 	/* If input_fd is a file, we should have reached its end now. */
 	if (fstat(input_fd, &st))
@@ -1239,21 +1239,21 @@ static void resolve_deltas(void)
 /*
  * Third pass:
  * - append objects to convert thin pack to full pack if required
- * - write the final 20-byte SHA-1
+ * - write the final pack hash
  */
 static void fix_unresolved_deltas(struct sha1file *f);
-static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned char *pack_sha1)
+static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned char *pack_hash)
 {
 	if (nr_ref_deltas + nr_ofs_deltas == nr_resolved_deltas) {
 		stop_progress(&progress);
-		/* Flush remaining pack final 20-byte SHA1. */
+		/* Flush remaining pack final hash. */
 		flush();
 		return;
 	}
 
 	if (fix_thin_pack) {
 		struct sha1file *f;
-		unsigned char read_sha1[20], tail_sha1[20];
+		unsigned char read_hash[GIT_MAX_RAWSZ], tail_hash[GIT_MAX_RAWSZ];
 		struct strbuf msg = STRBUF_INIT;
 		int nr_unresolved = nr_ofs_deltas + nr_ref_deltas - nr_resolved_deltas;
 		int nr_objects_initial = nr_objects;
@@ -1270,12 +1270,12 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 			    nr_objects - nr_objects_initial);
 		stop_progress_msg(&progress, msg.buf);
 		strbuf_release(&msg);
-		sha1close(f, tail_sha1, 0);
-		hashcpy(read_sha1, pack_sha1);
-		fixup_pack_header_footer(output_fd, pack_sha1,
+		sha1close(f, tail_hash, 0);
+		hashcpy(read_hash, pack_hash);
+		fixup_pack_header_footer(output_fd, pack_hash,
 					 curr_pack, nr_objects,
-					 read_sha1, consumed_bytes-20);
-		if (hashcmp(read_sha1, tail_sha1) != 0)
+					 read_hash, consumed_bytes-the_hash_algo->rawsz);
+		if (hashcmp(read_hash, tail_hash) != 0)
 			die(_("Unexpected tail checksum for %s "
 			      "(disk corruption?)"), curr_pack);
 	}
@@ -1392,7 +1392,7 @@ static void fix_unresolved_deltas(struct sha1file *f)
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
 		  const char *keep_name, const char *keep_msg,
-		  unsigned char *sha1)
+		  unsigned char *hash)
 {
 	const char *report = "pack";
 	struct strbuf pack_name = STRBUF_INIT;
@@ -1413,7 +1413,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		int keep_fd, keep_msg_len = strlen(keep_msg);
 
 		if (!keep_name)
-			keep_name = odb_pack_name(&keep_name_buf, sha1, "keep");
+			keep_name = odb_pack_name(&keep_name_buf, hash, "keep");
 
 		keep_fd = odb_pack_keep(keep_name);
 		if (keep_fd < 0) {
@@ -1434,7 +1434,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	if (final_pack_name != curr_pack_name) {
 		if (!final_pack_name)
-			final_pack_name = odb_pack_name(&pack_name, sha1, "pack");
+			final_pack_name = odb_pack_name(&pack_name, hash, "pack");
 		if (finalize_object_file(curr_pack_name, final_pack_name))
 			die(_("cannot store pack file"));
 	} else if (from_stdin)
@@ -1442,18 +1442,18 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	if (final_index_name != curr_index_name) {
 		if (!final_index_name)
-			final_index_name = odb_pack_name(&index_name, sha1, "idx");
+			final_index_name = odb_pack_name(&index_name, hash, "idx");
 		if (finalize_object_file(curr_index_name, final_index_name))
 			die(_("cannot store index file"));
 	} else
 		chmod(final_index_name, 0444);
 
 	if (!from_stdin) {
-		printf("%s\n", sha1_to_hex(sha1));
+		printf("%s\n", sha1_to_hex(hash));
 	} else {
 		struct strbuf buf = STRBUF_INIT;
 
-		strbuf_addf(&buf, "%s\t%s\n", report, sha1_to_hex(sha1));
+		strbuf_addf(&buf, "%s\t%s\n", report, sha1_to_hex(hash));
 		write_or_die(1, buf.buf, buf.len);
 		strbuf_release(&buf);
 
@@ -1637,7 +1637,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		      keep_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
-	unsigned char pack_sha1[20];
+	unsigned char pack_hash[GIT_MAX_RAWSZ];
 	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
 	int report_end_of_input = 0;
 
@@ -1768,11 +1768,11 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (show_stat)
 		obj_stat = xcalloc(st_add(nr_objects, 1), sizeof(struct object_stat));
 	ofs_deltas = xcalloc(nr_objects, sizeof(struct ofs_delta_entry));
-	parse_pack_objects(pack_sha1);
+	parse_pack_objects(pack_hash);
 	if (report_end_of_input)
 		write_in_full(2, "\0", 1);
 	resolve_deltas();
-	conclude_pack(fix_thin_pack, curr_pack, pack_sha1);
+	conclude_pack(fix_thin_pack, curr_pack, pack_hash);
 	free(ofs_deltas);
 	free(ref_deltas);
 	if (strict)
@@ -1784,14 +1784,14 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	ALLOC_ARRAY(idx_objects, nr_objects);
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
-	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_sha1);
+	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_hash);
 	free(idx_objects);
 
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
 		      keep_name, keep_msg,
-		      pack_sha1);
+		      pack_hash);
 	else
 		close(input_fd);
 	free(objects);
