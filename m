Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C281C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 10:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB68B64E70
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 10:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBIKze (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:55:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:54552 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231483AbhBIKxR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 05:53:17 -0500
Received: (qmail 25991 invoked by uid 109); 9 Feb 2021 10:52:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Feb 2021 10:52:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4083 invoked by uid 111); 9 Feb 2021 10:52:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Feb 2021 05:52:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Feb 2021 05:52:28 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] rev-list --disk-usage
Message-ID: <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a re-roll of my series to add "rev-list --disk-usage", for
counting up object storage used for various slices of history.

This fixes the minor bits mentioned in review for v1, but the big change
is that "--disk-usage" no longer implies "--objects". I think you
generally would want to use it with that option, but it really seemed to
violate the principle of least surprise for the user.

That requires handling each object type independently, but the code for
that turned out to be not too bad (and is modeled after the similar
logic in traverse_bitmap_commit_list()). I was slightly concerned that
it would slow things down to walk over the bitmap multiple times, but it
doesn't seem to make much of a difference in practice.

There's a range-diff below, but it's not really worth looking at. All of
the interesting parts were rewritten completely, so you're better off to
just read patch 2 again (and patch 1 did not change at all).

  [1/2]: t: add --no-tag option to test_commit
  [2/2]: rev-list: add --disk-usage option for calculating disk usage

 Documentation/rev-list-options.txt |  9 ++++
 builtin/rev-list.c                 | 46 +++++++++++++++++
 pack-bitmap.c                      | 81 ++++++++++++++++++++++++++++++
 pack-bitmap.h                      |  2 +
 t/t4208-log-magic-pathspec.sh      |  9 +---
 t/t6114-rev-list-du.sh             | 51 +++++++++++++++++++
 t/test-lib-functions.sh            |  9 +++-
 7 files changed, 199 insertions(+), 8 deletions(-)
 create mode 100755 t/t6114-rev-list-du.sh

1:  20f8edeff1 = 1:  6365cd94bd t: add --no-tag option to test_commit
2:  64e28cb6c9 ! 2:  8a93583dee rev-list: add --disk-usage option for calculating disk usage
    @@ Commit message
         You can find that out by generating a list of objects, getting their
         sizes from cat-file, and then summing them, like:
     
    -        git rev-list --objects main..branch
    -        cut -d' ' -f1 |
    +        git rev-list --objects --no-object-names main..branch
             git cat-file --batch-check='%(objectsize:disk)' |
             perl -lne '$total += $_; END { print $total }'
     
    @@ Commit message
         torvalds/linux:
     
           [rev-list piped to cat-file, no bitmaps]
    -      $ time git rev-list --objects --all |
    -        cut -d' ' -f1 |
    +      $ time git rev-list --objects --no-object-names --all |
             git cat-file --buffer --batch-check='%(objectsize:disk)' |
             perl -lne '$total += $_; END { print $total }'
    -      1455691059
    -      real  0m34.336s
    -      user  0m46.533s
    -      sys   0m2.953s
    +      1459938510
    +      real  0m29.635s
    +      user  0m38.003s
    +      sys   0m1.093s
     
           [internal, no bitmaps]
    -      $ time git rev-list --disk-usage --all
    -      1455691059
    -      real  0m32.662s
    -      user  0m32.306s
    -      sys   0m0.353s
    +      $ time git rev-list --disk-usage --objects --all
    +      1459938510
    +      real  0m31.262s
    +      user  0m30.885s
    +      sys   0m0.376s
     
    -    The wall-clock times aren't that different because of parallelism, but
    -    notice the CPU savings between the two. We saved 35% of the CPU just by
    +    Even though the wall-clock time is slightly worse due to parallelism,
    +    notice the CPU savings between the two. We saved 21% of the CPU just by
         avoiding the pipes.
     
         But the real win is with bitmaps. If we use them without the new option:
     
           [rev-list piped to cat-file, bitmaps]
    -      $ time git rev-list --objects --all --use-bitmap-index |
    -        cut -d' ' -f1 |
    +      $ time git rev-list --objects --no-object-names --all --use-bitmap-index |
             git cat-file --batch-check='%(objectsize:disk)' |
             perl -lne '$total += $_; END { print $total }'
    -      real  0m9.954s
    -      user  0m11.234s
    -      sys   0m8.522s
    +      1459938510
    +      real  0m6.244s
    +      user  0m8.452s
    +      sys   0m0.311s
     
         then we're faster to generate the list of objects, but we still spend a
         lot of time piping and looking things up. But if we do both together:
     
           [internal, bitmaps]
    -      $ time git rev-list --disk-usage --all --use-bitmap-index
    -      1455691059
    -      real  0m0.235s
    -      user  0m0.186s
    +      $ time git rev-list --disk-usage --objects --all --use-bitmap-index
    +      1459938510
    +      real  0m0.219s
    +      user  0m0.169s
           sys   0m0.049s
     
         then we get the same answer much faster.
    @@ Commit message
         of course. But we're actually checking reachability here, so we're still
         fast when we ask for more interesting things:
     
    -      $ time git rev-list --disk-usage --all --use-bitmap-index v5.0..v5.10
    +      $ time git rev-list --disk-usage --use-bitmap-index v5.0..v5.10
           374798628
           real  0m0.429s
           user  0m0.356s
    @@ Documentation/rev-list-options.txt: ifdef::git-rev-list[]
     +
     +--disk-usage::
     +	Suppress normal output; instead, print the sum of the bytes used
    -+	for on-disk storage by the selected objects. This is equivalent
    -+	to piping the output of `rev-list --objects` into
    -+	`git cat-file --batch-check='%(objectsize:disk)', except that it
    -+	runs much faster (especially with `--use-bitmap-index`). See the
    -+	`CAVEATS` section in linkgit:git-cat-file[1] for the limitations
    -+	of what "on-disk storage" means.
    ++	for on-disk storage by the selected commits or objects. This is
    ++	equivalent to piping the output into `git cat-file
    ++	--batch-check='%(objectsize:disk)'`, except that it runs much
    ++	faster (especially with `--use-bitmap-index`). See the `CAVEATS`
    ++	section in linkgit:git-cat-file[1] for the limitations of what
    ++	"on-disk storage" means.
      endif::git-rev-list[]
      
      --cherry-mark::
    @@ builtin/rev-list.c: static int try_bitmap_traversal(struct rev_info *revs,
     +		return -1;
     +
     +	printf("%"PRIuMAX"\n",
    -+	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git));
    ++	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
     +	return 0;
     +}
     +
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
      
     +		if (!strcmp(arg, "--disk-usage")) {
     +			show_disk_usage = 1;
    -+			revs.tag_objects = 1;
    -+			revs.tree_objects = 1;
    -+			revs.blob_objects = 1;
     +			info.flags |= REV_LIST_QUIET;
     +			continue;
     +		}
    @@ pack-bitmap.c: int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_g
      		bitmap_walk_contains(bitmap_git, bitmap_git->haves, oid);
      }
     +
    -+off_t get_disk_usage_from_bitmap(struct bitmap_index *bitmap_git)
    ++static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
    ++				     enum object_type object_type)
     +{
     +	struct bitmap *result = bitmap_git->result;
     +	struct packed_git *pack = bitmap_git->pack;
    -+	struct eindex *eindex = &bitmap_git->ext_index;
    -+	struct object_info oi = OBJECT_INFO_INIT;
    -+	off_t object_size;
     +	off_t total = 0;
    ++	struct ewah_iterator it;
    ++	eword_t filter;
     +	size_t i;
     +
    -+	oi.disk_sizep = &object_size;
    -+
    -+	for (i = 0; i < result->word_alloc; i++) {
    -+		eword_t word = result->words[i];
    ++	init_type_iterator(&it, bitmap_git, object_type);
    ++	for (i = 0; i < result->word_alloc &&
    ++			ewah_iterator_next(&filter, &it); i++) {
    ++		eword_t word = result->words[i] & filter;
     +		size_t base = (i * BITS_IN_EWORD);
     +		unsigned offset;
     +
    ++		if (!word)
    ++			continue;
    ++
     +		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
     +			size_t pos;
     +
    @@ pack-bitmap.c: int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_g
     +
     +			offset += ewah_bit_ctz64(word >> offset);
     +			pos = base + offset;
    -+
    -+			/*
    -+			 * If it's in the pack, we can use the fast path
    -+			 * and just check the revindex. Otherwise, we
    -+			 * fall back to looking it up.
    -+			 */
    -+			if (pos < pack->num_objects) {
    -+				object_size =
    -+					pack_pos_to_offset(pack, pos + 1) -
    -+					pack_pos_to_offset(pack, pos);
    -+			} else {
    -+				struct object *obj;
    -+				obj = eindex->objects[pos - pack->num_objects];
    -+				if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
    -+					die(_("unable to get disk usage of %s"),
    -+					      oid_to_hex(&obj->oid));
    -+			}
    -+
    -+			total += object_size;
    ++			total += pack_pos_to_offset(pack, pos + 1) -
    ++				 pack_pos_to_offset(pack, pos);
     +		}
     +	}
     +
     +	return total;
    ++}
    ++
    ++static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
    ++{
    ++	struct bitmap *result = bitmap_git->result;
    ++	struct packed_git *pack = bitmap_git->pack;
    ++	struct eindex *eindex = &bitmap_git->ext_index;
    ++	off_t total = 0;
    ++	struct object_info oi = OBJECT_INFO_INIT;
    ++	off_t object_size;
    ++	size_t i;
    ++
    ++	oi.disk_sizep = &object_size;
    ++
    ++	for (i = 0; i < eindex->count; i++) {
    ++		struct object *obj = eindex->objects[i];
    ++
    ++		if (!bitmap_get(result, pack->num_objects + i))
    ++			continue;
    ++
    ++		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
    ++			die(_("unable to get disk usage of %s"),
    ++			    oid_to_hex(&obj->oid));
    ++
    ++		total += object_size;
    ++	}
    ++	return total;
    ++}
    ++
    ++off_t get_disk_usage_from_bitmap(struct bitmap_index *bitmap_git,
    ++				 struct rev_info *revs)
    ++{
    ++	off_t total = 0;
    ++
    ++	total += get_disk_usage_for_type(bitmap_git, OBJ_COMMIT);
    ++	if (revs->tree_objects)
    ++		total += get_disk_usage_for_type(bitmap_git, OBJ_TREE);
    ++	if (revs->blob_objects)
    ++		total += get_disk_usage_for_type(bitmap_git, OBJ_BLOB);
    ++	if (revs->tag_objects)
    ++		total += get_disk_usage_for_type(bitmap_git, OBJ_TAG);
    ++
    ++	total += get_disk_usage_for_extended(bitmap_git);
    ++
    ++	return total;
     +}
     
      ## pack-bitmap.h ##
     @@ pack-bitmap.h: int bitmap_walk_contains(struct bitmap_index *,
       */
      int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_id *oid);
      
    -+off_t get_disk_usage_from_bitmap(struct bitmap_index *);
    ++off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
     +
      void bitmap_writer_show_progress(int show);
      void bitmap_writer_set_checksum(unsigned char *sha1);
    @@ t/t6114-rev-list-du.sh (new)
     +# packing, zlib, etc. We'll assume that the regular rev-list and cat-file
     +# machinery works and compare the --disk-usage output to that.
     +disk_usage_slow () {
    -+	git rev-list --objects "$@" |
    -+	cut -d' ' -f1 |
    ++	git rev-list --no-object-names "$@" |
     +	git cat-file --batch-check="%(objectsize:disk)" |
     +	perl -lne '$total += $_; END { print $total}'
     +}
    @@ t/t6114-rev-list-du.sh (new)
     +}
     +
     +check_du HEAD
    -+check_du HEAD^..HEAD
    ++check_du --objects HEAD
    ++check_du --objects HEAD^..HEAD
     +
     +test_done
