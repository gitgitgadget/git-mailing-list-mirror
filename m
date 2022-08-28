Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B8FECAAD5
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 12:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiH1Mu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiH1Muy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 08:50:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1625DB86C
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 05:50:52 -0700 (PDT)
Received: (qmail 27458 invoked by uid 109); 28 Aug 2022 12:50:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Aug 2022 12:50:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29708 invoked by uid 111); 28 Aug 2022 12:50:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Aug 2022 08:50:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 28 Aug 2022 08:50:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
Subject: ac/bitmap-lookup-table, was Re: What's cooking in git.git (Aug 2022,
 #09; Fri, 26)
Message-ID: <YwtkqmPSEikWPLv5@coredump.intra.peff.net>
References: <xmqqbks6ya5d.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbks6ya5d.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2022 at 02:20:30PM -0700, Junio C Hamano wrote:

> * ac/bitmap-lookup-table (2022-08-26) 6 commits
>   (merged to 'next' on 2022-08-26 at 7914c141eb)
>  + bitmap-lookup-table: add performance tests for lookup table
>  + pack-bitmap: prepare to read lookup table extension
>  + pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
>  + pack-bitmap-write.c: write lookup table extension
>  + bitmap: move `get commit positions` code to `bitmap_writer_finish`
>  + Documentation/technical: describe bitmap lookup table extension
> 
>  The pack bitmap file gained a bitmap-lookup table to speed up
>  locating the necessary bitmap for a given commit.
> 
>  Will merge to 'next'?
>  cf. <Ywf01YqJKNsGfffx@nand.local>
>  source: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>

We may want this on top:

-- >8 --
Subject: pack-bitmap-write: drop unused pack_idx_entry parameters

Our write_selected_commits_v1() function takes an array of
pack_idx_entry structs. We used to need them for computing commit
positions, but since aa30162559 (bitmap: move `get commit positions`
code to `bitmap_writer_finish`, 2022-08-14), the caller passes in a
separate array of positions for us. We can drop the unused array (and
its matching length parameter).

Likewise, when we added write_lookup_table() in 93eb41e240
(pack-bitmap-write.c: write lookup table extension, 2022-08-14), it
receives the same array of positions. So its "index" parameter was never
used at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap-write.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 2cfc92f287..a213f5eddc 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -649,8 +649,6 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 }
 
 static void write_selected_commits_v1(struct hashfile *f,
-				      struct pack_idx_entry **index,
-				      uint32_t index_nr,
 				      uint32_t *commit_positions,
 				      off_t *offsets)
 {
@@ -685,8 +683,6 @@ static int table_cmp(const void *_va, const void *_vb, void *_data)
 }
 
 static void write_lookup_table(struct hashfile *f,
-			       struct pack_idx_entry **index,
-			       uint32_t index_nr,
 			       uint32_t *commit_positions,
 			       off_t *offsets)
 {
@@ -808,10 +804,10 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 		commit_positions[i] = commit_pos;
 	}
 
-	write_selected_commits_v1(f, index, index_nr, commit_positions, offsets);
+	write_selected_commits_v1(f, commit_positions, offsets);
 
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
-		write_lookup_table(f, index, index_nr, commit_positions, offsets);
+		write_lookup_table(f, commit_positions, offsets);
 
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
-- 
2.37.2.1039.gebf11fa8a3

