Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5294920D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 18:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdFUSxL (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:53:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:47822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751038AbdFUSxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:53:09 -0400
Received: (qmail 4052 invoked by uid 109); 21 Jun 2017 18:53:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 18:53:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26454 invoked by uid 111); 21 Jun 2017 18:53:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 14:53:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 14:53:07 -0400
Date:   Wed, 21 Jun 2017 14:53:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        David Turner <dturner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] docs: update 64-bit core.packedGitLimit default
Message-ID: <20170621185307.xu6rcnj2y3jvdati@sigill.intra.peff.net>
References: <20170420204118.17856-1-dturner@twosigma.com>
 <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
 <20170621135130.6724hnoovcjfduto@sigill.intra.peff.net>
 <CAGZ79kZLcNdN0TsrHwm8YoAXx7tjWoWV29j=xyQFgUuNPouUOw@mail.gmail.com>
 <20170621180618.6yc433nwpi4d5wof@sigill.intra.peff.net>
 <xmqqvanpp4n5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvanpp4n5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 11:38:54AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So the other direction, instead of avoiding the memory limit in (4), is
> > to stop closing "small" packs in (2). But I don't think that's a good
> > idea. Even with the code after David's patch, you can still trigger the
> > problem by running out of file descriptors. And if we stop closing
> > small packs, that makes it even more likely for that to happen.
> 
> I recall that when we notice that we cannot access a loose one that
> we earlier thought existed we fall back to rescan the packs?  Would
> an approach similar to that can work to deal with the "closed small
> pack goes away" scenario?

Not very well. See the first paragraph of my explanation. Basically,
pack-objects is special because it makes decisions based on (and records
pointers to) the particular packed representation. If that goes away, it
just bails.

Which isn't to say that falling back is impossible. I think in the worst
case that it could say "oops, I can't access the pack that has object X
anymore", fall back to finding _any_ copy of it and including it as a
pure base object (it's too late at that point to make a delta, and
trying to be clever about reusing on-disk deltas is likely just going to
end up with a broken corner case).

So then you have a sub-optimal pack, but at least it didn't die(). If
that happens for one object, I don't think it's that big a deal. But the
resulting pack could end up pretty sub-optimal if you lose access to a
whole pack. And remember, "small" here is just smaller than the window
size, which is a gigabyte on 64 bit systems. So imagine that you lose
access to a 500 MB pack, but we recover by sending base objects. Then
everything that was in that pack gets converted to its full non-delta
representation, which could mean it expands to several gigabytes. The
current behavior to die() and retry the fetch is not that bad an
alternative.

Of course, the best alternative is retaining access to the packs, which
is what typically happens now on 64-bit systems (it's just that the
packedGitLimit was set pointlessly low). I'm not sure if you're asking
in general, or as a last-ditch effort for 32-bit systems.

-Peff
