Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D2B1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 21:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfJZVgu (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 17:36:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:59376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726392AbfJZVgu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 17:36:50 -0400
Received: (qmail 958 invoked by uid 109); 26 Oct 2019 21:36:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 26 Oct 2019 21:36:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21339 invoked by uid 111); 26 Oct 2019 21:39:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 26 Oct 2019 17:39:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 26 Oct 2019 17:36:48 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
Message-ID: <20191026213648.GA7331@sigill.intra.peff.net>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com>
 <pull.407.v2.git.1571755538.gitgitgadget@gmail.com>
 <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
 <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com>
 <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet>
 <20191025221118.GA29213@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910262040360.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1910262040360.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 26, 2019 at 10:56:45PM +0200, Johannes Schindelin wrote:

> Back to the issue at hand: I did open a GitGitGadget PR with my proposed
> change, in the hopes that I could somehow fast-track this fix into the
> CI/PR builds over at https://github.com/gitgitgadget/git, but there are
> problems: it seems that now there is an at least occasional broken pipe
> in the same test when run on macOS.

Yes, I think that's another issue in the same test. There's more
discussion further down in the thread I linked earlier, starting here:

  https://public-inbox.org/git/20190829143805.GB1746@sigill.intra.peff.net/

and I think Gábor's solution here:

  https://public-inbox.org/git/20190830121005.GI8571@szeder.dev/

is the right direction (and note that this _isn't_ just a test artifact,
but a bug that occasionally hits real-world cases, too).

> There _also_ seems to be something spooky going on in t3510.12 and .13,
> where the expected output differs from the actual output only by a
> re-ordering of the lines:
> 
> -- snip --
> [...]
> +++ diff -u expect advice
> --- expect	2019-10-25 22:17:44.982884700 +0000
> +++ advice	2019-10-25 22:17:45.278884500 +0000
> @@ -1,3 +1,3 @@
>  error: cherry-pick is already in progress
> -hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
>  fatal: cherry-pick failed
> +hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
> -- snap --

Hrm. I'd have thought those are both coming from the same process. Which
implies that we're not fflushing stderr before calling write(2). But
your patch seems to do so...

<scratches head> Aha. I think you force-pushed up as I am typing this.
:) So I think that is indeed the solution.

> So much as I would love to see the flakiness of t5516 be fixed as soon
> as possible, I fear we will have to look at the underlying issue a bit
> closer: there are two processes writing to `stderr` concurrently. I
> don't know whether there would be a good way for the `stderr` of the
> `upload-pack` process to be consumed by the `fetch` process, and to be
> printed by the latter.

The worst part is that this message already _is_ consumed by fetch: we
send it twice, once over the sideband, and once directly to stderr. In
most cases the stderr version is lost, but some server providers might
be collecting it. I wouldn't mind seeing the direct-to-stderr one
dropped. There's some more discussion in (from the same thread linked
earlier):

  https://public-inbox.org/git/20190828145412.GB14432@sigill.intra.peff.net/

-Peff
