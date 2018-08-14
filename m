Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B9F1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeHNVqe (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:46:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:55092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728199AbeHNVqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:46:34 -0400
Received: (qmail 986 invoked by uid 109); 14 Aug 2018 18:58:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 18:58:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25298 invoked by uid 111); 14 Aug 2018 18:58:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 14:58:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 14:58:00 -0400
Date:   Tue, 14 Aug 2018 14:58:00 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180814185759.GA28452@sigill.intra.peff.net>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180814180406.GA86804@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:04:06AM -0700, Brandon Williams wrote:

> > I think this backwards-compatibility is necessary to avoid pain. But
> > until it goes away, I don't think this is helping the vulnerability from
> > 0383bbb901. Because there the issue was that the submodule name pointed
> > back into the working tree, so this access() would find the untrusted
> > working tree code and say "ah, an old-fashioned name!".
> [...]
> 
> Oh I know that this doesn't help with that vulnerability.  As you've
> said we fix it and now disallow ".." at the submodule-config level so
> really this path is simply about using what we get out of
> submodule-config in a more sane manor.

OK, I'm alright with that as long as we are all on the same page. I
think I mistook "this addresses the vulnerability" from your commit
message the wrong way. I took it as "this patch", but reading it again,
you simply mean "the '..' handling we already did".

I do think eventually dropping this back-compatibility could save us
from another directory-escape problem, but it's hard to justify the
real-world pain for a hypothetical benefit. Maybe in a few years we
could get rid of it in a major version bump.

> > One interesting thing about url-encoding is that it's not one-to-one.
> > This case could also be %2F, which is a different file (on a
> > case-sensitive filesystem). I think "%20" and "+" are similarly
> > interchangeable.
> > 
> > If we were decoding the filenames, that's fine. The round-trip is
> > lossless.
> > 
> > But that's not quite how the new code behaves. We encode the input and
> > then check to see if it matches an encoding we previously performed. So
> > if our urlencode routines ever change, this will subtly break.
> > 
> > I don't know how much it's worth caring about. We're not that likely to
> > change the routines ourself (though certainly a third-party
> > implementation would need to know our exact url-encoding decisions).
> 
> This is exactly the reason why I wanted to get some opinions on what the
> best thing to do here would be.  I _think_ the best thing would probably
> be to write a specific routine to do the conversion, and it wouldn't
> even have to be all that complex.  Basically I'm just interested in
> converting '/' characters so that things no longer behave like
> nested directories.

I think we benefit from catching names that would trigger filesystem
case-folding, too. If I have submodules with names "foo" and "FOO", we
would not want to confuse them (or at least we should confuse them
equally on all platforms). I doubt you can do anything malicious, but it
might simply be annoying.

That implies to me using a custom function (even if its encoded form
ends up being understandable as url-encoding).

-Peff
