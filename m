Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF6CC63777
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 23:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405262463F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 23:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgKPXtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 18:49:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:59794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgKPXtl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 18:49:41 -0500
Received: (qmail 12254 invoked by uid 109); 16 Nov 2020 23:49:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Nov 2020 23:49:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20251 invoked by uid 111); 16 Nov 2020 23:49:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Nov 2020 18:49:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Nov 2020 18:49:39 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/5] handling 4GB .idx files
Message-ID: <20201116234939.GA5051@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
 <20201116041051.GA883199@coredump.intra.peff.net>
 <42080870-1a92-e76f-d83a-f15642a96329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42080870-1a92-e76f-d83a-f15642a96329@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 08:30:34AM -0500, Derrick Stolee wrote:

> > which took almost 13 minutes of CPU to run, and peaked around 15GB of
> > RAM (and takes about 6.7GB on disk).
> 
> I was thinking that maybe the RAM requirements would be lower
> if we batched the fast-import calls and then repacked, but then
> the repack would probably be just as expensive.

I think it's even worse. Fast-import just holds enough data to create
the index (sha1, etc), but pack-objects is also holding data to support
the delta search, etc. A quick (well, quick to invoke, not to run):

   git show-index <.git/objects/pack/pack-*.idx |
   awk '{print $2}' |
   git pack-objects foo --all-progress

on the fast-import pack seems to cap out around 27GB.

I doubt you could do much better overall than fast-import in terms of
CPU. The trick is really that you need to have a matching content/sha1
pair for 154M objects, and that's where most of the time goes. If we
lied about what's in each object (just generating an index with sha1
...0001, ...0002, etc), we could go much faster. But it's a much less
interesting test then.

> > That's the most basic test I think you could do. More interesting is
> > looking at entries that are actually after the 4GB mark. That requires
> > dumping the whole index:
> > 
> >   final=$(git show-index <.git/objects/pack/*.idx | tail -1 | awk '{print $2}')
> >   git cat-file blob $final
> 
> Could you also (after running the test once) determine the largest
> SHA-1, at least up to unique short-SHA? Then run something like
> 
> 	git cat-file blob fffffe
> 
> Since your loop is hard-coded, you could even use the largest full
> SHA-1.

That $final is the highest sha1. We could hard-code it, yes (and the
resulting lookup via cat-file is quite fast; it's the linear index dump
that's slow). We'd need the matching sha256 version, too. But it's
really the generation of the data that's the main issue.

> Naturally, nothing short of a full .idx verification would be
> completely sound, and we are already generating an enormous repo.

Yep.

> > So I dunno. I wouldn't be opposed to codifying some of that in a script,
> > but I can't imagine anybody ever running it unless they were working on
> > this specific problem.
> 
> It would be good to have this available somewhere in the codebase to
> run whenever testing .idx changes. Perhaps create a new prerequisite
> specifically for EXPENSIVE_IDX tests, triggered only by a GIT_TEST_*
> environment variable?

My feeling is that anybody who's really interested in playing with this
topic can find this thread in the archive. I don't think they're really
any worse off there than with a bit-rotting script in the repo that
nobody ever runs.

But if somebody wants to write up a test script, I'm happy to review it.

> It would be helpful to also write a multi-pack-index on top of this
> .idx to ensure we can handle that case, too.

I did run "git multi-pack-index write" on the resulting repo, which
completed in a reasonable amount of time (maybe 30-60s). And then
confirmed that lookups in the midx work just fine.

-Peff
