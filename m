Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC4F1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 23:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfG1XCK (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 19:02:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:53660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726103AbfG1XCK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 19:02:10 -0400
Received: (qmail 16140 invoked by uid 109); 28 Jul 2019 23:02:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 28 Jul 2019 23:02:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24816 invoked by uid 111); 28 Jul 2019 23:03:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jul 2019 19:03:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 28 Jul 2019 19:02:05 -0400
From:   Jeff King <peff@peff.net>
To:     James Ramsay <james@jramsay.com.au>
Cc:     git@vger.kernel.org
Subject: Re: Reporting reused packfile objects
Message-ID: <20190728230205.GB21379@sigill.intra.peff.net>
References: <3E56B0FD-EBE8-4057-A93A-16EBB09FBCE0@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3E56B0FD-EBE8-4057-A93A-16EBB09FBCE0@jramsay.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 02:10:58PM -0400, James Ramsay wrote:

> While investigating improvements to clone performance at GitLab we've been
> looking at how to trigger packfile reuse during clones. A challenge of the
> investigation and a future challenge of rolling out changes to encourage
> more frequent packfile reuse is knowing when packfile reuse kicks in and the
> extent of the reuse.
> 
> I notice that GitHub outputs 'pack-reused' statistics when fetching. I
> assume this is for similar reasons.

Yeah, we (GitHub) added it long ago when looking at why and when reuse
kicked in (or didn't).

What we found is that the initial implementation (which we did!) made a
lot of bad assumptions. The absolute worst one (for us, but also for
anyone else who follows our one-big-pack-for-all-forks approach) is
measuring the percentage of the total pack that's going to be sent. In a
world where you have a bunch of objects from other forks in the pack,
it's normal and expected that you'd be sending a much smaller percentage
of the pack.

In the end we rewrote that whole section of the code to be a lot
smarter. It allows "holes" in the chunks of packfile to be reused, and
skips over them. It rewrites OFS_DELTA offsets as it goes to account for
the holes. So it's basically a linear walk over the packfile, but with
the important distinction that we don't add those objects to the
object_entry array, which makes them very lightweight (especially in
memory use, but they also aren't considered bases for finding new
deltas, etc). I don't have exact numbers handy, but it seems like a good
compromise between the cost to serve a clone and the quality of the
resulting packfile.

It's been on my todo list to upstream for a while, but I've dragged my
feet on it because there's a lot of cleanup/polishing from the original
patches (they were never very clean in the first place, and we've merged
a dozen or more times with upstream since then, so the updates are
spread across a bunch of merge commits).

> Would there be interest in including a reused packfile objects statistic in
> the output of upload-pack?
> 
> I'm happy to contribute a patch (it is quite a small change), but it might
> be more efficient to upstream the patch that GitHub appears to already be
> running in production. Peff, what do you think?

Yeah, I think we should work on getting our changes (including those
stats) into upstream.

I'll look into turning this into a readable series, but in the meantime,
here's a _very_ rough diff against the current tip of master. I say
rough because we have other pack and bitmap-related changes, too. This
is the result of me spending a few minutes manually picking out hunks to
the point that "make test" seems to work. No guarantees beyond that
(yet). ;)

---
 builtin/pack-objects.c | 248 +++++++++++++++++++++++++++++++++--------
 csum-file.h            |   9 ++
 ewah/bitmap.c          |  13 ++-
 ewah/ewok.h            |   1 +
 pack-bitmap.c          | 178 ++++++++++++++++++++---------
 pack-bitmap.h          |   6 +-
 packfile.c             |  10 +-
 packfile.h             |   3 +
 8 files changed, 358 insertions(+), 110 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 267c562b1f..497f61723e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -92,10 +92,11 @@ static struct progress *progress_state;
 
 static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
-static off_t reuse_packfile_offset;
+static struct bitmap *reuse_packfile_bitmap;
 
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
+static int allow_pack_reuse = 1;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
 
@@ -780,57 +781,189 @@ static struct object_entry **compute_write_order(void)
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
 
-	close(fd);
-	written = reuse_packfile_objects;
-	display_progress(progress_state, written);
-	return reuse_packfile_offset - sizeof(struct pack_header);
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
+
+	unuse_pack(&w_curs);
 }
 
 static const char no_split_warning[] = N_(
@@ -863,11 +996,9 @@ static void write_pack_file(void)
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
@@ -996,6 +1127,10 @@ static int have_duplicate_entry(const struct object_id *oid,
 {
 	struct object_entry *entry;
 
+	if (reuse_packfile_bitmap &&
+	    bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid))
+		return 1;
+
 	entry = packlist_find(&to_pack, oid, index_pos);
 	if (!entry)
 		return 0;
@@ -1185,6 +1320,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	create_object_entry(oid, type, pack_name_hash(name),
 			    exclude, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
+
 	return 1;
 }
 
@@ -2562,6 +2698,13 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	free(p);
 }
 
+static int obj_is_packed(const struct object_id *oid)
+{
+	return packlist_find(&to_pack, oid, NULL) ||
+		(reuse_packfile_bitmap &&
+		 bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
+}
+
 static void add_tag_chain(const struct object_id *oid)
 {
 	struct tag *tag;
@@ -2573,7 +2716,7 @@ static void add_tag_chain(const struct object_id *oid)
 	 * it was included via bitmaps, we would not have parsed it
 	 * previously).
 	 */
-	if (packlist_find(&to_pack, oid, NULL))
+	if (obj_is_packed(oid))
 		return;
 
 	tag = lookup_tag(the_repository, oid);
@@ -2597,7 +2740,7 @@ static int add_ref_tag(const char *path, const struct object_id *oid, int flag,
 
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
 	    !peel_ref(path, &peeled)    && /* peelable? */
-	    packlist_find(&to_pack, &peeled, NULL))      /* object packed? */
+	    obj_is_packed(&peeled)) /* object packed? */
 		add_tag_chain(oid);
 	return 0;
 }
@@ -2665,6 +2808,7 @@ static void prepare_pack(int window, int depth)
 
 	if (nr_deltas && n > 1) {
 		unsigned nr_done = 0;
+
 		if (progress)
 			progress_state = start_progress(_("Compressing objects"),
 							nr_deltas);
@@ -2713,6 +2857,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		sparse = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.allowpackreuse")) {
+		allow_pack_reuse = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
@@ -3045,7 +3193,6 @@ static void loosen_unused_packed_objects(void)
 static int pack_options_allow_reuse(void)
 {
 	return pack_to_stdout &&
-	       allow_ofs_delta &&
 	       !ignore_packed_keep_on_disk &&
 	       !ignore_packed_keep_in_core &&
 	       (!local || !have_non_local_packs) &&
@@ -3057,12 +3204,13 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	if (!(bitmap_git = prepare_bitmap_walk(revs)))
 		return -1;
 
-	if (pack_options_allow_reuse() &&
+	if (allow_pack_reuse &&
+	    pack_options_allow_reuse() &&
 	    !reuse_partial_packfile_from_bitmap(
 			bitmap_git,
 			&reuse_packfile,
 			&reuse_packfile_objects,
-			&reuse_packfile_offset)) {
+			&reuse_packfile_bitmap)) {
 		assert(reuse_packfile_objects);
 		nr_result += reuse_packfile_objects;
 		display_progress(progress_state, nr_result);
@@ -3514,7 +3662,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress)
 		fprintf_ln(stderr,
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
-			     " reused %"PRIu32" (delta %"PRIu32")"),
-			   written, written_delta, reused, reused_delta);
+			     " reused %"PRIu32" (delta %"PRIu32"),"
+			     " pack-reused %"PRIu32),
+			   written, written_delta, reused, reused_delta,
+			   reuse_packfile_objects);
 	return 0;
 }
diff --git a/csum-file.h b/csum-file.h
index a98b1eee53..f9cbd317fb 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -42,6 +42,15 @@ void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
 
+/*
+ * Returns the total number of bytes fed to the hashfile so far (including ones
+ * that have not been written out to the descriptor yet).
+ */
+static inline off_t hashfile_total(struct hashfile *f)
+{
+	return f->total + f->offset;
+}
+
 static inline void hashwrite_u8(struct hashfile *f, uint8_t data)
 {
 	hashwrite(f, &data, sizeof(data));
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 52f1178db4..9e3227f215 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -22,21 +22,26 @@
 #define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_EWORD))
 #define EWAH_BLOCK(x) (x / BITS_IN_EWORD)
 
-struct bitmap *bitmap_new(void)
+struct bitmap *bitmap_new2(size_t word_alloc)
 {
 	struct bitmap *bitmap = xmalloc(sizeof(struct bitmap));
-	bitmap->words = xcalloc(32, sizeof(eword_t));
-	bitmap->word_alloc = 32;
+	bitmap->words = xcalloc(word_alloc, sizeof(eword_t));
+	bitmap->word_alloc = word_alloc;
 	return bitmap;
 }
 
+struct bitmap *bitmap_new(void)
+{
+	return bitmap_new2(32);
+}
+
 void bitmap_set(struct bitmap *self, size_t pos)
 {
 	size_t block = EWAH_BLOCK(pos);
 
 	if (block >= self->word_alloc) {
 		size_t old_size = self->word_alloc;
-		self->word_alloc = block * 2;
+		self->word_alloc = (block + 1) * 2;
 		REALLOC_ARRAY(self->words, self->word_alloc);
 		memset(self->words + old_size, 0x0,
 			(self->word_alloc - old_size) * sizeof(eword_t));
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 84b2a29faa..3ff650c5cd 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -172,6 +172,7 @@ struct bitmap {
 };
 
 struct bitmap *bitmap_new(void);
+struct bitmap *bitmap_new2(size_t word_alloc);
 void bitmap_set(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_reset(struct bitmap *self);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index ed2befaac6..3202ea1148 100644
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
 
@@ -622,7 +629,7 @@ static void show_objects_for_type(
 	enum object_type object_type,
 	show_reachable_fn show_reach)
 {
-	size_t pos = 0, i = 0;
+	size_t i = 0;
 	uint32_t offset;
 
 	struct ewah_iterator it;
@@ -630,13 +637,15 @@ static void show_objects_for_type(
 
 	struct bitmap *objects = bitmap_git->result;
 
-	if (bitmap_git->reuse_objects == bitmap_git->pack->num_objects)
-		return;
-
 	ewah_iterator_init(&it, type_filter);
 
-	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+	for (i = 0; i < objects->word_alloc &&
+			ewah_iterator_next(&filter, &it); i++) {
 		eword_t word = objects->words[i] & filter;
+		size_t pos = (i * BITS_IN_EWORD);
+
+		if (!word)
+			continue;
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 			struct object_id oid;
@@ -648,9 +657,6 @@ static void show_objects_for_type(
 
 			offset += ewah_bit_ctz64(word >> offset);
 
-			if (pos + offset < bitmap_git->reuse_objects)
-				continue;
-
 			entry = &bitmap_git->pack->revindex[pos + offset];
 			nth_packed_object_oid(&oid, bitmap_git->pack, entry->nr);
 
@@ -659,9 +665,6 @@ static void show_objects_for_type(
 
 			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, entry->offset);
 		}
-
-		pos += BITS_IN_EWORD;
-		i++;
 	}
 }
 
@@ -770,66 +773,139 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
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
+	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
+		i++;
 
-		reuse_objects += BITS_IN_EWORD;
-	}
+	/* Don't mark objects not in the packfile */
+	if (i > bitmap_git->pack->num_objects / BITS_IN_EWORD)
+		i = bitmap_git->pack->num_objects / BITS_IN_EWORD;
 
-#ifdef GIT_BITMAP_DEBUG
-	{
-		const unsigned char *sha1;
-		struct revindex_entry *entry;
+	reuse = bitmap_new2(i);
+	memset(reuse->words, 0xFF, i * sizeof(eword_t));
 
-		entry = &bitmap_git->reverse_index->revindex[reuse_objects];
-		sha1 = nth_packed_object_sha1(bitmap_git->pack, entry->nr);
+	for (; i < result->word_alloc; ++i) {
+		eword_t word = result->words[i];
+		size_t pos = (i * BITS_IN_EWORD);
 
-		fprintf(stderr, "Failed to reuse at %d (%016llx)\n",
-			reuse_objects, result->words[i]);
-		fprintf(stderr, " %s\n", hash_to_hex(sha1));
+		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
+			if ((word >> offset) == 0)
+				break;
+
+			offset += ewah_bit_ctz64(word >> offset);
+			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
+		}
 	}
-#endif
 
-	if (!reuse_objects)
-		return -1;
+	unuse_pack(&w_curs);
 
-	if (reuse_objects >= bitmap_git->pack->num_objects) {
-		bitmap_git->reuse_objects = *entries = bitmap_git->pack->num_objects;
-		*up_to = -1; /* reuse the full pack */
-		*packfile = bitmap_git->pack;
-		return 0;
+	*entries = bitmap_popcount(reuse);
+	if (!*entries) {
+		bitmap_free(reuse);
+		return -1;
 	}
 
-	reuse_threshold = bitmap_popcount(bitmap_git->result) * REUSE_PERCENT;
+	/*
+	 * Drop any reused objects from the result, since they will not
+	 * need to be handled separately.
+	 */
+	bitmap_and_not(result, reuse);
+	*packfile_out = bitmap_git->pack;
+	*reuse_out = reuse;
+	return 0;
+}
 
-	if (reuse_objects < reuse_threshold)
-		return -1;
+int bitmap_walk_contains(struct bitmap_index *bitmap_git,
+                        struct bitmap *bitmap, const struct object_id *oid)
+{
+       int idx;
 
-	bitmap_git->reuse_objects = *entries = reuse_objects;
-	*up_to = bitmap_git->pack->revindex[reuse_objects].offset;
-	*packfile = bitmap_git->pack;
+       if (!bitmap)
+               return 0;
 
-	return 0;
+       idx = bitmap_position(bitmap_git, oid);
+       return idx >= 0 && bitmap_get(bitmap, idx);
 }
 
 void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 00de3ec8e4..7af7335f2e 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -3,6 +3,7 @@
 
 #include "ewah/ewok.h"
 #include "khash.h"
+#include "pack.h"
 #include "pack-objects.h"
 
 struct commit;
@@ -49,10 +50,13 @@ void test_bitmap_walk(struct rev_info *revs);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 				       struct packed_git **packfile,
-				       uint32_t *entries, off_t *up_to);
+				       uint32_t *entries,
+				       struct bitmap **bitmap);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
+int bitmap_walk_contains(struct bitmap_index *,
+			 struct bitmap *bitmap, const struct object_id *oid);
 
 /*
  * After a traversal has been performed by prepare_bitmap_walk(), this can be
diff --git a/packfile.c b/packfile.c
index fc43a6c52c..5a6e8d54f1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1191,11 +1191,11 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 	return NULL;
 }
 
-static off_t get_delta_base(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t *curpos,
-				    enum object_type type,
-				    off_t delta_obj_offset)
+off_t get_delta_base(struct packed_git *p,
+		     struct pack_window **w_curs,
+		     off_t *curpos,
+		     enum object_type type,
+		     off_t delta_obj_offset)
 {
 	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
 	off_t base_offset;
diff --git a/packfile.h b/packfile.h
index 3e98910bdd..8049202f4c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -151,6 +151,9 @@ void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
+		     off_t *curpos, enum object_type type,
+		     off_t delta_obj_offset);
 
 void release_pack_memory(size_t);
 
-- 
2.22.0.1052.g5dbc04cce0

