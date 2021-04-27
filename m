Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE1FC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E841613DC
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhD0POX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 11:14:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:36748 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235466AbhD0POW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 11:14:22 -0400
Received: (qmail 3085 invoked by uid 109); 27 Apr 2021 15:13:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Apr 2021 15:13:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19524 invoked by uid 111); 27 Apr 2021 15:13:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Apr 2021 11:13:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Apr 2021 11:13:38 -0400
From:   Jeff King <peff@peff.net>
To:     David Emett <dave@sp4m.net>
Cc:     git@vger.kernel.org
Subject: Re: Two issues with mark_reachable_objects
Message-ID: <YIgqIiCeiTISIio1@coredump.intra.peff.net>
References: <CAJ-dYSOVx0egnyxJb6ZjgWvEDR=19QPgc70JQ7cXUjUPZ1XDiQ@mail.gmail.com>
 <YIgijn93f639Pp7Z@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIgijn93f639Pp7Z@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 27, 2021 at 10:41:18AM -0400, Jeff King wrote:

> I think we'd just want to run the whole mark_recent block after doing
> the bitmap traversal.
> 
> There may be some subtlety with reusing the rev_info struct again. I
> think we'd want to reset the pending objects list after calling into the
> bitmap code. It _usually_ does an actual traversal that consumes the
> list, but not necessarily. I think traverse_bitmap_commit_list()
> probably ought to be the one to do it, so it behaves more like
> traverse_commit_list(). (OTOH, I don't think it's _too_ bad if we don't;
> we'd include those already-seen objects in our traversal, but they
> should all by definition have the SEEN bit set, so we'd stop there).

Nope, I was wrong here. It's actually prepare_bitmap_walk() which would
want to clear the pending list, and it does so (it may later re-add
objects in find_objects(), but if it does so, it will definitely
traverse and consume them).

> It's possible that we could do the second mark_recent traversal also
> with bitmaps (but still separately). I can't offhand think of a reason
> that ignore_missing_links wouldn't behave well there. But since we
> expect it to be small, I'd be more comfortable just using the regular
> traversal code.

I poked at this a bit, and indeed, the bitmap code is not ready to
handle the caller passing ignore_missing_links (it performs two separate
traversals for the wanted and uninteresting objects, and manipulates
ignore_missing_links itself between the two). It would probably be easy
to change, but I think we should focus on the minimal fix for the bug
you found first.

-Peff
