Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5FEC1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 18:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeIYANg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 20:13:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:57508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727497AbeIYANg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 20:13:36 -0400
Received: (qmail 5019 invoked by uid 109); 24 Sep 2018 18:10:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Sep 2018 18:10:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28709 invoked by uid 111); 24 Sep 2018 18:09:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 24 Sep 2018 14:09:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2018 14:10:12 -0400
Date:   Mon, 24 Sep 2018 14:10:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180924181011.GA24781@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
 <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
 <20180921213753.GA11177@sigill.intra.peff.net>
 <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
 <20180921221832.GC11177@sigill.intra.peff.net>
 <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 08:17:14AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I was suggesting that check_everything_connected() is not strictly
> > transport-related, so would be inappropriate for transport.*, and we'd
> > need a more generic name. And my "either way" was that I could see
> > an argument that it _is_ transport related, since we only call it now
> > when receiving a pack. But that doesn't have to be the case, and
> > certainly implementing it with "rev-list --alternate-refs" muddies that
> > considerably.
> 
> Even after 7043c707 ("check_everything_connected: use a struct with
> named options", 2016-07-15) unified many into check_connected(),
> there still are different reasons why we call to find out about the
> connectivity, and I doubt we can afford to have a single knob that
> is shared both for transport and other kind of connectivity checks
> (like fsck or repack).  Do we want to be affected by "we pretend
> that these are the only refs exported from that alternate object
> store" when repacking and pruning only local objects and keep us
> rely on the alternate, for example?

Actually, yes, I think there is value in a single knob. At least that's
what I'd want for our (GitHub's) use case.

Remember that these alternate refs might not exist at all (the
alternates mechanism can work with just a bare "objects" directory,
unconnected from a real git repo). So I think anything using them has to
view it as a "best effort" optimization: we might or might not know
about some ref tips that might or might not cover the whole set of
objects in the alternate. They're the things we _guarantee_ that the
alternate has full connectivity for, and it might have more.

So I think it's conceptually consistent to always show a subset. I did
qualify with "for our use case" because some people might be primarily
concerned with the bandwidth of sending .haves across the network.
Whereas at our scale, even enumerating them at all is prohibitively
expensive.

One thing we could do is add a "core" config now (whether it's in core.*
or wherever). And then if later somebody wants receive-pack to behave
differently, we have an out: we can add transfer.alternateRefsCommand or
even receive.alternateRefsCommand that take precedence in those
situations.

Of course we could add the more restricted ones now, and add the "core"
one later as new uses grow. But that's more work now, since we'd have to
plumb through that context to the for_each_alternate_ref() interface.
I'd rather punt on that work until later (because I suspect that "later"
will never actually come).

> In any case it is good that these configuration variables are
> defined on _our_ side, not in the alternate---it means that we do
> not have to worry about the case where the alternateRefsCommand lies
> and tells us that an object that the alternate does not actually
> have exists at a tip of a ref in an attempt to confuse us, etc.

Yes. It also makes it easy to use "git -c" to override the scheme if you
want to (as opposed to mucking with on-disk files in the alternate).

-Peff
