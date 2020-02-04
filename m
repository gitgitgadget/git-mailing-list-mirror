Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C54C2D0B1
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFC220661
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 14:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgBDOOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:14:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:52076 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727235AbgBDOOm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 09:14:42 -0500
Received: (qmail 9598 invoked by uid 109); 4 Feb 2020 14:14:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Feb 2020 14:14:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32117 invoked by uid 111); 4 Feb 2020 14:22:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Feb 2020 09:22:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Feb 2020 09:14:41 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200204141441.GA563710@coredump.intra.peff.net>
References: <cover.1580430057.git.me@ttaylorr.com>
 <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
 <20200131233434.GJ10482@szeder.dev>
 <nycvar.QRO.7.76.6.2002012223490.46@tvgsbejvaqbjf.bet>
 <20200203104730.GK10482@szeder.dev>
 <20200203111117.GC4153124@coredump.intra.peff.net>
 <20200204035821.GB5790@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200204035821.GB5790@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 07:58:21PM -0800, Taylor Blau wrote:

> I think that this seems like a good step that we should probably take,
> but I don't think that it's necessary for the series at hand. The
> pattern in this function is to define a local variable which has the
> same value as in split_opts, or a reasonable default if split_opts is
> NULL (c.f., 'max_commits' and 'size_mult').
> 
> So, I think that a safe thing to do which prevents the segv and doesn't
> change the pattern too much is to write:
> 
>   enum commit_graph_split_flags flags = COMMIT_GRAPH_SPLIT_MERGE_AUTO;
>   if (ctx->split_opts) {
>     /* ... */
>     flags = ctx->split_opts->flags;
>   }
> 
>   /* ... */
> 
>   if (flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
>     while ( ... ) { ... }
>   }
> 
> This is adding another local variable, which seems like an odd thing to
> do *every* time that we add another member to split_opts. So for that
> reason it seems like in the longer-term we should either force the
> caller to pass in a blank, or do something else that doesn't require
> this, but I think that the intermediate cost isn't too bad.

It would perhaps be simpler to turn NULL into a _single_ default-filled
split_opts variable, and then just use it throughout the function. And
since presumably zero-initialization would yield good defaults (or we'd
define an INIT macro for the convenience of callers), it would be a
one-liner that we'd only have to do once.

But I think that can wait; the "if" solution discussed seems like a
straightforward way to make this patch correct both on top of master,
and when merged with next.

-Peff
