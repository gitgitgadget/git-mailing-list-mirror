Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D89DC2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3498320774
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgDXFcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:32:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:38398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725554AbgDXFcG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 01:32:06 -0400
Received: (qmail 19862 invoked by uid 109); 24 Apr 2020 05:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Apr 2020 05:32:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23265 invoked by uid 111); 24 Apr 2020 05:43:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Apr 2020 01:43:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Apr 2020 01:32:04 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, lkundrak@v3.sk,
        jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting
 gigabytes
Message-ID: <20200424053204.GD1648190@coredump.intra.peff.net>
References: <20200422104000.GA551233@coredump.intra.peff.net>
 <20200423213735.242662-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423213735.242662-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 02:37:35PM -0700, Jonathan Tan wrote:

> Thanks for the reproduction recipe (in [1]) and your analysis. I took a
> look, and it's because the check for in_vain is done differently. In v0:
> 
>   if (got_continue && MAX_IN_VAIN < in_vain) {
> 
> reflecting the documentation in pack-protocol.txt:
> 
>   However, the 256 limit *only* turns on in the canonical client
>   implementation if we have received at least one "ACK %s continue"
>   during a prior round.  This helps to ensure that at least one common
>   ancestor is found before we give up entirely.

Ah, thanks for that; I hadn't though to look in that file for more
clues.

> When debugging, I noticed that in_vain was increasing far in excess of
> MAX_IN_VAIN, but because got_continue was false, the client did not give
> up.
> 
> But in v2:
> 
>   if (!haves_added || *in_vain >= MAX_IN_VAIN) {
> 
> ("haves_added" is irrelevant to this discussion. It is another
> termination condition - when we have run out of "have"s to send.)
> 
> So there is no check that "continue" was sent. We probably should change
> v2 to match v0. I can start writing a patch unless someone else would
> like to take a further look at it.

Yeah, this fills in the final pieces of the puzzle I was chasing in:

 https://lore.kernel.org/git/20200422193324.GB558336@coredump.intra.peff.net/

And the patch you suggest sounds like the best solution.

I think there's some room for discussion about what the optimal
strategies are (e.g., v0 does send a lot more haves than v2 in this
instance, and it wouldn't always be helpful). But it makes sense to me
to put v2 and v0 on the same footing for now, especially given the
regressions people have mentioned, and then we can explore new options
at our convenience (like switching on the skipping negotiation
algorithm).

-Peff
