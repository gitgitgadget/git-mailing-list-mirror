Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70511FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 10:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964934AbeAJK52 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 05:57:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:39954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964916AbeAJK5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 05:57:25 -0500
Received: (qmail 26583 invoked by uid 109); 10 Jan 2018 10:57:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Jan 2018 10:57:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14164 invoked by uid 111); 10 Jan 2018 10:57:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Jan 2018 05:57:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2018 05:57:23 -0500
Date:   Wed, 10 Jan 2018 05:57:23 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
Message-ID: <20180110105723.GB18553@sigill.intra.peff.net>
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <87k1wtb8a4.fsf@evledraar.gmail.com>
 <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
 <20180108102029.GA21232@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1801081438470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180109065018.GA32257@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1801091357560.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1801091357560.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 09, 2018 at 02:05:09PM +0100, Johannes Schindelin wrote:

> > I think that could be easily worked around for rebase by asking git to
> > check ambiguity during the conversion.
> 
> Sure.
> 
> It also points to a flaw in your reasoning, and you should take my example
> further: previously, we guaranteed unique abbreviations, and who is to say
> that there is no script out there relying on that guarantee? You?

I'm not sure what you think my reasoning was, since I made the same
point directly after. ;)

> > I am a bit curious if there's a bounded probability that people would
> > find acceptable for Git to give an ambiguous abbreviation. We already
> > accept 1 in 2^160, of course. But would, e.g., one in a million be OK?
> 
> What is that going to solve?

I'm not sure I understand your question. We can bound the probability of
a collision by increasing the size of the abbreviation. My question was
whether there is a size where that tradeoff makes sense. So it "solves"
the problem of worrying about collisions.

> I think a better alternative would be to introduce a new abbreviation mode
> that is *intended* to stop caring about unique abbreviations.
> 
> In web interfaces, for example, it makes tons of sense to show, say, 8
> digits in link texts and have the full name in the actual link URL.

I'm not sure if that would be useful option or not. I certainly agree
that static abbreviations are a useful thing to want. But for scripted
callers, it's usually easy to cut down the abbreviation yourself. I
think your web interface example is a good one. The caller will ask Git
for the full 40-hex hash, and then cut it down itself when generating
the link (and I just so happen to have worked on a web interface that
does this[1]).

So would it be useful for humans to use? That's what I'm not sure about.
It seems cumbersome to have to add "--abbrev=8!" on the command line to
each invocation. But if it were triggered by config, it seems like we
would risk breaking scripts.

> I am just hesitant to change things that would break existing setups.

Me too. I'm not sure if I'm seriously advocating the "bound the
probability" thing. It's just something I think is worth pondering a
little.

-Peff

[1] Actually, there _is_ something that it's useful for Git to tell the
    caller, which is the approximate number of objects in the
    repository. Eight digits is not enough for the kernel, for example,
    and these days we use 12 digits by default. I'm not sure if such a
    web interface would rather ask for "%H %h" and generate the link
    text from the second half, or it would rather just get a ballpark on
    the number of objects, and do the simple abbreviation math itself
    (right now GitHub does not do either; I don't know about other
    interfaces).
