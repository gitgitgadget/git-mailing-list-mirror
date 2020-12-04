Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D954AC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DEF22CB2
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgLDUnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:43:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:52140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbgLDUnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:43:25 -0500
Received: (qmail 606 invoked by uid 109); 4 Dec 2020 20:42:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 20:42:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15661 invoked by uid 111); 4 Dec 2020 20:42:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 15:42:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 15:42:44 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 7/9] commit-graph: drop count_distinct_commits() function
Message-ID: <X8qfRDsfLYTDL3HV@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qGTaIdnNa5mAfC@coredump.intra.peff.net>
 <1103d97b-668f-8ad6-fc62-3fa09067a8bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1103d97b-668f-8ad6-fc62-3fa09067a8bb@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 03:06:24PM -0500, Derrick Stolee wrote:

> On 12/4/2020 1:56 PM, Jeff King wrote:
> > That turns out not to be a problem, though. The only things we do with
> > the count are:
> > 
> >   - check if our count will overflow our data structures. But the limit
> >     there is 2^31 commits, so it's not likely to happen in practice.
> 
> You do point out that you are removing this logic, done in this
> if statement:
> 
> > -	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
> > -		error(_("the commit graph format cannot write %d commits"), count_distinct);
> > -		res = -1;
> > -		goto cleanup;
> > -	}
> 
> What is the harm of keeping this? I know it is very unlikely, but
> I'd rather fail here than write a commit-graph that gets parsed as
> garbage.

I agree it's important to have. But this one is redundant. Look a few
lines below this hunk, and we have:

	copy_oids_to_commits(ctx);

	if (ctx->commits.nr >= GRAPH_EDGE_LAST_MASK) {
		error(_("too many commits to write graph"));
		res = -1;
		goto cleanup;
	}

So before we were counting distinct commits, checking that our count
fits, and then _ignoring_ that count in order to create the actual list
of commits, and then checking that the actual list's count fits. We only
need one of those checks, and the important one is the one from the
actual list (they _should_ match, but due to the bug, they sometimes
didn't).

My "not likely to happen in practice" is not about the quality of the
check, but rather that being off by one would never matter in practice.

Does that make more sense?

-Peff
