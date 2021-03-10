Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F1AC43381
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE4E64FCD
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhCJWTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:19:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:59284 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhCJWTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 17:19:45 -0500
Received: (qmail 7186 invoked by uid 109); 10 Mar 2021 22:19:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Mar 2021 22:19:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26361 invoked by uid 111); 10 Mar 2021 22:19:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Mar 2021 17:19:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Mar 2021 17:19:44 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/7] rev-parse: implement object type filter
Message-ID: <YElGANcek5DPxYKo@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <YElA+GI3oAZiueOs@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YElA+GI3oAZiueOs@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 04:58:16PM -0500, Taylor Blau wrote:

> On Mon, Mar 01, 2021 at 01:20:26PM +0100, Patrick Steinhardt wrote:
> > - A new object type filter `--filter=object:type=<type>` for
> >   git-rev-list(1), which is implemented both for normal graph walks and
> >   for the packfile bitmap index.
> 
> I understand what you're looking for here, but I worry that '--filter'
> might be too leaky of an abstraction.
> 
> I was a little surprised to learn that you can clone a repository with
> --filter=object:type=tree (excluding commits), but it does work. I'm
> fine reusing a lot of the object filtering code if it makes this an
> easier task, but I think it may be worthwhile to hide this new kind of
> filter from upload-pack.

I had a similar thought, but wouldn't the existing uploadpackfilter
config take care of this?

I guess the catch-all "allow" option defaults to "true", so we'd support
any new filters that are added. Which seems like a poor choice in
general, but flipping it would mean that servers have to update their
config.

I do wonder if it's that bad for clients to be able to specify something
like this, though. Even though there's not that much use for it with a
regular partial clone, it could conceivably used for some special cases.
I do think it would be more useful if you could OR together multiple
types. Asking for "commits|tags|trees" is really the same as the already
useful "blob:none". And "commits|tags" is the same as tree:depth=0.

-Peff
