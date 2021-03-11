Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25700C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E334E64FF9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCKR5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:57:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:60672 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCKR4t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:56:49 -0500
Received: (qmail 16225 invoked by uid 109); 11 Mar 2021 17:56:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Mar 2021 17:56:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12115 invoked by uid 111); 11 Mar 2021 17:56:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Mar 2021 12:56:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Mar 2021 12:56:47 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/7] rev-parse: implement object type filter
Message-ID: <YEpZ30YOZ/akZ7pm@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <YElA+GI3oAZiueOs@nand.local>
 <YElGANcek5DPxYKo@coredump.intra.peff.net>
 <YEosm+RjD/YRIcLo@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEosm+RjD/YRIcLo@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 03:43:39PM +0100, Patrick Steinhardt wrote:

> > I do wonder if it's that bad for clients to be able to specify something
> > like this, though. Even though there's not that much use for it with a
> > regular partial clone, it could conceivably used for some special cases.
> > I do think it would be more useful if you could OR together multiple
> > types. Asking for "commits|tags|trees" is really the same as the already
> > useful "blob:none". And "commits|tags" is the same as tree:depth=0.
> 
> I did waste a few thoughts on how this should be handled. I see two ways
> of doing it:
> 
>     - We could just implement the new `object:type` filter such that it
>       directly supports OR'ing. That's the easy way to do it, but it's
>       inflexible.
> 
>     - We could extend combined filters to support OR-semantics in
>       addition to the current AND-semantics. In the end, that'd be a
>       much more flexible approach and potentially allow additional
>       usecases.
> 
> I lean more towards the latter as it feels like the better design. But
> it's more involved, and I'm not sure I want to do it as part of this
> patch series.

Yeah, I don't think that needs to be part of this series. The only thing
to consider for this series is whether it's a problem for clients to be
able to ask for type=blob from a server which has blindly turned on
uploadpack.allowFilter without restricting the types.

My gut is to say yes. Even if we don't have a particular use, I don't
think it hurts (and in general, I think people running public servers
with bitmaps really ought to set uploadpackfilter.allow=false anyway,
because stuff like non-zero tree-depth filters are expensive).

-Peff
