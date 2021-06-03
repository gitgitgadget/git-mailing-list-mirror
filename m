Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856CFC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D4C611ED
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCTYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:24:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:45306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCTYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:24:20 -0400
Received: (qmail 6307 invoked by uid 109); 3 Jun 2021 19:22:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jun 2021 19:22:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28414 invoked by uid 111); 3 Jun 2021 19:22:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jun 2021 15:22:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Jun 2021 15:22:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Ilias Apostolou <ilias.apostolou.zero@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request feature: =?utf-8?B?4oCTbm8t?= =?utf-8?Q?submodule?=
Message-ID: <YLkr+kLdjmHyPjgl@coredump.intra.peff.net>
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
 <YLfqiLbpPXWXHlBi@nand.local>
 <xmqq8s3r7oma.fsf@gitster.g>
 <YLg/dLqYFEqHZJUn@nand.local>
 <xmqq7dja6e46.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dja6e46.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 04, 2021 at 02:40:25AM +0900, Junio C Hamano wrote:

> Besides, you can iterate over the available submodules with "git
> submodule foreach" fairly mechanically, and maintaining the
> attribute per path shouldn't be all that hard, I would imagine.

It doesn't seem outrageous to me for Git to automatically populate
"pseudo-attributes" that connect properties of paths to the attribute
system. I.e., could we just act as if every path that is a gitlink has
the "gitlink" attribute set to true, and let people do:

  git ls-files ':(attr:-gitlink)'

That uses the existing generic mechanism, so it supports complex
situations, but it also makes the "easy" case of "just ignore
submodules" easy, with no attribute maintenance.

I didn't look at the code, though, so I'm not sure how awkward it would
be to implement (usually we decide on attributes only from looking at
the attribute files, not the trees/index themselves, but I think most
code asking about a path would be iterating a list of files in the first
place, and could feed the mode information).

An alternative view is allowing a pathspec that asks about the mode:

  git ls-files ':(mode=160000)'

That also lets you ask about other things, like:

  git ls-files ':(mode=100755)'

but it is probably unnecessarily arcane (even I had to look up the
correct mode for a gitlink just now :) ).

-Peff
