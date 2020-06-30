Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F207DC433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0E4206C0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgF3Tdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:33:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:46494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgF3Tdl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 15:33:41 -0400
Received: (qmail 14428 invoked by uid 109); 30 Jun 2020 19:33:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2020 19:33:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26159 invoked by uid 111); 30 Jun 2020 19:33:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2020 15:33:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jun 2020 15:33:40 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 3/3] commit-graph: respect 'core.useBloomFilters'
Message-ID: <20200630193340.GA1889576@coredump.intra.peff.net>
References: <cover.1593536481.git.me@ttaylorr.com>
 <4cfa086e503e19763a9d581fcb6a2ef818776dfc.1593536481.git.me@ttaylorr.com>
 <20200630191834.GC1888406@coredump.intra.peff.net>
 <20200630192718.GA31522@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630192718.GA31522@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 03:27:18PM -0400, Taylor Blau wrote:

> So, I'm certainly open to changing it, although I'm not sure that I'm as
> worried about exposing the implementation detail as I am about squatting
> on Bloom filters within Git in general. I don't think that this
> configuration will end up getting used by folks other than server
> administrators and for debugging purposes, so those populations are
> already likely to be aware of changed-path Bloom filters beforehand.

Yeah, the squatting thing is definitely my bigger concern (having been
through the "bitmaps" version of the same thing).

> > It might even be worth considering whether "changed paths" needs more
> > context (or would if we add new features in the future). On a "git
> > commit-graph write" command-line it is perfectly clear, but would
> > core.commitGraphChangedPaths be worth it? It's definitely more specific,
> > but it's also way more ugly. ;)
> 
> Here's a third option what about 'graph.readChangedPaths'. I think that
> Stolee and I discussed a new top-level 'graph' section, since we now
> have a few commit-graph-related configuration variables in 'core'.

Yes, I like that even better. Probably "graph" is sufficiently specific
within Git's context, though I guess it _could_ bring to mind "git log
--graph". So many overloaded terms. :)

> That's a little shorter, and it adds the verb 'read', which is more
> descriptive than 'use' (I touch on this in the third patch, where I say
> that this configuration variable _doesn't_ affect the '--changed-path'
> option when writing).

Yeah, saying "read" specifically is much nicer.

> > > +	prepare_repo_settings(the_repository);
> > > +
> > >  	graph = read_commit_graph_one(the_repository, odb);
> >
> > I wondered why we would need this prepare_repo_settings() now, when it
> > should have been needed already to cover core.commitGraph already. I
> > strongly suspect the answer is: "test-tool read-graph" never properly
> > respected core.commitGraph in the first place.
> 
> Yep. Could probably be broken out into a separate patch (or mentioned as
> an aside in this one), but you're right: this helper did not respect
> any configuration that 'prepare_repo_settings' picks up.

I'd probably just note it in the commit message, but I'd be fine with
that or with a separate patch.

-Peff
