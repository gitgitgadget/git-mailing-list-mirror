Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF491F404
	for <e@80x24.org>; Sat,  1 Sep 2018 07:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeIALzx (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 07:55:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:36112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725964AbeIALzx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 07:55:53 -0400
Received: (qmail 24193 invoked by uid 109); 1 Sep 2018 07:44:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Sep 2018 07:44:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11557 invoked by uid 111); 1 Sep 2018 07:44:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Sep 2018 03:44:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2018 03:44:48 -0400
Date:   Sat, 1 Sep 2018 03:44:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] bitmap_has_sha1_in_uninteresting(): drop BUG check
Message-ID: <20180901074448.GA25461@sigill.intra.peff.net>
References: <20180901074145.GA24023@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180901074145.GA24023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 30cdc33fba (pack-bitmap: save "have" bitmap from
walk, 2018-08-21) introduced a new function for looking at
the "have" side of a bitmap walk. Because it only makes
sense to do so after we've finished the walk, we added an
extra safety assertion, making sure that bitmap_git->result
is non-NULL.

However, this safety is misguided. It was trying to catch
the case where we had called prepare_bitmap_walk() to give
us a "struct bitmap_index", but had not yet called
traverse_bitmap_commit_list() to walk it. But all of the
interesting computation (including setting up the result and
"have" bitmaps) happens in the first function! The latter
function only delivers the result to a callback function.

So the case we were worried about is impossible; if you get
a non-NULL result from prepare_bitmap_walk(), then its
"have" field will be fully formed.

But much worse, traverse_bitmap_commit_list() actually frees
the result field as it finishes. Which means that this
assertion is worse than useless: it's almost guaranteed to
trigger!

Our test suite didn't catch this because the function isn't
actually exercised at all. The only caller comes from
6a1e32d532 (pack-objects: reuse on-disk deltas for thin
"have" objects, 2018-08-21), and that's triggered only when
you fetch or push history that contains an object with a
base that is found deep in history. Our test suite fetches
and pushes either don't use bitmaps, or use too-small
example repositories. But any reasonably-sized real-world
push or fetch (with bitmaps) would trigger this.

This patch drops the harmful assertion and tweaks the
docstring for the function to make the precondition clear.
The tests need to be improved to exercise this new
pack-objects feature, but we'll do that in a separate
commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 2 --
 pack-bitmap.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index c3231ef9ef..76fd93a3de 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1128,8 +1128,6 @@ int bitmap_has_sha1_in_uninteresting(struct bitmap_index *bitmap_git,
 
 	if (!bitmap_git)
 		return 0; /* no bitmap loaded */
-	if (!bitmap_git->result)
-		BUG("failed to perform bitmap walk before querying");
 	if (!bitmap_git->haves)
 		return 0; /* walk had no "haves" */
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index c633bf5238..189dd68ad3 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -54,7 +54,7 @@ int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping
 void free_bitmap_index(struct bitmap_index *);
 
 /*
- * After a traversal has been performed on the bitmap_index, this can be
+ * After a traversal has been performed by prepare_bitmap_walk(), this can be
  * queried to see if a particular object was reachable from any of the
  * objects flagged as UNINTERESTING.
  */
-- 
2.19.0.rc1.549.g6ce4dc0f08

