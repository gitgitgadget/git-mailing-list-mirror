Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810B1C433E1
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE6820738
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgG0Tki (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:40:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:39030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgG0Tki (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 15:40:38 -0400
Received: (qmail 18774 invoked by uid 109); 27 Jul 2020 19:40:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Jul 2020 19:40:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17433 invoked by uid 111); 27 Jul 2020 19:40:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jul 2020 15:40:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jul 2020 15:40:36 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Anders Waldenborg <anders@0x63.nu>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
Message-ID: <20200727194036.GA795313@coredump.intra.peff.net>
References: <87blk0rjob.fsf@0x63.nu>
 <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
 <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 27, 2020 at 08:37:26PM +0200, Christian Couder wrote:

> > > I noticed some undocumented and (at least to me) surprising behavior in
> > > trailers.c.
> > >
> > > When configuring a value in trailer.<token>.key it causes the trailer to
> > > be normalized to that in "git interpret-trailers --parse".
> > > E.g:
> > >  $ printf '\naCKed: Zz\n' | \
> > >    git -c 'trailer.Acked.key=Acked' interpret-trailers --parse
> > >  will emit: "Acked: Zz"
> 
> Yeah, I think that's nice, as it can make sure that the key appears in
> the same way. It's true that it would be better if it would be
> documented.

I'd note that this also happens without --parse.

> > > Then there is the replacement by config "trailer.fix.key=Fixes" which
> > > expands "fix" to "Fixes". This happens when using "--trailer 'fix = 123'"
> > > which seems to be expected and useful behavior (albeit a bit unclear in
> > > documentation). But it also happens when parsing incoming trailers, e.g
> > > with that config
> > >  $ printf "\nFix: 1\n" | git interpret-trailers --parse
> > >  will emit: "Fixes: 1"
> [...]
> > > * Should replacement to what is in .key happen also in --parse mode, or
> > >   only for "--trailer"
> 
> I think it's more consistent if it happens in both --parse and
> --trailer mode. I didn't implement --parse though.

I don't recall being aware of this prefix matching until this thread, so
I doubt that the current behavior of --parse was something I tried for
intentionally. It's mostly just using the existing code, plus a few
extra options (listed in the docs). I'm not opposed to adding an option
to do strict matching and/or avoid rewriting, and then possibly adding
that into --parse by default.

I don't have much of an opinion on which behavior would be preferred.
I've never actually had a use case for configuring trailer.*.key, as I
usually am only looking at reading existing trailers to collect stats,
etc.

-Peff
