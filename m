From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 15/16] write-bitmap: implement new git command to write bitmaps
Date: Tue, 25 Jun 2013 01:23:12 +0200
Message-ID: <1372116193-32762-16-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:24:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG7g-0003eB-O5
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab3FXXY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:24:26 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:60992 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab3FXXYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:24:14 -0400
Received: by mail-wg0-f51.google.com with SMTP id e11so8643184wgh.18
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cv1+02+1RSsLCa01G1515VKrz71xxLkf9nG/jkQe3DE=;
        b=sWetODQxaRuRK/CFChRVgMR93fAP9F/IGoIBR75SjIQCsqythCPTzMHAFg5jgwHgRn
         kNF9qY4vMfpz4QC5OleiALLWX4M4qAow+iiDH48Al5Mbyn2KLFDBitjGdqWqJMzQDr9I
         qTMh/dV8Tw/pwuiTlcR0FYj2L7f8p1+RhWEEKr0DE+1dxNBHKOEnCv1drqHjT2nkxsgA
         4dslg8LccwgkVc3xF2G5M7Ai5toB2vDtx/KAbpPhGnWoeWKmv7iCUBHt6EPCInpMr7nt
         AzrLn/Gn7U3nsgU0B7MU6bgpasHno1NbjIdgxkie0sVum/YpsOC8CaECroHxmZ3Q2iVt
         iHIg==
X-Received: by 10.194.47.167 with SMTP id e7mr17739357wjn.57.1372116252904;
        Mon, 24 Jun 2013 16:24:12 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.24.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:24:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228934>

The `pack-objects` builtin is capable of writing out bitmap indexes
(.bitmap) next to the their corresponding packfile, as part of the
process of actually generating the packfile.

This is a very efficient operation because all the required data for
writing the bitmap index (commit traversal list, list of all objects in
a packfile, sorted index for the packfile, and types for all objects in
the packfile) is readily available in memory as part of the process of
building the packfile itself.

There are however cases when we want to generate a bitmap index for a
packfile that already exists on disk (i.e. one we're not writing from
scratch). This new git builtin implements the bitmap index equivalent of
`git index-pack`: it writes a `.bitmap` file given a pair of existing
`.pack` and `.idx` files.

	NOTE that `write-bitmap` requires the packfile to have been indexed
	beforehand. If the packfile doesn't have its corresponding `.idx`
	file, `git index-pack` must be called before `write-bitmap` can
	work.

The process of generating bitmaps for an existing packfile is as
follows:

	1. Load the existing pack index in memory. The `.idx` for the
	packfile is loaded into a hash table in mememory so it can be
	efficiently queried. As part of this loading process, the real type
	for each object in the packfile is resolved (this implies resolving
	deltas, which can make this process rather expensive).

	2. Find the full closure for the packfile. All the objects from the
	packfile that have been loaded in memory are iterated, looking for
	commits. These commits are parsed, and their parents are marked as
	such to ensure that

		a) there is a full closure in the packfile, and no commit has a
		dangling parent pointer

		b) we can find the set of "tips" for the packfile, i.e., the set
		of commits that don't have any commits pointing to them

	3. The "tips" of the packfile are then used as the roots to perform a
	normal revision walk. The result of this revision walk is the list
	of commits that will be used by `bitmap_writer_select_commits` when
	selecting which commits are going to be bitmapped.

	4. We build and write the bitmap index in the same way that
	`pack-objects` does, given that we have all the required metadata:

		- an array of all the objects in the packfile, in index order
		- the types of all these objects
		- an array with a walk-ordering of all the commits in the
			packfile, which will be used for selection
		- a hash table to efficiently look up objects in the index

	See the previous patch "pack-objects: implement bitmap writing" for
	details on how the bitmap computation happens.
---
 Makefile               |    1 +
 builtin.h              |    1 +
 builtin/write-bitmap.c |  256 ++++++++++++++++++++++++++++++++++++++++++++++++
 git.c                  |    1 +
 4 files changed, 259 insertions(+)
 create mode 100644 builtin/write-bitmap.c

diff --git a/Makefile b/Makefile
index 599aa59..4a0a7dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1000,6 +1000,7 @@ BUILTIN_OBJS += builtin/upload-archive.o
 BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
+BUILTIN_OBJS += builtin/write-bitmap.o
 BUILTIN_OBJS += builtin/write-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
diff --git a/builtin.h b/builtin.h
index 64bab6b..e39685f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -144,6 +144,7 @@ extern int cmd_var(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_version(int argc, const char **argv, const char *prefix);
 extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
+extern int cmd_write_bitmap(int argc, const char **argv, const char *prefix);
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/write-bitmap.c b/builtin/write-bitmap.c
new file mode 100644
index 0000000..0cc1c9e
--- /dev/null
+++ b/builtin/write-bitmap.c
@@ -0,0 +1,256 @@
+#include <stdlib.h>
+
+#include "cache.h"
+#include "commit.h"
+#include "tag.h"
+#include "diff.h"
+#include "revision.h"
+#include "progress.h"
+#include "list-objects.h"
+#include "pack.h"
+#include "refs.h"
+#include "pack-bitmap.h"
+
+#include "builtin/pack-objects.h"
+
+static int progress = 1;
+static struct progress *progress_state;
+static int write_hash_cache;
+
+static struct object_entry **objects;
+static uint32_t nr_objects;
+
+static struct commit **walked_commits;
+static uint32_t nr_commits;
+
+static khash_sha1 *packed_objects;
+
+static struct object_entry *
+allocate_entry(const unsigned char *sha1)
+{
+	struct object_entry *entry;
+	khiter_t pos;
+	int hash_ret;
+
+	entry = calloc(1, sizeof(struct object_entry));
+	hashcpy(entry->idx.sha1, sha1);
+
+	pos = kh_put_sha1(packed_objects, entry->idx.sha1, &hash_ret);
+	if (hash_ret == 0) {
+		die("BUG: duplicate entry in packfile");
+	}
+
+	kh_value(packed_objects, pos) = entry;
+	objects[nr_objects++] = entry;
+
+	return entry;
+}
+
+static void
+load_pack_index(struct packed_git *pack)
+{
+	uint32_t i, commits_found = 0;
+	khint_t new_hash_size, nr_alloc;
+
+	if (open_pack_index(pack))
+		die("Failed to load packfile");
+
+	new_hash_size = (pack->num_objects * (1.0 / __ac_HASH_UPPER)) + 0.5;
+	kh_resize_sha1(packed_objects, new_hash_size);
+
+	nr_alloc = (pack->num_objects + 63) & ~63;
+	objects = xmalloc(nr_alloc * sizeof(struct object_entry *));
+
+	if (progress)
+		progress_state = start_progress("Loading existing index", pack->num_objects);
+
+	for (i = 0; i < pack->num_objects; ++i) {
+		struct object_entry *entry;
+		const unsigned char *sha1;
+
+		sha1 = nth_packed_object_sha1(pack, i);
+		entry = allocate_entry(sha1);
+
+		entry->in_pack = pack;
+		entry->type = entry->real_type = nth_packed_object_info(pack, i, NULL);
+		entry->index_pos = i;
+
+		display_progress(progress_state, i + 1);
+	}
+
+	stop_progress(&progress_state);
+	if (progress)
+		progress_state = start_progress("Finding pack closure", 0);
+
+	for (i = 0; i < nr_objects; ++i) {
+		struct commit *commit;
+		struct commit_list *parent;
+
+		if (objects[i]->type != OBJ_COMMIT)
+			continue;
+
+		commit = lookup_commit(objects[i]->idx.sha1);
+		if (parse_commit(commit)) {
+			die("Bad commit: %s\n", sha1_to_hex(objects[i]->idx.sha1));
+		}
+
+		parent = commit->parents;
+
+		while (parent) {
+			khiter_t pos = kh_get_sha1(packed_objects, parent->item->object.sha1);
+
+			if (pos < kh_end(packed_objects)) {
+				struct object_entry *entry = kh_value(packed_objects, pos);
+				entry->refered = 1;
+			} else {
+				die("Failed to write bitmaps for packfile: No closure");
+			}
+
+			parent = parent->next;
+		}
+
+		display_progress(progress_state, ++commits_found);
+	}
+
+	stop_progress(&progress_state);
+}
+
+static void show_object(struct object *object,
+	const struct name_path *path, const char *last, void *data)
+{
+	char *name = path_name(path, last);
+	khiter_t pos = kh_get_sha1(packed_objects, object->sha1);
+
+	if (pos < kh_end(packed_objects)) {
+		struct object_entry *entry = kh_value(packed_objects, pos);
+		entry->hash = pack_name_hash(name);
+	}
+
+	free(name);
+}
+
+static void show_commit(struct commit *commit, void *data)
+{
+	walked_commits[nr_commits++] = commit;
+	display_progress(progress_state, nr_commits);
+}
+
+static void
+find_all_objects(struct packed_git *pack)
+{
+	struct rev_info revs;
+	uint32_t i, found_commits = 0;
+
+	init_revisions(&revs, NULL);
+	if (write_hash_cache) {
+		revs.tag_objects = 1;
+		revs.tree_objects = 1;
+		revs.blob_objects = 1;
+	}
+	revs.no_walk = 0;
+
+	for (i = 0; i < nr_objects; ++i) {
+		if (objects[i]->type == OBJ_COMMIT) {
+			if (!objects[i]->refered) {
+				struct object *object = parse_object(objects[i]->idx.sha1);
+				add_pending_object(&revs, object, "");
+			}
+
+			found_commits++;
+		}
+	}
+
+	if (progress)
+		progress_state = start_progress("Computing walk order", found_commits);
+
+	walked_commits = xmalloc(found_commits * sizeof(struct commit *));
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+
+	traverse_commit_list(&revs, show_commit, show_object, NULL);
+	stop_progress(&progress_state);
+
+	if (found_commits != nr_commits)
+		die("Missing commits in the walk? Got %d, expected %d", i, nr_commits);
+}
+
+static const char *write_bitmaps_usage[] = {
+	N_("git write-bitmap --hash-cache [options...] [pack-sha1]"),
+	NULL
+};
+
+int cmd_write_bitmap(int argc, const char **argv, const char *prefix)
+{
+	int max_bitmaps = 0;
+
+	struct option write_bitmaps_options[] = {
+		OPT_SET_INT('q', "quiet", &progress,
+			    N_("do not show progress meter"), 0),
+		OPT_SET_INT(0, "progress", &progress,
+			    N_("show progress meter"), 1),
+		OPT_BOOL(0, "hash-cache", &write_hash_cache,
+			 N_("Write a cache of hashes for delta resolution")),
+		OPT_INTEGER(0, "max", &max_bitmaps,
+			    N_("max number of bitmaps to generate")),
+		OPT_END(),
+	};
+
+	struct packed_git *p;
+	struct packed_git *pack_to_index = NULL;
+	char *bitmap_filename;
+	uint16_t write_flags;
+
+	progress = isatty(2);
+	argc = parse_options(argc, argv, prefix,
+			write_bitmaps_options, write_bitmaps_usage, 0);
+
+	packed_objects = kh_init_sha1();
+	prepare_packed_git();
+
+	if (argc) {
+		unsigned char pack_sha[20];
+
+		if (get_sha1_hex(argv[0], pack_sha))
+			die("Invalid SHA1 for packfile");
+
+		for (p = packed_git; p; p = p->next) {
+			if (hashcmp(p->sha1, pack_sha) == 0) {
+				pack_to_index = p;
+				break;
+			}
+		}
+	} else {
+		pack_to_index = packed_git;
+
+		for (p = packed_git; p; p = p->next) {
+			if (p->pack_size > pack_to_index->pack_size)
+				pack_to_index = p;
+		}
+	}
+
+	if (!pack_to_index)
+		die("No packs found for indexing");
+
+	if (progress)
+		fprintf(stderr, "Indexing 'pack-%s.pack'\n",
+			sha1_to_hex(pack_to_index->sha1));
+
+	load_pack_index(pack_to_index);
+	find_all_objects(pack_to_index);
+
+	bitmap_filename = pack_bitmap_filename(pack_to_index);
+	write_flags = 0;
+
+	if (write_hash_cache)
+		write_flags |= BITMAP_OPT_HASH_CACHE;
+
+	bitmap_writer_show_progress(progress);
+	bitmap_writer_build_type_index((struct pack_idx_entry **)objects, nr_objects);
+	bitmap_writer_select_commits(walked_commits, nr_commits, max_bitmaps);
+	bitmap_writer_build(packed_objects);
+	bitmap_writer_finish(bitmap_filename, pack_to_index->sha1, write_flags);
+
+	free(bitmap_filename);
+	return 0;
+}
diff --git a/git.c b/git.c
index 4359086..66ceb2c 100644
--- a/git.c
+++ b/git.c
@@ -426,6 +426,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP },
+		{ "write-bitmap", cmd_write_bitmap, RUN_SETUP },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
 	};
 	int i;
-- 
1.7.9.5
