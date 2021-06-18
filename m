Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB18C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC55161205
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhFRNCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:02:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:59922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhFRNCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 09:02:09 -0400
Received: (qmail 26637 invoked by uid 109); 18 Jun 2021 12:59:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Jun 2021 12:59:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15158 invoked by uid 111); 18 Jun 2021 12:59:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Jun 2021 08:59:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Jun 2021 08:59:59 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bitmaps: don't recurse into trees already in the bitmap
Message-ID: <YMyYz6Tavj5l6S8n@coredump.intra.peff.net>
References: <YMcExxF7DI6k+sZ+@coredump.intra.peff.net>
 <YMdGGL6v8LrbcAJP@coredump.intra.peff.net>
 <471cb9be-bb72-6a37-ede8-f9421d9d3ebe@gmail.com>
 <YMnvCI/jksyn2flD@tanuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMnvCI/jksyn2flD@tanuki>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 02:31:04PM +0200, Patrick Steinhardt wrote:

> > These many-refs scenarios make sense as something that is difficult to
> > verify using a single fork of an open-source project, but is common in
> > many closed-source projects that do not use forking to reduce the ref
> > count per repo.
> 
> Agreed. What I typically do to emulate this is to use some version of
> following command to create refs for "$n" commits.
> 
>     git log --all --format="tformat:create refs/commit/%h %H" |
>         shuf | head -n "$n" | git update-ref --stdin
> 
> It's obviously not ideal given that resulting refs are distributed at
> random. But combined with a sufficiently large repo, it's still helped
> me at times to reproduce adverse performance at times.

Yeah, I've done something similar. But I'd caution people into reading
too much into performance tests from something like that. What I've
found over the years is that traversal and bitmap performance can be
somewhat sensitive to tree shape and bitmap placement (which in turn is
often influenced by ref placement, if you are using delta islands or the
recently added pack.preferBitmapTips).

More than once I've spent many head-scratching hours trying to determine
why some real-world repo performs better or worse than expected. :)

> Anyway, the patch does look good to me and sounds like it may help with
> some of the cases where I have observed adverse performance with bitmaps
> enabled in the past. Thanks!

Thanks for taking a look!

-Peff
