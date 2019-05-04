Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395AD1F45F
	for <e@80x24.org>; Sat,  4 May 2019 01:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfEDBhP (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 21:37:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:48314 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726042AbfEDBhP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 21:37:15 -0400
Received: (qmail 16114 invoked by uid 109); 4 May 2019 01:37:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 04 May 2019 01:37:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16405 invoked by uid 111); 4 May 2019 01:37:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 May 2019 21:37:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 May 2019 21:37:13 -0400
Date:   Fri, 3 May 2019 21:37:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190504013713.GC17551@sigill.intra.peff.net>
References: <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 04:16:46PM +0900, Junio C Hamano wrote:

> I was revisiting the recent "What's cooking" report, and I am not
> sure what the current status of the topic is.
> 
> I do not get a feel that the current bitmap implementation has been
> widely used in repositories that have vastly different access
> patterns---it probably has been tried only by those who can afford
> the engineering cost to see if the implementation happens to work
> well for their workload and some may have chosen to adopt it while
> others didn't.  So it may be very well tuned for the former people
> but once we merge this topic down, we'll hear from others with quite
> different workload, which may lead to us tuning the code to bit
> better to their workload while not hurting other existing users,
> hopefully.
> 
> Or not.

Note that Ævar's case was somebody running bitmaps locally and trying to
push, which I think is generally not a good match for bitmaps (even when
they work, they cost more to generate than what you save if you're only
pushing once).

The goal of Eric's patch was that by kicking in for bare repos, we'd
mostly be hitting servers that are serving up fetches. So if by
"workload" you mean that we some people might use bare repos for other
cases, yeah, there's a potential for confusion or regression there.

If you mean that bitmaps might not work for some workloads even when
we're serving a lot of fetches, I won't say that's _not_ true, but my
experience is that they are generally a net win. Both for the smaller
repositories we see on github.com, but also for big, busy ones that our
on-premises customers use.

  Actually, there is one curiosity with Eric's patch that I haven't
  tested. As I've mentioned before, we store "forks" as single
  repositories pointing to a single shared alternates repository. Since
  the bitmap code only handles one .bitmap per invocation, you really
  want just one big one in the shared repo. If "git repack" in the forks
  started generating one, that would be surprising and annoying.

  In practice this is a pretty extreme corner case. And a lot would
  depend on how you're using "repack" in the fork (e.g., a partial
  repack would know that it can't generate bitmaps anyway). I'm pretty
  sure it would not even impact our setup at all, but I can probably
  come up with a devils advocate one where it would.

> I am somewhat tempted to make things more exciting by merging it to
> 'next' soonish, but I guess Ævar and you are not quite ready for
> that excitement yet, judging from the following (which looks quite
> sensible suggestions)?

It's OK with me for this to go to 'next'. Note that the other two
patches from me could actually graduate separately. One is a
straight-out test fix, and the other should always be a win (and does
nothing if you're not already generating bitmaps).

By the way, there were some timing puzzles mentioned in that second
commit. I re-ran them today and everything was what I'd expect. So I
wonder if I just screwed up the timings before. I can re-write that
commit message if it hasn't made it to 'next' yet.

-Peff
