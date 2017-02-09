Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841DE1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 19:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753671AbdBIT6Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 14:58:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:52473 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752337AbdBIT6P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 14:58:15 -0500
Received: (qmail 25597 invoked by uid 109); 9 Feb 2017 19:58:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 19:58:15 +0000
Received: (qmail 22787 invoked by uid 111); 9 Feb 2017 19:58:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 14:58:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Feb 2017 14:58:12 -0500
Date:   Thu, 9 Feb 2017 14:58:12 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] Store submodules in a hash, not a linked list
Message-ID: <20170209195812.dbbmko4sas3wtdy5@sigill.intra.peff.net>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1486629195.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2017 at 02:26:57PM +0100, Michael Haggerty wrote:

> I have mentioned this patch series on the mailing list a couple of
> time [1,2] but haven't submitted it before. I just rebased it to
> current master. It is available from my Git fork [3] as branch
> "submodule-hash".
> 
> The first point of this patch series is to optimize submodule
> `ref_store` lookup by storing the `ref_store`s in a hashmap rather
> than a linked list. But a more interesting second point is to weaken
> the 1:1 relationship between submodules and `ref_stores` a little bit
> more.

Sounds good. I remember this had been discussed before due to
performance issues with resolve_gitlink_ref(), and we took a different
route (not populating non-submodule entries). I think it's nice to have
both optimizations, though, as they hit different use cases.

> A `files_ref_store` would be perfectly happy to represent, say, the
> references *physically* stored in a linked worktree (e.g., `HEAD`,
> `refs/bisect/*`, etc) even though that is not the complete collection
> of refs that are *logically* visible from that worktree (which
> includes references from the main repository, too). But the old code
> was confusing the two things by storing "submodule" in every
> `ref_store` instance.
> 
> So push the submodule attribute down to the `files_ref_store` class
> (but continue to let the `ref_store`s be looked up by submodule).

I'm not sure I understand all of the ramifications here. It _sounds_ like
pushing this down into the files-backend code would make it harder to
have mixed ref-backends for different submodules. Or is this just
pushing down an implementation detail of the files backend, and future
code is free to have as many different ref_stores as it likes?

-Peff
