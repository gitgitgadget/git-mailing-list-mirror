Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330601F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 01:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfDWBzl (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 21:55:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:37544 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727588AbfDWBzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 21:55:40 -0400
Received: (qmail 13461 invoked by uid 109); 23 Apr 2019 01:55:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 01:55:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4432 invoked by uid 111); 23 Apr 2019 01:56:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 21:56:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 21:55:39 -0400
Date:   Mon, 22 Apr 2019 21:55:38 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Message-ID: <20190423015538.GA16369@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <16052712.dFCfNLlQnN@mfick-lnx>
 <20190422205653.GA30286@sigill.intra.peff.net>
 <19221376.OlD5LWjr85@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19221376.OlD5LWjr85@mfick-lnx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 04:32:16PM -0600, Martin Fick wrote:

> > Hours? I think something might be wrong. It takes 20s to run on
> > linux.git.
> 
> OK, yes I was running this on a "bad" copy of the repo, see below because I 
> think it might be of some interest also...
> 
> On the better copy, the git part of the command took 3m48.025s (still not 20s, 
> but not hours either), using git v2.18. The results were:

That is slower than I'd expect. Two things that could speed it up:

  - use --buffer, which drops write() overhead

  - use a more recent version of Git which has 0750bb5b51 (cat-file:
    support "unordered" output for --batch-all-objects, 2018-08-10).
    This is order gets better cache locality (both disk cache if you
    can't fit the whole thing in RAM, but also the delta cache).

Those drop my 20s run on linux.git to 13s, but they might have more
impact for you.

> 2) That copy of the repo is from a mirror clone of our source repo without 
> running repacking (-f) on it. Without repacking -f, the clone is actually 16G, 
> which I believe is using the deltas from the source repo which would have been 
> created by people pushing new commits over and over to the source repo and 
> those new objects just being added to the common pack file during repacking 
> without creating a ton of new deltas. It would appear that the deltas created 
> from regular repacking without using the -f may be really destroying some of 
> the performance of our source repo even worse then I imagined. The rest of my 
> testing has been done on a repo repacked with -f to eliminate the variability 
> imposed from the source repo because I figured it would adversely impact 
> things, but I did not imagine it being that bad because even the clone time of 
> the bad repo is not that bad, so I wonder why the git cat-file is way worse?

Yes, I do think it's worth doing a "repack -f" every once in a while
(and probably worth --window=250 since you're already splurging on CPU).
It does seem to produce better results than taking the accumulated
results of the individual pushes. I don't think this is an area we've
studied all that well, so there may be some ways to make it better (but
what's there has been "good enough" that nobody has sunk a lot of time
into it).

> > So definitely do something like:
> > 
> >   for threads in 1 2 3 4 5 12 56; do
> > 	rm -rf repo.git
> > 	git init --bare repo.git
> > 	GIT_FORCE_THREADS=$threads \
> > 	  git -C repo.git index-pack -v --stdin </path/to/pack
> >   done
> > 
> > to test.
> 
> Makes sense, testing now...

Here are my p5302 numbers on linux.git, by the way.

  Test                                           jk/p5302-repeat-fix
  ------------------------------------------------------------------
  5302.2: index-pack 0 threads                   307.04(303.74+3.30)
  5302.3: index-pack 1 thread                    309.74(306.13+3.56)
  5302.4: index-pack 2 threads                   177.89(313.73+3.60)
  5302.5: index-pack 4 threads                   117.14(344.07+4.29)
  5302.6: index-pack 8 threads                   112.40(607.12+5.80)
  5302.7: index-pack default number of threads   135.00(322.03+3.74)

which still imply that "4" is a win over "3" ("8" is slightly better
still in wall-clock time, but the total CPU rises dramatically; that's
probably because this is a quad-core with hyperthreading, so by that
point we're just throttling down the CPUs).

> > It's a lot harder to thread since we're eating the incoming bytes. And
> > unless you're just coming from a local disk copy, the network is
> > generally the bottleneck (and if you are coming from a local disk copy,
> > then consider doing a local clone which will avoid all of this hashing
> > in the first place).
> 
> Is that really a fair assumption in today's intranets? Many corporate LANs 
> have higher bandwidth than normal disks, don't they?

Single-threaded SHA-1 is 500-1000 megabytes/sec. That's 4-8
gigabits/sec. And keep in mind we're just handling the base objects, so
we're only computing the SHA-1 on some of the bytes.

Of course there's another SHA-1 computation going over the whole
packfile at that point, so _that_ is probably a bigger bottleneck if you
really are on a 10 gigabit network.

But if somebody wants to spend the time to look at parallelizing it, I
wouldn't say no. :)

-Peff
