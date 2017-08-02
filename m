Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAAE20899
	for <e@80x24.org>; Wed,  2 Aug 2017 17:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbdHBRSx (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 13:18:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:55782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753201AbdHBRSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 13:18:51 -0400
Received: (qmail 8442 invoked by uid 109); 2 Aug 2017 17:18:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 17:18:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10558 invoked by uid 111); 2 Aug 2017 17:19:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 13:19:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 13:18:49 -0400
Date:   Wed, 2 Aug 2017 13:18:49 -0400
From:   Jeff King <peff@peff.net>
To:     Dave Borowitz <dborowitz@google.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: reftable [v4]: new ref storage format
Message-ID: <20170802171849.qwg36gahgrav3o25@sigill.intra.peff.net>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
 <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
 <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
 <CAD0k6qRTa6jSgEBBX1Ux5yg4QMMWPpyOGTa471cRhtzBaS-KjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD0k6qRTa6jSgEBBX1Ux5yg4QMMWPpyOGTa471cRhtzBaS-KjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2017 at 08:20:44AM -0400, Dave Borowitz wrote:

> >> OTOH a mythical protocol v2 might reduce the need to scan the
> >> references for advertisement, so maybe this optimization will be more
> >> helpful in the future?
> 
> I haven't been following the status of the proposal, but I was
> assuming a client-speaks-first protocol would also imply the client
> asking for refnames, not SHA-1s, in which case lookup by SHA-1 is no
> longer relevant.

Good point. The hidden-refs thing Shawn described is a trick that would
be used because the current protocol is so lousy. It's not clear how a
stateless-rpc request would work, but in theory the follow-up requests
could also say "hey, I'm only interested in refs/{heads,tags}" and the
stateless server could limit is marking to that.

But that would still leave something like allowReachableSHA1InWant
having to look at all refs (and I don't see why a client requesting by
sha1 would give any limiting refspec at all). On the other hand, looking
at the ref tips would probably be dominated by actually traversing the
commits in most cases. Of course one could come up with a pathological
case pretty easily (tons of refs, and people asking for submodules at
tip commits).

So I do think there are cases where the optimization would help, but I
still not sure how much. If it's an optional bit of the design, we at
least have the option of just not generating if it turns out not to be
useful. My only concern would be if we make other protocol sacrifices or
complications to include it.

-Peff
