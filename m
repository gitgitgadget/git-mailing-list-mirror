Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DFDC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D140610A2
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbhIMRKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:10:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:46356 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238090AbhIMRKt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 13:10:49 -0400
Received: (qmail 20649 invoked by uid 109); 13 Sep 2021 17:09:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Sep 2021 17:09:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11772 invoked by uid 111); 13 Sep 2021 17:09:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Sep 2021 13:09:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Sep 2021 13:09:32 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
Message-ID: <YT+FzPT0RCP2PdNL@coredump.intra.peff.net>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
 <YSvsQcGNpCMZwS8o@nand.local>
 <xmqqeeaa6fey.fsf@gitster.g>
 <8d2e0876-9441-9665-ebb1-8cb28902014b@web.de>
 <YS1EVq2Gz+sPhw3c@coredump.intra.peff.net>
 <8bd13e99-208b-4c22-90e6-28227593e9c4@web.de>
 <nycvar.QRO.7.76.6.2109131335260.55@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2109131335260.55@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 01:37:48PM +0200, Johannes Schindelin wrote:

> > Good point.  So fspathcmp() and friends would need a repo parameter. :-|
> 
> Yes, we will eventually have to pass `struct repository *r` into a _lot_
> of call chains. It'll be a disruptive change, yet if the submodule folks
> truly want to aim for in-process recursive treatment of submodules, there
> is no alternative.
> 
> FWIW on Windows there are other potentially repository-specific settings
> that are relevant in similar situations. For example, there is
> `core.symlinks`.

Another approach is to stuff the appropriate globals into the repository
struct, and then "push" onto the global the_repository pointer, treating
it like a stack. And then low-level code is free to use that global
context, even if it wasn't passed in.

That helps the primary use case of "now I need to do something in a
sub-module, but I'd like to do it in-process". But it's not without
challenges:

  - code which acts at the boundary of a submodule and a superproject
    may be more awkward (since only one of them can be "the current
    repository" at a time).

  - it's a challenge with threading (an obvious problem would be a
    multi-threaded grep which wanted to descend into a submodule). Using
    a thread-local global for the_repository might solve that.

It's possible that this is a terrible direction to go, so I'm not
necessarily endorsing it, but just offering it as a possibility to think
about. The trickiest thing is that any devil would likely be in the
details, and we wouldn't know until proceeding for a while along that
path. Whereas passing around a context struct, while verbose and
annoying, is a well-understood construct.

-Peff
