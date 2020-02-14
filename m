Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC7BC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995332086A
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390646AbgBNSWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:22:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:43754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2404448AbgBNSWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:22:40 -0500
Received: (qmail 23019 invoked by uid 109); 14 Feb 2020 18:22:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:22:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23733 invoked by uid 111); 14 Feb 2020 18:31:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:31:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:22:39 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/15] pack-bitmap: implement BLOB_LIMIT filtering
Message-ID: <20200214182239.GN150965@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182147.GA654525@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just as the previous commit implemented BLOB_NONE, we can support
BLOB_LIMIT filters by looking at the sizes of any blobs in the result
and unsetting their bits as appropriate. This is slightly more expensive
than BLOB_NONE, but still produces a noticeable speedup (these results
are on git.git):

  Test                                         HEAD~2            HEAD
  ------------------------------------------------------------------------------------
  5310.9:  rev-list count with blob:none       1.80(1.77+0.02)   0.22(0.20+0.02) -87.8%
  5310.10: rev-list count with blob:limit=1k   1.99(1.96+0.03)   0.29(0.25+0.03) -85.4%

The implementation is similar to the BLOB_NONE one, with the exception
that we have to go object-by-object while walking the blob-type bitmap
(since we can't mask out the matches, but must look up the size
individually for each blob). The trick with using ctz64() is taken from
show_objects_for_type(), which likewise needs to find individual bits
(but wants to quickly skip over big chunks without blobs).

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c                      | 80 ++++++++++++++++++++++++++++++
 t/perf/p5310-pack-bitmaps.sh       |  5 ++
 t/t6113-rev-list-bitmap-filters.sh | 20 +++++++-
 3 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index dcf8a9aadf..9d680065e4 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -779,6 +779,78 @@ static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
 	bitmap_free(tips);
 }
 
+static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
+				     uint32_t pos)
+{
+	struct packed_git *pack = bitmap_git->pack;
+	unsigned long size;
+	struct object_info oi = OBJECT_INFO_INIT;
+
+	oi.sizep = &size;
+
+	if (pos < pack->num_objects) {
+		struct revindex_entry *entry = &pack->revindex[pos];
+		if (packed_object_info(the_repository, pack,
+				       entry->offset, &oi) < 0) {
+			struct object_id oid;
+			nth_packed_object_oid(&oid, pack, entry->nr);
+			die(_("unable to get size of %s"), oid_to_hex(&oid));
+		}
+	} else {
+		struct eindex *eindex = &bitmap_git->ext_index;
+		struct object *obj = eindex->objects[pos - pack->num_objects];
+		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
+			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
+	}
+
+	return size;
+}
+
+static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
+				     struct object_list *tip_objects,
+				     struct bitmap *to_filter,
+				     unsigned long limit)
+{
+	struct eindex *eindex = &bitmap_git->ext_index;
+	struct bitmap *tips;
+	struct ewah_iterator it;
+	eword_t mask;
+	uint32_t i;
+
+	tips = find_tip_blobs(bitmap_git, tip_objects);
+
+	for (i = 0, init_type_iterator(&it, bitmap_git, OBJ_BLOB);
+	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
+	     i++) {
+		eword_t word = to_filter->words[i] & mask;
+		unsigned offset;
+
+		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
+			uint32_t pos;
+
+			if ((word >> offset) == 0)
+				break;
+			offset += ewah_bit_ctz64(word >> offset);
+			pos = i * BITS_IN_EWORD + offset;
+
+			if (!bitmap_get(tips, pos) &&
+			    get_size_by_pos(bitmap_git, pos) >= limit)
+				bitmap_unset(to_filter, pos);
+		}
+	}
+
+	for (i = 0; i < eindex->count; i++) {
+		uint32_t pos = i + bitmap_git->pack->num_objects;
+		if (eindex->objects[i]->type == OBJ_BLOB &&
+		    bitmap_get(to_filter, pos) &&
+		    !bitmap_get(tips, pos) &&
+		    get_size_by_pos(bitmap_git, pos) >= limit)
+			bitmap_unset(to_filter, pos);
+	}
+
+	bitmap_free(tips);
+}
+
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
@@ -794,6 +866,14 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
 		return 0;
 	}
 
+	if (filter->choice == LOFC_BLOB_LIMIT) {
+		if (bitmap_git)
+			filter_bitmap_blob_limit(bitmap_git, tip_objects,
+						 to_filter,
+						 filter->blob_limit_value);
+		return 0;
+	}
+
 	/* filter choice not handled */
 	return -1;
 }
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 936742314c..8b43a545c1 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -52,6 +52,11 @@ test_perf 'rev-list count with blob:none' '
 		--filter=blob:none >/dev/null
 '
 
+test_perf 'rev-list count with blob:limit=1k' '
+	git rev-list --use-bitmap-index --count --objects --all \
+		--filter=blob:limit=1k >/dev/null
+'
+
 test_expect_success 'create partial bitmap state' '
 	# pick a commit to represent the repo tip in the past
 	cutoff=$(git rev-list HEAD~100 -1) &&
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
index f4e6d582f0..145603f124 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -6,8 +6,10 @@ test_description='rev-list combining bitmaps and filters'
 test_expect_success 'set up bitmapped repo' '
 	# one commit will have bitmaps, the other will not
 	test_commit one &&
+	test_commit much-larger-blob-one &&
 	git repack -adb &&
-	test_commit two
+	test_commit two &&
+	test_commit much-larger-blob-two
 '
 
 test_expect_success 'filters fallback to non-bitmap traversal' '
@@ -35,4 +37,20 @@ test_expect_success 'blob:none filter with specified blob' '
 	test_bitmap_traversal expect actual
 '
 
+test_expect_success 'blob:limit filter' '
+	git rev-list --objects --filter=blob:limit=5 HEAD >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=blob:limit=5 HEAD >actual &&
+	test_bitmap_traversal expect actual
+'
+
+test_expect_success 'blob:limit filter with specified blob' '
+	git rev-list --objects --filter=blob:limit=5 \
+		     HEAD HEAD:much-larger-blob-two.t >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=blob:limit=5 \
+		     HEAD HEAD:much-larger-blob-two.t >actual &&
+	test_bitmap_traversal expect actual
+'
+
 test_done
-- 
2.25.0.796.gcc29325708

