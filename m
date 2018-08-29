Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6111F428
	for <e@80x24.org>; Wed, 29 Aug 2018 21:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeH3BC3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:02:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:32798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727595AbeH3BC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:02:29 -0400
Received: (qmail 20038 invoked by uid 109); 29 Aug 2018 21:03:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 21:03:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18612 invoked by uid 111); 29 Aug 2018 21:03:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 17:03:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 17:03:48 -0400
Date:   Wed, 29 Aug 2018 17:03:48 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180829210348.GA29880@sigill.intra.peff.net>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
 <20180829052519.GA17253@sigill.intra.peff.net>
 <CAGZ79kZv4BjRq=kq_1UeT2Kn38OZwYFgnMsTe6X_WP41=hBtSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZv4BjRq=kq_1UeT2Kn38OZwYFgnMsTe6X_WP41=hBtSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 11:10:51AM -0700, Stefan Beller wrote:

> > Do you care about case-folding issues (e.g., submodules "FOO" and "foo"
> > colliding)?
> 
> I do. :(
> 
> 2d84f13dcb6 (config: fix case sensitive subsection names on writing, 2018-08-08)
> explains the latest episode of case folding with submodules involved.
> 
> > I'm OK if the answer is "no", but if you do want to deal with it, the
> > time is probably now.
> 
> Good point. But as soon as we start discussing case sensitivity, we
> are drawn down the rabbit hole of funny file names. (Try naming
> a submodule "CON1" and obtain it on Windows for example)
> So we would need to have a file system specific encoding function for
> submodule names, which sounds like a maintenance night mare.

Hmph. I'd hoped that simply escaping metacharacters and doing some
obvious case-folding would be enough. And I think that would cover most
accidental cases. But yeah, Windows reserved names are basically
indistinguishable from reasonable names. They'd probably need
special-cased.

OTOH, I'm not sure how we handle those for entries in the actual tree.
Poking around git-for-windows/git, I think it uses the magic "\\?"
marker to tell the OS to interpret the name literally.

So I wonder if it might be sufficient to just deal with the more obvious
folding issues. Or as you noted, if we just choose lowercase names as
the normalized form, that might also be enough. :)

> So if I was thinking in the scheme presented above, we could just
> have another rule that is
> 
>   [A-Z]  -> _[a-z]
> 
> (lowercase capital letters and escape them with an underscore)

Yes, that makes even the capitalized "CON" issues go away. It's not a
one-to-one mapping, though ("foo-" and "foo_" map to the same entity).

If we want that, too, I think something like url-encoding is fine, with
the caveat that we simply urlencode _more_ things (i.e., anything not in
[a-z_]).

-Peff
