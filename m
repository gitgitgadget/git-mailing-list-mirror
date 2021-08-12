Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE090C432BE
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908AF610A8
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbhHLUXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 16:23:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:45848 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237450AbhHLUW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 16:22:58 -0400
Received: (qmail 24752 invoked by uid 109); 12 Aug 2021 20:22:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 20:22:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25322 invoked by uid 111); 12 Aug 2021 20:22:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 16:22:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 16:22:29 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 09/25] midx: avoid opening multiple MIDXs when writing
Message-ID: <YRWDBdpizLH/gX1a@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <40cff5beb50cdfbd13ae7f6017152f2628b25814.1627420428.git.me@ttaylorr.com>
 <YRWBZJDCVyUOhk2F@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRWBZJDCVyUOhk2F@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 04:15:32PM -0400, Jeff King wrote:

> I think we'd need something like this:
> 
> diff --git a/midx.c b/midx.c
> index 6dfafe7a8c..bfb6afea2e 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1123,8 +1123,7 @@ static int write_midx_internal(const char *object_dir,
>  	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
>  	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
>  
> -	if (ctx.m)
> -		close_midx(ctx.m);
> +	close_object_store(the_repository->objects);
>  
>  	if (ctx.nr - dropped_packs == 0) {
>  		error(_("no pack files to index."));
> 
> though I'm not sure:
> 
>  - if this should be unconditional or dependent on ctx.m (I think the
>    latter, because if we are renaming over any open midx, we would have
>    filled in ctx.m earlier).
> 
>  - if this should go below the "no pack files to index" check (i.e., is
>    there any point in closing if we know we will not write?). In fact,
>    its purpose might be more obvious right before finalize_hashfile(),
>    but I am OK either way on that.

Ah, this close_midx() actually gets moved and made unconditional later
in the series.  But it still needs to be close_object_store() instead.

Also, my mention of finalize_hashfile() is wrong. It's
commit_lock_file() that does the actual rename, and indeed, that's where
you moved it to in the end, which is good.

-Peff




> 
> -Peff
