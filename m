Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3CDB1F488
	for <e@80x24.org>; Tue,  7 May 2019 07:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEGHpI (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 03:45:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:49890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726249AbfEGHpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 03:45:08 -0400
Received: (qmail 18777 invoked by uid 109); 7 May 2019 07:45:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 07:45:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9025 invoked by uid 111); 7 May 2019 07:45:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 03:45:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 03:45:06 -0400
Date:   Tue, 7 May 2019 03:45:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190507074506.GF28060@sigill.intra.peff.net>
References: <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com>
 <20190504013713.GC17551@sigill.intra.peff.net>
 <87a7g2iuem.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7g2iuem.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 04, 2019 at 08:52:01AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Note that Ævar's case was somebody running bitmaps locally and trying to
> > push, which I think is generally not a good match for bitmaps (even when
> > they work, they cost more to generate than what you save if you're only
> > pushing once).
> 
> Right. It was *not* caused by this "enable bitmaps by default on bare
> repos" patch (which I wasn't even running with), but *is* indicative of
> a pretty big edge case with enabling bitmaps that *will* happen for some
> on such bare repos if we ship the patch.

Yeah. To clarify my comments a bit: I do think it would be possible to
hit a weird case like this while serving fetches (i.e., as far as I know
there is nothing in what you saw that is inherent to pushes). But I do
think for serving fetches, bitmaps are overall a big net win (based on
my experiences).

So I think it may come down to a tradeoff: enabling this by default
would probably be a net win across the population, but that's little
comfort to the unlucky somebody who may see it as a regression. I'm not
sure which is more important to maintain.

> As an aside this is the Nth time I notice how crappy that "Enumerating
> objects" progress bar is. We do a *lot* of things there, including this
> bitmap calculation.
> 
> But just splitting it up might result in either no progress (all
> individually below 2 seconds), or a lot of noise as you have 20 things
> that each take 2 seconds. I wonder if someone's looked at supporting:
> 
>     Enumerating Objects (X%) => Calculating bitmaps (Y%)
> 
> Where X% is the total progres, and %Y is the sub-progress. I eyeballed
> doing this once by "chaining" the progress structs, but there's probably
> a less crappy way...

I don't think it needs to be split; I think we just need to update the
object count while we're traversing the bitmaps. The problem is that the
progress object is known to pack-objects.c. Without bitmaps, as the
revision machinery walks the graph, our callbacks bump the progress
meter every time we see an object.

With bitmaps, all that walking happens behind the scenes, and the bitmap
code delivers us the final answer. So we pause for a long time, and then
suddenly it shoots forward.

I think we'd want a way to tell the bitmap code to update our progress
meter as it traverses (both single objects, but also taking into account
when it finds a bitmap and then suddenly bumps the value by a large
amount).

-Peff
