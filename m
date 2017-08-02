Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0292D208B4
	for <e@80x24.org>; Wed,  2 Aug 2017 17:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbdHBR2s (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 13:28:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:55800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751162AbdHBR2r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 13:28:47 -0400
Received: (qmail 9178 invoked by uid 109); 2 Aug 2017 17:28:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 17:28:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10594 invoked by uid 111); 2 Aug 2017 17:29:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 13:29:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 13:28:45 -0400
Date:   Wed, 2 Aug 2017 13:28:45 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Subject: Re: reftable [v4]: new ref storage format
Message-ID: <20170802172844.pkwjovofrzarjrgn@sigill.intra.peff.net>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
 <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
 <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
 <20170802092846.u4lyiogvvl7ezdfq@sigill.intra.peff.net>
 <CAJo=hJu1rud5pEZ93HDty1qyaCOHmwn89aEvPFe2ER0JD1ExwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJu1rud5pEZ93HDty1qyaCOHmwn89aEvPFe2ER0JD1ExwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2017 at 08:17:29AM -0700, Shawn Pearce wrote:

> > Just peeking at torvalds/linux, we have some objects with ~35K refs
> > pointing to them (e.g., the v2.6.11 tag).
> 
> Oy. I'll bet that every occurrence winds up in its own block due to
> the layout of the namespace, and so the obj block list needs 35k
> varint pointers. That requires a larger block size if it has any
> chance of fitting into the reftable format.
> 
> Another option is disable the obj table for these shared-object repos.
> Its an optional part of the format and can be omitted if the reader
> isn't likely to need to lookup by SHA-1, or is willing to pay the
> brute force cost of scanning every ref.

Yeah, sorry, I meant to write a few more paragraphs. I think refusing to
generate the object table for these repos would be OK. We don't serve
any user-facing operations out of them directly[1].

I'm also open to the argument that they're simply insane. Most of the
time we don't need them to be a real repository at all. They could exist
as a bare "objects/" directory. It's only at repack time that we
actually need to know which objects are reachable[2], so we could
do a special repack that generates the list on the fly from the child
repositories.

-Peff

[1] We actually disable the ".have" advertisements, because the cost of
    showing all of the shared-storage ref tips is too high. One thing
    I'd like to do is be able to advertise a subset of the alternate
    refs (if you're a fork of torvalds/linux, then share _just_ the refs
    from there). But with the current ref code, I can't even ask for a
    subset of the refs without paying the cost to walk all of them.
    That's one of the things I'd like to build on top of the mmap'd
    packed-refs solution (and naturally would work with reftables, too).

[2] It's a bit more complicated than just knowing the list of reachable
    objects. We also want to know which ones are reachable from which
    fork, as we do some trickery to avoid creating deltas across forks.
    So we really do want the whole ref-list, and not something like a
    de-duped set of reachable tips. I don't think that makes a
    difference for anything we're discussing here, but just a bit of
    trivia in case somebody is thinking about the shared-storage problem
    space.
