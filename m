Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEDC1203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758123AbcGZUs4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:48:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:49540 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758040AbcGZUsy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:48:54 -0400
Received: (qmail 11370 invoked by uid 102); 26 Jul 2016 20:48:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 16:48:54 -0400
Received: (qmail 11448 invoked by uid 107); 26 Jul 2016 20:49:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 16:49:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2016 16:48:51 -0400
Date:	Tue, 26 Jul 2016 16:48:51 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: break out of want_object loop early
Message-ID: <20160726204851.GA22353@sigill.intra.peff.net>
References: <20160725184938.GA12871@sigill.intra.peff.net>
 <20160725185010.GA12974@sigill.intra.peff.net>
 <xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com>
 <20160725214113.GA13589@sigill.intra.peff.net>
 <xmqqbn1l4c87.fsf@gitster.mtv.corp.google.com>
 <20160725221411.GA14131@sigill.intra.peff.net>
 <xmqqshuwyw14.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshuwyw14.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 01:38:47PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> I do not mind too much about having to check two bools twice.  But
> >> given that the reason why I was confused was because I didn't see
> >> why we need to pass the two "return 0" conditions at least once
> >> before we decide that we do not need the "return 0" thing at all,
> >> and started constructing a case where this might break by writing
> >> "Suppose you have two packs, one remote and one local in packed_git
> >> list in this order, and ..." before I realized that the new "early
> >> break" can be hoisted up like the above, I definitely feel that "we
> >> found one, and we aren't conditionally pretending that this thing
> >> does not need to be packed at all, so return early and say we want
> >> to pack it" is easier to understand before the two existing "if"
> >> statements.
> >
> > Ah, right. Now you had me second-guessing for a moment that there might
> > be a bad case in hoisting it up where we would want to return 0 but
> > would break out early to the "return 1".
> >
> > But it cannot be the case, because the break is mutually exclusive with
> > the two conditions.
> 
> Here is what I amended looks like (with s/local/non-local/ in the
> log message).

Thanks, I was actually just preparing a very similar patch (to move the
condition and to add a comment, since clearly it is tricky).

I got side-tracked by adding a t/perf test to show off the improvement.
It's rather tricky to get right and takes a long time to run. I _think_
I have it now, but am waiting for results. :)

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a2f8cfd..a46bf5b 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -977,6 +977,21 @@ static int want_object_in_pack(const unsigned char *sha1,
>  				return 1;
>  			if (incremental)
>  				return 0;
> +
> +			/*
> +			 * When asked to do --local (do not include an
> +			 * object that appears in a pack we borrow
> +			 * from elsewhere) or --honor-pack-keep (do not
> +			 * include an object that appears in a pack marked
> +			 * with .keep), we need to make sure no copy of this
> +			 * object come from in _any_ pack that causes us to
> +			 * omit it, and need to complete this loop.  When
> +			 * neither option is in effect, we know the object
> +			 * we just found is going to be packed, so break
> +			 * out of the loop to return 1 now.
> +			 */
> +			if (!ignore_packed_keep && !local)
> +				break;

This looks great. Given the explanation in the comment, it might be more
clear to switch the break to "return 1", but I could go either way.

-Peff
