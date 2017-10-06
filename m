Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D879D1FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 04:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdJFE4n (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 00:56:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:34780 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750781AbdJFE4n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 00:56:43 -0400
Received: (qmail 7962 invoked by uid 109); 6 Oct 2017 04:56:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 04:56:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2654 invoked by uid 111); 6 Oct 2017 04:56:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 00:56:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 00:56:40 -0400
Date:   Fri, 6 Oct 2017 00:56:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        t.gummerer@gmail.com, jrnieder@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/2] entry.c: check if file exists after checkout
Message-ID: <20171006045640.vihagnlnuximzmjs@sigill.intra.peff.net>
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
 <20171005104407.65948-3-lars.schneider@autodesk.com>
 <20171005112355.lsoqxybgsovpqriy@sigill.intra.peff.net>
 <xmqqlgkoyk8n.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgkoyk8n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 01:26:48PM +0900, Junio C Hamano wrote:

> > We could probably be a bit more specific about the situation, since the
> > user will see this message with no context. Maybe something like:
> >
> >   unable to stat just-written file %s
> >
> > or something. We should probably also use error_errno(). I'd bet if this
> > ever triggers that it's likely to be ENOENT, but certainly if it _isn't_
> > that would be interesting information.
> 
> ENOTDIR and to a lesser degree EACCES and ELOOP are also
> uninteresting, as we are talking about somebody else mucking with
> the filesystem.

True. The nice thing about the error() route is that we don't need to
make such judgements. The user can decide what is unexpected.

> -- >8 --
> From: Lars Schneider <larsxschneider@gmail.com>
> Date: Thu, 5 Oct 2017 12:44:07 +0200
> Subject: [PATCH] entry.c: check if file exists after checkout
> 
> If we are checking out a file and somebody else racily deletes our file,
> then we would write garbage to the cache entry. Fix that by checking
> the result of the lstat() call on that file. Print an error to the user
> if the file does not exist.

I don't know if we wanted to capture any of the reasoning behind using
error() here or not. Frankly, I'm not sure how to argue for it
succinctly. :) I'm happy with letting it live on in the list archive.

> diff --git a/entry.c b/entry.c
> index f879758c73..6d9de3a5aa 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -341,7 +341,9 @@ static int write_entry(struct cache_entry *ce,
>  	if (state->refresh_cache) {
>  		assert(state->istate);
>  		if (!fstat_done)
> -			lstat(ce->name, &st);
> +			if (lstat(ce->name, &st) < 0)
> +				return error_errno("unable stat just-written file %s",
> +						   ce->name);

s/unable stat/unable to stat/, I think.

Other than that, this looks fine to me.

-Peff
