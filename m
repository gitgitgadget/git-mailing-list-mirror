Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631C51F404
	for <e@80x24.org>; Fri, 24 Aug 2018 06:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeHXK3n (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 06:29:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726455AbeHXK3n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 06:29:43 -0400
Received: (qmail 14340 invoked by uid 109); 24 Aug 2018 06:56:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Aug 2018 06:56:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24297 invoked by uid 111); 24 Aug 2018 06:56:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 Aug 2018 02:56:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2018 02:56:25 -0400
Date:   Fri, 24 Aug 2018 02:56:25 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180824065625.GA10556@sigill.intra.peff.net>
References: <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823185317.GA12534@sigill.intra.peff.net>
 <4b0168ee-4826-1f14-fc83-04c4cec18687@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b0168ee-4826-1f14-fc83-04c4cec18687@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 04:59:27PM -0400, Derrick Stolee wrote:

> Using git/git:
> 
> Test      v2.18.0           v2.19.0-rc0             HEAD
> -------------------------------------------------------------------------
> 0001.2:   3.10(3.02+0.08)   3.27(3.17+0.09) +5.5% 3.14(3.02+0.11) +1.3%
> 
> 
> Using torvalds/linux:
> 
> Test     v2.18.0             v2.19.0-rc0               HEAD
> ------------------------------------------------------------------------------
> 0001.2:  56.08(45.91+1.50)   56.60(46.62+1.50) +0.9% 54.61(45.47+1.46) -2.6%

Interesting that these timings aren't as dramatic as the ones you got
the other day (mine seemed to shift, too; for whatever reason it seems
like under load the difference is larger).

> Now here is where I get on my soapbox (and create a TODO for myself later).
> I ran the above with GIT_PERF_REPEAT_COUNT=10, which intuitively suggests
> that the results should be _more_ accurate than the default of 3. However, I
> then remember that we only report the *minimum* time from all the runs,
> which is likely to select an outlier from the distribution. To test this, I
> ran a few tests manually and found the variation between runs to be larger
> than 3%.

Yes, I agree it's not a great system. The whole "best of 3" thing is
OK for throwing out cold-cache warmups, but it's really bad for teasing
out the significance of small changes, or even understanding how much
run-to-run noise there is.

> When I choose my own metrics for performance tests, I like to run at least
> 10 runs, remove the largest AND smallest runs from the samples, and then
> take the average. I did this manually for 'git rev-list --all --objects' on
> git/git and got the following results:

I agree that technique is better. I wonder if there's something even
more statistically rigorous we could do. E.g., to compute the variance
and throw away outliers based on standard deviations. And also to report
the variance to give a sense of the significance of any changes.

Obviously more runs gives greater confidence in the results, but 10
sounds like a lot. Many of these tests take minutes to run. Letting it
go overnight is OK if you're doing a once-per-release mega-run, but it's
pretty painful if you just want to generate some numbers to show off
your commit.

> v2.18.0    v2.19.0-rc0   HEAD
> --------------------------------
> 3.126 s    3.308 s       3.170 s

So that's 5% worsening in 2.19, and we reclaim all but 1.4% of it. Those
numbers match what I expect (and what I was seeing in some of my earlier
timings).

> I just kicked off a script that will run this test on the Linux repo while I
> drive home. I'll be able to report a similar table of data easily.

Thanks, I'd expect it to come up with similar percentages. So we'll see
if that holds true. :)

> My TODO is to consider aggregating the data this way (or with a median)
> instead of reporting the minimum.

Yes, I think that would be a great improvement for t/perf.

-Peff
