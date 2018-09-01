Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E1E1F404
	for <e@80x24.org>; Sat,  1 Sep 2018 07:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeIAMCD (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 08:02:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:36146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726435AbeIAMCD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 08:02:03 -0400
Received: (qmail 24490 invoked by uid 109); 1 Sep 2018 07:50:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Sep 2018 07:50:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11624 invoked by uid 111); 1 Sep 2018 07:51:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Sep 2018 03:51:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2018 03:50:57 -0400
Date:   Sat, 1 Sep 2018 03:50:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] pack-bitmap: drop "loaded" flag
Message-ID: <20180901075056.GD25461@sigill.intra.peff.net>
References: <20180901074145.GA24023@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180901074145.GA24023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the early days of the bitmap code, there was a single
static bitmap_index struct that was used behind the scenes,
and any bitmap-related functions could lazily check
bitmap_git.loaded to see if they needed to read the on-disk
data.

But since 3ae5fa0768 (pack-bitmap: remove bitmap_git global
variable, 2018-06-07), the caller is responsible for the
lifetime of the bitmap_index struct, and we return it from
prepare_bitmap_git() and prepare_bitmap_walk(), both of
which load the on-disk data (or return NULL).

So outside of these functions, it's not possible to have a
bitmap_index for which the loaded flag is not true. Nor is
it possible to accidentally pass an already-loaded
bitmap_index to the loading function (which is static-local
to the file).

We can drop this unnecessary and confusing flag.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8c1af1cca2..40debd5e20 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -91,8 +91,6 @@ struct bitmap_index {
 
 	/* Version of the bitmap index */
 	unsigned int version;
-
-	unsigned loaded : 1;
 };
 
 static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
@@ -306,7 +304,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 static int load_pack_bitmap(struct bitmap_index *bitmap_git)
 {
-	assert(bitmap_git->map && !bitmap_git->loaded);
+	assert(bitmap_git->map);
 
 	bitmap_git->bitmaps = kh_init_sha1();
 	bitmap_git->ext_index.positions = kh_init_sha1_pos();
@@ -321,7 +319,6 @@ static int load_pack_bitmap(struct bitmap_index *bitmap_git)
 	if (load_bitmap_entries_v1(bitmap_git) < 0)
 		goto failed;
 
-	bitmap_git->loaded = 1;
 	return 0;
 
 failed:
@@ -336,7 +333,7 @@ static int open_pack_bitmap(struct bitmap_index *bitmap_git)
 	struct packed_git *p;
 	int ret = -1;
 
-	assert(!bitmap_git->map && !bitmap_git->loaded);
+	assert(!bitmap_git->map);
 
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (open_pack_bitmap_1(bitmap_git, p) == 0)
@@ -738,7 +735,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (!bitmap_git->loaded && load_pack_bitmap(bitmap_git) < 0)
+	if (load_pack_bitmap(bitmap_git) < 0)
 		goto cleanup;
 
 	object_array_clear(&revs->pending);
-- 
2.19.0.rc1.549.g6ce4dc0f08
