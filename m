Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393F6C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 20:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0B42251D
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 20:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbhAYUvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 15:51:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:38290 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732325AbhAYUv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 15:51:27 -0500
Received: (qmail 9404 invoked by uid 109); 25 Jan 2021 20:50:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Jan 2021 20:50:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21416 invoked by uid 111); 25 Jan 2021 20:50:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Jan 2021 15:50:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Jan 2021 15:50:45 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 4/8] builtin/pack-objects.c: respect
 'pack.writeReverseIndex'
Message-ID: <YA8vJcb7YbLwmF/V@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <68bde3ea972f5b3753d7e9063d0490c67c74709b.1610576805.git.me@ttaylorr.com>
 <YAtmb7wXQse76kJi@coredump.intra.peff.net>
 <YAto/ndOVfKSkizS@coredump.intra.peff.net>
 <YA8oPcvS0n8pUmcB@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YA8oPcvS0n8pUmcB@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 03:21:17PM -0500, Taylor Blau wrote:

> > Oh, one subtlety here: this is in pack-objects itself, _not_ in
> > git-repack. This has bit us before with options like
> > repack.writebitmaps, which was originally pack.writebitmaps and
> > introduced all sorts of awkwardness (because pack-objects serves many
> > other purposes besides repacks).
> 
> I'd think that we'd want a single option to control whether or not
> reverse indexes are written to disk. I briefly considered (and I believe
> that you and I even discussed) having options to control this behavior
> per command, but it got out of hand quickly.

Yeah, I think per-command is something we should avoid.

My concern is mostly that pack-objects in a non-repack setting would
accidentally try to write a .rev file (or complain that it cannot). But
again, we already have the same potential issue for .idx files, so by
following those code paths as you did, we should be OK.

And certainly we test that code path a lot in the normal test suite
(i.e., every fetch or push), so your run-the-test-suite-with-rev-files
patches from later would presumably catch it otherwise.

> And that might have been OK, but I don't think the complexity was even
> warranted, because really on-disk reverse indexes are an all-or-nothing
> thing. That is: either you want to have revindexes accompanying .packs,
> or you don't. IOW, it doesn't matter whether those packs were pushed to
> us, or generated during repack, or from another pack-objects or what
> have you.

Right, I agree with all of that.

-Peff
