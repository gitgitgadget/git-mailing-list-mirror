Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB931F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeHUW20 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:28:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:50766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727233AbeHUW2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:28:25 -0400
Received: (qmail 6974 invoked by uid 109); 21 Aug 2018 19:07:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 19:07:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26093 invoked by uid 111); 21 Aug 2018 19:07:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 15:07:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 15:07:01 -0400
Date:   Tue, 21 Aug 2018 15:07:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] pack-bitmap: save "have" bitmap from walk
Message-ID: <20180821190701.GE30764@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821184140.GA24165@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we do a bitmap walk, we save the result, which
represents (WANTs & ~HAVEs); i.e., every object we care
about visiting in our walk. However, we throw away the
haves bitmap, which can sometimes be useful, too. Save it
and provide an access function so code which has performed a
walk can query it.

A few notes on the accessor interface:

 - the bitmap code calls these "haves" because it grew out
   of the want/have negotiation for fetches. But really,
   these are simply the objects that would be flagged
   UNINTERESTING in a regular traversal. Let's use that
   more universal nomenclature for the external module
   interface. We may want to change the internal naming
   inside the bitmap code, but that's outside the scope of
   this patch.

 - it still uses a bare "sha1" rather than "oid". That's
   true of all of the bitmap code. And in this particular
   instance, our caller in pack-objects is dealing with the
   bare sha1 that comes from a packed REF_DELTA (we're
   pointing directly to the mmap'd pack on disk). That's
   something we'll have to deal with as we transition to a
   new hash, but we can wait and see how the caller ends up
   being fixed and adjust this interface accordingly.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 25 ++++++++++++++++++++++++-
 pack-bitmap.h |  7 +++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f0a1937a1c..c3231ef9ef 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -86,6 +86,9 @@ struct bitmap_index {
 	/* Bitmap result of the last performed walk */
 	struct bitmap *result;
 
+	/* "have" bitmap from the last performed walk */
+	struct bitmap *haves;
+
 	/* Version of the bitmap index */
 	unsigned int version;
 
@@ -759,8 +762,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
 
 	bitmap_git->result = wants_bitmap;
+	bitmap_git->haves = haves_bitmap;
 
-	bitmap_free(haves_bitmap);
 	return bitmap_git;
 
 cleanup:
@@ -1114,5 +1117,25 @@ void free_bitmap_index(struct bitmap_index *b)
 	free(b->ext_index.objects);
 	free(b->ext_index.hashes);
 	bitmap_free(b->result);
+	bitmap_free(b->haves);
 	free(b);
 }
+
+int bitmap_has_sha1_in_uninteresting(struct bitmap_index *bitmap_git,
+				     const unsigned char *sha1)
+{
+	int pos;
+
+	if (!bitmap_git)
+		return 0; /* no bitmap loaded */
+	if (!bitmap_git->result)
+		BUG("failed to perform bitmap walk before querying");
+	if (!bitmap_git->haves)
+		return 0; /* walk had no "haves" */
+
+	pos = bitmap_position_packfile(bitmap_git, sha1);
+	if (pos < 0)
+		return 0;
+
+	return bitmap_get(bitmap_git->haves, pos);
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 8a04741e12..c633bf5238 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -53,6 +53,13 @@ int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping
 			     khash_sha1 *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
 
+/*
+ * After a traversal has been performed on the bitmap_index, this can be
+ * queried to see if a particular object was reachable from any of the
+ * objects flagged as UNINTERESTING.
+ */
+int bitmap_has_sha1_in_uninteresting(struct bitmap_index *, const unsigned char *sha1);
+
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
 void bitmap_writer_build_type_index(struct packing_data *to_pack,
-- 
2.19.0.rc0.398.g138a08f6f6

