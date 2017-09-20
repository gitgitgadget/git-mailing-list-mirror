Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B266820A29
	for <e@80x24.org>; Wed, 20 Sep 2017 20:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbdITUCd (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 16:02:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:45066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751016AbdITUCc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 16:02:32 -0400
Received: (qmail 11031 invoked by uid 109); 20 Sep 2017 20:02:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 20:02:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15725 invoked by uid 111); 20 Sep 2017 20:03:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 16:03:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 16:02:29 -0400
Date:   Wed, 20 Sep 2017 16:02:29 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] diff-lib: clear `pending` object-array in
 `index_differs_from()`
Message-ID: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
References: <1505936846-2195-2-git-send-email-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1505936846-2195-2-git-send-email-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 09:47:24PM +0200, Martin Ågren wrote:

> Instead of conditionally freeing `rev.pending.objects`, just call
> `object_array_clear()` on `rev.pending`. This means we don't poke as
> much into the implementation, which is already a good thing, but also
> that we free the individual entries as well, thereby fixing a
> memory-leak.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  diff-lib.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/diff-lib.c b/diff-lib.c
> index 2a52b07..4e0980c 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -549,7 +549,6 @@ int index_differs_from(const char *def, int diff_flags,
>  	rev.diffopt.flags |= diff_flags;
>  	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
>  	run_diff_index(&rev, 1);
> -	if (rev.pending.alloc)
> -		free(rev.pending.objects);
> +	object_array_clear(&rev.pending);

Looks good. A similar bug was the exact reason for adding the function
in 46be82312. I did a grep for 'free.*\.objects' to see if there were
other cases.

There are some hits. E.g., the one in orphaned_commit_warning(). It does
something funny with setting revs.leak_pending. But I _think_ after the
whole thing is done and we call free(refs.objects), that probably ought
to be an object_array_clear().

As I suspect you're working your way through leak-checker results, I'm
OK if you want to punt on digging into more cases for now and just fix
ones that the tool has identified as real leaks.

-Peff
