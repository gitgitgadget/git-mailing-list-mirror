Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8389AC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKBHz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiKBHzD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:55:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B07027B21
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:54:51 -0700 (PDT)
Received: (qmail 9052 invoked by uid 109); 2 Nov 2022 07:54:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 07:54:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3101 invoked by uid 111); 2 Nov 2022 07:54:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 03:54:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 03:54:49 -0400
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y2IiSU1L+bJPUioV@coredump.intra.peff.net>
References: <Y1rt+uOKwlP5PIrT@coredump.intra.peff.net>
 <20221102053748.7366-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102053748.7366-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 01:37:48PM +0800, Teng Long wrote:

> Jeff King <peff@peff.net> writes：
> 
> > Now this might not be as bad as it seems:
> >
> >   - in the long run, we might open those idx files anyway, if we have to
> >     access those packs. So it's really just overriding the lazy-open
> >     behavior.
> 
> Sorry, can you explain it a bit more. When we might open idxes anyway? Do you
> mean if the pack idx files will be opened sooner or later if a repo serves
> git-upload-pack many times in the long run. So, the system-wide table or the
> mmap space will not be wasted so much in practice.

I mean that later in the process, if we need to find an object we may
open the .idx file to look for it. So by opening them all up front, we
_might_ just be doing work that would get done later.

But it's not guaranteed. Imagine you have 10,000 small packs, and one
big bitmapped pack. If you can serve the request from just the big pack,
then you'd never need to open those other .idx files at all. However,
the current code will open them anyway.

I care less about mmap space, and more that it's work (syscalls, and
examining the contents of the idx) to open each one. It's probably not
even measurable unless you have a ton of packs, though.

> > So it may not be worth worrying about. It does seem like it would be
> > easy to reorder open_pack_bitmap_1() to look for a bitmap file first and
> > only open the idx if it finds something.
> 
> I think it may be worthy if we have lots of packs and the bitmap is refer to
> an older one, but I didn't make the test. At least, the scenario is common, I
> agree with that, so maybe we could shuffle the sort order in "open_pack_bitmap()".

I don't mean the order in which we look at packs. I mean the order of
operations in open_pack_bitmap_1(), something like:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 440407f1be..1df2f6c8b6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -411,9 +411,6 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	struct stat st;
 	char *bitmap_name;
 
-	if (open_pack_index(packfile))
-		return -1;
-
 	bitmap_name = pack_bitmap_filename(packfile);
 	fd = git_open(bitmap_name);
 
@@ -438,6 +435,10 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
+	/* now we know we have a plausible bitmap; make sure the idx is OK, too */
+	if (open_pack_index(packfile))
+		return -1;
+
 	if (!is_pack_valid(packfile)) {
 		close(fd);
 		return -1;

But we can further observe that the first thing is_pack_valid() will do
is open the idx file. :) So we can really just drop this line entirely,
I'd think.

BTW, another oddity I noticed in this function. We check:

   if (bitmap_git->pack || bitmap_git->midx) {
	   /* ignore extra bitmap file; we can only handle one */
	   ...
   }

but it's impossible for bitmap_git->midx to be set here. If we opened
the midx bitmap, we'll skip calling open_pack_bitmap() entirely.

-Peff
