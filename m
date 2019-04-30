Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9518F1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 18:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfD3SCe (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 14:02:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:44810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726056AbfD3SCe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 14:02:34 -0400
Received: (qmail 25512 invoked by uid 109); 30 Apr 2019 18:02:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Apr 2019 18:02:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10962 invoked by uid 111); 30 Apr 2019 18:03:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Apr 2019 14:03:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2019 14:02:32 -0400
Date:   Tue, 30 Apr 2019 14:02:32 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Message-ID: <20190430180231.GC16729@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <20190423042109.GA19183@sigill.intra.peff.net>
 <CACsJy8B7tjjpUZK+zH4rvOSk=uTLOHCOy6hk4FkkHXqCzNZU9g@mail.gmail.com>
 <3329645.KIYB9vJKXd@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3329645.KIYB9vJKXd@mfick-lnx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 02:09:31PM -0600, Martin Fick wrote:

> Here are my index-pack results (I only ran them once since they take a while) 
> using vgit 1.8.3.2:
> 
> Threads  real       user        sys
> 1     108m46.151s 106m14.420s  1m57.192s
> 2     58m14.274s  106m23.158s  5m32.736s
> 3     40m33.351s  106m42.281s  5m40.884s
> 4     31m40.342s  107m20.278s  5m40.675s
> 5     26m0.454s   106m54.370s  5m35.827s
> 12    13m25.304s  107m57.271s  6m26.493s
> 16    10m56.866s  107m46.107s  6m41.330s
> 18    10m18.112s  109m50.893s  7m1.369s
> 20    9m54.010s   113m51.028s  7m53.082s
> 24    9m1.104s    115m8.245s   7m57.156s
> 28    8m26.058s   116m46.311s  8m34.752s
> 32    8m42.967s   140m33.280s  9m59.514s
> 36    8m52.228s   151m28.939s  11m55.590s
> 40    8m22.719s   153m4.496s   12m36.041s
> 44    8m12.419s   166m41.594s  14m7.717s
> 48    8m0.377s    172m3.597s   16m32.041s
> 56    8m22.320s   188m31.426s  17m48.274s

Thanks for the data.

That seems to roughly match my results. Things get obviously better up
to around close to half of the available processors, and then you get
minimal returns for more CPU (some of yours actually get worse in the
middle, but that may be due to noise; my timings are all best-of-3).

> I think that if there were no default limit during a clone it could have 
> disastrous effects on people using the repo tool from the android project, or 
> any other "submodule like" tool that might clone many projects in parallel. 
> With the repo tool, people often use a large -j number such as 24 which means 
> they end up cloning around 24 projects at a time, and they may do this for 
> around 1000 projects. If git clone suddenly started as many threads as there 
> are CPUs for each clone, this would likely paralyze the machine.

IMHO this is already a problem, because none of those 24 gits knows
about the others. So they're already using 24*3 cores, though of course
at any given moment some of those 24 may be bottle-necked on the
network.

I suspect that repo should be passing in `-c pack.threads=N`, where `N`
is some formula based around how many cores we want to use, with some
constant fraction applied for how many we expect to be chugging on CPU
at any given point.

The optimal behavior would probably come from index-pack dynamically
assigning work based on system load, but that gets pretty messy. Ideally
we could just throw all of the load at the kernel's scheduler and let it
do the right thing, but:

  - we clearly get some inefficiencies from being overly-parallelized,
    so we don't want to go too far

  - we have other resources we'd like to keep in use like the network
    and disk. So probably the optimal case would be to have one (or a
    few) index-packs fully utilizing the network, and then as they move
    to the local-only CPU-heavy phase, start a few more on the network,
    and so on.

    There's no way to do that kind of slot-oriented gating now. It
    actually wouldn't be too hard at the low-level of the code, but I'm
    not sure what interface you'd use to communicate "OK, now go" to
    each process.

> I do suspect it would be nice to have a switch though that repo could use to 
> adjust this intelligently, is there some way to adjust threads from a clone, I 
> don't see one? I tried using 'GIT_FORCE_THREADS=28 git clone ...' and it 
> didn't seem to make a difference?

I think I led you astray earlier by mentioning GIT_FORCE_THREADS. It's
actually just a boolean for "use threads even if we're only
single-threaded". What you actually want is probably:

  git clone -c pack.threads=28 ...

(though I didn't test it to be sure).

-Peff
