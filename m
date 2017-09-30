Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC2320A10
	for <e@80x24.org>; Sat, 30 Sep 2017 07:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbdI3HLA (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 03:11:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:55344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751345AbdI3HLA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 03:11:00 -0400
Received: (qmail 9582 invoked by uid 109); 30 Sep 2017 07:10:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 07:10:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11441 invoked by uid 111); 30 Sep 2017 07:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Sep 2017 03:11:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Sep 2017 03:10:57 -0400
Date:   Sat, 30 Sep 2017 03:10:57 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 3/5] ref-filter.c: add trailer options to used_atom
Message-ID: <20170930071057.3mosgarb5coje4pu@sigill.intra.peff.net>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930062238.87077-4-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170930062238.87077-4-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 11:22:36PM -0700, Taylor Blau wrote:

> In preparation for "%(trailers)" to take trailer parsing arguments, use Jeff's
> convenience structure for trailer processing options introduced in 8abc89800c.
> 
> We will later populate this field from the arguments given to %(trailers), and
> then use the trailer_opts instance to format ref trailers correctly using
> `format_trailer_from_commit`.

I think this should probably just be squashed in with the next patch,
since this does nothing at all without adding a caller that uses it.

> diff --git a/ref-filter.c b/ref-filter.c
> index 467c0279c..84f14093c 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -82,6 +82,7 @@ static struct used_atom {
>  		} remote_ref;
>  		struct {
>  			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
> +			struct process_trailer_options trailer_opts;
>  			unsigned int nlines;
>  		} contents;

This contents struct is odd. The used_atom struct can have many types,
and has has a big union of type-specific data.  And then we break down
the "contents" type with a further enum, but don't actually put the
type-specific data into a union (not just your patch, but already
"nlines" is specific only to C_LINES).

It's probably not worth caring about, though. The point of a union is to
reduce the overall struct size, and here our type-specific data is
fairly small. It would only change the overall struct size if it were
larger than other parts of the union (and remote_ref, for example, is
pretty big).

-Peff

PS As an aside, I find the whole %(contents:...) thing a bit
   unfortunate. I understand why the _implementation_ wants to group
   similar options together so that it can avoid parsing too much. But
   the user doesn't care about that. Just "%(trailers)" should be
   sufficient (as evidenced by the fact that we added it a separate
   alias). But none of that is new to your series.
