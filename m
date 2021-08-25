Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D238C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 07:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593A860E78
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 07:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbhHYHhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 03:37:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:58636 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238790AbhHYHhB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 03:37:01 -0400
Received: (qmail 24129 invoked by uid 109); 25 Aug 2021 07:36:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Aug 2021 07:36:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6853 invoked by uid 111); 25 Aug 2021 07:36:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Aug 2021 03:36:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Aug 2021 03:36:15 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 00/25] multi-pack reachability bitmaps
Message-ID: <YSXy73lWKteiuY6s@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
 <YSWOtNoxirDdmBXG@coredump.intra.peff.net>
 <YSWmhMID1hGs7Yp1@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSWmhMID1hGs7Yp1@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 10:10:12PM -0400, Taylor Blau wrote:

> > It's not clear to me that we have a resolution on whether calling "cd ..
> > && git multi-pack-index write --object-dir repo.git" is supposed to
> > work.
> 
> My recommendation would be to do the following things, all in a reroll
> of this series:
> 
>   - Fix the bug by which we would delete a .rev or .bitmap file out of a
>     different object store than we were working in (when the caller
>     passes `--object-dir`).
> 
>   - Disallow running `git multi-pack-index` outside of a Git repository.
> 
>   - Restrict `--object-dir` to only work with alternates of the
>     repository in the current working directory.
> 
> To me, that seems like both the least-surprising behavior, and what
> would lend itself to the easiest implementation. I would probably argue
> that the existing behavior (where `--object-dir` would work against
> arbitrary repositories) is a bug, and shouldn't continue to be
> supported.

All of those seem reasonable to me, and are what I would suggest if we
were starting from scratch. My only hesitation is whether people are
using the weird behavior of --object-dir in the wild (e.g., are bup
folks relying on it).

Johannes, is this something you're using _now_, and it works, or
something you hoped to use in the future?

In a sense, "hope to use" does not make you any less disappointed. ;)
But what I'm wondering is whether using --object-dir from outside a repo
entirely is actually something that even works. I.e., would we be
disabling a behavior that was not intended, but does happen to work? Or
are we closing off a possibly buggy and half-working part of the system?

-Peff
