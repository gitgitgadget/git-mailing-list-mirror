Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADCB1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 03:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIGIIw (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 04:08:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:42292 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725987AbeIGIIv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 04:08:51 -0400
Received: (qmail 15469 invoked by uid 109); 7 Sep 2018 03:30:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Sep 2018 03:30:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10882 invoked by uid 111); 7 Sep 2018 03:30:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 23:30:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 23:30:04 -0400
Date:   Thu, 6 Sep 2018 23:30:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
Message-ID: <20180907033003.GA1383@sigill.intra.peff.net>
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net>
 <87bma2qcba.fsf@evledraar.gmail.com>
 <87y3clbcqf.fsf@evledraar.gmail.com>
 <20180902074656.GB18787@sigill.intra.peff.net>
 <20180902075528.GC18787@sigill.intra.peff.net>
 <20180902085503.GA25391@sigill.intra.peff.net>
 <87musybk7d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87musybk7d.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 03, 2018 at 06:48:54PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > And there are definitely a few nasty bits (like the way the progress is
> > ended). I'm not planning on taking this further for now, but maybe
> > you or somebody can find it interesting or useful.
> 
> I think it would be really nice if this were taken further. Using my
> perf test in
> https://public-inbox.org/git/20180903144928.30691-7-avarab@gmail.com/T/#u
> I get these results:
> 
>     $ GIT_PERF_LARGE_REPO=/home/aearnfjord/g/linux GIT_PERF_REPEAT_COUNT=5 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run HEAD~ HEAD p1450-fsck.sh
>     [...]
>     Test           HEAD~                 HEAD
>     ----------------------------------------------------------------
>     1450.1: fsck   384.18(381.63+2.53)   301.52(508.28+38.34) -21.5%
> 
> 
> I.e. this gives a 20% speedup, although of course some of that might be
> because some of this might be skipping too much work, but looks really
> promising.

I'm pretty sure it's doing the correct thing, in terms of doing all the
right checks. But look at your CPU time. You're getting a 20% wall-clock
speedup, but spending a lot more CPU. So the main difference is really
the multi-threading in index-pack. It should be strictly worse in terms
of total CPU on a single-processor system because we're doing work in
the sub-process (so we pay for the process invocation, but also we
probably are unable to share things like in-memory commit structs,
wasting a little extra time).

So I'm on the fence on whether it is worth it. I like getting rid of the
duplicated code. But on the other hand it is not all that complex, and
maybe when it comes to things like fsck it is good to have a different
implementation than the one that writes the .idx out in the first place.

-Peff
