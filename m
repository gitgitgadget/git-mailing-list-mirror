From: Jeff King <peff@peff.net>
Subject: [PATCH v3 13/21] pack-objects: implement bitmap writing
Date: Thu, 14 Nov 2013 07:45:45 -0500
Message-ID: <20131114124544.GM10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:45:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwIx-0001EA-MI
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145Ab3KNMps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:45:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:39138 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752902Ab3KNMpq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:45:46 -0500
Received: (qmail 11614 invoked by uid 102); 14 Nov 2013 12:45:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:45:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:45:45 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237837>

From: Vicent Marti <tanoku@gmail.com>

This commit extends more the functionality of `pack-objects` by allowing
it to write out a `.bitmap` index next to any written packs, together
with the `.idx` index that currently gets written.

If bitmap writing is enabled for a given repository (either by calling
`pack-objects` with the `--write-bitmap-index` flag or by having
`pack.writebitmaps` set to `true` in the config) and pack-objects is
writing a packfile that would normally be indexed (i.e. not piping to
stdout), we will attempt to write the corresponding bitmap index for the
packfile.

Bitmap index writing happens after the packfile and its index has been
successfully written to disk (`finish_tmp_packfile`). The process is
performed in several steps:

    1. `bitmap_writer_set_checksum`: this call stores the partial
       checksum for the packfile being written; the checksum will be
       written in the resulting bitmap index to verify its integrity

    2. `bitmap_writer_build_type_index`: this call uses the array of
       `struct object_entry` that has just been sorted when writing out
       the actual packfile index to disk to generate 4 type-index bitmaps
       (one for each object type).

       These bitmaps have their nth bit set if the given object is of
       the bitmap's type. E.g. the nth bit of the Commits bitmap will be
       1 if the nth object in the packfile index is a commit.

       This is a very cheap operation because the bitmap writing code has
       access to the metadata stored in the `struct object_entry` array,
       and hence the real type for each object in the packfile.

    3. `bitmap_writer_reuse_bitmaps`: if there exists an existing bitmap
       index for one of the packfiles we're trying to repack, this call
       will efficiently rebuild the existing bitmaps so they can be
       reused on the new index. All the existing bitmaps will be stored
       in a `reuse` hash table, and the commit selection phase will
       prioritize these when selecting, as they can be written directly
       to the new index without having to perform a revision walk to
       fill the bitmap. This can greatly speed up the repack of a
       repository that already has bitmaps.

    4. `bitmap_writer_select_commits`: if bitmap writing is enabled for
       a given `pack-objects` run, the sequence of commits generated
       during the Counting Objects phase will be stored in an array.

       We then use that array to build up the list of selected commits.
       Writing a bitmap in the index for each object in the repository
       would be cost-prohibitive, so we use a simple heuristic to pick
       the commits that will be indexed with bitmaps.

       The current heuristics are a simplified version of JGit's
       original implementation. We select a higher density of commits
       depending on their age: the 100 most recent commits are always
       selected, after that we pick 1 commit of each 100, and the gap
       increases as the commits grow older. On top of that, we make sure
       that every single branch that has not been merged (all the tips
       that would be required from a clone) gets their own bitmap, and
       when selecting commits between a gap, we tend to prioritize the
       commit with the most parents.

       Do note that there is no right/wrong way to perform commit
       selection; different selection algorithms will result in
       different commits being selected, but there's no such thing as
       "missing a commit". The bitmap walker algorithm implemented in
       `prepare_bitmap_walk` is able to adapt to missing bitmaps by
       performing manual walks that complete the bitmap: the ideal
       selection algorithm, however, would select the commits that are
       more likely to be used as roots for a walk in the future (e.g.
       the tips of each branch, and so on) to ensure a bitmap for them
       is always available.

    5. `bitmap_writer_build`: this is the computationally expensive part
       of bitmap generation. Based on the list of commits that were
       selected in the previous step, we perform several incremental
       walks to generate the bitmap for each commit.

       The walks begin from the oldest commit, and are built up
       incrementally for each branch. E.g. consider this dag where A, B,
       C, D, E, F are the selected commits, and a, b, c, e are a chunk
       of simplified history that will not receive bitmaps.

            A---a---B--b--C--c--D
                     \
                      E--e--F

       We start by building the bitmap for A, using A as the root for a
       revision walk and marking all the objects that are reachable
       until the walk is over. Once this bitmap is stored, we reuse the
       bitmap walker to perform the walk for B, assuming that once we
       reach A again, the walk will be terminated because A has already
       been SEEN on the previous walk.

       This process is repeated for C, and D, but when we try to
       generate the bitmaps for E, we can reuse neither the current walk
       nor the bitmap we have generated so far.

       What we do now is resetting both the walk and clearing the
       bitmap, and performing the walk from scratch using E as the
       origin. This new walk, however, does not need to be completed.
       Once we hit B, we can lookup the bitmap we have already stored
       for that commit and OR it with the existing bitmap we've composed
       so far, allowing us to limit the walk early.

       After all the bitmaps have been generated, another iteration
       through the list of commits is performed to find the best XOR
       offsets for compression before writing them to disk. Because of
       the incremental nature of these bitmaps, XORing one of them with
       its predecesor results in a minimal "bitmap delta" most of the
       time. We can write this delta to the on-disk bitmap index, and
       then re-compose the original bitmaps by XORing them again when
       loaded.

       This is a phase very similar to pack-object's `find_delta` (using
       bitmaps instead of objects, of course), except the heuristics
       have been greatly simplified: we only check the 10 bitmaps before
       any given one to find best compressing one. This gives good
       results in practice, because there is locality in the ordering of
       the objects (and therefore bitmaps) in the packfile.

     6. `bitmap_writer_finish`: the last step in the process is
	serializing to disk all the bitmap data that has been generated
	in the two previous steps.

	The bitmap is written to a tmp file and then moved atomically to
	its final destination, using the same process as
	`pack-write.c:write_idx_file`.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |   8 +
 Makefile                 |   1 +
 builtin/pack-objects.c   |  53 +++++
 pack-bitmap-write.c      | 535 +++++++++++++++++++++++++++++++++++++++++++++++
 pack-bitmap.c            |  92 ++++++++
 pack-bitmap.h            |  19 ++
 pack-objects.h           |   1 +
 pack-write.c             |   2 +
 8 files changed, 711 insertions(+)
 create mode 100644 pack-bitmap-write.c

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a981369..a439a4c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1864,6 +1864,14 @@ pack.useBitmaps::
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
 
+pack.writebitmaps::
+	When true, git will write a bitmap index when packing all
+	objects to disk (e.g., as when `git repack -a` is run).  This
+	index can speed up the "counting objects" phase of subsequent
+	packs created for clones and fetches, at the cost of some disk
+	space and extra time spent on the initial repack.  Defaults to
+	false.
+
 pager.<cmd>::
 	If the value is boolean, turns on or off pagination of the
 	output of a particular Git subcommand when writing to a tty.
diff --git a/Makefile b/Makefile
index b983d78..555d44c 100644
--- a/Makefile
+++ b/Makefile
@@ -839,6 +839,7 @@ LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-bitmap.o
+LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-objects.o
 LIB_OBJS += pack-revindex.o
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f04cce5..26646e7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -63,6 +63,7 @@ static uint32_t reuse_packfile_objects;
 static off_t reuse_packfile_offset;
 
 static int use_bitmap_index = 1;
+static int write_bitmap_index;
 
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
@@ -81,6 +82,24 @@ enum {
 static uint32_t written, written_delta;
 static uint32_t reused, reused_delta;
 
+/*
+ * Indexed commits
+ */
+static struct commit **indexed_commits;
+static unsigned int indexed_commits_nr;
+static unsigned int indexed_commits_alloc;
+
+static void index_commit_for_bitmap(struct commit *commit)
+{
+	if (indexed_commits_nr >= indexed_commits_alloc) {
+		indexed_commits_alloc = (indexed_commits_alloc + 32) * 2;
+		indexed_commits = xrealloc(indexed_commits,
+			indexed_commits_alloc * sizeof(struct commit *));
+	}
+
+	indexed_commits[indexed_commits_nr++] = commit;
+}
+
 static void *get_delta(struct object_entry *entry)
 {
 	unsigned long size, base_size, delta_size;
@@ -823,9 +842,30 @@ static void write_pack_file(void)
 			if (sizeof(tmpname) <= strlen(base_name) + 50)
 				die("pack base name '%s' too long", base_name);
 			snprintf(tmpname, sizeof(tmpname), "%s-", base_name);
+
+			if (write_bitmap_index) {
+				bitmap_writer_set_checksum(sha1);
+				bitmap_writer_build_type_index(written_list, nr_written);
+			}
+
 			finish_tmp_packfile(tmpname, pack_tmp_name,
 					    written_list, nr_written,
 					    &pack_idx_opts, sha1);
+
+			if (write_bitmap_index) {
+				char *end_of_name_prefix = strrchr(tmpname, 0);
+				sprintf(end_of_name_prefix, "%s.bitmap", sha1_to_hex(sha1));
+
+				stop_progress(&progress_state);
+
+				bitmap_writer_show_progress(progress);
+				bitmap_writer_reuse_bitmaps(&to_pack);
+				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
+				bitmap_writer_build(&to_pack);
+				bitmap_writer_finish(written_list, nr_written, tmpname);
+				write_bitmap_index = 0;
+			}
+
 			free(pack_tmp_name);
 			puts(sha1_to_hex(sha1));
 		}
@@ -2111,6 +2151,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		cache_max_small_delta_size = git_config_int(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.writebitmaps")) {
+		write_bitmap_index = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "pack.usebitmaps")) {
 		use_bitmap_index = git_config_bool(k, v);
 		return 0;
@@ -2173,6 +2217,9 @@ static void show_commit(struct commit *commit, void *data)
 {
 	add_object_entry(commit->object.sha1, OBJ_COMMIT, NULL, 0);
 	commit->object.flags |= OBJECT_ADDED;
+
+	if (write_bitmap_index)
+		index_commit_for_bitmap(commit);
 }
 
 static void show_object(struct object *obj,
@@ -2365,6 +2412,7 @@ static void get_object_list(int ac, const char **av)
 		if (*line == '-') {
 			if (!strcmp(line, "--not")) {
 				flags ^= UNINTERESTING;
+				write_bitmap_index = 0;
 				continue;
 			}
 			die("not a rev '%s'", line);
@@ -2507,6 +2555,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			    N_("do not hide commits by grafts"), 0),
 		OPT_BOOL(0, "use-bitmap-index", &use_bitmap_index,
 			 N_("use a bitmap index if available to speed up counting objects")),
+		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
+			 N_("write a bitmap index together with the pack index")),
 		OPT_END(),
 	};
 
@@ -2576,6 +2626,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
 		use_bitmap_index = 0;
 
+	if (pack_to_stdout || !rev_list_all)
+		write_bitmap_index = 0;
+
 	if (progress && all_progress_implied)
 		progress = 2;
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
new file mode 100644
index 0000000..954a74d
--- /dev/null
+++ b/pack-bitmap-write.c
@@ -0,0 +1,535 @@
+#include "cache.h"
+#include "commit.h"
+#include "tag.h"
+#include "diff.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "progress.h"
+#include "pack-revindex.h"
+#include "pack.h"
+#include "pack-bitmap.h"
+#include "sha1-lookup.h"
+#include "pack-objects.h"
+
+struct bitmapped_commit {
+	struct commit *commit;
+	struct ewah_bitmap *bitmap;
+	struct ewah_bitmap *write_as;
+	int flags;
+	int xor_offset;
+	uint32_t commit_pos;
+};
+
+struct bitmap_writer {
+	struct ewah_bitmap *commits;
+	struct ewah_bitmap *trees;
+	struct ewah_bitmap *blobs;
+	struct ewah_bitmap *tags;
+
+	khash_sha1 *bitmaps;
+	khash_sha1 *reused;
+	struct packing_data *to_pack;
+
+	struct bitmapped_commit *selected;
+	unsigned int selected_nr, selected_alloc;
+
+	struct progress *progress;
+	int show_progress;
+	unsigned char pack_checksum[20];
+};
+
+static struct bitmap_writer writer;
+
+void bitmap_writer_show_progress(int show)
+{
+	writer.show_progress = show;
+}
+
+/**
+ * Build the initial type index for the packfile
+ */
+void bitmap_writer_build_type_index(struct pack_idx_entry **index,
+				    uint32_t index_nr)
+{
+	uint32_t i;
+
+	writer.commits = ewah_new();
+	writer.trees = ewah_new();
+	writer.blobs = ewah_new();
+	writer.tags = ewah_new();
+
+	for (i = 0; i < index_nr; ++i) {
+		struct object_entry *entry = (struct object_entry *)index[i];
+		enum object_type real_type;
+
+		entry->in_pack_pos = i;
+
+		switch (entry->type) {
+		case OBJ_COMMIT:
+		case OBJ_TREE:
+		case OBJ_BLOB:
+		case OBJ_TAG:
+			real_type = entry->type;
+			break;
+
+		default:
+			real_type = sha1_object_info(entry->idx.sha1, NULL);
+			break;
+		}
+
+		switch (real_type) {
+		case OBJ_COMMIT:
+			ewah_set(writer.commits, i);
+			break;
+
+		case OBJ_TREE:
+			ewah_set(writer.trees, i);
+			break;
+
+		case OBJ_BLOB:
+			ewah_set(writer.blobs, i);
+			break;
+
+		case OBJ_TAG:
+			ewah_set(writer.tags, i);
+			break;
+
+		default:
+			die("Missing type information for %s (%d/%d)",
+			    sha1_to_hex(entry->idx.sha1), real_type, entry->type);
+		}
+	}
+}
+
+/**
+ * Compute the actual bitmaps
+ */
+static struct object **seen_objects;
+static unsigned int seen_objects_nr, seen_objects_alloc;
+
+static inline void push_bitmapped_commit(struct commit *commit, struct ewah_bitmap *reused)
+{
+	if (writer.selected_nr >= writer.selected_alloc) {
+		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
+		writer.selected = xrealloc(writer.selected,
+					   writer.selected_alloc * sizeof(struct bitmapped_commit));
+	}
+
+	writer.selected[writer.selected_nr].commit = commit;
+	writer.selected[writer.selected_nr].bitmap = reused;
+	writer.selected[writer.selected_nr].flags = 0;
+
+	writer.selected_nr++;
+}
+
+static inline void mark_as_seen(struct object *object)
+{
+	ALLOC_GROW(seen_objects, seen_objects_nr + 1, seen_objects_alloc);
+	seen_objects[seen_objects_nr++] = object;
+}
+
+static inline void reset_all_seen(void)
+{
+	unsigned int i;
+	for (i = 0; i < seen_objects_nr; ++i) {
+		seen_objects[i]->flags &= ~(SEEN | ADDED | SHOWN);
+	}
+	seen_objects_nr = 0;
+}
+
+static uint32_t find_object_pos(const unsigned char *sha1)
+{
+	struct object_entry *entry = packlist_find(writer.to_pack, sha1, NULL);
+
+	if (!entry) {
+		die("Failed to write bitmap index. Packfile doesn't have full closure "
+			"(object %s is missing)", sha1_to_hex(sha1));
+	}
+
+	return entry->in_pack_pos;
+}
+
+static void show_object(struct object *object, const struct name_path *path,
+			const char *last, void *data)
+{
+	struct bitmap *base = data;
+	bitmap_set(base, find_object_pos(object->sha1));
+	mark_as_seen(object);
+}
+
+static void show_commit(struct commit *commit, void *data)
+{
+	mark_as_seen((struct object *)commit);
+}
+
+static int
+add_to_include_set(struct bitmap *base, struct commit *commit)
+{
+	khiter_t hash_pos;
+	uint32_t bitmap_pos = find_object_pos(commit->object.sha1);
+
+	if (bitmap_get(base, bitmap_pos))
+		return 0;
+
+	hash_pos = kh_get_sha1(writer.bitmaps, commit->object.sha1);
+	if (hash_pos < kh_end(writer.bitmaps)) {
+		struct bitmapped_commit *bc = kh_value(writer.bitmaps, hash_pos);
+		bitmap_or_ewah(base, bc->bitmap);
+		return 0;
+	}
+
+	bitmap_set(base, bitmap_pos);
+	return 1;
+}
+
+static int
+should_include(struct commit *commit, void *_data)
+{
+	struct bitmap *base = _data;
+
+	if (!add_to_include_set(base, commit)) {
+		struct commit_list *parent = commit->parents;
+
+		mark_as_seen((struct object *)commit);
+
+		while (parent) {
+			parent->item->object.flags |= SEEN;
+			mark_as_seen((struct object *)parent->item);
+			parent = parent->next;
+		}
+
+		return 0;
+	}
+
+	return 1;
+}
+
+static void compute_xor_offsets(void)
+{
+	static const int MAX_XOR_OFFSET_SEARCH = 10;
+
+	int i, next = 0;
+
+	while (next < writer.selected_nr) {
+		struct bitmapped_commit *stored = &writer.selected[next];
+
+		int best_offset = 0;
+		struct ewah_bitmap *best_bitmap = stored->bitmap;
+		struct ewah_bitmap *test_xor;
+
+		for (i = 1; i <= MAX_XOR_OFFSET_SEARCH; ++i) {
+			int curr = next - i;
+
+			if (curr < 0)
+				break;
+
+			test_xor = ewah_pool_new();
+			ewah_xor(writer.selected[curr].bitmap, stored->bitmap, test_xor);
+
+			if (test_xor->buffer_size < best_bitmap->buffer_size) {
+				if (best_bitmap != stored->bitmap)
+					ewah_pool_free(best_bitmap);
+
+				best_bitmap = test_xor;
+				best_offset = i;
+			} else {
+				ewah_pool_free(test_xor);
+			}
+		}
+
+		stored->xor_offset = best_offset;
+		stored->write_as = best_bitmap;
+
+		next++;
+	}
+}
+
+void bitmap_writer_build(struct packing_data *to_pack)
+{
+	static const double REUSE_BITMAP_THRESHOLD = 0.2;
+
+	int i, reuse_after, need_reset;
+	struct bitmap *base = bitmap_new();
+	struct rev_info revs;
+
+	writer.bitmaps = kh_init_sha1();
+	writer.to_pack = to_pack;
+
+	if (writer.show_progress)
+		writer.progress = start_progress("Building bitmaps", writer.selected_nr);
+
+	init_revisions(&revs, NULL);
+	revs.tag_objects = 1;
+	revs.tree_objects = 1;
+	revs.blob_objects = 1;
+	revs.no_walk = 0;
+
+	revs.include_check = should_include;
+	reset_revision_walk();
+
+	reuse_after = writer.selected_nr * REUSE_BITMAP_THRESHOLD;
+	need_reset = 0;
+
+	for (i = writer.selected_nr - 1; i >= 0; --i) {
+		struct bitmapped_commit *stored;
+		struct object *object;
+
+		khiter_t hash_pos;
+		int hash_ret;
+
+		stored = &writer.selected[i];
+		object = (struct object *)stored->commit;
+
+		if (stored->bitmap == NULL) {
+			if (i < writer.selected_nr - 1 &&
+			    (need_reset ||
+			     !in_merge_bases(writer.selected[i + 1].commit,
+					     stored->commit))) {
+			    bitmap_reset(base);
+			    reset_all_seen();
+			}
+
+			add_pending_object(&revs, object, "");
+			revs.include_check_data = base;
+
+			if (prepare_revision_walk(&revs))
+				die("revision walk setup failed");
+
+			traverse_commit_list(&revs, show_commit, show_object, base);
+
+			revs.pending.nr = 0;
+			revs.pending.alloc = 0;
+			revs.pending.objects = NULL;
+
+			stored->bitmap = bitmap_to_ewah(base);
+			need_reset = 0;
+		} else
+			need_reset = 1;
+
+		if (i >= reuse_after)
+			stored->flags |= BITMAP_FLAG_REUSE;
+
+		hash_pos = kh_put_sha1(writer.bitmaps, object->sha1, &hash_ret);
+		if (hash_ret == 0)
+			die("Duplicate entry when writing index: %s",
+			    sha1_to_hex(object->sha1));
+
+		kh_value(writer.bitmaps, hash_pos) = stored;
+		display_progress(writer.progress, writer.selected_nr - i);
+	}
+
+	bitmap_free(base);
+	stop_progress(&writer.progress);
+
+	compute_xor_offsets();
+}
+
+/**
+ * Select the commits that will be bitmapped
+ */
+static inline unsigned int next_commit_index(unsigned int idx)
+{
+	static const unsigned int MIN_COMMITS = 100;
+	static const unsigned int MAX_COMMITS = 5000;
+
+	static const unsigned int MUST_REGION = 100;
+	static const unsigned int MIN_REGION = 20000;
+
+	unsigned int offset, next;
+
+	if (idx <= MUST_REGION)
+		return 0;
+
+	if (idx <= MIN_REGION) {
+		offset = idx - MUST_REGION;
+		return (offset < MIN_COMMITS) ? offset : MIN_COMMITS;
+	}
+
+	offset = idx - MIN_REGION;
+	next = (offset < MAX_COMMITS) ? offset : MAX_COMMITS;
+
+	return (next > MIN_COMMITS) ? next : MIN_COMMITS;
+}
+
+static int date_compare(const void *_a, const void *_b)
+{
+	struct commit *a = *(struct commit **)_a;
+	struct commit *b = *(struct commit **)_b;
+	return (long)b->date - (long)a->date;
+}
+
+void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack)
+{
+	if (prepare_bitmap_git() < 0)
+		return;
+
+	writer.reused = kh_init_sha1();
+	rebuild_existing_bitmaps(to_pack, writer.reused, writer.show_progress);
+}
+
+static struct ewah_bitmap *find_reused_bitmap(const unsigned char *sha1)
+{
+	khiter_t hash_pos;
+
+	if (!writer.reused)
+		return NULL;
+
+	hash_pos = kh_get_sha1(writer.reused, sha1);
+	if (hash_pos >= kh_end(writer.reused))
+		return NULL;
+
+	return kh_value(writer.reused, hash_pos);
+}
+
+void bitmap_writer_select_commits(struct commit **indexed_commits,
+				  unsigned int indexed_commits_nr,
+				  int max_bitmaps)
+{
+	unsigned int i = 0, j, next;
+
+	qsort(indexed_commits, indexed_commits_nr, sizeof(indexed_commits[0]),
+	      date_compare);
+
+	if (writer.show_progress)
+		writer.progress = start_progress("Selecting bitmap commits", 0);
+
+	if (indexed_commits_nr < 100) {
+		for (i = 0; i < indexed_commits_nr; ++i)
+			push_bitmapped_commit(indexed_commits[i], NULL);
+		return;
+	}
+
+	for (;;) {
+		struct ewah_bitmap *reused_bitmap = NULL;
+		struct commit *chosen = NULL;
+
+		next = next_commit_index(i);
+
+		if (i + next >= indexed_commits_nr)
+			break;
+
+		if (max_bitmaps > 0 && writer.selected_nr >= max_bitmaps) {
+			writer.selected_nr = max_bitmaps;
+			break;
+		}
+
+		if (next == 0) {
+			chosen = indexed_commits[i];
+			reused_bitmap = find_reused_bitmap(chosen->object.sha1);
+		} else {
+			chosen = indexed_commits[i + next];
+
+			for (j = 0; j <= next; ++j) {
+				struct commit *cm = indexed_commits[i + j];
+
+				reused_bitmap = find_reused_bitmap(cm->object.sha1);
+				if (reused_bitmap || (cm->object.flags & NEEDS_BITMAP) != 0) {
+					chosen = cm;
+					break;
+				}
+
+				if (cm->parents && cm->parents->next)
+					chosen = cm;
+			}
+		}
+
+		push_bitmapped_commit(chosen, reused_bitmap);
+
+		i += next + 1;
+		display_progress(writer.progress, i);
+	}
+
+	stop_progress(&writer.progress);
+}
+
+
+static int sha1write_ewah_helper(void *f, const void *buf, size_t len)
+{
+	/* sha1write will die on error */
+	sha1write(f, buf, len);
+	return len;
+}
+
+/**
+ * Write the bitmap index to disk
+ */
+static inline void dump_bitmap(struct sha1file *f, struct ewah_bitmap *bitmap)
+{
+	if (ewah_serialize_to(bitmap, sha1write_ewah_helper, f) < 0)
+		die("Failed to write bitmap index");
+}
+
+static const unsigned char *sha1_access(size_t pos, void *table)
+{
+	struct pack_idx_entry **index = table;
+	return index[pos]->sha1;
+}
+
+static void write_selected_commits_v1(struct sha1file *f,
+				      struct pack_idx_entry **index,
+				      uint32_t index_nr)
+{
+	int i;
+
+	for (i = 0; i < writer.selected_nr; ++i) {
+		struct bitmapped_commit *stored = &writer.selected[i];
+		struct bitmap_disk_entry on_disk;
+
+		int commit_pos =
+			sha1_pos(stored->commit->object.sha1, index, index_nr, sha1_access);
+
+		if (commit_pos < 0)
+			die("BUG: trying to write commit not in index");
+
+		on_disk.object_pos = htonl(commit_pos);
+		on_disk.xor_offset = stored->xor_offset;
+		on_disk.flags = stored->flags;
+
+		sha1write(f, &on_disk, sizeof(on_disk));
+		dump_bitmap(f, stored->write_as);
+	}
+}
+
+void bitmap_writer_set_checksum(unsigned char *sha1)
+{
+	hashcpy(writer.pack_checksum, sha1);
+}
+
+void bitmap_writer_finish(struct pack_idx_entry **index,
+			  uint32_t index_nr,
+			  const char *filename)
+{
+	static char tmp_file[PATH_MAX];
+	static uint16_t default_version = 1;
+	static uint16_t flags = BITMAP_OPT_FULL_DAG;
+	struct sha1file *f;
+
+	struct bitmap_disk_header header;
+
+	int fd = odb_mkstemp(tmp_file, sizeof(tmp_file), "pack/tmp_bitmap_XXXXXX");
+
+	if (fd < 0)
+		die_errno("unable to create '%s'", tmp_file);
+	f = sha1fd(fd, tmp_file);
+
+	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
+	header.version = htons(default_version);
+	header.options = htons(flags);
+	header.entry_count = htonl(writer.selected_nr);
+	memcpy(header.checksum, writer.pack_checksum, 20);
+
+	sha1write(f, &header, sizeof(header));
+	dump_bitmap(f, writer.commits);
+	dump_bitmap(f, writer.trees);
+	dump_bitmap(f, writer.blobs);
+	dump_bitmap(f, writer.tags);
+	write_selected_commits_v1(f, index, index_nr);
+
+	sha1close(f, NULL, CSUM_FSYNC);
+
+	if (adjust_shared_perm(tmp_file))
+		die_errno("unable to make temporary bitmap file readable");
+
+	if (rename(tmp_file, filename))
+		die_errno("unable to rename temporary bitmap file to '%s'", filename);
+}
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 340f02b..7792dfd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -968,3 +968,95 @@ void test_bitmap_walk(struct rev_info *revs)
 	else
 		fprintf(stderr, "Mismatch!\n");
 }
+
+static int rebuild_bitmap(uint32_t *reposition,
+			  struct ewah_bitmap *source,
+			  struct bitmap *dest)
+{
+	uint32_t pos = 0;
+	struct ewah_iterator it;
+	eword_t word;
+
+	ewah_iterator_init(&it, source);
+
+	while (ewah_iterator_next(&word, &it)) {
+		uint32_t offset, bit_pos;
+
+		for (offset = 0; offset < BITS_IN_WORD; ++offset) {
+			if ((word >> offset) == 0)
+				break;
+
+			offset += ewah_bit_ctz64(word >> offset);
+
+			bit_pos = reposition[pos + offset];
+			if (bit_pos > 0)
+				bitmap_set(dest, bit_pos - 1);
+			else /* can't reuse, we don't have the object */
+				return -1;
+		}
+
+		pos += BITS_IN_WORD;
+	}
+	return 0;
+}
+
+int rebuild_existing_bitmaps(struct packing_data *mapping,
+			     khash_sha1 *reused_bitmaps,
+			     int show_progress)
+{
+	uint32_t i, num_objects;
+	uint32_t *reposition;
+	struct bitmap *rebuild;
+	struct stored_bitmap *stored;
+	struct progress *progress = NULL;
+
+	khiter_t hash_pos;
+	int hash_ret;
+
+	if (prepare_bitmap_git() < 0)
+		return -1;
+
+	num_objects = bitmap_git.pack->num_objects;
+	reposition = xcalloc(num_objects, sizeof(uint32_t));
+
+	for (i = 0; i < num_objects; ++i) {
+		const unsigned char *sha1;
+		struct revindex_entry *entry;
+		struct object_entry *oe;
+
+		entry = &bitmap_git.reverse_index->revindex[i];
+		sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
+		oe = packlist_find(mapping, sha1, NULL);
+
+		if (oe)
+			reposition[i] = oe->in_pack_pos + 1;
+	}
+
+	rebuild = bitmap_new();
+	i = 0;
+
+	if (show_progress)
+		progress = start_progress("Reusing bitmaps", 0);
+
+	kh_foreach_value(bitmap_git.bitmaps, stored, {
+		if (stored->flags & BITMAP_FLAG_REUSE) {
+			if (!rebuild_bitmap(reposition,
+					    lookup_stored_bitmap(stored),
+					    rebuild)) {
+				hash_pos = kh_put_sha1(reused_bitmaps,
+						       stored->sha1,
+						       &hash_ret);
+				kh_value(reused_bitmaps, hash_pos) =
+					bitmap_to_ewah(rebuild);
+			}
+			bitmap_reset(rebuild);
+			display_progress(progress, ++i);
+		}
+	});
+
+	stop_progress(&progress);
+
+	free(reposition);
+	bitmap_free(rebuild);
+	return 0;
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 9351aa5..5e3fb9a 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -3,6 +3,7 @@
 
 #include "ewah/ewok.h"
 #include "khash.h"
+#include "pack-objects.h"
 
 struct bitmap_disk_entry {
 	uint32_t object_pos;
@@ -20,10 +21,16 @@ struct bitmap_disk_header {
 
 static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};;
 
+#define NEEDS_BITMAP (1u<<22)
+
 enum pack_bitmap_opts {
 	BITMAP_OPT_FULL_DAG = 1,
 };
 
+enum pack_bitmap_flags {
+	BITMAP_FLAG_REUSE = 0x1
+};
+
 typedef int (*show_reachable_fn)(
 	const unsigned char *sha1,
 	enum object_type type,
@@ -39,5 +46,17 @@ void test_bitmap_walk(struct rev_info *revs);
 char *pack_bitmap_filename(struct packed_git *p);
 int prepare_bitmap_walk(struct rev_info *revs);
 int reuse_partial_packfile_from_bitmap(struct packed_git **packfile, uint32_t *entries, off_t *up_to);
+int rebuild_existing_bitmaps(struct packing_data *mapping, khash_sha1 *reused_bitmaps, int show_progress);
+
+void bitmap_writer_show_progress(int show);
+void bitmap_writer_set_checksum(unsigned char *sha1);
+void bitmap_writer_build_type_index(struct pack_idx_entry **index, uint32_t index_nr);
+void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack);
+void bitmap_writer_select_commits(struct commit **indexed_commits,
+		unsigned int indexed_commits_nr, int max_bitmaps);
+void bitmap_writer_build(struct packing_data *to_pack);
+void bitmap_writer_finish(struct pack_idx_entry **index,
+			  uint32_t index_nr,
+			  const char *filename);
 
 #endif
diff --git a/pack-objects.h b/pack-objects.h
index 90ad0a8..d1b98b3 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -17,6 +17,7 @@ struct object_entry {
 	enum object_type type;
 	enum object_type in_pack_type;	/* could be delta */
 	uint32_t hash;			/* name hint hash */
+	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size;
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
diff --git a/pack-write.c b/pack-write.c
index ca9e63b..6203d37 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -371,5 +371,7 @@ void finish_tmp_packfile(char *name_buffer,
 	if (rename(idx_tmp_name, name_buffer))
 		die_errno("unable to rename temporary index file");
 
+	*end_of_name_prefix = '\0';
+
 	free((void *)idx_tmp_name);
 }
-- 
1.8.5.rc0.443.g2df7f3f
