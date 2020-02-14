Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E01C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC78B222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404643AbgBNSW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:22:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:43740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2403774AbgBNSWi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:22:38 -0500
Received: (qmail 23009 invoked by uid 109); 14 Feb 2020 18:22:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:22:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23702 invoked by uid 111); 14 Feb 2020 18:31:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:31:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:22:36 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/15] pack-bitmap: implement BLOB_NONE filtering
Message-ID: <20200214182236.GM150965@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182147.GA654525@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can easily support BLOB_NONE filters with bitmaps. Since we know the
types of all of the objects, we just need to clear the result bits of
any blobs.

Note two subtleties in the implementation (which I also called out in
comments):

  - we have to include any blobs that were specifically asked for (and
    not reached through graph traversal) to match the non-bitmap version

  - we have to handle in-pack and "ext_index" objects separately.
    Arguably prepare_bitmap_walk() could be adding these ext_index
    objects to the type bitmaps. But it doesn't for now, so let's match
    the rest of the bitmap code here (it probably wouldn't be an
    efficiency improvement to do so since the cost of extending those
    bitmaps is about the same as our loop here, but it might make the
    code a bit simpler).

Here are perf results for the new test on git.git:

  Test                                    HEAD^             HEAD
  --------------------------------------------------------------------------------
  5310.9: rev-list count with blob:none   1.67(1.62+0.05)   0.22(0.21+0.02) -86.8%

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c                      | 74 ++++++++++++++++++++++++++++++
 t/perf/p5310-pack-bitmaps.sh       |  5 ++
 t/t6113-rev-list-bitmap-filters.sh | 14 ++++++
 3 files changed, 93 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 48c8694f92..dcf8a9aadf 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -712,6 +712,73 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 	return 0;
 }
 
+static struct bitmap *find_tip_blobs(struct bitmap_index *bitmap_git,
+				     struct object_list *tip_objects)
+{
+	struct bitmap *result = bitmap_new();
+	struct object_list *p;
+
+	for (p = tip_objects; p; p = p->next) {
+		int pos;
+
+		if (p->item->type != OBJ_BLOB)
+			continue;
+
+		pos = bitmap_position(bitmap_git, &p->item->oid);
+		if (pos < 0)
+			continue;
+
+		bitmap_set(result, pos);
+	}
+
+	return result;
+}
+
+static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
+				    struct object_list *tip_objects,
+				    struct bitmap *to_filter)
+{
+	struct eindex *eindex = &bitmap_git->ext_index;
+	struct bitmap *tips;
+	struct ewah_iterator it;
+	eword_t mask;
+	uint32_t i;
+
+	/*
+	 * The non-bitmap version of this filter never removes
+	 * blobs which the other side specifically asked for,
+	 * so we must match that behavior.
+	 */
+	tips = find_tip_blobs(bitmap_git, tip_objects);
+
+	/*
+	 * We can use the blob type-bitmap to work in whole words
+	 * for the objects that are actually in the bitmapped packfile.
+	 */
+	for (i = 0, init_type_iterator(&it, bitmap_git, OBJ_BLOB);
+	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
+	     i++) {
+		if (i < tips->word_alloc)
+			mask &= ~tips->words[i];
+		to_filter->words[i] &= ~mask;
+	}
+
+	/*
+	 * Clear any blobs that weren't in the packfile (and so would not have
+	 * been caught by the loop above. We'll have to check them
+	 * individually.
+	 */
+	for (i = 0; i < eindex->count; i++) {
+		uint32_t pos = i + bitmap_git->pack->num_objects;
+		if (eindex->objects[i]->type == OBJ_BLOB &&
+		    bitmap_get(to_filter, pos) &&
+		    !bitmap_get(tips, pos))
+			bitmap_unset(to_filter, pos);
+	}
+
+	bitmap_free(tips);
+}
+
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
@@ -720,6 +787,13 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
 	if (!filter || filter->choice == LOFC_DISABLED)
 		return 0;
 
+	if (filter->choice == LOFC_BLOB_NONE) {
+		if (bitmap_git)
+			filter_bitmap_blob_none(bitmap_git, tip_objects,
+						to_filter);
+		return 0;
+	}
+
 	/* filter choice not handled */
 	return -1;
 }
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index e52f66ec9e..936742314c 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -47,6 +47,11 @@ test_perf 'rev-list (objects)' '
 	git rev-list --all --use-bitmap-index --objects >/dev/null
 '
 
+test_perf 'rev-list count with blob:none' '
+	git rev-list --use-bitmap-index --count --objects --all \
+		--filter=blob:none >/dev/null
+'
+
 test_expect_success 'create partial bitmap state' '
 	# pick a commit to represent the repo tip in the past
 	cutoff=$(git rev-list HEAD~100 -1) &&
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
index 977f8d0930..f4e6d582f0 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -21,4 +21,18 @@ test_expect_success 'filters fallback to non-bitmap traversal' '
 	test_cmp expect actual
 '
 
+test_expect_success 'blob:none filter' '
+	git rev-list --objects --filter=blob:none HEAD >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=blob:none HEAD >actual &&
+	test_bitmap_traversal expect actual
+'
+
+test_expect_success 'blob:none filter with specified blob' '
+	git rev-list --objects --filter=blob:none HEAD HEAD:two.t >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=blob:none HEAD HEAD:two.t >actual &&
+	test_bitmap_traversal expect actual
+'
+
 test_done
-- 
2.25.0.796.gcc29325708

