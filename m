Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CBD1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbfIMNDA (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:03:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33175 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbfIMNDA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:03:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id o9so27029511edq.0
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uwrKVMIsJycWJBPIImLVMCIiKPd40aIozZjKsFZrgxY=;
        b=TlQtLDOh73UZ3RDmNZhZmCV8tnyt6bM7KYYPE9QAiDw1z2KCOzr6fkDjkN6XmOzVvm
         NQPCJUwz+OB0AHZRO3tSVoeNey+9LvyYz6WkkO5jSlBTe5YcXlii+yZceruOu3rYjDXA
         fwYDqcIP/g9T2HrXAEZxUzEQuySt+dDnQdRZPdpt6RH0E+fr5W5EpqygbJuutZdi+hT1
         lmHxQlh+uDzCTCM5gk1+nfwJ3801jj3fxYCL0dhWOwj/01Jw8/oKsHO2i8+T8NpnPNci
         t5wlvj3hB7ba/jK+HWucEWQwUvkvtsb+8PEdAf2oleopo09zT1/rt2dnrQtp+flt6bDx
         iiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uwrKVMIsJycWJBPIImLVMCIiKPd40aIozZjKsFZrgxY=;
        b=E1HiNV9xFpXQ6HG22AXP3+fVZUH3bdpy+kOAotMEXRwmiQKcs2b4RtHF5DyQW3OHjA
         racXPvvqQ4k4ftUaudVsWI128GZyIURRSMNTRoJespxx6dVaSzI3WY9zF3IQow4lTMhd
         Y2+3tHRCcx/5HURgqI8HLOUx3WYoKSQC3Ytff3I0kHhJlRXF3wPOp+ovYx03NcHotJI3
         IkmB6mSaTPWYvOjUgO03G9lSsaV/ilnlAvrBV+J1nN+Hz2FRWnSkLhrPaABjYIYqLm05
         iB3dDln4A9VlrDdYlqSL9QvCfE+4sQF+P9TQYTk5NFQ1c/jkOGNKEYYKRvq8ClNWg0bH
         Eobw==
X-Gm-Message-State: APjAAAWm9aZ6Fs/ZOfZ0wdVzyh0yljzoYZrjzeFPnxZOnD5wEJHMs21X
        MKhc4An9zlKJunWXyHfMlsb6HvTI
X-Google-Smtp-Source: APXvYqzdEcLdNBbbxWqUCRJPOnNhb2TO0lctRoKX2KI33HVxgQv9DiTz9UaL/x1WMjJU62Xtyjesdg==
X-Received: by 2002:a05:6402:125a:: with SMTP id l26mr10775572edw.95.1568379777584;
        Fri, 13 Sep 2019 06:02:57 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:56 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
Date:   Fri, 13 Sep 2019 15:02:26 +0200
Message-Id: <20190913130226.7449-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.46.gd213b4aca1.dirty
In-Reply-To: <20190913130226.7449-1-chriscool@tuxfamily.org>
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
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

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 227 +++++++++++++++++++++++++++++++++--------
 pack-bitmap.c          | 150 +++++++++++++++++++--------
 pack-bitmap.h          |   3 +-
 3 files changed, 293 insertions(+), 87 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5ee0b3092d..6822ac1026 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -92,7 +92,7 @@ static struct progress *progress_state;
 
 static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
-static off_t reuse_packfile_offset;
+static struct bitmap *reuse_packfile_bitmap;
 
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
@@ -785,57 +785,189 @@ static struct object_entry **compute_write_order(void)
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
 
-	if (reuse_packfile_offset < 0)
-		reuse_packfile_offset = reuse_packfile->pack_size - the_hash_algo->rawsz;
+static void write_reused_pack_one(size_t pos, struct hashfile *out,
+				  struct pack_window **w_curs)
+{
+	off_t offset, next, cur;
+	enum object_type type;
+	unsigned long size;
 
-	total = to_write = reuse_packfile_offset - sizeof(struct pack_header);
+	offset = reuse_packfile->revindex[pos].offset;
+	next = reuse_packfile->revindex[pos + 1].offset;
 
-	while (to_write) {
-		int read_pack = xread(fd, buffer, sizeof(buffer));
+	record_reused_object(offset, offset - hashfile_total(out));
 
-		if (read_pack <= 0)
-			die_errno(_("unable to read from reused packfile"));
+	cur = offset;
+	type = unpack_object_header(reuse_packfile, w_curs, &cur, &size);
+	assert(type >= 0);
 
-		if (read_pack > to_write)
-			read_pack = to_write;
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
 
-		hashwrite(f, buffer, read_pack);
-		to_write -= read_pack;
+		/* Otherwise see if we need to rewrite the offset... */
+		fixup = find_reused_offset(offset) -
+			find_reused_offset(base_offset);
+		if (fixup) {
+			unsigned char ofs_header[10];
+			unsigned i, ofs_len;
+			off_t ofs = offset - base_offset - fixup;
+
+			len = encode_in_pack_object_header(header, sizeof(header),
+							   OBJ_OFS_DELTA, size);
+
+			i = sizeof(ofs_header) - 1;
+			ofs_header[i] = ofs & 127;
+			while (ofs >>= 7)
+				ofs_header[--i] = 128 | (--ofs & 127);
+
+			ofs_len = sizeof(ofs_header) - i;
+
+			if (0) {
+				off_t expected_size = cur - offset;
+
+				if (len + ofs_len < expected_size) {
+					unsigned max_pad = (len >= 4) ? 9 : 5;
+					header[len - 1] |= 0x80;
+					while (len < max_pad && len + ofs_len < expected_size)
+						header[len++] = 0x80;
+					header[len - 1] &= 0x7F;
+				}
+			}
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
@@ -868,11 +1000,9 @@ static void write_pack_file(void)
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
@@ -1002,6 +1132,10 @@ static int have_duplicate_entry(const struct object_id *oid,
 {
 	struct object_entry *entry;
 
+	if (reuse_packfile_bitmap &&
+	    bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid))
+		return 1;
+
 	entry = packlist_find(&to_pack, oid, index_pos);
 	if (!entry)
 		return 0;
@@ -1192,6 +1326,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	create_object_entry(oid, type, pack_name_hash(name),
 			    exclude, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
+
 	return 1;
 }
 
@@ -2571,7 +2706,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 
 static int obj_is_packed(const struct object_id *oid)
 {
-	return !!packlist_find(&to_pack, oid, NULL);
+	return packlist_find(&to_pack, oid, NULL) ||
+		(reuse_packfile_bitmap &&
+		 bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
 }
 
 static void add_tag_chain(const struct object_id *oid)
@@ -2677,6 +2814,7 @@ static void prepare_pack(int window, int depth)
 
 	if (nr_deltas && n > 1) {
 		unsigned nr_done = 0;
+
 		if (progress)
 			progress_state = start_progress(_("Compressing objects"),
 							nr_deltas);
@@ -3061,7 +3199,6 @@ static void loosen_unused_packed_objects(void)
 static int pack_options_allow_reuse(void)
 {
 	return pack_to_stdout &&
-	       allow_ofs_delta &&
 	       !ignore_packed_keep_on_disk &&
 	       !ignore_packed_keep_in_core &&
 	       (!local || !have_non_local_packs) &&
@@ -3079,7 +3216,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 			bitmap_git,
 			&reuse_packfile,
 			&reuse_packfile_objects,
-			&reuse_packfile_offset)) {
+			&reuse_packfile_bitmap)) {
 		assert(reuse_packfile_objects);
 		nr_result += reuse_packfile_objects;
 		display_progress(progress_state, nr_result);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1833971dc7..1d4c95ebc1 100644
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
 
@@ -766,65 +773,126 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
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
index 5425767f0f..7af7335f2e 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -50,7 +50,8 @@ void test_bitmap_walk(struct rev_info *revs);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 				       struct packed_git **packfile,
-				       uint32_t *entries, off_t *up_to);
+				       uint32_t *entries,
+				       struct bitmap **bitmap);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
-- 
2.23.0.46.gd213b4aca1.dirty

