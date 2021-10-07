Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9504CC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 02:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657736124C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 02:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhJGC0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 22:26:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:34668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhJGC0e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 22:26:34 -0400
Received: (qmail 27641 invoked by uid 109); 7 Oct 2021 02:24:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Oct 2021 02:24:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6266 invoked by uid 111); 7 Oct 2021 02:24:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Oct 2021 22:24:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Oct 2021 22:24:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YV5aaD418SyZqS/1@coredump.intra.peff.net>
References: <xmqqfstdr8b5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfstdr8b5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 06, 2021 at 05:24:14PM -0700, Junio C Hamano wrote:

> * tb/repack-write-midx (2021-10-01) 9 commits
>   (merged to 'next' on 2021-10-06 at ccdd5aaf2a)
>  + builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
>  + builtin/repack.c: make largest pack preferred
>  + builtin/repack.c: support writing a MIDX while repacking
>  + builtin/repack.c: extract showing progress to a variable
>  + builtin/repack.c: rename variables that deal with non-kept packs
>  + builtin/repack.c: keep track of existing packs unconditionally
>  + midx: preliminary support for `--refs-snapshot`
>  + builtin/multi-pack-index.c: support `--stdin-packs` mode
>  + midx: expose `write_midx_file_only()` publicly
> 
>  "git repack" has been taught to generate multi-pack reachability
>  bitmaps.
> 
>  Will merge to 'master'.

Sorry not to catch this before it hit 'next', but there's a small leak
in the test helper. This patch can go on top to fix it.

-- >8 --
Subject: [PATCH] test-read-midx: fix leak of bitmap_index struct

In read_midx_preferred_pack(), we open the bitmap index but never free
it. This isn't a big deal since this is just a test helper, and we exit
immediately after, but since we're trying to keep our leak-checking tidy
now, it's worth fixing.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-read-midx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 0038559129..9d6fa7a377 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -85,11 +85,15 @@ static int read_midx_preferred_pack(const char *object_dir)
 		return 1;
 
 	bitmap = prepare_bitmap_git(the_repository);
-	if (!(bitmap && bitmap_is_midx(bitmap)))
+	if (!bitmap)
 		return 1;
-
+	if (!bitmap_is_midx(bitmap)) {
+		free_bitmap_index(bitmap);
+		return 1;
+	}
 
 	printf("%s\n", midx->pack_names[midx_preferred_pack(bitmap)]);
+	free_bitmap_index(bitmap);
 	return 0;
 }
 
-- 
2.33.0.1340.gfe2cb2531f

