Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0381F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 22:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbcJKW7p (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 18:59:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:56140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754266AbcJKW7o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 18:59:44 -0400
Received: (qmail 15014 invoked by uid 109); 11 Oct 2016 22:59:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 22:59:44 +0000
Received: (qmail 14564 invoked by uid 111); 11 Oct 2016 23:00:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 19:00:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 18:59:42 -0400
Date:   Tue, 11 Oct 2016 18:59:42 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Ram Rachum <ram@rachum.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Make `git fetch --all` parallel?
Message-ID: <20161011225942.tvqbbzxglvu7lldi@sigill.intra.peff.net>
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
 <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
 <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 03:50:36PM -0700, Stefan Beller wrote:

> I agree. Though even for implementing the "dumb" case of fetching
> objects twice we'd have to take care of some racing issues, I would assume.
> 
> Why did you put a "sleep 2" below?
> * a slow start to better spread load locally? (keep the workstation responsive?)
> * a slow start to have different fetches in a different phase of the
> fetch protocol?
> * avoiding some subtle race?
> 
> At the very least we would need a similar thing as Jeff recently sent for the
> push case with objects quarantined and then made available in one go?

I don't think so. The object database is perfectly happy with multiple
simultaneous writers, and nothing impacts the have/wants until actual
refs are written. Quarantining objects before the refs are written is an
orthogonal concept.

I'm not altogether convinced that parallel fetch would be that much
faster, though. Your bottleneck for a fetch is generally the network for
most of the time, then a brief spike of CPU during delta resolution. You
might get some small benefit from overlapping the fetches so that you
spend CPU on one while you spend network on the other, but I doubt it
would be nearly as beneficial as the parallel submodule clones (which
generally have a bigger CPU segment, and also are generally considered
independent, so there's no real tradeoff of getting duplicate objects).

Sometimes the bottleneck is the server preparing the back, but if that
is the case, you should probably complain to your server admin to enable
bitmaps. :)

> I would love to see the implementation though, as over time I accumulate
> a lot or remotes. (Someone published patches on the mailing list and made
> them available somewhere hosted? Grabbing them from their hosting site
> is easier than applying patches for me, so I'd rather fetch them... so I have
> some remotes now)

I usually just do a one-off fetch of their URL in such a case, exactly
because I _don't_ want to end up with a bunch of remotes. You can also
mark them with skipDefaultUpdate if you only care about them
occasionally (so you can "git fetch sbeller" when you care about it, but
it doesn't slow down your daily "git fetch").

-Peff
