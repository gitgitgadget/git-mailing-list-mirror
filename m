From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 12/16] pack-objects: implement bitmap writing
Date: Tue, 25 Jun 2013 01:23:09 +0200
Message-ID: <1372116193-32762-13-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:24:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG7S-0003Sv-MO
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab3FXXYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:24:17 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:45390 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab3FXXYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:24:09 -0400
Received: by mail-we0-f170.google.com with SMTP id w57so8797230wes.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Cys6hu1dhC8uuxDcCr/JEXIONCa8kPtq9wEZOXYhy7c=;
        b=HriaFNQPqqoJwfsVdgGWDwZ4RD6+RAsI2m/yL+ml1gVtnN4EYP5FMd3qDNx3+QmWUV
         ck6Ml9ClBRFpjS9zLJVz60BsoOND6uNeLhWWtQlzg8gNzt4mKosVHgDZ2UEcADDirzYz
         SsyCs6frBKJC7oAZZJgn1zBTcSgs9GiUmM7dwnlSTTAIRly7hoUnJnj8LBWuMv58PrbS
         xPpnc6mu1KLTtvZXNJXKk6mDpP2ItTiBz2jFjWwhlYkOv+hqhWC0yVrHLLv+vxtJLOQp
         V+HO4XeGzQDFc5qlfP1KvliNGjMmZT/uf9U4ID4x8bz/u9EBQbQTbOpUlfGHhIvQgGwH
         uJew==
X-Received: by 10.180.9.242 with SMTP id d18mr7341656wib.18.1372116247310;
        Mon, 24 Jun 2013 16:24:07 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.24.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:24:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228929>

This commit extends more the functionality of `pack-objects` by allowing
it to write out a `.bitmap` index next to any written packs, together
with the `.idx` index that currently gets written.

If bitmaps are enabled for a given repository (either by calling
`pack-objects` with the `--use-bitmaps` flag or by having
`pack.usebitmaps` set to `true` in the config) and pack-objects is
writing a packfile that would normally be indexed (i.e. not piping to
stdout), we will attempt to write the corresponding bitmap index for the
packfile.

Bitmap index writing happens after the packfile and its index has been
successfully written to disk (`finish_tmp_packfile`). The process is
performed in several steps:

	1. `bitmap_writer_build_type_index`: this call uses the array of
	`struct object_entry`es that has just been sorted when writing out
	the actual packfile index to disk to generate 4 type-index bitmaps
	(one for each object type).

	These bitmaps have their nth bit set if the given object is of the
	bitmap's type. E.g. the nth bit of the Commits bitmap will be 1 if
	the nth object in the packfile index is a commit.

	This is a very cheap operation because the bitmap writing code has
	access to the metadata stored in the `struct object_entry` array,
	and hence the real type for each object in the packfile.

	2. `bitmap_writer_select_commits`: if bitmap writing is enabled for
	a given `pack-objects` run, the sequence of commits generated during
	the Counting Objects phase will be stored in an array.

	We then use that array to build up the list of selected commits.
	Writing a bitmap in the index for each object in the repository
	would be cost-prohibitive, so we use a simple heuristic to pick the
	commits that will be indexed with bitmaps.

	The current heuristics are a simplified version of JGit's original
	implementation. We select a higher density of commits depending on
	their age: the 100 most recent commits are always selected, after
	that we pick 1 commit of each 100, and the gap increases as the
	commits grow older. On top of that, we make sure that every single
	branch that has not been merged (all the tips that would be required
	from a clone) gets their own bitmap, and when selecting commits
	between a gap, we tend to prioritize the commit with the most
	parents.

	Do note that there is no right/wrong way to perform commit selection;
	different selection algorithms will result in different commits
	being selected, but there's no such thing as "missing a commit". The
	bitmap walker algorithm implemented in `prepare_bitmap_walk` is able
	to adapt to missing bitmaps by performing manual walks that complete
	the bitmap: the ideal selection algorithm, however, would select
	the commits that are more likely to be used as roots for a walk in
	the future (e.g. the tips of each branch, and so on) to ensure a
	bitmap for them is always available.

	3. `bitmap_writer_build`: this is the computationally expensive part
	of bitmap generation. Based on the list of commits that were
	selected in the previous step, we perform several incremental walks
	to generate the bitmap for each commit.

	The walks begin from the oldest commit, and are built up
	incrementally for each branch. E.g. consider this dag where A, B, C,
	D, E, F are the selected commits, and a, b, c, e are a chunk of
	simplified history that will not receive bitmaps.

		A---a---B--b--C--c--D
		         \
		          E--e--F

	We start by building the bitmap for A, using A as the root for a
	revision walk and marking all the objects that are reachable until
	the walk is over. Once this bitmap is stored, we reuse the bitmap
	walker to perform the walk for B, assuming that once we reach A
	again, the walk will be terminated because A has already been SEEN
	on the previous walk.

	This process is repeated for C, and D, but when we try to generate
	the bitmaps for E, we cannot reuse neither the current walk nor the
	bitmap we have generated so far.

	What we do now is resetting both the walk and clearing the bitmap,
	and performing the walk from scratch using E as the origin. This new
	walk, however, does not need to be completed. Once we hit B, we can
	lookup the bitmap we have already stored for that commit and OR it
	with the existing bitmap we've composed so far, allowing us to limit
	the walk early.

	After all the bitmaps have been generated, another iteration through
	the list of commits is performed to find the best XOR offsets for
	compression before writing them to disk. Because of the incremental
	nature of these bitmaps, XORing one of them with its predecesor
	results in a minimal "bitmap delta" most of the time. We can write
	this delta to the on-disk bitmap index, and then re-compose the
	original bitmaps by XORing them again when loaded.

	This is a phase very similar to pack-object's `find_delta` (using
	bitmaps instead of objects, of course), except the heuristics have
	been greatly simplified: we only check the 10 bitmaps before any
	given one to find best compressing one. This operation gives optimal
	results (again, because of the incremental nature of the bitmaps)
	and has a very good runtime performance because of the way EWAH
	bitmaps are implemented.

	3. `bitmap_writer_finish`: the last step in the process is
	serializing to disk all the bitmap data that has been generated in
	the two previous steps.

	The bitmap is written to a tmp file and then moved atomically to its
	final destination, using the same process as `pack-write.c:write_idx_file`.
---
 Makefile               |    1 +
 builtin/pack-objects.c |  117 +++++++----
 builtin/pack-objects.h |   33 +++
 pack-bitmap-write.c    |  520 ++++++++++++++++++++++++++++++++++++++++++++++++
 pack-bitmap.h          |    9 +
 pack-write.c           |    2 +
 6 files changed, 646 insertions(+), 36 deletions(-)
 create mode 100644 builtin/pack-objects.h
 create mode 100644 pack-bitmap-write.c

diff --git a/Makefile b/Makefile
index 0f2e72b..599aa59 100644
--- a/Makefile
+++ b/Makefile
@@ -840,6 +840,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-bitmap.o
+LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 469b8da..58003ec 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -20,6 +20,7 @@
 #include "thread-utils.h"
 #include "khash.h"
 #include "pack-bitmap.h"
+#include "builtin/pack-objects.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-list]"),
@@ -27,32 +28,6 @@ static const char *pack_usage[] = {
 	NULL
 };
 
-struct object_entry {
-	struct pack_idx_entry idx;
-	unsigned long size;	/* uncompressed size */
-	struct packed_git *in_pack; 	/* already in pack */
-	off_t in_pack_offset;
-	struct object_entry *delta;	/* delta base object */
-	struct object_entry *delta_child; /* deltified objects who bases me */
-	struct object_entry *delta_sibling; /* other deltified objects who
-					     * uses the same base as me
-					     */
-	void *delta_data;	/* cached delta (uncompressed) */
-	unsigned long delta_size;	/* delta data size (uncompressed) */
-	unsigned long z_delta_size;	/* delta data size (compressed) */
-	unsigned int hash;	/* name hint hash */
-	enum object_type type;
-	enum object_type in_pack_type;	/* could be delta */
-	unsigned char in_pack_header_size;
-	unsigned char preferred_base; /* we do not pack this, but is available
-				       * to be used as the base object to delta
-				       * objects against.
-				       */
-	unsigned char no_try_delta;
-	unsigned char tagged; /* near the very tip of refs */
-	unsigned char filled; /* assigned write-order */
-};
-
 /*
  * Objects we are going to pack are collected in objects array (dynamically
  * expanded).  nr_objects & nr_alloc controls this array.  They are stored
@@ -86,6 +61,7 @@ static int pack_compression_seen;
 
 static int bitmap_support;
 static int use_bitmap_index;
+static int write_bitmap_index;
 
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
@@ -108,6 +84,12 @@ static struct object_entry *locate_object_entry(const unsigned char *sha1);
 static uint32_t written, written_delta;
 static uint32_t reused, reused_delta;
 
+/*
+ * Indexed commits
+ */
+struct commit **indexed_commits;
+unsigned int indexed_commits_nr;
+unsigned int indexed_commits_alloc;
 
 static struct object_slab {
 	struct object_slab *next;
@@ -137,6 +119,16 @@ static struct object_entry *alloc_object_entry(void)
 	return &slab->data[slab->count++];
 }
 
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
 
 static void *get_delta(struct object_entry *entry)
 {
@@ -746,6 +738,29 @@ static struct object_entry **compute_write_order(void)
 	return wo;
 }
 
+static void resolve_real_types(
+	 struct pack_idx_entry **index, uint32_t index_nr)
+{
+	uint32_t i;
+
+	for (i = 0; i < index_nr; ++i) {
+		struct object_entry *entry = (struct object_entry *)index[i];
+
+		switch (entry->type) {
+		case OBJ_COMMIT:
+		case OBJ_TREE:
+		case OBJ_BLOB:
+		case OBJ_TAG:
+			entry->real_type = entry->type;
+			break;
+
+		default:
+			entry->real_type = sha1_object_info(entry->idx.sha1, NULL);
+			break;
+		}
+	}
+}
+
 static void write_pack_file(void)
 {
 	uint32_t i = 0, j;
@@ -824,9 +839,27 @@ static void write_pack_file(void)
 			if (sizeof(tmpname) <= strlen(base_name) + 50)
 				die("pack base name '%s' too long", base_name);
 			snprintf(tmpname, sizeof(tmpname), "%s-", base_name);
+
+			if (write_bitmap_index)
+				resolve_real_types(written_list, nr_written);
+
 			finish_tmp_packfile(tmpname, pack_tmp_name,
 					    written_list, nr_written,
 					    &pack_idx_opts, sha1);
+
+			if (write_bitmap_index && nr_remaining == nr_written) {
+				char *end_of_name_prefix = strrchr(tmpname, 0);
+				sprintf(end_of_name_prefix, "%s.bitmap", sha1_to_hex(sha1));
+
+				stop_progress(&progress_state);
+
+				bitmap_writer_show_progress(progress);
+				bitmap_writer_build_type_index(written_list, nr_written);
+				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
+				bitmap_writer_build(packed_objects);
+				bitmap_writer_finish(tmpname, sha1, BITMAP_OPT_HASH_CACHE);
+			}
+
 			free(pack_tmp_name);
 			puts(sha1_to_hex(sha1));
 		}
@@ -900,10 +933,8 @@ static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
 		return 0;
 	}
 
-	if (!exclude && local && has_loose_object_nonlocal(sha1)) {
-		kh_del_sha1(packed_objects, ix);
-		return 0;
-	}
+	if (!exclude && local && has_loose_object_nonlocal(sha1))
+		goto skip_entry;
 
 	if (!found_pack) {
 		for (p = packed_git; p; p = p->next) {
@@ -919,12 +950,12 @@ static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
 				}
 				if (exclude)
 					break;
-				if (incremental ||
-					(local && !p->pack_local) ||
-					(ignore_packed_keep && p->pack_local && p->pack_keep)) {
-					kh_del_sha1(packed_objects, ix);
-					return 0;
-				}
+				if (incremental)
+					goto skip_entry;
+				if (local && !p->pack_local)
+					goto skip_entry;
+				if (ignore_packed_keep && p->pack_local && p->pack_keep)
+					goto skip_entry;
 			}
 		}
 	}
@@ -956,6 +987,11 @@ static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
 	display_progress(progress_state, nr_objects);
 
 	return 1;
+
+skip_entry:
+	kh_del_sha1(packed_objects, ix);
+	write_bitmap_index = 0;
+	return 0;
 }
 
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
@@ -1266,6 +1302,7 @@ static void check_object(struct object_entry *entry)
 		used = unpack_object_header_buffer(buf, avail,
 						   &entry->in_pack_type,
 						   &entry->size);
+
 		if (used == 0)
 			goto give_up;
 
@@ -2197,6 +2234,10 @@ static void show_commit(struct commit *commit, void *data)
 {
 	add_object_entry(commit->object.sha1, OBJ_COMMIT, NULL, 0);
 	commit->object.flags |= OBJECT_ADDED;
+
+	if (write_bitmap_index) {
+		index_commit_for_bitmap(commit);
+	}
 }
 
 static void show_object(struct object *obj,
@@ -2366,6 +2407,7 @@ static void get_object_list(int ac, const char **av)
 		if (*line == '-') {
 			if (!strcmp(line, "--not")) {
 				flags ^= UNINTERESTING;
+				write_bitmap_index = 0;
 				continue;
 			}
 			die("not a rev '%s'", line);
@@ -2588,6 +2630,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		die("--keep-unreachable and --unpack-unreachable are incompatible.");
 
 	if (bitmap_support) {
+		if (!pack_to_stdout && rev_list_all)
+			write_bitmap_index = 1;
+
 		if (use_internal_rev_list && pack_to_stdout)
 			use_bitmap_index = 1;
 	}
diff --git a/builtin/pack-objects.h b/builtin/pack-objects.h
new file mode 100644
index 0000000..e186161
--- /dev/null
+++ b/builtin/pack-objects.h
@@ -0,0 +1,33 @@
+#ifndef BUILTIN_PACK_OBJECTS_H
+#define BUILTIN_PACK_OBJECTS_H
+
+struct object_entry {
+	struct pack_idx_entry idx;
+	unsigned long size;	/* uncompressed size */
+	struct packed_git *in_pack; 	/* already in pack */
+	off_t in_pack_offset;
+	struct object_entry *delta;	/* delta base object */
+	struct object_entry *delta_child; /* deltified objects who bases me */
+	struct object_entry *delta_sibling; /* other deltified objects who
+					     * uses the same base as me
+					     */
+	void *delta_data;	/* cached delta (uncompressed) */
+	unsigned long delta_size;	/* delta data size (uncompressed) */
+	unsigned long z_delta_size;	/* delta data size (compressed) */
+	unsigned int hash;	/* name hint hash */
+
+	enum object_type type;
+	enum object_type in_pack_type;
+	enum object_type real_type;
+
+	unsigned int index_pos;
+
+	unsigned char in_pack_header_size;
+	unsigned char preferred_base;
+	unsigned char no_try_delta;
+	unsigned char tagged;
+	unsigned char filled;
+	unsigned char refered;
+};
+
+#endif
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
new file mode 100644
index 0000000..d232545
--- /dev/null
+++ b/pack-bitmap-write.c
@@ -0,0 +1,520 @@
+#include <stdlib.h>
+
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
+#include "builtin/pack-objects.h"
+
+struct bitmapped_commit {
+	struct commit *commit;
+	struct ewah_bitmap *bitmap;
+	struct ewah_bitmap *write_as;
+	int flags;
+	int xor_offset;
+	uint32_t write_pos;
+};
+
+struct bitmap_writer {
+	struct ewah_bitmap *commits;
+	struct ewah_bitmap *trees;
+	struct ewah_bitmap *blobs;
+	struct ewah_bitmap *tags;
+
+	khash_sha1 *bitmaps;
+	khash_sha1 *packed_objects;
+
+	struct bitmapped_commit *selected;
+	unsigned int selected_nr, selected_alloc;
+
+	struct object_entry **index;
+	uint32_t index_nr;
+
+	int fd;
+	uint32_t written;
+
+	struct progress *progress;
+	int show_progress;
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
+void bitmap_writer_build_type_index(
+	 struct pack_idx_entry **index, uint32_t index_nr)
+{
+	uint32_t i = 0;
+
+	if (writer.show_progress)
+		writer.progress = start_progress("Building bitmap type index", index_nr);
+
+	writer.commits = ewah_new();
+	writer.trees = ewah_new();
+	writer.blobs = ewah_new();
+	writer.tags = ewah_new();
+
+	writer.index = (struct object_entry **)index;
+	writer.index_nr = index_nr;
+
+	while (i < index_nr) {
+		struct object_entry *entry = (struct object_entry *)index[i];
+		entry->index_pos = i;
+
+		switch (entry->real_type) {
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
+					sha1_to_hex(entry->idx.sha1), entry->real_type, entry->type);
+		}
+
+		i++;
+		display_progress(writer.progress, i);
+	}
+
+	stop_progress(&writer.progress);
+}
+
+/**
+ * Compute the actual bitmaps
+ */
+static struct object **seen_objects;
+static unsigned int seen_objects_nr, seen_objects_alloc;
+
+static inline void push_bitmapped_commit(struct commit *commit)
+{
+	if (writer.selected_nr >= writer.selected_alloc) {
+		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
+		writer.selected = xrealloc(writer.selected,
+			writer.selected_alloc * sizeof(struct bitmapped_commit));
+	}
+
+	writer.selected[writer.selected_nr].commit = commit;
+	writer.selected[writer.selected_nr].bitmap = NULL;
+	writer.selected[writer.selected_nr].flags = 0;
+
+	writer.selected_nr++;
+}
+
+static inline void mark_as_seen(struct object *object)
+{
+	if (seen_objects_nr >= seen_objects_alloc) {
+		seen_objects_alloc = (seen_objects_alloc + 32) * 2;
+		seen_objects = xrealloc(seen_objects,
+			seen_objects_alloc * sizeof(struct object*));
+	}
+
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
+	khiter_t pos = kh_get_sha1(writer.packed_objects, sha1);
+
+	if (pos < kh_end(writer.packed_objects)) {
+		struct object_entry *entry = kh_value(writer.packed_objects, pos);
+		return entry->index_pos;
+	}
+
+	die("Failed to write bitmap index. Packfile doesn't have full closure "
+		"(object %s is missing)", sha1_to_hex(sha1));
+}
+
+static void show_object(struct object *object,
+	const struct name_path *path, const char *last, void *data)
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
+		bitmap_or_inplace(base, bc->bitmap);
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
+static void
+compute_xor_offsets(void)
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
+void
+bitmap_writer_build(khash_sha1 *packed_objects)
+{
+	int i;
+	struct bitmap *base = bitmap_new();
+	struct rev_info revs;
+
+	writer.bitmaps = kh_init_sha1();
+	writer.packed_objects = packed_objects;
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
+		if (i < writer.selected_nr - 1) {
+			if (!in_merge_bases(writer.selected[i + 1].commit, stored->commit)) {
+				bitmap_reset(base);
+				reset_all_seen();
+			}
+		}
+
+		add_pending_object(&revs, object, "");
+		revs.include_check_data = base;
+
+		if (prepare_revision_walk(&revs))
+			die("revision walk setup failed");
+
+		traverse_commit_list(&revs, show_commit, show_object, base);
+
+		revs.pending.nr = 0;
+		revs.pending.alloc = 0;
+		revs.pending.objects = NULL;
+
+		stored->bitmap = bitmap_to_ewah(base);
+		stored->flags = object->flags;
+
+		hash_pos = kh_put_sha1(writer.bitmaps, object->sha1, &hash_ret);
+		if (hash_ret == 0)
+			die("Duplicate entry when writing index: %s",
+				sha1_to_hex(object->sha1));
+
+		kh_value(writer.bitmaps, hash_pos) = stored;
+
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
+void bitmap_writer_select_commits(
+		struct commit **indexed_commits,
+		unsigned int indexed_commits_nr,
+		int max_bitmaps)
+{
+	unsigned int i = 0, next;
+
+	if (writer.show_progress)
+		writer.progress = start_progress("Selecting bitmap commits", 0);
+
+	if (indexed_commits_nr < 100) {
+		for (i = 0; i < indexed_commits_nr; ++i) {
+			push_bitmapped_commit(indexed_commits[i]);
+		}
+		return;
+	}
+
+	for (;;) {
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
+			push_bitmapped_commit(indexed_commits[i]);
+		} else {
+			unsigned int j;
+			struct commit *chosen = indexed_commits[i + next];
+
+			for (j = 0; j <= next; ++j) {
+				struct commit *cm = indexed_commits[i + j];
+				if (cm->parents && cm->parents->next)
+					chosen = cm;
+			}
+
+			push_bitmapped_commit(chosen);
+		}
+
+		i += next + 1;
+		display_progress(writer.progress, i);
+	}
+
+	stop_progress(&writer.progress);
+}
+
+/**
+ * Write the bitmap index to disk
+ */
+static void write_hash_table(
+	 struct object_entry **index, uint32_t index_nr)
+{
+	uint32_t i, j = 0;
+	uint32_t buffer[1024];
+
+	for (i = 0; i < index_nr; ++i) {
+		struct object_entry *entry = index[i];
+
+		buffer[j++] = htonl(entry->hash);
+		if (j == 1024) {
+			write_or_die(writer.fd, buffer, sizeof(buffer));
+			j = 0;
+		}
+	}
+
+	if (j > 0) {
+		write_or_die(writer.fd, buffer, j * sizeof(uint32_t));
+	}
+
+	writer.written += (index_nr * sizeof(uint32_t));
+}
+
+static void dump_bitmap(struct ewah_bitmap *bitmap)
+{
+	int written;
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	written = ewah_serialize_native(bitmap, writer.fd);
+#else
+	written = ewah_serialize(bitmap, writer.fd);
+#endif
+
+	if (written < 0)
+		die("Failed to write bitmap index");
+
+	writer.written += written;
+}
+
+static void
+write_selected_commits_v2(void)
+{
+	int i;
+
+	for (i = 0; i < writer.selected_nr; ++i) {
+		struct bitmapped_commit *stored = &writer.selected[i];
+		stored->write_pos = writer.written;
+		dump_bitmap(stored->write_as);
+	}
+
+	for (i = 0; i < writer.selected_nr; ++i) {
+		struct bitmapped_commit *stored = &writer.selected[i];
+		struct bitmap_disk_entry_v2 on_disk;
+
+		memcpy(on_disk.sha1, stored->commit->object.sha1, 20);
+		on_disk.bitmap_pos = htonl(stored->write_pos);
+		on_disk.xor_offset = stored->xor_offset;
+		on_disk.flags = stored->flags;
+
+		write_or_die(writer.fd, &on_disk, sizeof(on_disk));
+		writer.written += sizeof(on_disk);
+	}
+}
+
+void bitmap_writer_finish(
+	 const char *filename, unsigned char sha1[], uint16_t flags)
+{
+	static char tmp_file[PATH_MAX];
+	static uint16_t default_version = 2;
+
+	struct bitmap_disk_header header;
+
+	flags |= BITMAP_OPT_FULL_DAG;
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	/*
+	 * In little endian machines (i.e. most of them) we're
+	 * going to dump the bitmaps straight from memory into
+	 * disk, and tag the bitmap index as having LE bitmaps
+	 */
+	flags |= BITMAP_OPT_LE_BITMAPS;
+#else
+	flags |= BITMAP_OPT_BE_BITMAPS;
+#endif
+
+	writer.fd = odb_mkstemp(tmp_file, sizeof(tmp_file), "pack/tmp_bitmap_XXXXXX");
+
+	if (writer.fd < 0)
+		die_errno("unable to create '%s'", tmp_file);
+
+	memcpy(header.magic, BITMAP_MAGIC_PREFIX, sizeof(BITMAP_MAGIC_PREFIX));
+	header.version = htons(default_version);
+	header.options = htons(flags);
+	header.entry_count = htonl(writer.selected_nr);
+	memcpy(header.checksum, sha1, 20);
+
+	write_or_die(writer.fd, &header, sizeof(header));
+	writer.written += sizeof(header);
+
+	if (flags & BITMAP_OPT_HASH_CACHE)
+		write_hash_table(writer.index, writer.index_nr);
+
+	dump_bitmap(writer.commits);
+	dump_bitmap(writer.trees);
+	dump_bitmap(writer.blobs);
+	dump_bitmap(writer.tags);
+	write_selected_commits_v2();
+
+	close(writer.fd);
+
+	if (adjust_shared_perm(tmp_file))
+		die_errno("unable to make temporary bitmap file readable");
+
+	if (rename(tmp_file, filename))
+		die_errno("unable to rename temporary bitmap file to '%s'", filename);
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index b97bd46..8e7e3dc 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -31,6 +31,8 @@ struct bitmap_disk_header {
 
 static const char BITMAP_MAGIC_PREFIX[] = {'B', 'I', 'T', 'M'};;
 
+#define NEEDS_BITMAP (1u<<22)
+
 enum pack_bitmap_opts {
 	BITMAP_OPT_FULL_DAG = 1,
 	BITMAP_OPT_LE_BITMAPS = 2,
@@ -50,4 +52,11 @@ int prepare_bitmap_walk(struct rev_info *revs, uint32_t *result_size);
 void test_bitmap_walk(struct rev_info *revs);
 char *pack_bitmap_filename(struct packed_git *p);
 
+void bitmap_writer_show_progress(int show);
+void bitmap_writer_build_type_index(struct pack_idx_entry **index, uint32_t index_nr);
+void bitmap_writer_select_commits(struct commit **indexed_commits,
+		unsigned int indexed_commits_nr, int max_bitmaps);
+void bitmap_writer_build(khash_sha1 *packed_objects);
+void bitmap_writer_finish(const char *filename, unsigned char sha1[], uint16_t flags);
+
 #endif
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
1.7.9.5
