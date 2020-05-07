Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA77C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725E52083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgEGMR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 08:17:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:40060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725879AbgEGMR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 08:17:28 -0400
Received: (qmail 31163 invoked by uid 109); 7 May 2020 12:17:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 12:17:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16364 invoked by uid 111); 7 May 2020 12:17:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 08:17:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 08:17:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200507121727.GA3057274@coredump.intra.peff.net>
References: <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <xmqqlfm69il6.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2005061623520.56@tvgsbejvaqbjf.bet>
 <xmqqeerx81wy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeerx81wy.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 09:26:53AM -0700, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The idea is indeed very neat. I think we can do a bit better with resource
> > usage by not even bothering to check this branch out. Something along
> > those lines (sorry, I really would love to have the time to test this...):
> 
> Nice.  I view the latest round of Peff's idea "allow-ref" as
> "because we are spinning a VM anyway, why not just run an end-user
> supplied script and let it decide?" and not as "we must have a
> Turing complete flexibility so let's run a script in a VM".  In
> other words, it may be overkill and we may strike a better tradeoff
> by living with reduced flexibility if there is a way to avoid the
> associated cost.

The script is just javascript, which has an eval(). We could probably
let refs/ci/config:allow-ref be a snippet of javascript that we run.

I do prefer the VM environment to snippets of javascript for a few
reasons:

  - shell scripts match the rest of our Git toolbox (though that's a
    personal preference, and for the amount of code we're talking about
    even _I_ can do a little javascript)

  - it's easy to test your code locally by running "./allow-ref foo".
    Whereas emulating the environment in which those scriptlets are run
    is much trickier (e.g., you need a working github-api object)

That said, if this is more lightweight, I think it's worth exploring.

> But doesn't this (i.e. uses: actions/github-script) still pay the
> cost of spinning up a VM?  How expensive is it to check out a small
> tree with a single file, whether it is ref-whitelist or allow-ref?

I suspect this script mechanism may be much cheaper. I don't know the
implementation details, but spinning up a nodejs container to run a
javascript snippet should be much cheaper than a full ubuntu VM running
"git clone" (the clone itself should be super cheap because it's a
shallow single-branch clone of a tree with one file in it, but getting
there is relatively heavy-weight).

But I could be wrong.  It's clear that they're not spinning up a full
ubuntu vm from scratch to serve the requests (since it happens in 3s).
I'll see if I can get something working and do some timings.

The latency isn't incredibly important. This is all happening async, and
either we'll skip CI (in which case you don't care how long it takes,
since you're not waiting on the result) or CI will take many minutes, in
which case 3s is nothing. But I would like to be respectful of the CPU
spent running Actions and be as lightweight as possible.

-Peff
