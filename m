Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF8C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B9264E0D
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhBILLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 06:11:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:54588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232370AbhBILKR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 06:10:17 -0500
Received: (qmail 26075 invoked by uid 109); 9 Feb 2021 11:09:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Feb 2021 11:09:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4235 invoked by uid 111); 9 Feb 2021 11:09:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Feb 2021 06:09:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Feb 2021 06:09:34 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] rev-list --disk-usage
Message-ID: <YCJtbmaguIW+YeAs@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 05:52:28AM -0500, Jeff King wrote:

> This fixes the minor bits mentioned in review for v1, but the big change
> is that "--disk-usage" no longer implies "--objects". I think you
> generally would want to use it with that option, but it really seemed to
> violate the principle of least surprise for the user.
> 
> That requires handling each object type independently, but the code for
> that turned out to be not too bad (and is modeled after the similar
> logic in traverse_bitmap_commit_list()). I was slightly concerned that
> it would slow things down to walk over the bitmap multiple times, but it
> doesn't seem to make much of a difference in practice.

You might reasonably ask whether we could just directly use
traverse_bitmap_commit_list(), since after all it takes a callback. And
indeed, doing so reduces the size of the code (see the patch below).

But it's shockingly slower! It takes consistently 2-3x longer to produce
the same answer on linux.git with bitmaps. The problem is that we give
more information to the callback than the disk-usage computation needs.

In particular, finding nth_packed_object_id() is a big killer. Which
kind of makes sense. We memcpy() the oids out of the .idx file into a
"struct object_id" on the stack. And linux.git has ~200MB of oids to
copy (and I'm sure doing it 20 bytes at a time isn't quite optimal).
That adds several hundred milliseconds. Not a lot in absolute terms, but
we're able to do the whole computation in ~200ms to start with, so it's
relatively a big change.

This could be solved by having a more "bare" callback that just passes
the pack position, and not the oid (and then the callback is responsible
for looking it up if they care). But it gets pretty awkward when we have
to complete the bitmap traversal with non-bitmap objects (for those we
_do_ have an oid to pass, but no pack position). I think the
implementation in my 2/2 isn't so bad in comparison (and we can always
swap it out later; these are all just implementation details).

I did find it a bit interesting, though. When we moved to "struct
object_id" and started copying bits out with nth_packed_object_id(),
rather than just pointing to the mmap'd .idx bytes, we wondered whether
there would be any measurable difference. Likewise when we extended it
to handle the oid size changing at runtime. At the time, I wasn't able
to measure any impact for real operations, but I guess we just needed a
case that highlighted it more.

I don't know that it's really worth digging into that much, though it's
quite possible there may be some easy wins by optimizing those memcpy
calls. E.g., I'm not sure if the compiler ends up inlining them or not.
If it doesn't realize that the_hash_algo->rawsz is only ever "20" or
"32", we could perhaps help it along with specialized versions of
hashcpy(). If somebody does want to play with it, this patch may make a
good testbed. :)

-- >8 --
 builtin/pack-objects.c |  3 +-
 builtin/rev-list.c     | 40 +++++++++++------------
 pack-bitmap.c          | 86 ++------------------------------------------------
 pack-bitmap.h          |  1 +
 reachable.c            |  1 +
 5 files changed, 25 insertions(+), 106 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 13cde5896a..33f7d19eb3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1388,7 +1388,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 static int add_object_entry_from_bitmap(const struct object_id *oid,
 					enum object_type type,
 					int flags, uint32_t name_hash,
-					struct packed_git *pack, off_t offset)
+					struct packed_git *pack,
+					uint32_t pack_pos, off_t offset)
 {
 	display_progress(progress_state, ++nr_seen);
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b4d8ea0a35..cc96b4c854 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -83,13 +83,13 @@ static int arg_show_object_names = 1;
 static int show_disk_usage;
 static off_t total_disk_usage;
 
-static off_t get_object_disk_usage(struct object *obj)
+static off_t get_object_disk_usage(const struct object_id *oid)
 {
 	off_t size;
 	struct object_info oi = OBJECT_INFO_INIT;
 	oi.disk_sizep = &size;
-	if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
-		die(_("unable to get disk usage of %s"), oid_to_hex(&obj->oid));
+	if (oid_object_info_extended(the_repository, oid, &oi, 0) < 0)
+		die(_("unable to get disk usage of %s"), oid_to_hex(oid));
 	return size;
 }
 
@@ -102,7 +102,7 @@ static void show_commit(struct commit *commit, void *data)
 	display_progress(progress, ++progress_counter);
 
 	if (show_disk_usage)
-		total_disk_usage += get_object_disk_usage(&commit->object);
+		total_disk_usage += get_object_disk_usage(&commit->object.oid);
 
 	if (info->flags & REV_LIST_QUIET) {
 		finish_commit(commit);
@@ -275,7 +275,7 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 		return;
 	display_progress(progress, ++progress_counter);
 	if (show_disk_usage)
-		total_disk_usage += get_object_disk_usage(obj);
+		total_disk_usage += get_object_disk_usage(&obj->oid);
 	if (info->flags & REV_LIST_QUIET)
 		return;
 
@@ -363,8 +363,19 @@ static int show_object_fast(
 	int exclude,
 	uint32_t name_hash,
 	struct packed_git *found_pack,
+	uint32_t pack_pos,
 	off_t found_offset)
 {
+	if (show_disk_usage) {
+		if (found_pack) {
+			total_disk_usage +=
+				pack_pos_to_offset(found_pack, pack_pos + 1) -
+				found_offset;
+		} else {
+			total_disk_usage += get_object_disk_usage(oid);
+		}
+		return 1;
+	}
 	fprintf(stdout, "%s\n", oid_to_hex(oid));
 	return 1;
 }
@@ -467,23 +478,10 @@ static int try_bitmap_traversal(struct rev_info *revs,
 
 	traverse_bitmap_commit_list(bitmap_git, revs, &show_object_fast);
 	free_bitmap_index(bitmap_git);
-	return 0;
-}
-
-static int try_bitmap_disk_usage(struct rev_info *revs,
-				 struct list_objects_filter_options *filter)
-{
-	struct bitmap_index *bitmap_git;
 
-	if (!show_disk_usage)
-		return -1;
-
-	bitmap_git = prepare_bitmap_walk(revs, filter);
-	if (!bitmap_git)
-		return -1;
+	if (show_disk_usage)
+		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
 
-	printf("%"PRIuMAX"\n",
-	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
 	return 0;
 }
 
@@ -667,8 +665,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (use_bitmap_index) {
 		if (!try_bitmap_count(&revs, &filter_options))
 			return 0;
-		if (!try_bitmap_disk_usage(&revs, &filter_options))
-			return 0;
 		if (!try_bitmap_traversal(&revs, &filter_options))
 			return 0;
 	}
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1f69b5fa85..f118a365e1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -655,7 +655,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 		    (obj->type == OBJ_TAG && !revs->tag_objects))
 			continue;
 
-		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0);
+		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0, 0);
 	}
 }
 
@@ -726,7 +726,8 @@ static void show_objects_for_type(
 			if (bitmap_git->hashes)
 				hash = get_be32(bitmap_git->hashes + index_pos);
 
-			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, ofs);
+			show_reach(&oid, object_type, 0, hash,
+				   bitmap_git->pack, pos + offset, ofs);
 		}
 	}
 }
@@ -1430,84 +1431,3 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_git,
 	return bitmap_git &&
 		bitmap_walk_contains(bitmap_git, bitmap_git->haves, oid);
 }
-
-static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
-				     enum object_type object_type)
-{
-	struct bitmap *result = bitmap_git->result;
-	struct packed_git *pack = bitmap_git->pack;
-	off_t total = 0;
-	struct ewah_iterator it;
-	eword_t filter;
-	size_t i;
-
-	init_type_iterator(&it, bitmap_git, object_type);
-	for (i = 0; i < result->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
-		eword_t word = result->words[i] & filter;
-		size_t base = (i * BITS_IN_EWORD);
-		unsigned offset;
-
-		if (!word)
-			continue;
-
-		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
-			size_t pos;
-
-			if ((word >> offset) == 0)
-				break;
-
-			offset += ewah_bit_ctz64(word >> offset);
-			pos = base + offset;
-			total += pack_pos_to_offset(pack, pos + 1) -
-				 pack_pos_to_offset(pack, pos);
-		}
-	}
-
-	return total;
-}
-
-static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
-{
-	struct bitmap *result = bitmap_git->result;
-	struct packed_git *pack = bitmap_git->pack;
-	struct eindex *eindex = &bitmap_git->ext_index;
-	off_t total = 0;
-	struct object_info oi = OBJECT_INFO_INIT;
-	off_t object_size;
-	size_t i;
-
-	oi.disk_sizep = &object_size;
-
-	for (i = 0; i < eindex->count; i++) {
-		struct object *obj = eindex->objects[i];
-
-		if (!bitmap_get(result, pack->num_objects + i))
-			continue;
-
-		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
-			die(_("unable to get disk usage of %s"),
-			    oid_to_hex(&obj->oid));
-
-		total += object_size;
-	}
-	return total;
-}
-
-off_t get_disk_usage_from_bitmap(struct bitmap_index *bitmap_git,
-				 struct rev_info *revs)
-{
-	off_t total = 0;
-
-	total += get_disk_usage_for_type(bitmap_git, OBJ_COMMIT);
-	if (revs->tree_objects)
-		total += get_disk_usage_for_type(bitmap_git, OBJ_TREE);
-	if (revs->blob_objects)
-		total += get_disk_usage_for_type(bitmap_git, OBJ_BLOB);
-	if (revs->tag_objects)
-		total += get_disk_usage_for_type(bitmap_git, OBJ_TAG);
-
-	total += get_disk_usage_for_extended(bitmap_git);
-
-	return total;
-}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 36d99930d8..ba71a9f5c6 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -38,6 +38,7 @@ typedef int (*show_reachable_fn)(
 	int flags,
 	uint32_t hash,
 	struct packed_git *found_pack,
+	uint32_t pack_pos,
 	off_t found_offset);
 
 struct bitmap_index;
diff --git a/reachable.c b/reachable.c
index 77a60c70a5..79ebe8f940 100644
--- a/reachable.c
+++ b/reachable.c
@@ -182,6 +182,7 @@ static int mark_object_seen(const struct object_id *oid,
 			     int exclude,
 			     uint32_t name_hash,
 			     struct packed_git *found_pack,
+			     uint32_t pack_pos,
 			     off_t found_offset)
 {
 	struct object *obj = lookup_object_by_type(the_repository, oid, type);
