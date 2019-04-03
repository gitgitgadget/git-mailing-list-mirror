Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5199220248
	for <e@80x24.org>; Wed,  3 Apr 2019 12:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDCMTW (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 08:19:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:45496 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726074AbfDCMTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 08:19:22 -0400
Received: (qmail 1410 invoked by uid 109); 3 Apr 2019 12:19:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Apr 2019 12:19:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8695 invoked by uid 111); 3 Apr 2019 12:19:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Apr 2019 08:19:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2019 08:19:19 -0400
Date:   Wed, 3 Apr 2019 08:19:19 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
Message-ID: <20190403121919.GA6818@sigill.intra.peff.net>
References: <20190402115625.21427-1-dak@gnu.org>
 <xmqqv9zvsfay.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AbkmJ69ucCfGMdXHGvfko89SxH=DKjra6Ltwf7wpy-Og@mail.gmail.com>
 <20190403113604.GA2941@sigill.intra.peff.net>
 <CACsJy8BCGHqjO5fKG7TO5X239z_7Gzdo80jF0rx939X501yVnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BCGHqjO5fKG7TO5X239z_7Gzdo80jF0rx939X501yVnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 07:06:02PM +0700, Duy Nguyen wrote:

> On Wed, Apr 3, 2019 at 6:36 PM Jeff King <peff@peff.net> wrote:
> > I suspect we could do even better by storing and reusing not just the
> > original blob between diffs, but the intermediate diff state (i.e., the
> > hashes produced by xdl_prepare(), which should be usable between
> > multiple diffs). That's quite a bit more complex, though, and I imagine
> > would require some surgery to xdiff.
> 
> Amazing. xdl_prepare_ctx and xdl_hash_record (called inside
> xdl_prepare_ctx) account for 36% according to 'perf report'. Please
> tell me you just did not get this on your first guess.

Sorry, it was a guess. ;)

But an educated one, based on previous experiments with speeding up "log
-p". Remember XDL_FAST_HASH, which produced speedups there (but
unfortunately had some pathological slowdowns, because it produced too
many collisions). I've also played around with using other hashes like
murmur or siphash, but was never able to get anything remarkably faster
than what we have now.

> I tracked and dumped all the hashes that are sent to xdl_prepare() and
> it looks like the amount of duplicates is quite high. There are only
> about 1000 one-time hashes out of 7000 (didn't really draw a histogram
> to examine closer). So yeah this looks really promising, assuming
> somebody is going to do something about it.

I don't think counting the unique hash outputs tells you much about what
can be sped up. After all, two related blobs are likely to overlap quite
a bit in their hashes (i.e., all of their non-unique lines). The trick
is finding in each blob those ones that _are_ unique. :)

But if we spend 36% of our time in hashing the blobs, then that implies
that we could gain back 18% by caching and reusing the work from a
previous diff (as David notes, a simple keep-the-last-parent cache only
yields 100% cache hits in a linear history, but it's probably good
enough for our purposes).

This should likewise make "git log -p -- file" faster, though with more
files you'd need a bigger cache.

So I do think it's a promising lead. I don't have immediate plans to
work on it, though. Maybe it would be a good GSoC project. ;)

-Peff
