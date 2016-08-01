Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A2311F855
	for <e@80x24.org>; Mon,  1 Aug 2016 18:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbcHASYF (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 14:24:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:52694 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754214AbcHASYB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 14:24:01 -0400
Received: (qmail 9967 invoked by uid 102); 1 Aug 2016 18:17:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 14:17:20 -0400
Received: (qmail 15754 invoked by uid 107); 1 Aug 2016 18:17:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 14:17:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 14:17:17 -0400
Date:	Mon, 1 Aug 2016 14:17:17 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Paul Tan <pyokagan@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
Message-ID: <20160801181717.orwqnm6hkooztb4w@sigill.intra.peff.net>
References: <20160729002902.GD9646@sigill.intra.peff.net>
 <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
 <20160729155012.GA29773@sigill.intra.peff.net>
 <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
 <20160729180517.GA14953@sigill.intra.peff.net>
 <CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
 <20160730024135.oaqtjpo5l2e3dam2@sigill.intra.peff.net>
 <xmqqbn1cl6qv.fsf@gitster.mtv.corp.google.com>
 <xmqq7fc0l6aw.fsf@gitster.mtv.corp.google.com>
 <20160801181233.wycskha3mrribx7s@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160801181233.wycskha3mrribx7s@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 02:12:34PM -0400, Jeff King wrote:

> Before I switched to "reset at the beginning" in my original patch, I
> also noticed this issue, but decided the other way: to only reset after
> a successful creation.
> 
> I think in most cases it wouldn't matter anyway, because the caller will
> generally abort as soon as this returns failure anyway. But I wondered
> about something like:
> 
>   author = prepare_author_info();
>   if (commit_tree_extended(..., author, ...) < 0) {
> 	/* oops, we failed. Do a thing and try again. */
> 	possible_fix();
> 	if (commit_tree_extended(..., author, ...) < 0)
> 		die("giving up");
>   }
> 
> In the second call (but only the second call!) the committer and author
> can diverge.

To be clear, I checked all of the callers and nobody actually does this.
Every caller proceeds straight to a die() except the one in
notes_cache_write(), which silently ignores error (which is the correct
thing to do).

This is more "it seems like a fragile pattern to me".

-Peff
