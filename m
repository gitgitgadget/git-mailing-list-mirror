Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C29EC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 19:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiKUTJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiKUTJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 14:09:19 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94B7D29B6
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:09:17 -0800 (PST)
Received: (qmail 12426 invoked by uid 109); 21 Nov 2022 19:09:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 19:09:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26515 invoked by uid 111); 21 Nov 2022 19:09:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 14:09:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 14:09:16 -0500
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 4/4] pack-bitmap.c: trace bitmap ignore logs when
 midx-bitmap is found
Message-ID: <Y3vM3GZYFy+l006d@coredump.intra.peff.net>
References: <cover.1669032425.git.dyroneteng@gmail.com>
 <2acaa3f097e0ab08a63ae1719454f5e11bb15a44.1669032426.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2acaa3f097e0ab08a63ae1719454f5e11bb15a44.1669032426.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 08:16:15PM +0800, Teng Long wrote:

> From: Jeff King <peff@peff.net>
> 
> We retained pack bitmaps as a quick recovery mechanism while
> test-deploying midx bitmaps. This is an internal mechanism, and we
> want to expose this rule externally through trace2 so that end users,
> repo-maintainers, and debuggers know what is happening in the process.

Re-reading this outside the context of the earlier thread, I think "this
rule" is a little vague. Maybe:

  When we find a midx bitmap, we do not bother checking for pack
  bitmaps, since we can use only one. But since we will warn of unused
  bitmaps via trace2, let's continue looking for pack bitmaps when
  tracing is enabled.

> @@ -559,11 +557,20 @@ static int open_midx_bitmap(struct repository *r,
>  static int open_bitmap(struct repository *r,
>  		       struct bitmap_index *bitmap_git)
>  {
> +	int found = 0;
> +
>  	assert(!bitmap_git->map);
>  
> -	if (!open_midx_bitmap(r, bitmap_git))
> -		return 0;
> -	return open_pack_bitmap(r, bitmap_git);
> +	found = !open_midx_bitmap(r, bitmap_git);

I think we can drop the initialization of "found = 0"; that value is
unused, since we'll always assign to it (I think my initial attempt had
setting it to 1 inside the conditional).

It's not hurting anything functionally, but it makes the code slightly
more confusing to read.

-Peff
