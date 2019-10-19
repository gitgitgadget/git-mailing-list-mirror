Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCFBA1F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 10:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfJSKgI (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:36:08 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46056 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfJSKgF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:36:05 -0400
Received: by mail-wr1-f54.google.com with SMTP id q13so3765581wrs.12
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 03:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTRq+NqVF424qMd9aJJd13XV30sTMY1YHvLbHuluefc=;
        b=IYOnxqNJguIa3WdrS1jaoZp3KdiFcmo5l1Chjf5+pLVLYGnSkXMVV7inyP+qeQ4GJe
         JW6Tp7B3THCzb9VX2B0weZAlr8vQORWMQpResXusssZ4hGkgQZ0XuN/0hL39CUWVDDkC
         W3SpvjKC+HuzzzZ0qQFNPoWk5ODZpKD7QfzAg3PGvdVKdcKC+23hijA1857mNQ8TSomo
         IOAjjLgctme9zHyfSgjJmAL9Q7m1BRDUzES/KztuJEmrz8nlS/zNdis0rS340mzBbMy4
         tzGTYxUcpPNXni7WIVNkySoQkqnvQ8GbPwcEfQpBSJ5li5/EJAGN0JvgA2YJg0xc1iK0
         7Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTRq+NqVF424qMd9aJJd13XV30sTMY1YHvLbHuluefc=;
        b=a107CNcqspcBqy/1lrH5x22vbAs5VkVpvHItRRJ65SPL+WI1JVaqdQGb4M6bQ2wuxF
         jZv/XVtsR9nDxV6zFzkWgBUE2P/liKPZPf5lwqZaimx2AIze8jC8IQ1m2EEtYam1f4YF
         u72vhpnhOEznzc12PRqI2h5dhVqc0JtUwJuE6PBcrFAeB4wi8C/22uB72DKynEaCsrlA
         bKLPCqYjn2LYAvRrVnmpP8IwlbeDDnVztQKDuX8s0p6c4q0J/kqK+dN7IVZ/CiHxzmsO
         8K1nnbsxslaSIXaLHWapdwcP72AQJkGy4WbBUMkPdrrEaDH4zuqAJeNshbtJ2sAss/0m
         cDAw==
X-Gm-Message-State: APjAAAVeatrloIIIko0esBbJtvHRl0bhCmTWrEwDOSYJtPCjjg/Oc5wr
        OH5ActkTrmK7NodcRNjlRI6pgZhpXWZNaA==
X-Google-Smtp-Source: APXvYqwUtmISdgsFFfVXxoDiDs3EcQ8UPyDL0pw4KPpv5WMBHsN0agGLBOlCLR1VpBbSObpWaSKsXA==
X-Received: by 2002:adf:fe10:: with SMTP id n16mr12180206wrr.288.1571481361455;
        Sat, 19 Oct 2019 03:36:01 -0700 (PDT)
Received: from localhost.localdomain ([80.214.68.206])
        by smtp.gmail.com with ESMTPSA id p68sm6383086wme.0.2019.10.19.03.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 03:36:00 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 9/9] pack-objects: improve partial packfile reuse
Date:   Sat, 19 Oct 2019 12:35:31 +0200
Message-Id: <20191019103531.23274-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0.rc0.9.gef620577e2
In-Reply-To: <20191019103531.23274-1-chriscool@tuxfamily.org>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Let's store the chunks of the packfile that we reuse in
a dynamic array of `struct reused_chunk`, and let's use
a reuse_packfile_bitmap to speed up reusing parts of
packfiles.

The dynamic array of `struct reused_chunk` is useful
because we need to know not just the number of zero bits,
but the accumulated offset due to missing objects. So
without the array we'd end up having to walk over the
revindex for that set of objects. The array is
basically caching those accumulated offsets (for the
parts we _do_ include), so we don't have to compute them
repeatedly.

The old code just tried to dump a whole segment of the
pack verbatim. That's faster than the traditional way of
actually adding objects to the packing list, but it
didn't kick in very often. This new code is really going
for a middle ground: do _some_ per-object work, but way
less than we'd traditionally do.

For instance, packing torvalds/linux on GitHub servers
just now reused 6.5M objects, but only needed ~50k
chunks.

Additional checks are added in have_duplicate_entry()
and obj_is_packed() to avoid duplicate objects in the
reuse bitmap. It was probably buggy to not have such a
check before.

If a client both asks for a tag by sha1 and specifies
"include-tag", we may end up including the tag in the reuse
bitmap (due to the first thing), and then later adding it to
the packlist (due to the second). This results in duplicate
objects in the pack, which git chokes on. We should notice
that we are already including it when doing the include-tag
portion, and avoid adding it to the packlist.

The simplest place to fix this is right in add_ref_tag,
where we could avoid peeling the tag at all if we know that
we are already including it. However, I've pushed the check
instead into have_duplicate_entry(). This fixes not only
this case, but also means that we cannot have any similar
problems lurking in other code.

No tests, because git does not actually exhibit this "ask
for it and also include-tag" behavior. We do one or the
other on clone, depending on whether --single-branch is set.
However, libgit2 does both.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 214 ++++++++++++++++++++++++++++++++---------
 pack-bitmap.c          | 150 +++++++++++++++++++++--------
 pack-bitmap.h          |   3 +-
 3 files changed, 280 insertions(+), 87 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 08898331ef..f710f8dde3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -92,7 +92,7 @@ static struct progress *progress_state;
 
 static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
-static off_t reuse_packfile_offset;
+static struct bitmap *reuse_packfile_bitmap;
 
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
@@ -785,57 +785,177 @@ static struct object_entry **compute_write_order(void)
 	return wo;
 }
 
-static off_t write_reused_pack(struct hashfile *f)
+/*
+ * Record the offsets needed in our reused packfile chunks due to
+ * "gaps" where we omitted some objects.
+ */
+static struct reused_chunk {
+	off_t start;
+	off_t offset;
+} *reused_chunks;
+static int reused_chunks_nr;
+static int reused_chunks_alloc;
+
+static void record_reused_object(off_t where, off_t offset)
 {
-	unsigned char buffer[8192];
-	off_t to_write, total;
-	int fd;
+	if (reused_chunks_nr && reused_chunks[reused_chunks_nr-1].offset == offset)
+		return;
 
-	if (!is_pack_valid(reuse_packfile))
-		die(_("packfile is invalid: %s"), reuse_packfile->pack_name);
+	ALLOC_GROW(reused_chunks, reused_chunks_nr + 1,
+		   reused_chunks_alloc);
+	reused_chunks[reused_chunks_nr].start = where;
+	reused_chunks[reused_chunks_nr].offset = offset;
+	reused_chunks_nr++;
+}
 
-	fd = git_open(reuse_packfile->pack_name);
-	if (fd < 0)
-		die_errno(_("unable to open packfile for reuse: %s"),
-			  reuse_packfile->pack_name);
+/*
+ * Binary search to find the chunk that "where" is in. Note
+ * that we're not looking for an exact match, just the first
+ * chunk that contains it (which implicitly ends at the start
+ * of the next chunk.
+ */
+static off_t find_reused_offset(off_t where)
+{
+	int lo = 0, hi = reused_chunks_nr;
+	while (lo < hi) {
+		int mi = lo + ((hi - lo) / 2);
+		if (where == reused_chunks[mi].start)
+			return reused_chunks[mi].offset;
+		if (where < reused_chunks[mi].start)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
 
-	if (lseek(fd, sizeof(struct pack_header), SEEK_SET) == -1)
-		die_errno(_("unable to seek in reused packfile"));
+	/*
+	 * The first chunk starts at zero, so we can't have gone below
+	 * there.
+	 */
+	assert(lo);
+	return reused_chunks[lo-1].offset;
+}
+
+static void write_reused_pack_one(size_t pos, struct hashfile *out,
+				  struct pack_window **w_curs)
+{
+	off_t offset, next, cur;
+	enum object_type type;
+	unsigned long size;
+
+	offset = reuse_packfile->revindex[pos].offset;
+	next = reuse_packfile->revindex[pos + 1].offset;
 
-	if (reuse_packfile_offset < 0)
-		reuse_packfile_offset = reuse_packfile->pack_size - the_hash_algo->rawsz;
+	record_reused_object(offset, offset - hashfile_total(out));
 
-	total = to_write = reuse_packfile_offset - sizeof(struct pack_header);
+	cur = offset;
+	type = unpack_object_header(reuse_packfile, w_curs, &cur, &size);
+	assert(type >= 0);
 
-	while (to_write) {
-		int read_pack = xread(fd, buffer, sizeof(buffer));
+	if (type == OBJ_OFS_DELTA) {
+		off_t base_offset;
+		off_t fixup;
+
+		unsigned char header[MAX_PACK_OBJECT_HEADER];
+		unsigned len;
+
+		base_offset = get_delta_base(reuse_packfile, w_curs, &cur, type, offset);
+		assert(base_offset != 0);
+
+		/* Convert to REF_DELTA if we must... */
+		if (!allow_ofs_delta) {
+			int base_pos = find_revindex_position(reuse_packfile, base_offset);
+			const unsigned char *base_sha1 =
+				nth_packed_object_sha1(reuse_packfile,
+						       reuse_packfile->revindex[base_pos].nr);
+
+			len = encode_in_pack_object_header(header, sizeof(header),
+							   OBJ_REF_DELTA, size);
+			hashwrite(out, header, len);
+			hashwrite(out, base_sha1, 20);
+			copy_pack_data(out, reuse_packfile, w_curs, cur, next - cur);
+			return;
+		}
 
-		if (read_pack <= 0)
-			die_errno(_("unable to read from reused packfile"));
+		/* Otherwise see if we need to rewrite the offset... */
+		fixup = find_reused_offset(offset) -
+			find_reused_offset(base_offset);
+		if (fixup) {
+			unsigned char ofs_header[10];
+			unsigned i, ofs_len;
+			off_t ofs = offset - base_offset - fixup;
 
-		if (read_pack > to_write)
-			read_pack = to_write;
+			len = encode_in_pack_object_header(header, sizeof(header),
+							   OBJ_OFS_DELTA, size);
 
-		hashwrite(f, buffer, read_pack);
-		to_write -= read_pack;
+			i = sizeof(ofs_header) - 1;
+			ofs_header[i] = ofs & 127;
+			while (ofs >>= 7)
+				ofs_header[--i] = 128 | (--ofs & 127);
+
+			ofs_len = sizeof(ofs_header) - i;
+
+			hashwrite(out, header, len);
+			hashwrite(out, ofs_header + sizeof(ofs_header) - ofs_len, ofs_len);
+			copy_pack_data(out, reuse_packfile, w_curs, cur, next - cur);
+			return;
+		}
+
+		/* ...otherwise we have no fixup, and can write it verbatim */
+	}
+
+	copy_pack_data(out, reuse_packfile, w_curs, offset, next - offset);
+}
+
+static size_t write_reused_pack_verbatim(struct hashfile *out,
+					 struct pack_window **w_curs)
+{
+	size_t pos = 0;
+
+	while (pos < reuse_packfile_bitmap->word_alloc &&
+			reuse_packfile_bitmap->words[pos] == (eword_t)~0)
+		pos++;
+
+	if (pos) {
+		off_t to_write;
+
+		written = (pos * BITS_IN_EWORD);
+		to_write = reuse_packfile->revindex[written].offset
+			- sizeof(struct pack_header);
+
+		record_reused_object(sizeof(struct pack_header), 0);
+		hashflush(out);
+		copy_pack_data(out, reuse_packfile, w_curs,
+			sizeof(struct pack_header), to_write);
 
-		/*
-		 * We don't know the actual number of objects written,
-		 * only how many bytes written, how many bytes total, and
-		 * how many objects total. So we can fake it by pretending all
-		 * objects we are writing are the same size. This gives us a
-		 * smooth progress meter, and at the end it matches the true
-		 * answer.
-		 */
-		written = reuse_packfile_objects *
-				(((double)(total - to_write)) / total);
 		display_progress(progress_state, written);
 	}
+	return pos;
+}
+
+static void write_reused_pack(struct hashfile *f)
+{
+	size_t i = 0;
+	uint32_t offset;
+	struct pack_window *w_curs = NULL;
+
+	if (allow_ofs_delta)
+		i = write_reused_pack_verbatim(f, &w_curs);
+
+	for (; i < reuse_packfile_bitmap->word_alloc; ++i) {
+		eword_t word = reuse_packfile_bitmap->words[i];
+		size_t pos = (i * BITS_IN_EWORD);
+
+		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
+			if ((word >> offset) == 0)
+				break;
+
+			offset += ewah_bit_ctz64(word >> offset);
+			write_reused_pack_one(pos + offset, f, &w_curs);
+			display_progress(progress_state, ++written);
+		}
+	}
 
-	close(fd);
-	written = reuse_packfile_objects;
-	display_progress(progress_state, written);
-	return reuse_packfile_offset - sizeof(struct pack_header);
+	unuse_pack(&w_curs);
 }
 
 static const char no_split_warning[] = N_(
@@ -868,11 +988,9 @@ static void write_pack_file(void)
 		offset = write_pack_header(f, nr_remaining);
 
 		if (reuse_packfile) {
-			off_t packfile_size;
 			assert(pack_to_stdout);
-
-			packfile_size = write_reused_pack(f);
-			offset += packfile_size;
+			write_reused_pack(f);
+			offset = hashfile_total(f);
 		}
 
 		nr_written = 0;
@@ -1001,6 +1119,10 @@ static int have_duplicate_entry(const struct object_id *oid,
 {
 	struct object_entry *entry;
 
+	if (reuse_packfile_bitmap &&
+	    bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid))
+		return 1;
+
 	entry = packlist_find(&to_pack, oid);
 	if (!entry)
 		return 0;
@@ -2555,7 +2677,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 
 static int obj_is_packed(const struct object_id *oid)
 {
-	return !!packlist_find(&to_pack, oid);
+	return packlist_find(&to_pack, oid) ||
+		(reuse_packfile_bitmap &&
+		 bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
 }
 
 static void add_tag_chain(const struct object_id *oid)
@@ -2661,6 +2785,7 @@ static void prepare_pack(int window, int depth)
 
 	if (nr_deltas && n > 1) {
 		unsigned nr_done = 0;
+
 		if (progress)
 			progress_state = start_progress(_("Compressing objects"),
 							nr_deltas);
@@ -3042,7 +3167,6 @@ static int pack_options_allow_reuse(void)
 {
 	return allow_pack_reuse &&
 	       pack_to_stdout &&
-	       allow_ofs_delta &&
 	       !ignore_packed_keep_on_disk &&
 	       !ignore_packed_keep_in_core &&
 	       (!local || !have_non_local_packs) &&
@@ -3059,7 +3183,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 			bitmap_git,
 			&reuse_packfile,
 			&reuse_packfile_objects,
-			&reuse_packfile_offset)) {
+			&reuse_packfile_bitmap)) {
 		assert(reuse_packfile_objects);
 		nr_result += reuse_packfile_objects;
 		display_progress(progress_state, nr_result);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8a51302a1a..cbfc544411 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -326,6 +326,13 @@ static int load_pack_bitmap(struct bitmap_index *bitmap_git)
 	munmap(bitmap_git->map, bitmap_git->map_size);
 	bitmap_git->map = NULL;
 	bitmap_git->map_size = 0;
+
+	kh_destroy_oid_map(bitmap_git->bitmaps);
+	bitmap_git->bitmaps = NULL;
+
+	kh_destroy_oid_pos(bitmap_git->ext_index.positions);
+	bitmap_git->ext_index.positions = NULL;
+
 	return -1;
 }
 
@@ -764,65 +771,126 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	return NULL;
 }
 
-int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
-				       struct packed_git **packfile,
-				       uint32_t *entries,
-				       off_t *up_to)
+static void try_partial_reuse(struct bitmap_index *bitmap_git,
+			      size_t pos,
+			      struct bitmap *reuse,
+			      struct pack_window **w_curs)
 {
+	struct revindex_entry *revidx;
+	off_t offset;
+	enum object_type type;
+	unsigned long size;
+
+	if (pos >= bitmap_git->pack->num_objects)
+		return; /* not actually in the pack */
+
+	revidx = &bitmap_git->pack->revindex[pos];
+	offset = revidx->offset;
+	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
+	if (type < 0)
+		return; /* broken packfile, punt */
+
+	if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA) {
+		off_t base_offset;
+		int base_pos;
+
+		/*
+		 * Find the position of the base object so we can look it up
+		 * in our bitmaps. If we can't come up with an offset, or if
+		 * that offset is not in the revidx, the pack is corrupt.
+		 * There's nothing we can do, so just punt on this object,
+		 * and the normal slow path will complain about it in
+		 * more detail.
+		 */
+		base_offset = get_delta_base(bitmap_git->pack, w_curs,
+					     &offset, type, revidx->offset);
+		if (!base_offset)
+			return;
+		base_pos = find_revindex_position(bitmap_git->pack, base_offset);
+		if (base_pos < 0)
+			return;
+
+		/*
+		 * We assume delta dependencies always point backwards. This
+		 * lets us do a single pass, and is basically always true
+		 * due to the way OFS_DELTAs work. You would not typically
+		 * find REF_DELTA in a bitmapped pack, since we only bitmap
+		 * packs we write fresh, and OFS_DELTA is the default). But
+		 * let's double check to make sure the pack wasn't written with
+		 * odd parameters.
+		 */
+		if (base_pos >= pos)
+			return;
+
+		/*
+		 * And finally, if we're not sending the base as part of our
+		 * reuse chunk, then don't send this object either. The base
+		 * would come after us, along with other objects not
+		 * necessarily in the pack, which means we'd need to convert
+		 * to REF_DELTA on the fly. Better to just let the normal
+		 * object_entry code path handle it.
+		 */
+		if (!bitmap_get(reuse, base_pos))
+			return;
+	}
+
 	/*
-	 * Reuse the packfile content if we need more than
-	 * 90% of its objects
+	 * If we got here, then the object is OK to reuse. Mark it.
 	 */
-	static const double REUSE_PERCENT = 0.9;
+	bitmap_set(reuse, pos);
+}
 
+int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
+				       struct packed_git **packfile_out,
+				       uint32_t *entries,
+				       struct bitmap **reuse_out)
+{
 	struct bitmap *result = bitmap_git->result;
-	uint32_t reuse_threshold;
-	uint32_t i, reuse_objects = 0;
+	struct bitmap *reuse;
+	struct pack_window *w_curs = NULL;
+	size_t i = 0;
+	uint32_t offset;
 
 	assert(result);
 
-	for (i = 0; i < result->word_alloc; ++i) {
-		if (result->words[i] != (eword_t)~0) {
-			reuse_objects += ewah_bit_ctz64(~result->words[i]);
-			break;
-		}
-
-		reuse_objects += BITS_IN_EWORD;
-	}
+	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
+		i++;
 
-#ifdef GIT_BITMAP_DEBUG
-	{
-		const unsigned char *sha1;
-		struct revindex_entry *entry;
+	/* Don't mark objects not in the packfile */
+	if (i > bitmap_git->pack->num_objects / BITS_IN_EWORD)
+		i = bitmap_git->pack->num_objects / BITS_IN_EWORD;
 
-		entry = &bitmap_git->reverse_index->revindex[reuse_objects];
-		sha1 = nth_packed_object_sha1(bitmap_git->pack, entry->nr);
+	reuse = bitmap_word_alloc(i);
+	memset(reuse->words, 0xFF, i * sizeof(eword_t));
 
-		fprintf(stderr, "Failed to reuse at %d (%016llx)\n",
-			reuse_objects, result->words[i]);
-		fprintf(stderr, " %s\n", hash_to_hex(sha1));
-	}
-#endif
+	for (; i < result->word_alloc; ++i) {
+		eword_t word = result->words[i];
+		size_t pos = (i * BITS_IN_EWORD);
 
-	if (!reuse_objects)
-		return -1;
+		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
+			if ((word >> offset) == 0)
+				break;
 
-	if (reuse_objects >= bitmap_git->pack->num_objects) {
-		bitmap_git->reuse_objects = *entries = bitmap_git->pack->num_objects;
-		*up_to = -1; /* reuse the full pack */
-		*packfile = bitmap_git->pack;
-		return 0;
+			offset += ewah_bit_ctz64(word >> offset);
+			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
+		}
 	}
 
-	reuse_threshold = bitmap_popcount(bitmap_git->result) * REUSE_PERCENT;
+	unuse_pack(&w_curs);
 
-	if (reuse_objects < reuse_threshold)
+	*entries = bitmap_popcount(reuse);
+	if (!*entries) {
+		bitmap_free(reuse);
 		return -1;
+	}
 
-	bitmap_git->reuse_objects = *entries = reuse_objects;
-	*up_to = bitmap_git->pack->revindex[reuse_objects].offset;
-	*packfile = bitmap_git->pack;
-
+	/*
+	 * Drop any reused objects from the result, since they will not
+	 * need to be handled separately.
+	 */
+	bitmap_and_not(result, reuse);
+	*packfile_out = bitmap_git->pack;
+	*reuse_out = reuse;
 	return 0;
 }
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 6ab6033dbe..bcd03b8993 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -50,7 +50,8 @@ void test_bitmap_walk(struct rev_info *revs);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 				       struct packed_git **packfile,
-				       uint32_t *entries, off_t *up_to);
+				       uint32_t *entries,
+				       struct bitmap **reuse_out);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
-- 
2.24.0.rc0.9.gef620577e2

