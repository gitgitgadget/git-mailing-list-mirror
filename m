Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8A61F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 12:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeKXW6J (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 17:58:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:49954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726160AbeKXW6J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 17:58:09 -0500
Received: (qmail 1888 invoked by uid 109); 24 Nov 2018 12:09:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Nov 2018 12:09:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1339 invoked by uid 111); 24 Nov 2018 12:09:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 24 Nov 2018 07:09:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Nov 2018 07:09:50 -0500
Date:   Sat, 24 Nov 2018 07:09:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
Message-ID: <20181124120950.GB19257@sigill.intra.peff.net>
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
 <87muq2zoy9.fsf@evledraar.gmail.com>
 <20181122175259.GC22123@sigill.intra.peff.net>
 <87efbd0xix.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efbd0xix.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 07:36:54PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Yeah, my intent had been to circle back around to this, but I just
> > hadn't gotten to it. I'm still pondering a config option or similar,
> > though I remain unconvinced that the cases in which you've showed it
> > being slow are actually realistic or worth worrying about
> 
> FWIW those "used to be 2ms are now 20-40ms" pushes on ext4 are
> representative of the actual prod setup I'm mainly targeting. Now, I
> don't run on ext4 this patch helps there, but it seems plausible that it
> matters to someone who's counting on that performance.

Those are actually the more interesting cases, I think. The ones I'm
most skeptical of are the multi-second delays due to having 250K+
objects.

I do also think in the long run we should be fixing the "unreachable
always become loose" issues.

> Buh yeah, it's certainly obscure. I don't blame you if you don't want to
> hack on it, and not ejecting this out before 2.20 isn't going to break
> anything for me. But do you mind if I make it configurable as part of my
> post-2.20 "disable collisions?"

No, not at all.

> >  (and certainly having an obscure config option is not enough to help
> > most people). If we could have it kick in heuristically, that would be
> > better.
> 
> Aside from this specific scenario. I'd really prefer if we avoid having
> heuristic performance optimizations at all costs.
> 
> Database servers tend to do that sort of thing with their query planner,
> and it results in cases where your entire I/O profile changes overnight
> because you're now on the wrong side of some if/else heuristic about
> whather to use some index or not.

Yes, I agree that's a downside. I just think if we make everybody's
performance 10% slower, they're not really going to notice and seek out
a config option to flip to fix it.

> > However, note that the cache-load for finding abbreviations _must_ have
> > the complete list. And has been loading it for some time. So if you run
> > "git-fetch", for example, you've already been running this code for
> > months (and using the cache in more places is now a free speedup).
> 
> This is reminding me that I need to get around to re-submitting my
> core.validateAbbrev series, which addresses this part of the problem:
> https://public-inbox.org/git/20180608224136.20220-21-avarab@gmail.com/

Yeah, I still agree that is a reasonable thing to do.

> > At the very least, we'd want this patch on top, too. I also think René's
> > suggestion use access() is worth pursuing (though to some degree is
> > orthogonal to the cache).
> 
> I haven't had time to test that, and wasn't prioritizing it since I
> figured this was post-2.20. My hunch is it doesn't matter much if at all
> on NFS. The roundtrip time is what matters, whether that roundtrip is
> fstat() or access() probably not.

Yes, that line of reasoning makes sense to me (but I think an easy 2-3%
speedup on local filesystems may be worth it).

-Peff
