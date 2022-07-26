Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8434EC00144
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 22:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiGZWFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 18:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGZWFK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 18:05:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66887BF9
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 15:05:08 -0700 (PDT)
Received: (qmail 6311 invoked by uid 109); 26 Jul 2022 22:05:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Jul 2022 22:05:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27970 invoked by uid 111); 26 Jul 2022 22:05:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jul 2022 18:05:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jul 2022 18:05:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <junio@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: ds/midx-with-less-memory
Message-ID: <YuBlD3o5bYMg8f6i@coredump.intra.peff.net>
References: <xmqqh738bq21.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh738bq21.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 06:01:10PM -0700, Junio C Hamano wrote:

> * ds/midx-with-less-memory (2022-07-19) 3 commits
>   (merged to 'next' on 2022-07-20 at 250d257c3e)
>  + midx: reduce memory pressure while writing bitmaps
>  + midx: extract bitmap write setup
>  + pack-bitmap-write: use const for hashes
> 
>  The codepath to write multi-pack index has been taught to release a
>  large chunk of memory that holds an array of objects in the packs,
>  as soon as it is done with the array, to reduce memory consumption.
> 
>  Will merge to 'master'.
>  source: <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>

This topic looks very nice, but I think we might want this additional
cleanup on top:

-- >8 --
Subject: [PATCH] write_midx_bitmap(): drop unused refs_snapshot parameter

The refactoring in 90b2bb710d (midx: extract bitmap write setup,
2022-07-19) hoisted our call to find_commits_for_midx_bitmap() into the
caller, which means we no longer need to see the refs_snapshot at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 midx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 772ab7d294..4e956cacb7 100644
--- a/midx.c
+++ b/midx.c
@@ -1059,7 +1059,6 @@ static int write_midx_bitmap(const char *midx_name,
 			     struct commit **commits,
 			     uint32_t commits_nr,
 			     uint32_t *pack_order,
-			     const char *refs_snapshot,
 			     unsigned flags)
 {
 	int ret, i;
@@ -1462,7 +1461,7 @@ static int write_midx_internal(const char *object_dir,
 
 		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
 				      commits, commits_nr, ctx.pack_order,
-				      refs_snapshot, flags) < 0) {
+				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			result = 1;
 			goto cleanup;
-- 
2.37.1.641.g73229dff8a

