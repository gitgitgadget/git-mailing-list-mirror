Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B901F404
	for <e@80x24.org>; Tue, 23 Jan 2018 16:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeAWQRm (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 11:17:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:54368 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751840AbeAWQRl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 11:17:41 -0500
Received: (qmail 23851 invoked by uid 109); 23 Jan 2018 16:17:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 16:17:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16805 invoked by uid 111); 23 Jan 2018 16:18:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Jan 2018 11:18:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2018 11:17:38 -0500
Date:   Tue, 23 Jan 2018 11:17:38 -0500
From:   Jeff King <peff@peff.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180123161738.GC13068@sigill.intra.peff.net>
References: <20180117235220.GD6948@thunk.org>
 <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
 <20180118162721.GA26078@lst.de>
 <xmqqzi59psxt.fsf@gitster.mtv.corp.google.com>
 <20180120221445.GA4451@thunk.org>
 <xmqqefmknp3f.fsf@gitster.mtv.corp.google.com>
 <871siihqvw.fsf@evledraar.gmail.com>
 <20180122180903.GB3513@thunk.org>
 <20180123004710.GF26357@sigill.intra.peff.net>
 <20180123054553.GA21015@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180123054553.GA21015@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 12:45:53AM -0500, Theodore Ts'o wrote:

> What I was thinking about instead is that in cases where we know we
> are likely to be creating a large number of loose objects (whether
> they referenced or not), in a world where we will be calling fsync(2)
> after every single loose object being created, pack files start
> looking *way* more efficient.  So in general, if you know you will be
> creating N loose objects, where N is probably around 50 or so, you'll
> want to create a pack instead.
> 
> One of those cases is "repack -A", and in that case the loose objects
> are all going tobe not referenced, so it would be a "cruft pack".  But
> in many other cases where we might be importing from another DCVS,
> which will be another case where doing an fsync(2) after every loose
> object creation (and where I have sometimes seen it create them *all*
> loose, and not use a pack at all), is going to get extremely slow and
> painful.

Ah, I see. I think in the general case of git operations this is hard
(because most object writes don't realize the larger operation that
they're a part of). But I agree that those two are the low-hanging fruit
(imports should already be using fast-import, and "cruft packs" are not
too hard an idea to implement).

I agree that a cruft-pack implementation could just be for "repack -A",
and does not have to collect otherwise loose objects. I think part of my
confusion was that you and I are coming to the idea from different
angles: you care about minimizing fsyncs, and I'm interested in stopping
the problem where you have too many loose objects after running auto-gc.
So I care more about collecting those loose objects for that case.

> > So if we pack all the loose objects into a cruft pack, the mtime of the
> > cruft pack becomes the new gauge for "recent". And if we migrate objects
> > from old cruft pack to new cruft pack at each gc, then they'll keep
> > getting their mtimes refreshed, and we'll never drop them.
> 
> Well, I was assuming that gc would be a special case which doesn't the
> mtime of the old cruft pack.  (Or more generally, any time an object
> is gets copied out of the cruft pack, either to a loose object, or to
> another pack, the mtime on the source pack should not be touched.)

Right, that's the "you have multiple cruft packs" idea which has been
discussed[1] (each one just hangs around until its mtime expires, and
may duplicate objects found elsewhere).

That does end up with one pack per gc, which just punts the "too many
loose objects" to "too many packs". But unless the number of gc runs you
do is very high compared to the expiration time, we can probably ignore
that.

-Peff

[1] https://public-inbox.org/git/20170610080626.sjujpmgkli4muh7h@sigill.intra.peff.net/
