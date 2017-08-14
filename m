Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9289D20899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbdHNWNM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:13:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:38516 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752275AbdHNWNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:13:12 -0400
Received: (qmail 27440 invoked by uid 109); 14 Aug 2017 22:13:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 22:13:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6153 invoked by uid 111); 14 Aug 2017 22:13:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 18:13:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 18:13:10 -0400
Date:   Mon, 14 Aug 2017 18:13:10 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] commit: skip discarding the index if there is no
 pre-commit hook
Message-ID: <20170814221309.tg7wizmvx3gtzfc7@sigill.intra.peff.net>
References: <20170810185416.8224-1-kewillf@microsoft.com>
 <20170814215425.23784-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170814215425.23784-1-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 03:54:25PM -0600, Kevin Willford wrote:

> If there is not a pre-commit hook, there is no reason to discard
> the index and reread it.
> 
> This change checks to presence of a pre-commit hook and then only
> discards the index if there was one.
> 
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>  builtin/commit.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Thanks, this looks nice and simple.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index e7a2cb6285..ab71b93518 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -940,12 +940,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		return 0;
>  	}
>  
> -	/*
> -	 * Re-read the index as pre-commit hook could have updated it,
> -	 * and write it out as a tree.  We must do this before we invoke
> -	 * the editor and after we invoke run_status above.
> -	 */
> -	discard_cache();
> +	if (!no_verify && find_hook("pre-commit")) {
> +		/*
> +		 * Re-read the index as pre-commit hook could have updated it,
> +		 * and write it out as a tree.  We must do this before we invoke
> +		 * the editor and after we invoke run_status above.
> +		 */
> +		discard_cache();
> +	}
> +
>  	read_cache_from(index_file);

This read_cache_from() should be a noop, right, because it immediately
sees istate->initialized is set? So it shouldn't matter that it is not
in the conditional with discard_cache(). Though if its only purpose is
to re-read the just-discarded contents, perhaps it makes sense to put it
there for readability.

-Peff
