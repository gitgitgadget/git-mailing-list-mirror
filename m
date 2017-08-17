Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D0D20899
	for <e@80x24.org>; Thu, 17 Aug 2017 15:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbdHQPWn (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 11:22:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:41668 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753154AbdHQPWm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 11:22:42 -0400
Received: (qmail 26203 invoked by uid 109); 17 Aug 2017 15:22:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 15:22:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27125 invoked by uid 111); 17 Aug 2017 15:23:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 11:23:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 11:22:40 -0400
Date:   Thu, 17 Aug 2017 11:22:40 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>, s@kazlauskas.me,
        git@vger.kernel.org
Subject: Re: [PATCH] files-backend: cheapen refname_available check when
 locking refs
Message-ID: <20170817152240.coioktoqfkcvxldj@sigill.intra.peff.net>
References: <20170709112932.njac5m6jmgmjywoz@sigill.intra.peff.net>
 <4e81f1ecf190082d3415d96650014841cd4c5b19.1502982012.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e81f1ecf190082d3415d96650014841cd4c5b19.1502982012.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 05:12:50PM +0200, Michael Haggerty wrote:

> I was testing this using the reporter's recipe (but fetching from a
> local clone), and found the following surprising timing numbers:
> 
> b05855b5bc (before the slowdown): 22.7 s
> 524a9fdb51 (immediately after the slowdown): 13 minutes
> 4e81f1ecf1 (after this fix): 14.5 s
> 
> The fact that the fetch is now significantly *faster* than before the
> slowdown seems not to have anything to do with the reference code.

I bisected this (with some hackery, since the commits in the middle all
take 13 minutes to run). The other speedup is indeed unrelated, and is
due to Brandon's aacc5c1a81 (submodule: refactor logic to determine
changed submodules, 2017-05-01).

The commit message doesn't mention performance (it's mostly about code
reduction). I think the speedup comes from using
diff_tree_combined_merge() instead of manually diffing each commit
against its parents. But I didn't do further timings to verify that (I'm
reporting it here mostly as an interesting curiosity for submodule
folks).

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index e9b95592b6..f2a420c611 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -631,11 +631,11 @@ static int lock_raw_ref(struct files_ref_store *refs,
>  
>  		/*
>  		 * If the ref did not exist and we are creating it,
> -		 * make sure there is no existing ref that conflicts
> -		 * with refname:
> +		 * make sure there is no existing packed ref that
> +		 * conflicts with refname:
>  		 */
>  		if (refs_verify_refname_available(
> -				    &refs->base, refname,
> +				    refs->packed_ref_store, refname,
>  				    extras, skip, err))
>  			goto error_return;
>  	}

This seems too easy to be true. :) But I think it matches what we were
doing before 524a9fdb51 (so it's correct), and the performance numbers
don't lie.

-Peff
