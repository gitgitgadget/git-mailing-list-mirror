Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875A41FAFB
	for <e@80x24.org>; Tue,  4 Apr 2017 02:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbdDDCT0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 22:19:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:56297 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752556AbdDDCTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 22:19:25 -0400
Received: (qmail 17469 invoked by uid 109); 4 Apr 2017 02:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 02:19:23 +0000
Received: (qmail 3094 invoked by uid 111); 4 Apr 2017 02:19:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Apr 2017 22:19:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Apr 2017 22:19:21 -0400
Date:   Mon, 3 Apr 2017 22:19:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH/RFC] gitperformance: add new documentation about git
 performance tuning
Message-ID: <20170404021921.cz6gz3lpanr2rwqv@sigill.intra.peff.net>
References: <20170403211644.26814-1-avarab@gmail.com>
 <20170403213440.GA1409@whir>
 <CACBZZX7R5svNJ+Ak3LFh8+kY48i6V7Yo6JDS+PSDJCkZ5vHb6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7R5svNJ+Ak3LFh8+kY48i6V7Yo6JDS+PSDJCkZ5vHb6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 03, 2017 at 11:57:51PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> +These features can be enabled on git servers, they won't help the
> >> +performance of the servers themselves,
> >
> > Is that true for bitmaps?  I thought they reduced CPU usage on
> > the server side...
> 
> I'm not sure, JK? From my reading of the repack.writeBitmaps docs it
> seems to only help clone/fetch for the client, but maybe they do more
> than that.

Bitmaps reduce the CPU required to do the "Counting" phase of
pack-objects. For serving a fetch or clone, the server side is happy
because they use less CPU, but the client is happy because the server
moves to the "Writing" phase more quickly.

Bitmaps also help with pushes, but this is usually less interesting. You
don't tend to push all of history over and over (whereas people _do_
tend to clone all of history over and over).

They don't speed up the counting portion of a regular repack. In theory
they could, but the resulting packs may grow less optimal over time
(e.g., we can't compute the same history-based write order, so over time
your objects would get jumbled, leading to worse cold-cache behavior).

You can also use bitmaps for other reachability computations, but we
don't do so currently. I have patches that I need to clean up to use
them for "git prune", doing ahead/behind checks, --contains, etc.

> I also see we should mention pack.writeBitmapHashCache, which
> according to my reading of v2.0.0-rc0~13^2~8 only helps clone/fetch.

Yes, it helps the delta search heuristic, so only pack-objects would
ever benefit. This should basically be turned on all the time, as
without it fetches from partially-bitmapped repos (i.e., when you've
gotten some pushes but haven't repacked yet) do a really bad job of
finding deltas (the waste too much time and deliver sub-optimal packs).

Arguably it should be the default. The initial patches made it optional
for strict JGit compatibility (I don't know if JGit ever implemented the
extension). We've had it on at GitHub since day one, so I don't have any
operational experience with turning it off (aside from the simulated
numbers in that commit message).

> > A sidenote: I wonder if bitmaps should be the default for bare
> > repos, since bare repos are likely used on servers.

That's an interesting notion. It's a net loss if you don't serve a lot
of fetches, because it's trying to amortize the extra CPU during the
repack with faster fetches and clones. So it makes sense for a hosting
site, but less for somebody pushing to a personal bare repo.

-Peff
