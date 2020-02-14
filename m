Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90489C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DC82168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394833AbgBNSVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:21:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:43680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390489AbgBNSVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:21:50 -0500
Received: (qmail 22923 invoked by uid 109); 14 Feb 2020 18:21:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:21:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23623 invoked by uid 111); 14 Feb 2020 18:30:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:30:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:21:47 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/15] combining object filters and bitmaps
Message-ID: <20200214182147.GA654525@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213021506.GA1124607@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a v2 based on the early feedback from Junio, and a few things I
noticed while addressing it:

 - patch 4 now moves the check for revs.prune into the pack-bitmap code,
   rather than rearranging it within rev-list.

 - I noticed some more opportunities to reuse the "compare the results
   of a bitmap and non-bitmap traversal" code, so I factored that out
   into its own commit (patch 8)

 - I realized another long-standing annoyance is simple to fix: before
   we did not know how to do "rev-list --use-bitmap-index" without
   "--objects", but it was pretty easy to support. That's patch 9.

The range diff below is a little noisy because of the ripple effects of
some of those changes. If you just want to review the substantive
changes, look at patches 4, 8, and 9.

  [01/15]: pack-bitmap: factor out type iterator initialization
  [02/15]: pack-bitmap: fix leak of haves/wants object lists
  [03/15]: rev-list: fallback to non-bitmap traversal when filtering
  [04/15]: pack-bitmap: refuse to do a bitmap traversal with pathspecs
  [05/15]: rev-list: factor out bitmap-optimized routines
  [06/15]: rev-list: make --count work with --objects
  [07/15]: rev-list: allow bitmaps when counting objects
  [08/15]: t5310: factor out bitmap traversal comparison
  [09/15]: rev-list: allow commit-only bitmap traversals
  [10/15]: pack-bitmap: basic noop bitmap filter infrastructure
  [11/15]: rev-list: use bitmap filters for traversal
  [12/15]: bitmap: add bitmap_unset() function
  [13/15]: pack-bitmap: implement BLOB_NONE filtering
  [14/15]: pack-bitmap: implement BLOB_LIMIT filtering
  [15/15]: pack-objects: support filters with bitmaps

 builtin/pack-objects.c             |   6 +-
 builtin/rev-list.c                 | 114 +++++++++---
 ewah/bitmap.c                      |   8 +
 ewah/ewok.h                        |   1 +
 object.c                           |   9 +
 object.h                           |   2 +
 pack-bitmap.c                      | 272 +++++++++++++++++++++++++----
 pack-bitmap.h                      |   5 +-
 reachable.c                        |   4 +-
 t/perf/p5310-pack-bitmaps.sh       |  22 +++
 t/t5310-pack-bitmaps.sh            |  36 +++-
 t/t6000-rev-list-misc.sh           |  12 ++
 t/t6113-rev-list-bitmap-filters.sh |  56 ++++++
 t/test-lib-functions.sh            |  27 +++
 14 files changed, 504 insertions(+), 70 deletions(-)
 create mode 100755 t/t6113-rev-list-bitmap-filters.sh

Range-diff from v1:

 1:  283874f2ac =  1:  4424d745de pack-bitmap: factor out type iterator initialization
 2:  68e7bed41c =  2:  bc0576868f pack-bitmap: fix leak of haves/wants object lists
 3:  1182593fb2 =  3:  9d2ef09b9b rev-list: fallback to non-bitmap traversal when filtering
 4:  03b20e9b66 <  -:  ---------- rev-list: consolidate bitmap-disabling options
 -:  ---------- >  4:  ce7969221a pack-bitmap: refuse to do a bitmap traversal with pathspecs
 5:  91032b0d78 =  5:  a9a5513bb0 rev-list: factor out bitmap-optimized routines
 6:  c7c3a31cf3 !  6:  eab5dd34bc rev-list: make --count work with --objects
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
     +	    (revs.left_right || revs.cherry_mark))
     +		die(_("marked counting is incompatible with --objects"));
     +
    - 	if (filter_options.choice || revs.prune)
    + 	if (filter_options.choice)
      		use_bitmap_index = 0;
      
     
 7:  0aabf6262b =  7:  04af6b9362 rev-list: allow bitmaps when counting objects
 -:  ---------- >  8:  4b93d064b1 t5310: factor out bitmap traversal comparison
 -:  ---------- >  9:  d89509fa8f rev-list: allow commit-only bitmap traversals
 8:  969238ec42 ! 10:  c64d4db8e8 pack-bitmap: basic noop bitmap filter infrastructure
    @@ builtin/rev-list.c: static int try_bitmap_count(struct rev_info *revs)
      		return -1;
      
     @@ builtin/rev-list.c: static int try_bitmap_traversal(struct rev_info *revs)
    - 	if (!revs->tag_objects || !revs->tree_objects || !revs->blob_objects)
    + 	if (revs->max_count >= 0)
      		return -1;
      
     -	bitmap_git = prepare_bitmap_walk(revs);
    @@ pack-bitmap.c: static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
      	unsigned int i;
      
     @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
    - 	struct bitmap *wants_bitmap = NULL;
    - 	struct bitmap *haves_bitmap = NULL;
    + 	if (revs->prune)
    + 		return NULL;
      
    --	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
    -+	struct bitmap_index *bitmap_git;
    -+
     +	if (!can_filter_bitmap(filter))
     +		return NULL;
     +
      	/* try to open a bitmapped pack, but don't parse it yet
      	 * because we may not need to use it */
    -+	bitmap_git = xcalloc(1, sizeof(*bitmap_git));
    - 	if (open_pack_bitmap(revs->repo, bitmap_git) < 0)
    - 		goto cleanup;
    - 
    + 	bitmap_git = xcalloc(1, sizeof(*bitmap_git));
     @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
      	if (haves_bitmap)
      		bitmap_and_not(wants_bitmap, haves_bitmap);
    @@ pack-bitmap.h
      
      static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
      
    -@@ pack-bitmap.h: void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
    - void traverse_bitmap_commit_list(struct bitmap_index *,
    +@@ pack-bitmap.h: void traverse_bitmap_commit_list(struct bitmap_index *,
    + 				 struct rev_info *revs,
      				 show_reachable_fn show_reachable);
      void test_bitmap_walk(struct rev_info *revs);
     -struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs);
    @@ reachable.c: void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
     -	bitmap_git = prepare_bitmap_walk(revs);
     +	bitmap_git = prepare_bitmap_walk(revs, NULL);
      	if (bitmap_git) {
    - 		traverse_bitmap_commit_list(bitmap_git, mark_object_seen);
    + 		traverse_bitmap_commit_list(bitmap_git, revs, mark_object_seen);
      		free_bitmap_index(bitmap_git);
 9:  b4eb8fcb9d ! 11:  caa69ac535 rev-list: use bitmap filters for traversal
    @@ builtin/rev-list.c: static int try_bitmap_count(struct rev_info *revs)
      	struct bitmap_index *bitmap_git;
      
     @@ builtin/rev-list.c: static int try_bitmap_traversal(struct rev_info *revs)
    - 	if (!revs->tag_objects || !revs->tree_objects || !revs->blob_objects)
    + 	if (revs->max_count >= 0)
      		return -1;
      
     -	bitmap_git = prepare_bitmap_walk(revs, NULL);
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
      	    (revs.left_right || revs.cherry_mark))
      		die(_("marked counting is incompatible with --objects"));
      
    --	if (filter_options.choice || revs.prune)
    -+	if (revs.prune)
    - 		use_bitmap_index = 0;
    - 
    +-	if (filter_options.choice)
    +-		use_bitmap_index = 0;
    +-
      	save_commit_buffer = (revs.verbose_header ||
    + 			      revs.grep_filter.pattern_list ||
    + 			      revs.grep_filter.header_list);
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *prefix)
      		progress = start_delayed_progress(show_progress, 0);
      
10:  b518070c12 = 12:  d3e7462138 bitmap: add bitmap_unset() function
11:  438c21082e ! 13:  07ee699520 pack-bitmap: implement BLOB_NONE filtering
    @@ Commit message
             bitmaps is about the same as our loop here, but it might make the
             code a bit simpler).
     
    -    The regression tests just compare the bitmap output to the non-bitmap
    -    output. Since the code internally falls back to the non-bitmap path in
    -    some cases, this is at risk of being a trivial noop. To combat this,
    -    we'll check for small differences between the two outputs (see the
    -    comment in the test). This is a little fragile, as it's possible that we
    -    may teach the fallback path for --use-bitmap-index to produce
    -    bitmap-like output in the future. But the exact ordering of objects
    -    would likely be different in such a case, anyway.
    +    Here are perf results for the new test on git.git:
     
    -    Plus we'd catch an unexpected fallback when running the perf suite, as
    -    things would get slower. Here's what it looks like now (on git.git):
    -
    -    Test                                    HEAD^             HEAD
    -    --------------------------------------------------------------------------------
    -    5310.7: rev-list count with blob:none   1.67(1.62+0.05)   0.22(0.21+0.02) -86.8%
    +      Test                                    HEAD^             HEAD
    +      --------------------------------------------------------------------------------
    +      5310.9: rev-list count with blob:none   1.67(1.62+0.05)   0.22(0.21+0.02) -86.8%
     
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
    @@ pack-bitmap.c: static int filter_bitmap(struct bitmap_index *bitmap_git,
      }
     
      ## t/perf/p5310-pack-bitmaps.sh ##
    -@@ t/perf/p5310-pack-bitmaps.sh: test_perf 'pack to file (bitmap)' '
    - 	git pack-objects --use-bitmap-index --all pack1b </dev/null >/dev/null
    +@@ t/perf/p5310-pack-bitmaps.sh: test_perf 'rev-list (objects)' '
    + 	git rev-list --all --use-bitmap-index --objects >/dev/null
      '
      
     +test_perf 'rev-list count with blob:none' '
    @@ t/t6113-rev-list-bitmap-filters.sh: test_expect_success 'filters fallback to non
      	test_cmp expect actual
      '
      
    -+# the bitmap and regular traversals produce subtly different output:
    -+#
    -+#   - regular output is in traversal order, whereas bitmap is split by type,
    -+#     with non-packed objects at the end
    -+#
    -+#   - regular output has a space and the pathname appended to non-commit
    -+#     objects; bitmap output omits this
    -+#
    -+# Normalize and compare the two. The second argument should always be the
    -+# bitmap output.
    -+cmp_bitmap_traversal () {
    -+	if cmp "$1" "$2"
    -+	then
    -+		echo >&2 "identical raw outputs; are you sure bitmaps were used?"
    -+		return 1
    -+	fi &&
    -+	cut -d' ' -f1 "$1" | sort >"$1.normalized" &&
    -+	sort "$2" >"$2.normalized" &&
    -+	test_cmp "$1.normalized" "$2.normalized"
    -+}
    -+
     +test_expect_success 'blob:none filter' '
     +	git rev-list --objects --filter=blob:none HEAD >expect &&
     +	git rev-list --use-bitmap-index \
     +		     --objects --filter=blob:none HEAD >actual &&
    -+	cmp_bitmap_traversal expect actual
    ++	test_bitmap_traversal expect actual
     +'
     +
     +test_expect_success 'blob:none filter with specified blob' '
     +	git rev-list --objects --filter=blob:none HEAD HEAD:two.t >expect &&
     +	git rev-list --use-bitmap-index \
     +		     --objects --filter=blob:none HEAD HEAD:two.t >actual &&
    -+	cmp_bitmap_traversal expect actual
    ++	test_bitmap_traversal expect actual
     +'
     +
      test_done
12:  05cd57f0ba ! 14:  f35fab09a0 pack-bitmap: implement BLOB_LIMIT filtering
    @@ Commit message
         than BLOB_NONE, but still produces a noticeable speedup (these results
         are on git.git):
     
    -      Test                                        HEAD~2            HEAD
    +      Test                                         HEAD~2            HEAD
           ------------------------------------------------------------------------------------
    -      5310.7: rev-list count with blob:none       1.80(1.77+0.02)   0.22(0.20+0.02) -87.8%
    -      5310.8: rev-list count with blob:limit=1k   1.99(1.96+0.03)   0.29(0.25+0.03) -85.4%
    +      5310.9:  rev-list count with blob:none       1.80(1.77+0.02)   0.22(0.20+0.02) -87.8%
    +      5310.10: rev-list count with blob:limit=1k   1.99(1.96+0.03)   0.29(0.25+0.03) -85.4%
     
         The implementation is similar to the BLOB_NONE one, with the exception
         that we have to go object-by-object while walking the blob-type bitmap
    @@ t/t6113-rev-list-bitmap-filters.sh: test_description='rev-list combining bitmaps
      
      test_expect_success 'filters fallback to non-bitmap traversal' '
     @@ t/t6113-rev-list-bitmap-filters.sh: test_expect_success 'blob:none filter with specified blob' '
    - 	cmp_bitmap_traversal expect actual
    + 	test_bitmap_traversal expect actual
      '
      
     +test_expect_success 'blob:limit filter' '
     +	git rev-list --objects --filter=blob:limit=5 HEAD >expect &&
     +	git rev-list --use-bitmap-index \
     +		     --objects --filter=blob:limit=5 HEAD >actual &&
    -+	cmp_bitmap_traversal expect actual
    ++	test_bitmap_traversal expect actual
     +'
     +
     +test_expect_success 'blob:limit filter with specified blob' '
    @@ t/t6113-rev-list-bitmap-filters.sh: test_expect_success 'blob:none filter with s
     +	git rev-list --use-bitmap-index \
     +		     --objects --filter=blob:limit=5 \
     +		     HEAD HEAD:much-larger-blob-two.t >actual &&
    -+	cmp_bitmap_traversal expect actual
    ++	test_bitmap_traversal expect actual
     +'
     +
      test_done
13:  1e5befb73a ! 15:  797dbfe28f pack-objects: support filters with bitmaps
    @@ Commit message
         This unsurprisingly makes things faster for partial clones of large
         repositories (here we're cloning linux.git):
     
    -      Test                              HEAD^               HEAD
    +      Test                               HEAD^               HEAD
           ------------------------------------------------------------------------------
    -      5310.9: simulated partial clone   38.94(37.28+5.87)   11.06(11.27+4.07) -71.6%
    +      5310.11: simulated partial clone   38.94(37.28+5.87)   11.06(11.27+4.07) -71.6%
     
      ## builtin/pack-objects.c ##
     @@ builtin/pack-objects.c: static int pack_options_allow_reuse(void)
