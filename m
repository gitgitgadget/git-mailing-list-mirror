Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3EA11F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeGSWRW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 18:17:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:53324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727743AbeGSWRW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:17:22 -0400
Received: (qmail 11010 invoked by uid 109); 19 Jul 2018 21:32:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 21:32:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17155 invoked by uid 111); 19 Jul 2018 21:32:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 17:32:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 17:32:23 -0400
Date:   Thu, 19 Jul 2018 17:32:23 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180719213222.GB13151@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <CAGZ79ka1yHb-485xc-sAK5iVkeyWJq4Q2g-7jzEgHuVUWLBXKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka1yHb-485xc-sAK5iVkeyWJq4Q2g-7jzEgHuVUWLBXKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 02:15:54PM -0700, Stefan Beller wrote:

> >  Documentation/CodingGuidelines |  3 +++
> 
> I'd prefer to not add more text to our documentation
> (It is already long and in case you run into this problem
> the error message is clear enough IMHO)

I'm fine with that too. I just wondered if somebody would complain in
the opposite way: your patch enforces this, but we never made it an
"official" guideline.

But that may be overly paranoid.  Once upon a time there was some rules
lawyering around CodingGuidelines, but I think that was successfully
shut down and hasn't reared its head for several years.

> > +#define strcpy(x,y) BANNED(strcpy)
> > +
> > +#ifdef HAVE_VARIADIC_MACROS
> 
> In a split second I thought you forgot sprintf that was
> mentioned in the commit message, but then I kept on reading
> just to find it here. I wonder if we want put this #ifdef at the
> beginning of the file (after the guard) as then we can have
> a uncluttered list of banned functions here. The downside is that
> the use of strcpy would not be banned in case you have no
> variadic macros, but we'd still catch it quickly as most people
> have them. Undecided.

Right, exactly. We should catch what we can on lesser platforms, and
everything on modern ones. My hope is that people would not generally
have to touch this file. I don't think we'll be adding banned functions
often.

> Regarding the introduction of the functions to this list,
> I would imagine people would find the commit that introduced
> a function to the ban list to look for a reason why.
> Can we include a link[1] to explain why we discourage
> strcpy and sprintf in this commit?

I hoped that it was mostly common knowledge, but that's probably not a
good assumption. I agree if there's a good reference, we should link to
it.

> [1] https://www.thegeekstuff.com/2013/06/buffer-overflow/?utm_source=feedly
>   This is the best I found. So not sure if it worth it.

Yeah, this one is so-so, because it goes into a lot more detail. I think
we can assume that people know that overflowing a buffer is bad. Maybe
just a short paragraph like:

  We'll include strcpy() and sprintf() in the initial list of banned
  functions. While these _can_ be used carefully by surrounding them
  with extra code, there's no inherent check that the size of the
  destination buffer is big enough, it's very easy to overflow the
  buffer.

-Peff
