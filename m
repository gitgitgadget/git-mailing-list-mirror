Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3761F404
	for <e@80x24.org>; Thu, 16 Aug 2018 20:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeHPX4h (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 19:56:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:58070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725835AbeHPX4g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 19:56:36 -0400
Received: (qmail 17662 invoked by uid 109); 16 Aug 2018 20:55:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 20:55:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19270 invoked by uid 111); 16 Aug 2018 20:56:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 16:56:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 16:55:57 -0400
Date:   Thu, 16 Aug 2018 16:55:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
Message-ID: <20180816205556.GA8257@sigill.intra.peff.net>
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net>
 <87bma2qcba.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bma2qcba.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 10:35:53PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This is all interesting, but I think unrelated to what Ulrich is talking
> about. Quote:
> 
>     Between the two phases of "git fsck" (checking directories and
>     checking objects) there was a break of several seconds where no
>     progress was indicated
> 
> I.e. it's not about the pause you get with your testcase (which is
> certainly another issue) but the break between the two progress bars.

I think he's talking about both. What I said responds to this:

> >> During "git gc" the writing objects phase did not update for some
> >> seconds, but then the percentage counter jumped like from 15% to 42%.

But yeah, I missed that the fsck thing was specifically about a break
between two meters. That's a separate problem, but also worth
discussing (and hopefully much easier to address).

> If you fsck this repository it'll take around (on my spinning rust
> server) 30 seconds between 100% of "Checking object directories" before
> you get any output from "Checking objects".
> 
> The breakdown of that is (this is from approximate eyeballing):
> 
>  * We spend 1-3 seconds just on this:
>    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L181

OK, so that's checking the sha1 over the .idx file. We could put a meter
on that. I wouldn't expect it to generally be all that slow outside of
pathological cases, since it scales with the number of objects (and 1s
is our minimum update anyway, so that might be OK as-is). Your case has
13M objects, which is quite large.

>  * We spend the majority of the ~30s on this:
>    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L70-L79

This is hashing the actual packfile. This is potentially quite long,
especially if you have a ton of big objects.

I wonder if we need to do this as a separate step anyway, though. Our
verification is based on index-pack these days, which means it's going
to walk over the whole content as part of the "Indexing objects" step to
expand base objects and mark deltas for later. Could we feed this hash
as part of that walk over the data? It's not going to save us 30s, but
it's likely to be more efficient. And it would fold the effort naturally
into the existing progress meter.

>  * Wes spend another 3-5 seconds on this QSORT:
>    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L105

That's a tough one. I'm not sure how we'd count it (how many compares we
do?). And each item is doing so little work that hitting the progress
code may make things noticeably slower.

Again, your case is pretty big. Just based on the number of objects,
linux.git should be 1.5-2.5 seconds on your machine for the same
operation. Which I think may be small enough to ignore (or even just
print a generic before/after). It's really the 30s packfile hash that's
making the whole thing so terrible.

-Peff
