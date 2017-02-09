Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67DF1FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 01:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbdBIBUg (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 20:20:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:51961 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbdBIBUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 20:20:22 -0500
Received: (qmail 13422 invoked by uid 109); 9 Feb 2017 01:12:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 01:12:44 +0000
Received: (qmail 32473 invoked by uid 111); 9 Feb 2017 01:12:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:12:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 20:12:41 -0500
Date:   Wed, 8 Feb 2017 20:12:41 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
Message-ID: <20170209011241.vfiup56gwrvlxm2k@sigill.intra.peff.net>
References: <1486515795.1938.45.camel@novalis.org>
 <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
 <1486542299.1938.47.camel@novalis.org>
 <CACsJy8C4DO-GYREUhED3YU_WetoTZaB3MUq1kGfRjA3e-FOLYQ@mail.gmail.com>
 <xmqqtw84wpag.fsf@gitster.mtv.corp.google.com>
 <1486580742.1938.52.camel@novalis.org>
 <20170208190858.rjoqehbhyizlwg5q@sigill.intra.peff.net>
 <1486592043.1938.82.camel@novalis.org>
 <20170208230057.hking37uuynf4cgd@sigill.intra.peff.net>
 <xmqqbmuctdwu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmuctdwu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2017 at 04:18:25PM -0800, Junio C Hamano wrote:

> > We wrote something similar at GitHub, too, but we never ended up using
> > it in production. We found that with a sane scheduler, it's not too big
> > a deal to just do maintenance once in a while.
> 
> Thanks again for this.  I've also been wondering about how effective
> a "concatenate packs without paying reachability penalty" would be.

For the sake of posterity, I'll include our patch at the end (sorry, not
chunked into nice readable commits; that never existed in the first
place).

> > I'm still not sure if it's worth making the fatal/non-fatal distinction.
> > Doing so is perhaps safer, but it does mean that somebody has to decide
> > which errors are important enough to block a retry totally, and which
> > are not. In theory, it would be safe to always _try_ and then the gc
> > process can decide when something is broken and abort. And all you've
> > wasted is some processing power each day.
> 
> Yup, and somebody or something need to monitor so that repeated
> failures can be dealt with.

Yes. I think that part is probably outside the scope of Git. But if
auto-gc leaves gc.log lying around, it would be easy to visit each repo
and collect the various failures.

-- >8 --
This is the "pack-fast" patch, for reference. It applies on v2.6.5,
though I had to do some wiggling due to a few of our other custom
patches, so it's possible I introduced new bugs. It compiles, but I
didn't actually re-test the result.  I _think_ the original at least
generated valid packs in all cases.

So I would certainly not recommend anybody run this. It's just a
possible base to work off of if anybody's interested in the topic. I
haven't looked at David's combine-packs at all to see if it is any less
gross. :)

---
 Makefile            |   1 +
 builtin.h           |   1 +
 builtin/pack-fast.c | 618 +++++++++++++++++++++++++++++++++++
 cache.h             |   5 +
 git.c               |   1 +
 pack-bitmap-write.c | 167 +++++++++-
 pack-bitmap.c       |   2 +-
 pack-bitmap.h       |   8 +
 sha1_file.c         |   4 +-
 9 files changed, 792 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 37e2d9e18..524b185ec 100644
--- a/Makefile
+++ b/Makefile
@@ -887,6 +887,7 @@ BUILTIN_OBJS += builtin/mv.o
 BUILTIN_OBJS += builtin/name-rev.o
 BUILTIN_OBJS += builtin/notes.o
 BUILTIN_OBJS += builtin/pack-objects.o
+BUILTIN_OBJS += builtin/pack-fast.o
 BUILTIN_OBJS += builtin/pack-redundant.o
 BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
diff --git a/builtin.h b/builtin.h
index 79aaf0afe..df4e4d668 100644
--- a/builtin.h
+++ b/builtin.h
@@ -95,6 +95,7 @@ extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_notes(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_pack_fast(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
diff --git a/builtin/pack-fast.c b/builtin/pack-fast.c
new file mode 100644
index 000000000..ad9f5e5f1
--- /dev/null
+++ b/builtin/pack-fast.c
@@ -0,0 +1,618 @@
+#include "builtin.h"
+#include "cache.h"
+#include "pack.h"
+#include "progress.h"
+#include "csum-file.h"
+#include "sha1-lookup.h"
+#include "parse-options.h"
+#include "tempfile.h"
+#include "pack-bitmap.h"
+#include "pack-revindex.h"
+
+static const char *pack_usage[] = {
+	N_("git pack-fast --quiet [options...] [base-name]"),
+	NULL
+};
+
+struct packwriter {
+	struct tempfile *tmp;
+	off_t total;
+	int fd;
+	uint32_t crc32;
+	unsigned do_crc;
+};
+
+static void packwriter_crc32_start(struct packwriter *w)
+{
+	w->crc32 = crc32(0, NULL, 0);
+	w->do_crc = 1;
+}
+
+static uint32_t packwriter_crc32_end(struct packwriter *w)
+{
+	w->do_crc = 0;
+	return w->crc32;
+}
+
+static void packwriter_write(struct packwriter *w, const void *buf, unsigned int count)
+{
+	if (w->do_crc)
+		w->crc32 = crc32(w->crc32, buf, count);
+	write_or_die(w->fd, buf, count);
+	w->total += count;
+}
+
+static off_t packwriter_total(struct packwriter *w)
+{
+	return w->total;
+}
+
+static void packwriter_init(struct packwriter *w)
+{
+	char tmpname[PATH_MAX];
+
+	w->fd = odb_mkstemp(tmpname, sizeof(tmpname), "pack/tmp_pack_XXXXXX");
+	w->total = 0;
+	w->do_crc = 0;
+	w->tmp = xcalloc(1, sizeof(*w->tmp));
+
+	register_tempfile(w->tmp, tmpname);
+}
+
+
+static int progress = 1;
+static struct progress *progress_state;
+static struct pack_idx_option pack_idx_opts;
+static const char *base_name = "pack-fast";
+static int skip_largest;
+static int write_bitmap_index = 1;
+
+static struct packed_git **all_packfiles;
+static unsigned int all_packfiles_nr;
+
+static struct pack_idx_entry **written_list;
+static unsigned int written_nr;
+
+struct write_slab {
+	struct write_slab *next;
+	unsigned int nr;
+
+	struct write_slab_entry {
+		struct pack_idx_entry idx;
+		enum object_type real_type;
+	} entries[];
+};
+
+static struct write_slab *written_slab_root;
+static struct write_slab *written_slab_current;
+
+static void add_to_write_list(
+	const unsigned char *sha1, off_t offset, uint32_t crc32,
+	enum object_type real_type)
+{
+	struct write_slab *slab = written_slab_current;
+	struct write_slab_entry *entry = &(slab->entries[slab->nr++]);
+
+	entry->real_type = real_type;
+	entry->idx.offset = offset;
+	entry->idx.crc32 = crc32;
+	hashcpy(entry->idx.sha1, sha1);
+}
+
+static void preallocate_write_slab(unsigned int num_entries)
+{
+	struct write_slab *slab = xmalloc(
+		sizeof(struct write_slab) +
+		num_entries * sizeof(struct write_slab_entry));
+
+	slab->next = NULL;
+	slab->nr = 0;
+
+	if (!written_slab_current) {
+		written_slab_current = slab;
+		written_slab_root = slab;
+	} else {
+		written_slab_current->next = slab;
+		written_slab_current = slab;
+	}
+}
+
+static struct skipped_object {
+	off_t skipped_offset;
+	off_t real_offset;
+} *skipped_list;
+static unsigned int skipped_nr;
+static unsigned int skipped_alloc;
+
+static void add_to_skipped_list(off_t skipped_offset, off_t real_offset)
+{
+	if (skipped_nr >= skipped_alloc) {
+		skipped_alloc = (skipped_alloc + 32) * 2;
+		REALLOC_ARRAY(skipped_list, skipped_alloc);
+	}
+
+	skipped_list[skipped_nr].skipped_offset = skipped_offset;
+	skipped_list[skipped_nr].real_offset = real_offset;
+	skipped_nr++;
+}
+
+static off_t find_real_offset_for_base(off_t skipped_offset)
+{
+	int lo = 0, hi = skipped_nr;
+	while (lo < hi) {
+		int mi = lo + ((hi - lo) / 2);
+		if (skipped_offset == skipped_list[mi].skipped_offset)
+			return skipped_list[mi].real_offset;
+		if (skipped_offset < skipped_list[mi].skipped_offset)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+
+	return 0;
+}
+
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
+{
+	if (reused_chunks_nr && reused_chunks[reused_chunks_nr-1].offset == offset)
+		return;
+
+	ALLOC_GROW(reused_chunks, reused_chunks_nr + 1,
+		   reused_chunks_alloc);
+	reused_chunks[reused_chunks_nr].start = where;
+	reused_chunks[reused_chunks_nr].offset = offset;
+	reused_chunks_nr++;
+}
+
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
+
+	/*
+	 * The first chunk starts at zero, so we can't have gone below
+	 * there.
+	 */
+	assert(lo);
+	return reused_chunks[lo-1].offset;
+}
+
+static uint32_t nth_packed_object_crc32(const struct packed_git *p, uint32_t nr)
+{
+	const uint32_t *index_crc = p->index_data;
+	index_crc += 2 + 256 + p->num_objects * (20/4) + nr;
+	return ntohl(*index_crc);
+}
+
+static void load_index_or_die(struct packed_git *p)
+{
+	if (open_pack_index(p) < 0)
+		die("failed to open index for '%s'", p->pack_name);
+
+	if (p->index_version != 2)
+		die("unsupported index version %d (fast-pack requires index v2)\n",
+			p->index_version);
+}
+
+static int sort_pack(const void *a_, const void *b_)
+{
+	struct packed_git *a = *((struct packed_git **)a_);
+	struct packed_git *b = *((struct packed_git **)b_);
+
+	if (a->mtime > b->mtime)
+		return 1;
+	else if (a->mtime == b->mtime)
+		return 0;
+	return -1;
+}
+
+static void find_packfiles(void)
+{
+	struct packed_git *p;
+	unsigned int n;
+
+	prepare_packed_git();
+
+	for (n = 0, p = packed_git; p; p = p->next) {
+		if (p->pack_local)
+			n++;
+	}
+
+	all_packfiles = xcalloc(n, sizeof(struct packed_git *));
+	all_packfiles_nr = n;
+
+	for (n = 0, p = packed_git; p; p = p->next) {
+		if (p->pack_local)
+			all_packfiles[n++] = p;
+	}
+
+	for (n = 1; n < all_packfiles_nr; ++n) {
+		if (all_packfiles[n]->pack_size > all_packfiles[0]->pack_size) {
+			struct packed_git *tmp = all_packfiles[0];
+			all_packfiles[0] = all_packfiles[n];
+			all_packfiles[n] = tmp;
+		}
+	}
+
+	qsort(all_packfiles + 1, all_packfiles_nr - 1, sizeof(struct packed_git *), sort_pack);
+}
+
+static int sha1_index__cmp(const void *a_, const void *b_)
+{
+	struct pack_idx_entry *a = *((struct pack_idx_entry **)a_);
+	struct pack_idx_entry *b = *((struct pack_idx_entry **)b_);
+	return hashcmp(a->sha1, b->sha1);
+}
+
+static const unsigned char *sha1_index__access(size_t pos, void *table)
+{
+	struct pack_idx_entry **index = table;
+	return index[pos]->sha1;
+}
+
+static void sha1_index_update(void)
+{
+	const unsigned int left_nr = written_nr;
+	const unsigned int right_nr = written_slab_current->nr;
+	const unsigned int total_nr = left_nr + right_nr;
+
+	struct pack_idx_entry **left = written_list;
+	struct pack_idx_entry **right = xmalloc(right_nr * sizeof(struct pack_idx_entry *));
+	struct pack_idx_entry **result = xmalloc(total_nr * sizeof(struct pack_idx_entry *));
+
+	unsigned int i, j, n;
+
+	for (j = 0; j < right_nr; ++j)
+		right[j] = (struct pack_idx_entry *)(&written_slab_current->entries[j]);
+
+	qsort(right, right_nr, sizeof(struct pack_idx_entry  *), sha1_index__cmp);
+
+	for (i = j = n = 0; i < left_nr && j < right_nr; ++n) {
+		struct pack_idx_entry *a = left[i];
+		struct pack_idx_entry *b = right[j];
+
+		if (hashcmp(a->sha1, b->sha1) <= 0) {
+			result[n] = a;
+			i++;
+		} else {
+			result[n] = b;
+			j++;
+		}
+	}
+
+	for (; i < left_nr; ++n, ++i)
+		result[n] = left[i];
+
+	for (; j < right_nr; ++n, ++j)
+		result[n] = right[j];
+
+	free(written_list);
+	free(right);
+
+	written_list = result;
+	written_nr = total_nr;
+}
+
+static off_t sha1_index_find_offset(const unsigned char *sha1)
+{
+	int pos = sha1_pos(sha1, written_list, written_nr, sha1_index__access);
+	return (pos < 0) ? 0 : written_list[pos]->offset;
+}
+
+static void copy_pack_data(
+		struct packwriter *w,
+		struct packed_git *p,
+		struct pack_window **w_curs,
+		off_t offset,
+		off_t len)
+{
+	unsigned char *in;
+	unsigned long avail;
+
+	while (len) {
+		in = use_pack(p, w_curs, offset, &avail);
+		if (avail > len)
+			avail = (unsigned long)len;
+		packwriter_write(w, in, avail);
+		offset += avail;
+		len -= avail;
+	}
+}
+
+extern enum object_type packed_to_object_type(
+	struct packed_git *p, off_t obj_offset, enum object_type type,
+	struct pack_window **w_curs, off_t curpos);
+
+static int append_object_1(
+	struct revindex_entry *reventry,
+	struct packwriter *w,
+	struct packed_git *pack,
+	struct pack_window **w_curs,
+	enum object_type *real_type)
+{
+	const off_t offset = reventry[0].offset;
+	const off_t next = reventry[1].offset;
+
+	off_t cur;
+	enum object_type type;
+	unsigned long size;
+
+	record_reused_object(offset, offset - packwriter_total(w));
+
+	cur = offset;
+	type = unpack_object_header(pack, w_curs, &cur, &size);
+	assert(type >= 0);
+
+	if (write_bitmap_index)
+		*real_type = packed_to_object_type(pack, offset, type, w_curs, cur);
+
+	if (type == OBJ_OFS_DELTA) {
+		const off_t base_offset = get_delta_base(pack, w_curs, &cur, type, offset);
+		const off_t real_base_offset = find_real_offset_for_base(base_offset);
+		off_t fixed_offset = 0;
+
+		assert(base_offset != 0);
+
+		if (real_base_offset) {
+			fixed_offset = packwriter_total(w) - real_base_offset;
+		} else {
+			off_t fixup = find_reused_offset(offset) - find_reused_offset(base_offset);
+			if (fixup)
+				fixed_offset = offset - base_offset - fixup;
+		}
+
+		if (fixed_offset) {
+			unsigned char header[10], ofs_header[10];
+			unsigned i, len, ofs_len;
+
+			assert(fixed_offset > 0);
+			len = encode_in_pack_object_header(OBJ_OFS_DELTA, size, header);
+
+			i = sizeof(ofs_header) - 1;
+			ofs_header[i] = fixed_offset & 127;
+			while (fixed_offset >>= 7)
+				ofs_header[--i] = 128 | (--fixed_offset & 127);
+
+			ofs_len = sizeof(ofs_header) - i;
+
+			packwriter_write(w, header, len);
+			packwriter_write(w, ofs_header + sizeof(ofs_header) - ofs_len, ofs_len);
+			copy_pack_data(w, pack, w_curs, cur, next - cur);
+			return 1;
+		}
+
+		/* ...otherwise we have no fixup, and can write it verbatim */
+	}
+
+	copy_pack_data(w, pack, w_curs, offset, next - offset);
+	return 0;
+}
+
+static int copy_packfile(int from, struct packwriter *w)
+{
+	unsigned char buffer[8192];
+	struct stat st;
+	ssize_t to_read;
+
+	if (from < 0 || fstat(from, &st))
+		return -1;
+
+	posix_fadvise(from, 0, st.st_size, POSIX_FADV_SEQUENTIAL);
+	to_read = st.st_size - 20;
+
+	if (progress)
+		fprintf(stderr, "Copying main packfile...");
+
+	while (to_read) {
+		ssize_t r, cap = sizeof(buffer);
+
+		if (cap > to_read)
+			cap = to_read;
+
+		r = xread(from, buffer, cap);
+		if (r < 0)
+			return -1;
+
+		packwriter_write(w, buffer, r);
+		to_read -= r;
+	}
+
+	if (progress)
+		fprintf(stderr, " done.\n");
+	assert(to_read == 0);
+	return 0;
+}
+
+static void write_initial_packfile(struct packed_git *p, struct packwriter *w)
+{
+	unsigned int n;
+	int source_fd = git_open_noatime(p->pack_name);
+
+	if (copy_packfile(source_fd, w) < 0)
+		die_errno("failed to copy '%s'", p->pack_name);
+	close(source_fd);
+
+	load_index_or_die(p);
+	preallocate_write_slab(p->num_objects);
+
+	if (progress)
+		progress_state = start_progress("Indexing main packfile", p->num_objects);
+
+	for (n = 0; n < p->num_objects; ++n) {
+		const unsigned char *sha1 = nth_packed_object_sha1(p, n);
+		const off_t offset = nth_packed_object_offset(p, n);
+		const uint32_t crc32 = nth_packed_object_crc32(p, n);
+		add_to_write_list(sha1, offset, crc32, OBJ_BAD);
+		display_progress(progress_state, n + 1);
+	}
+
+	stop_progress(&progress_state);
+	close_pack_index(p);
+
+	written_list = xmalloc(p->num_objects * sizeof(struct packed_git *));
+	written_nr = p->num_objects;
+	for (n = 0; n < written_nr; ++n)
+		written_list[n] = (struct pack_idx_entry *)(&written_slab_current->entries[n]);
+}
+
+static void append_packfile(struct packed_git *p, struct packwriter *w)
+{
+	struct pack_window *w_curs = NULL;
+	struct pack_revindex *revidx;
+
+	unsigned int n;
+
+	load_index_or_die(p);
+	preallocate_write_slab(p->num_objects);
+	revidx = revindex_for_pack(p);
+
+	if (progress)
+		progress_state = start_progress("Appending packfile", p->num_objects);
+
+	for (n = 0; n < p->num_objects; ++n) {
+		struct revindex_entry *reventry = &revidx->revindex[n];
+		const unsigned char *sha1 = nth_packed_object_sha1(p, reventry[0].nr);
+		const off_t offset_in_pack = sha1_index_find_offset(sha1);
+
+		if (!offset_in_pack) {
+			const off_t offset = packwriter_total(w);
+
+			enum object_type real_type = OBJ_BAD;
+			uint32_t crc32;
+			int rewrite_header;
+
+			packwriter_crc32_start(w);
+			rewrite_header = append_object_1(reventry, w, p, &w_curs, &real_type);
+			crc32 = packwriter_crc32_end(w);
+
+			if (!rewrite_header && crc32 != nth_packed_object_crc32(p, reventry[0].nr))
+				die("crc32 check failed for %s", sha1_to_hex(sha1));
+
+			add_to_write_list(sha1, offset, crc32, real_type);
+		} else {
+			add_to_skipped_list(reventry[0].offset, offset_in_pack);
+		}
+
+		display_progress(progress_state, n + 1);
+	}
+
+	stop_progress(&progress_state);
+	unuse_pack(&w_curs);
+	close_pack_windows(p);
+	close_pack_index(p);
+
+	sha1_index_update();
+	skipped_nr = 0;
+	reused_chunks_nr = 0;
+}
+
+static void write_packs(void)
+{
+	struct packwriter w;
+	unsigned int i;
+
+	packwriter_init(&w);
+	write_initial_packfile(all_packfiles[0], &w);
+
+	for (i = 1; i < all_packfiles_nr; ++i)
+		append_packfile(all_packfiles[i], &w);
+
+	/* finalize pack */
+	{
+		unsigned char sha1[20];
+		struct strbuf tmpname = STRBUF_INIT;
+
+		fixup_pack_header_footer(w.fd, sha1, w.tmp->filename.buf, written_nr, NULL, 0);
+		close(w.fd);
+
+		strbuf_addf(&tmpname, "%s-", base_name);
+
+		finish_tmp_packfile(&tmpname, w.tmp->filename.buf,
+				written_list, written_nr,
+				&pack_idx_opts, sha1);
+
+		if (write_bitmap_index) {
+			strbuf_addf(&tmpname, "%s.bitmap", sha1_to_hex(sha1));
+			bitmap_rewrite_existing(
+				all_packfiles[0],
+				written_list, written_nr,
+				packwriter_total(&w),
+				sha1, tmpname.buf);
+		}
+
+		strbuf_release(&tmpname);
+		puts(sha1_to_hex(sha1));
+	}
+}
+
+void pack_fast_grow_typemaps(struct packed_git *p, struct ewah_bitmap **typemaps)
+{
+	uint32_t n;
+	size_t pos = p->num_objects;
+	struct write_slab *slab = written_slab_root;
+
+	assert(slab->nr == p->num_objects);
+	assert(slab->next);
+	slab = slab->next;
+
+	while (slab) {
+		for (n = 0; n < slab->nr; ++n) {
+			const enum object_type real_type = slab->entries[n].real_type;
+			assert(real_type >= OBJ_COMMIT && real_type <= OBJ_TAG);
+			ewah_set(typemaps[real_type - 1], pos++);
+		}
+		slab = slab->next;
+	}
+}
+
+int cmd_pack_fast(int argc, const char **argv, const char *prefix)
+{
+	struct option pack_fast_options[] = {
+		OPT_SET_INT('q', "quiet", &progress,
+			    N_("do not show progress meter"), 0),
+		OPT_SET_INT(0, "progress", &progress,
+			    N_("show progress meter"), 1),
+		OPT_BOOL(0, "skip-largest", &skip_largest,
+			 N_("do not pack the largest packfile in the repository")),
+		OPT_END(),
+	};
+
+	reset_pack_idx_option(&pack_idx_opts);
+	progress = isatty(2);
+	argc = parse_options(argc, argv, prefix, pack_fast_options,
+			     pack_usage, 0);
+
+	if (argc) {
+		base_name = argv[0];
+		argc--;
+	}
+
+	find_packfiles();
+	write_packs();
+	return 0;
+}
diff --git a/cache.h b/cache.h
index 6f53962bf..1a13961bd 100644
--- a/cache.h
+++ b/cache.h
@@ -1336,6 +1336,11 @@ extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsign
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+extern off_t get_delta_base(struct packed_git *p,
+			    struct pack_window **w_curs,
+			    off_t *curpos,
+			    enum object_type type,
+			    off_t delta_obj_offset);
 
 /*
  * Iterate over the files in the loose-object parts of the object
diff --git a/git.c b/git.c
index 40f9df089..d81bd4469 100644
--- a/git.c
+++ b/git.c
@@ -440,6 +440,7 @@ static struct cmd_struct commands[] = {
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+	{ "pack-fast", cmd_pack_fast, RUN_SETUP },
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	{ "patch-id", cmd_patch_id },
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c05d1386a..449715f02 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -505,23 +505,39 @@ void bitmap_writer_set_checksum(unsigned char *sha1)
 	hashcpy(writer.pack_checksum, sha1);
 }
 
+static struct sha1file *bitmap_file_new(char *tmp_file, size_t len)
+{
+	int fd = odb_mkstemp(tmp_file, len, "pack/tmp_bitmap_XXXXXX");
+
+	if (fd < 0)
+		die_errno("unable to create '%s'", tmp_file);
+
+	return sha1fd(fd, tmp_file);
+}
+
+static void bitmap_file_close(struct sha1file *f, const char *tmp_file, const char *dest)
+{
+	sha1close(f, NULL, CSUM_FSYNC);
+
+	if (adjust_shared_perm(tmp_file))
+		die_errno("unable to make temporary bitmap file readable");
+
+	if (rename(tmp_file, dest))
+		die_errno("unable to rename temporary bitmap file to '%s'", dest);
+}
+
 void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint32_t index_nr,
 			  const char *filename,
 			  uint16_t options)
 {
-	static char tmp_file[PATH_MAX];
 	static uint16_t default_version = 1;
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
+	char tmp_file[PATH_MAX];
 	struct sha1file *f;
-
 	struct bitmap_disk_header header;
 
-	int fd = odb_mkstemp(tmp_file, sizeof(tmp_file), "pack/tmp_bitmap_XXXXXX");
-
-	if (fd < 0)
-		die_errno("unable to create '%s'", tmp_file);
-	f = sha1fd(fd, tmp_file);
+	f = bitmap_file_new(tmp_file, sizeof(tmp_file));
 
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
 	header.version = htons(default_version);
@@ -539,11 +555,138 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
 
-	sha1close(f, NULL, CSUM_FSYNC);
+	bitmap_file_close(f, tmp_file, filename);
+}
 
-	if (adjust_shared_perm(tmp_file))
-		die_errno("unable to make temporary bitmap file readable");
+static void *try_load_bitmap(struct packed_git *p, size_t *_size_out)
+{
+	void *reused_bitmap;
+	size_t reused_bitmap_size;
+
+	int fd;
+	struct stat st;
+	char *idx_name;
+
+	idx_name = pack_bitmap_filename(p);
+	fd = git_open_noatime(idx_name);
+	free(idx_name);
+
+	if (fd < 0)
+		return NULL;
+
+	if (fstat(fd, &st)) {
+		close(fd);
+		return NULL;
+	}
+
+	reused_bitmap_size = xsize_t(st.st_size);
+	reused_bitmap = xmmap(NULL, reused_bitmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	*_size_out = reused_bitmap_size;
+	return reused_bitmap;
+}
+
+extern void pack_fast_grow_typemaps(struct packed_git *p, struct ewah_bitmap **typemaps);
+
+static size_t rewrite_type_maps(struct sha1file *f,
+	struct packed_git *p, unsigned char *original_map, size_t original_size, size_t pos)
+{
+	struct ewah_bitmap *typemaps[4];
+	int r, i;
+
+	for (i = 0; i < 4; ++i) {
+		typemaps[i] = ewah_pool_new();
+		r = ewah_read_mmap(typemaps[i], original_map + pos, original_size - pos);
+		if (r < 0)
+			die("failed to read bitmap index");
+		pos += r;
+	}
+
+	pack_fast_grow_typemaps(p, typemaps);
+
+	for (i = 0; i < 4; ++i) {
+		dump_bitmap(f, typemaps[i]);
+		ewah_pool_free(typemaps[i]);
+	}
+
+	return pos;
+}
+
+static size_t rewrite_bitmaps(struct sha1file *f,
+	struct packed_git *p, unsigned char *original_map, size_t original_size, size_t pos,
+	uint32_t entry_count, struct pack_idx_entry **index, uint32_t index_nr)
+{
+	uint32_t i;
+
+	for (i = 0; i < entry_count; ++i) {
+		const unsigned char *sha1;
+		uint32_t src_idx, src_buffer_len, total_len;
+		int new_idx;
+
+		src_idx = get_be32(original_map + pos);
+		pos += 4;
+
+		sha1 = nth_packed_object_sha1(p, src_idx);
+		new_idx = sha1_pos(sha1, index, index_nr, sha1_access);
+		sha1write_be32(f, (uint32_t)new_idx);
+
+		src_buffer_len = get_be32(original_map + pos + 2 + 4);
+		total_len = (3 * 4) + (src_buffer_len * 8);
+
+		sha1write(f, original_map + pos, 2 + total_len);
+		pos += 2 + total_len;
+
+		if (pos > original_size)
+			die("unexpected end of file");
+	}
+
+	return pos;
+}
+
+void bitmap_rewrite_existing(
+	struct packed_git *p,
+	struct pack_idx_entry **index,
+	uint32_t index_nr,
+	off_t pack_offset,
+	const unsigned char *pack_sha1,
+	const char *filename)
+{
+	char tmp_file[PATH_MAX];
+	struct sha1file *f;
+
+	unsigned char *original_map;
+	size_t original_size, pos = 0;
+	struct bitmap_disk_header header;
+
+	original_map = try_load_bitmap(p, &original_size);
+	if (!original_map || original_size < sizeof(header) + 20)
+		return;
+
+	memcpy(&header, original_map, sizeof(header));
+	hashcpy(header.checksum, pack_sha1);
+
+	if (memcmp(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
+		die("existing bitmap for '%s' is corrupted", p->pack_name);
+
+	if (ntohs(header.version) != 1)
+		die("existing bitmap for '%s' has an unsupported version", p->pack_name);
+
+	f = bitmap_file_new(tmp_file, sizeof(tmp_file));
+
+	sha1write(f, &header, sizeof(header));
+	pos = sizeof(header);
+	pos = rewrite_type_maps(f, p, original_map, original_size, pos);
+	pos = rewrite_bitmaps(f, p, original_map, original_size, pos,
+			ntohl(header.entry_count), index, index_nr);
+
+	if (ntohs(header.options) & BITMAP_OPT_HASH_CACHE) {
+		uint32_t i, zero = 0;
+		sha1write(f, original_map + pos, p->num_objects * 4);
+		for (i = p->num_objects; i < index_nr; ++i)
+			sha1write(f, &zero, 4);
+		pos += (p->num_objects * 4);
+	}
 
-	if (rename(tmp_file, filename))
-		die_errno("unable to rename temporary bitmap file to '%s'", filename);
+	bitmap_file_close(f, tmp_file, filename);
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 637770af8..ee361fa6a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -250,7 +250,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 	return 0;
 }
 
-static char *pack_bitmap_filename(struct packed_git *p)
+char *pack_bitmap_filename(struct packed_git *p)
 {
 	char *idx_name;
 	int len;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 0adcef77b..398523dbb 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -34,6 +34,7 @@ typedef int (*show_reachable_fn)(
 	struct packed_git *found_pack,
 	off_t found_offset);
 
+char *pack_bitmap_filename(struct packed_git *p);
 int prepare_bitmap_git(void);
 void count_bitmap_commit_list(uint32_t *commits, uint32_t *trees, uint32_t *blobs, uint32_t *tags);
 void traverse_bitmap_commit_list(show_reachable_fn show_reachable);
@@ -53,5 +54,12 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint32_t index_nr,
 			  const char *filename,
 			  uint16_t options);
+void bitmap_rewrite_existing(
+	struct packed_git *p,
+	struct pack_idx_entry **index,
+	uint32_t index_nr,
+	off_t pack_offset,
+	const unsigned char *pack_sha1,
+	const char *filename);
 
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 72289696d..bcd447f16 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1821,7 +1821,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
 }
 
-static off_t get_delta_base(struct packed_git *p,
+off_t get_delta_base(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t *curpos,
 				    enum object_type type,
@@ -1936,7 +1936,7 @@ static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
 
 #define POI_STACK_PREALLOC 64
 
-static enum object_type packed_to_object_type(struct packed_git *p,
+enum object_type packed_to_object_type(struct packed_git *p,
 					      off_t obj_offset,
 					      enum object_type type,
 					      struct pack_window **w_curs,
