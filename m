Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 607D51F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeGMVp7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 17:45:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:59034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725908AbeGMVp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 17:45:59 -0400
Received: (qmail 4648 invoked by uid 109); 13 Jul 2018 21:29:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Jul 2018 21:29:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7757 invoked by uid 111); 13 Jul 2018 21:29:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 17:29:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 17:29:34 -0400
Date:   Fri, 13 Jul 2018 17:29:34 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: prefer xsnprintf to strcpy for colors
Message-ID: <20180713212934.GA19565@sigill.intra.peff.net>
References: <20180713204350.GA16999@sigill.intra.peff.net>
 <CAGZ79kakrS_tk=x4Rb9qSu9e4RVSJ=J64eOdasKhOy=g8kV68w@mail.gmail.com>
 <20180713210452.GA18909@sigill.intra.peff.net>
 <CAGZ79kYpZy4q4vD3z5oZNZYgCYWu4YWeA4DX=E8jFW9=XUe7_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYpZy4q4vD3z5oZNZYgCYWu4YWeA4DX=E8jFW9=XUe7_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 13, 2018 at 02:10:24PM -0700, Stefan Beller wrote:

> > I'd be happy to declare strcpy() totally banned (and it more or less
> > is). I found this with a simple "git grep", though it seems like a
> > trivial application of coccinelle to find it. The question is what to
> > convert it into.
> 
> into some "meta BUG("your review process failed")"? :-)

Heh, yes, I was tempted to suggest that.

> > xsnprintf() is often a good choice, but not always
> > (e.g., if the destination isn't an array, we'd have to get the size from
> > somewhere else).
> >
> > I wouldn't be surprised if there's a way to ask coccinelle to convert
> > the easy cases and barf with an error on the hard cases or something. I
> > don't know the tool very well.
> 
> I was just suggesting that tool as it is run on pu by some automation,
> hence it would not fall through the cracks. I mean how often to you
> happen to run git grep looking for strcpy on our code base and do we
> want to rely on that in the long run?

Clearly not often enough. :)

I probably do it once or twice a year, but the ideal is "as part of
testing every topic". It wouldn't be hard to script around "git grep" as
part of the DEVELOPER build), but I think that still turns up some false
positives. Not for strcpy() or sprintf(), but snprintf() for example is
easy to use badly but sometimes the correct tool. We also have an
strncpy() which would be easy to turn into memcpy(), but it's in the
compat/regex code, which preferably we wouldn't change.

There are also probably better tools than grep (i.e., that actually
parse C), but they may not be worth the overhead (though if we can reuse
cocci for this, that seems easy enough).

As an aside, I recently got introduced to Microsoft's SDL Banned
Function list:

  https://msdn.microsoft.com/en-us/library/bb288454.aspx

They even hate memcpy! I'll grant that you _can_ use memcpy badly, but
it's often the right tool (and IMHO the C11 Annex.K memcpy_s() is not
much better).

-Peff
