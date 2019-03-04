Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1737A20248
	for <e@80x24.org>; Mon,  4 Mar 2019 21:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfCDVhh (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 16:37:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:38412 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726076AbfCDVhf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 16:37:35 -0500
Received: (qmail 29504 invoked by uid 109); 4 Mar 2019 21:37:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Mar 2019 21:37:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26238 invoked by uid 111); 4 Mar 2019 21:37:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 16:37:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 16:37:33 -0500
Date:   Mon, 4 Mar 2019 16:37:33 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
Message-ID: <20190304213733.GA3347@sigill.intra.peff.net>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
 <20190303171951.GD23811@sigill.intra.peff.net>
 <8e4b7966-7a3e-a081-bfc1-9e60303b8eab@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1903041210410.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903041210410.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 01:38:13PM +0100, Johannes Schindelin wrote:

> > So, tl;dr: soon, I will be submitting a patch to remove the
> > 'hdr-check' target completely, for now anyway.
> 
> You mentioned later that you might be the only person using that target,
> and if that were so, I would agree.
> 
> However, I started looking into adding `hdr-check` to the Azure Pipeline
> we have (which would make a *ton* of sense, if you ask me), along with the
> `sparse` thing we talked about.
> 
> So I am a bit opposed to removing that target.

Yeah, I agree. If it's a linting check we expect developers to follow,
then we need to make it easy for developers to run it.

> > Yep, for me too. There is a similar problem if you build with
> > NO_CURL and don't have the 'curl/curl.h' header file, etc ...
> 
> I think all it needs to do is to pass `$(ALL_CFLAGS)` to gcc (although we
> might need to add something like `#if defined(SHA256_GCRYPT) ... #endif`
> guards to `sha256/gcrypt.h` to make it work in Peff's case).
> 
> But given that this target really is meant to catch all kinds of errors,
> I'd be in favor of declaring that target requiring things like libgcrypt's
> header files to be installed. We can easily make that happen in our CI
> builds.

I don't think that really scales, though. For CI, perhaps it's not too
bad, but IMHO there's real value making it possible for everyday
developers to run linting and tests locally, because it keeps the
feedback cycle tight. In other words, imagine my changes go through a
sequence like this:

  1. I run "make" locally

  2. I run "make test" locally

  3. I push, and CI runs "make && make test" on more platforms, or with
     more knobs tweaked.

it's preferable to find out about problems in the early steps, because
the cost to run each of the subsequent steps is much higher.

So if we're adding more linting, it would ideally be part of the build.
The obvious reasons not to are that it's expensive, or that it's hard
for the local user to set up. But I think at least a hdr-check that
checks _your_ platform would be valuable to run as part of step 1 or 2.

I also think it points to a weakness in the current hdr-check scheme. It
omits compat/* entirely, so we can't detect any problems there. But if
we are going to add those back in, then making it run in CI is not as
simple as "just make sure we have all libraries installed". It's
inherently going to be a different set per platform (and we'd want to
run "make hdr-check" on each of the platforms where we already run "make
test").

> > Anyway, for now, since I seem to be the only person using this
> > target, I think we should just remove it while I think again.
> > (I can put it in my config.mak, so there will be no loss for me).
> 
> As I said above, I would rather keep it, with the `ls-files` and `:=`
> fixup.
> 
> If others *really* feel strongly about lazy-evaluating `LIB_H`, then I
> would *additionally* use Peff's sub-make hack. But only if others feel
> strongly about it, because I, for one, certainly don't.

My measurements show it's not a big expense at least on my system (even
with the 3x runs). So I can live with just moving it to ls-files to
bound the filesystem access, and calling that good enough.

-Peff
