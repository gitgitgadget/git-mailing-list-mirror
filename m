Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257EBC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BEF6044F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhHLUP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 16:15:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:45810 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232564AbhHLUP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 16:15:59 -0400
Received: (qmail 24713 invoked by uid 109); 12 Aug 2021 20:15:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 20:15:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25274 invoked by uid 111); 12 Aug 2021 20:15:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 16:15:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 16:15:32 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 09/25] midx: avoid opening multiple MIDXs when writing
Message-ID: <YRWBZJDCVyUOhk2F@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <40cff5beb50cdfbd13ae7f6017152f2628b25814.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40cff5beb50cdfbd13ae7f6017152f2628b25814.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 05:19:46PM -0400, Taylor Blau wrote:

> Opening multiple instance of the same MIDX can lead to problems like two
> separate packed_git structures which represent the same pack being added
> to the repository's object store.
> [...]

Thanks, I think this approach fixes all of the potential problems from
our earlier discussion. You already noted the "!ctx->m" thing in a
follow-up. But also...

> Likewise, replace the call to `close_midx()` with
> `close_object_store()`, since we're about to replace the MIDX with a new
> one and should invalidate the object store's memory of any MIDX that
> might have existed beforehand.

Yes, I agree we need to do this, but I don't see the change in the
patch. Did something get lost in the rebasing/squashing process?

I think we'd need something like this:

diff --git a/midx.c b/midx.c
index 6dfafe7a8c..bfb6afea2e 100644
--- a/midx.c
+++ b/midx.c
@@ -1123,8 +1123,7 @@ static int write_midx_internal(const char *object_dir,
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 
-	if (ctx.m)
-		close_midx(ctx.m);
+	close_object_store(the_repository->objects);
 
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));

though I'm not sure:

 - if this should be unconditional or dependent on ctx.m (I think the
   latter, because if we are renaming over any open midx, we would have
   filled in ctx.m earlier).

 - if this should go below the "no pack files to index" check (i.e., is
   there any point in closing if we know we will not write?). In fact,
   its purpose might be more obvious right before finalize_hashfile(),
   but I am OK either way on that.

-Peff
