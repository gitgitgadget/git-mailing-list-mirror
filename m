Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF7C2D0D3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669FF2070A
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLVJi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 04:38:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:52278 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725997AbfLVJi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 04:38:58 -0500
Received: (qmail 12736 invoked by uid 109); 22 Dec 2019 09:38:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Dec 2019 09:38:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26960 invoked by uid 111); 22 Dec 2019 09:43:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Dec 2019 04:43:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Dec 2019 04:38:57 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
Message-ID: <20191222093857.GB3449072@coredump.intra.peff.net>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <CAP8UFD1mOEUngLofTZ2hjsTooR49FktfWHWJGzQ9Y-a=oB-mZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1mOEUngLofTZ2hjsTooR49FktfWHWJGzQ9Y-a=oB-mZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 22, 2019 at 10:26:20AM +0100, Christian Couder wrote:

> I have a question though. Are the performance gains only available
> with `git log -- path` or are they already available for example when
> doing a partial clone and/or a sparse checkout?

From my quick look at the code, anything that feeds a pathspec to a
revision traversal would be helped. I'm not sure if it would help for
partial/sparse traversals, though. There we actually need to know which
blobs correspond to the paths in question, not just whether any
particular commit touched them.

I also took a brief look at adding support to the custom blame-tree
implementation we use at GitHub, and got about a 6x speedup.

> > This series is intended to start the conversation and many of the commit
> > messages include specific call outs for suggestions and thoughts.
> 
> I think Peff said during the Virtual Contributor Summit that he was
> interested in using bitmaps to speed up partial clone on the server
> side. Would it make sense to use both bitmaps and bloom filters?

I think they're orthogonal. For size-based filters on blobs, you'd just
use bitmaps as normal, because you can post-process the result to check
the type and size of each object in the list (and I have patches to do
this, but they need some polishing and we're not yet running them).

For path-based filters like a sparse specification, you can't use
bitmaps at all; you have to do a real traversal. But there you still
generally get all of the commits. I guess if a commit doesn't touch any
path you're interested in, you could avoid walking into its tree at all,
which might help. I haven't given it much thought yet.

-Peff
