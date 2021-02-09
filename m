Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387ADC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 10:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D499C64E26
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 10:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhBIK5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:57:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:54564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231894AbhBIKyf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 05:54:35 -0500
Received: (qmail 26018 invoked by uid 109); 9 Feb 2021 10:53:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Feb 2021 10:53:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4108 invoked by uid 111); 9 Feb 2021 10:53:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Feb 2021 05:53:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Feb 2021 05:53:50 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 2/2] rev-list: add --disk-usage option for calculating
 disk usage
Message-ID: <YCJpvi0V045PkpJ2@coredump.intra.peff.net>
References: <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can sometimes be useful to see which refs are contributing to the
overall repository size (e.g., does some branch have a bunch of objects
not found elsewhere in history, which indicates that deleting it would
shrink the size of a clone).

You can find that out by generating a list of objects, getting their
sizes from cat-file, and then summing them, like:

    git rev-list --objects --no-object-names main..branch
    git cat-file --batch-check='%(objectsize:disk)' |
    perl -lne '$total += $_; END { print $total }'

Though note that the caveats from git-cat-file(1) apply here. We "blame"
base objects more than their deltas, even though the relationship could
easily be flipped. Still, it can be a useful rough measure.

But one problem is that it's slow to run. Teaching rev-list to sum up
the sizes can be much faster for two reasons:

  1. It skips all of the piping of object names and sizes.

  2. If bitmaps are in use, for objects that are in the
     bitmapped packfile we can skip the oid_object_info()
     lookup entirely, and just ask the revindex for the
     on-disk size.

This patch implements a --disk-usage option which produces the same
answer in a fraction of the time. Here are some timings using a clone of
torvalds/linux:

  [rev-list piped to cat-file, no bitmaps]
  $ time git rev-list --objects --no-object-names --all |
    git cat-file --buffer --batch-check='%(objectsize:disk)' |
    perl -lne '$total += $_; END { print $total }'
  1459938510
  real	0m29.635s
  user	0m38.003s
  sys	0m1.093s

  [internal, no bitmaps]
  $ time git rev-list --disk-usage --objects --all
  1459938510
  real	0m31.262s
  user	0m30.885s
  sys	0m0.376s

Even though the wall-clock time is slightly worse due to parallelism,
notice the CPU savings between the two. We saved 21% of the CPU just by
avoiding the pipes.

But the real win is with bitmaps. If we use them without the new option:

  [rev-list piped to cat-file, bitmaps]
  $ time git rev-list --objects --no-object-names --all --use-bitmap-index |
    git cat-file --batch-check='%(objectsize:disk)' |
    perl -lne '$total += $_; END { print $total }'
  1459938510
  real	0m6.244s
  user	0m8.452s
  sys	0m0.311s

then we're faster to generate the list of objects, but we still spend a
lot of time piping and looking things up. But if we do both together:

  [internal, bitmaps]
  $ time git rev-list --disk-usage --objects --all --use-bitmap-index
  1459938510
  real	0m0.219s
  user	0m0.169s
  sys	0m0.049s

then we get the same answer much faster.

For "--all", that answer will correspond closely to "du objects/pack",
of course. But we're actually checking reachability here, so we're still
fast when we ask for more interesting things:

  $ time git rev-list --disk-usage --use-bitmap-index v5.0..v5.10
  374798628
  real	0m0.429s
  user	0m0.356s
  sys	0m0.072s

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt |  9 ++++
 builtin/rev-list.c                 | 46 +++++++++++++++++
 pack-bitmap.c                      | 81 ++++++++++++++++++++++++++++++
 pack-bitmap.h                      |  2 +
 t/t6114-rev-list-du.sh             | 51 +++++++++++++++++++
 5 files changed, 189 insertions(+)
 create mode 100755 t/t6114-rev-list-du.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 96cc89d157..1238bfd915 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -227,6 +227,15 @@ ifdef::git-rev-list[]
 	test the exit status to see if a range of objects is fully
 	connected (or not).  It is faster than redirecting stdout
 	to `/dev/null` as the output does not have to be formatted.
+
+--disk-usage::
+	Suppress normal output; instead, print the sum of the bytes used
+	for on-disk storage by the selected commits or objects. This is
+	equivalent to piping the output into `git cat-file
+	--batch-check='%(objectsize:disk)'`, except that it runs much
+	faster (especially with `--use-bitmap-index`). See the `CAVEATS`
+	section in linkgit:git-cat-file[1] for the limitations of what
+	"on-disk storage" means.
 endif::git-rev-list[]
 
 --cherry-mark::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 25c6c3b38d..b4d8ea0a35 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -80,6 +80,19 @@ static int arg_show_object_names = 1;
 
 #define DEFAULT_OIDSET_SIZE     (16*1024)
 
+static int show_disk_usage;
+static off_t total_disk_usage;
+
+static off_t get_object_disk_usage(struct object *obj)
+{
+	off_t size;
+	struct object_info oi = OBJECT_INFO_INIT;
+	oi.disk_sizep = &size;
+	if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
+		die(_("unable to get disk usage of %s"), oid_to_hex(&obj->oid));
+	return size;
+}
+
 static void finish_commit(struct commit *commit);
 static void show_commit(struct commit *commit, void *data)
 {
@@ -88,6 +101,9 @@ static void show_commit(struct commit *commit, void *data)
 
 	display_progress(progress, ++progress_counter);
 
+	if (show_disk_usage)
+		total_disk_usage += get_object_disk_usage(&commit->object);
+
 	if (info->flags & REV_LIST_QUIET) {
 		finish_commit(commit);
 		return;
@@ -258,6 +274,8 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 	if (finish_object(obj, name, cb_data))
 		return;
 	display_progress(progress, ++progress_counter);
+	if (show_disk_usage)
+		total_disk_usage += get_object_disk_usage(obj);
 	if (info->flags & REV_LIST_QUIET)
 		return;
 
@@ -452,6 +470,23 @@ static int try_bitmap_traversal(struct rev_info *revs,
 	return 0;
 }
 
+static int try_bitmap_disk_usage(struct rev_info *revs,
+				 struct list_objects_filter_options *filter)
+{
+	struct bitmap_index *bitmap_git;
+
+	if (!show_disk_usage)
+		return -1;
+
+	bitmap_git = prepare_bitmap_walk(revs, filter);
+	if (!bitmap_git)
+		return -1;
+
+	printf("%"PRIuMAX"\n",
+	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
+	return 0;
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -584,6 +619,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, "--disk-usage")) {
+			show_disk_usage = 1;
+			info.flags |= REV_LIST_QUIET;
+			continue;
+		}
+
 		usage(rev_list_usage);
 
 	}
@@ -626,6 +667,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (use_bitmap_index) {
 		if (!try_bitmap_count(&revs, &filter_options))
 			return 0;
+		if (!try_bitmap_disk_usage(&revs, &filter_options))
+			return 0;
 		if (!try_bitmap_traversal(&revs, &filter_options))
 			return 0;
 	}
@@ -690,5 +733,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			printf("%d\n", revs.count_left + revs.count_right);
 	}
 
+	if (show_disk_usage)
+		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
+
 	return 0;
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 60fe20fb87..1f69b5fa85 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1430,3 +1430,84 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_git,
 	return bitmap_git &&
 		bitmap_walk_contains(bitmap_git, bitmap_git->haves, oid);
 }
+
+static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
+				     enum object_type object_type)
+{
+	struct bitmap *result = bitmap_git->result;
+	struct packed_git *pack = bitmap_git->pack;
+	off_t total = 0;
+	struct ewah_iterator it;
+	eword_t filter;
+	size_t i;
+
+	init_type_iterator(&it, bitmap_git, object_type);
+	for (i = 0; i < result->word_alloc &&
+			ewah_iterator_next(&filter, &it); i++) {
+		eword_t word = result->words[i] & filter;
+		size_t base = (i * BITS_IN_EWORD);
+		unsigned offset;
+
+		if (!word)
+			continue;
+
+		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
+			size_t pos;
+
+			if ((word >> offset) == 0)
+				break;
+
+			offset += ewah_bit_ctz64(word >> offset);
+			pos = base + offset;
+			total += pack_pos_to_offset(pack, pos + 1) -
+				 pack_pos_to_offset(pack, pos);
+		}
+	}
+
+	return total;
+}
+
+static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
+{
+	struct bitmap *result = bitmap_git->result;
+	struct packed_git *pack = bitmap_git->pack;
+	struct eindex *eindex = &bitmap_git->ext_index;
+	off_t total = 0;
+	struct object_info oi = OBJECT_INFO_INIT;
+	off_t object_size;
+	size_t i;
+
+	oi.disk_sizep = &object_size;
+
+	for (i = 0; i < eindex->count; i++) {
+		struct object *obj = eindex->objects[i];
+
+		if (!bitmap_get(result, pack->num_objects + i))
+			continue;
+
+		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
+			die(_("unable to get disk usage of %s"),
+			    oid_to_hex(&obj->oid));
+
+		total += object_size;
+	}
+	return total;
+}
+
+off_t get_disk_usage_from_bitmap(struct bitmap_index *bitmap_git,
+				 struct rev_info *revs)
+{
+	off_t total = 0;
+
+	total += get_disk_usage_for_type(bitmap_git, OBJ_COMMIT);
+	if (revs->tree_objects)
+		total += get_disk_usage_for_type(bitmap_git, OBJ_TREE);
+	if (revs->blob_objects)
+		total += get_disk_usage_for_type(bitmap_git, OBJ_BLOB);
+	if (revs->tag_objects)
+		total += get_disk_usage_for_type(bitmap_git, OBJ_TAG);
+
+	total += get_disk_usage_for_extended(bitmap_git);
+
+	return total;
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 25dfcf5615..36d99930d8 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -68,6 +68,8 @@ int bitmap_walk_contains(struct bitmap_index *,
  */
 int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_id *oid);
 
+off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
+
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
 void bitmap_writer_build_type_index(struct packing_data *to_pack,
diff --git a/t/t6114-rev-list-du.sh b/t/t6114-rev-list-du.sh
new file mode 100755
index 0000000000..b4aef32b71
--- /dev/null
+++ b/t/t6114-rev-list-du.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='basic tests of rev-list --disk-usage'
+. ./test-lib.sh
+
+# we want a mix of reachable and unreachable, as well as
+# objects in the bitmapped pack and some outside of it
+test_expect_success 'set up repository' '
+	test_commit --no-tag one &&
+	test_commit --no-tag two &&
+	git repack -adb &&
+	git reset --hard HEAD^ &&
+	test_commit --no-tag three &&
+	test_commit --no-tag four &&
+	git reset --hard HEAD^
+'
+
+# We don't want to hardcode sizes, because they depend on the exact details of
+# packing, zlib, etc. We'll assume that the regular rev-list and cat-file
+# machinery works and compare the --disk-usage output to that.
+disk_usage_slow () {
+	git rev-list --no-object-names "$@" |
+	git cat-file --batch-check="%(objectsize:disk)" |
+	perl -lne '$total += $_; END { print $total}'
+}
+
+# check behavior with given rev-list options; note that
+# whitespace is not preserved in args
+check_du () {
+	args=$*
+
+	test_expect_success "generate expected size ($args)" "
+		disk_usage_slow $args >expect
+	"
+
+	test_expect_success "rev-list --disk-usage without bitmaps ($args)" "
+		git rev-list --disk-usage $args >actual &&
+		test_cmp expect actual
+	"
+
+	test_expect_success "rev-list --disk-usage with bitmaps ($args)" "
+		git rev-list --disk-usage --use-bitmap-index $args >actual &&
+		test_cmp expect actual
+	"
+}
+
+check_du HEAD
+check_du --objects HEAD
+check_du --objects HEAD^..HEAD
+
+test_done
-- 
2.30.1.887.ge7d57fcab0
