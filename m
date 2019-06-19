Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF1F1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfFSVWB (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:22:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:44754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726230AbfFSVWB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:22:01 -0400
Received: (qmail 12852 invoked by uid 109); 19 Jun 2019 21:18:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 21:18:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10009 invoked by uid 111); 19 Jun 2019 21:22:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 17:22:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 17:21:59 -0400
Date:   Wed, 19 Jun 2019 17:21:59 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rev-list: clarify --abbrev and --abbrev-commit usage
Message-ID: <20190619212159.GA6571@sigill.intra.peff.net>
References: <20190613221541.10007-1-emilyshaffer@google.com>
 <20190614161841.GB30083@sigill.intra.peff.net>
 <20190614205950.GC233791@google.com>
 <20190614212714.GA15798@sigill.intra.peff.net>
 <20190614225654.GD233791@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614225654.GD233791@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 03:56:54PM -0700, Emily Shaffer wrote:

> > Ah, I see. I don't consider "|" to indicate an exclusion to the point
> > that the options are rejected. Only that you wouldn't want to use both,
> > because one counteracts the other. So every "--no-foo" is mutually
> > exclusive with "--foo" in the sense that one override the other. But the
> > outcome is "last one wins", and not "whoops, we cannot figure out what
> > you meant". And that's what the original:
> > 
> >       --abbrev=<n> | --no-abbrev
> > 
> > before your patch was trying to say (and I suspect there are many other
> > cases of "|" with this kind of last-one-wins behavior).
> 
> For what it's worth, in this case it's not last-one-wins - --no-abbrev
> always wins:

Ah, thanks for pointing that; I hadn't noticed. That _is_ unlike most of
the rest of Git. I'm tempted to say it's a bug and should be fixed, but
I worry slightly that it could have an unexpected effect.

> I think a good solution here is to go and add --abbrev-commit=<n>
> without breaking support for --abbrev=<n>; I'm a little more worried
> about changing --no-abbrev to last-one-wins but I'll take a crack at it
> and see what the test suite says. While I'm at it, I'll check for
> last-one-wins with multiple instances of --abbrev[-commit]=<n>.

I think --abbrev-commit=<n> sounds safe enough, though I worry it may
get a bit complicated because we'd presumably want to fall back to the
<n> from --abbrev=<n>. I'll see how your patch turns out. :)

I like the idea of changing --no-abbrev to last-one-wins, as above, but
the test suite may not give us that much confidence. These kinds of
cases are often not well-covered, and we're really worried about the
wider world of random scripts people have grown over the last 10 years.
Of course if the test suite does break horribly that might give us extra
caution, but I'm not sure "the test suite does not break" gives us much
confidence.

> Having done so, I'll also change the documentation here in rev-list to:
>  --abbrev-commit[=<n>] [--abbrev=<n>] | --no-abbrev

Yeah, that makes sense.

-Peff
