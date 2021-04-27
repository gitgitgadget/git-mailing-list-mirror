Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB5C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 14:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F7E613DC
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 14:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbhD0OmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 10:42:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:36712 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236144AbhD0OmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 10:42:03 -0400
Received: (qmail 2982 invoked by uid 109); 27 Apr 2021 14:41:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Apr 2021 14:41:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19280 invoked by uid 111); 27 Apr 2021 14:41:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Apr 2021 10:41:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Apr 2021 10:41:18 -0400
From:   Jeff King <peff@peff.net>
To:     David Emett <dave@sp4m.net>
Cc:     git@vger.kernel.org
Subject: Re: Two issues with mark_reachable_objects
Message-ID: <YIgijn93f639Pp7Z@coredump.intra.peff.net>
References: <CAJ-dYSOVx0egnyxJb6ZjgWvEDR=19QPgc70JQ7cXUjUPZ1XDiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-dYSOVx0egnyxJb6ZjgWvEDR=19QPgc70JQ7cXUjUPZ1XDiQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 27, 2021 at 11:45:01AM +0100, David Emett wrote:

> I noticed that this only happened when the fetch triggered an automatic GC at
> the end. After a bit of digging I discovered two separate issues:
> 
> 1) It seems that FETCH_HEAD is not considered a root by mark_reachable_objects.

Right, as you discovered, this is known and intentional. I don't have
anything to add to the thread you linked already.

> 2) If the bitmap_git branch in mark_reachable_objects is taken, the mark_recent
>    argument is ignored. This doesn't _completely_ break "git prune"'s --expire
>    option, as it turns out there is another explicit mtime check in
>    prune_object (prune.c). If that check passes this is not propagated to
>    referenced objects though. So even if a dangling commit is recent, a prune
>    can discard old objects it references.

But this one is a scary bug. As you note, it's not _completely_ breaking
"--expire", but it is totally disabling the "reachable from recent"
safety added in d3038d22f9 (prune: keep objects reachable from recent
objects, 2014-10-15).

The bug here was introduced by me, and comes from a matter of timing.
Despite what you'll see in the project history, the "use bitmaps" patch
actually predates the "reachable from recent" one. I just didn't clean
it up and upstream it until 2019, and failed to notice the bad
interaction between the two.

> I assume (2) is not intentional, given that "git gc --help" explicitly says
> "Any object with modification time newer than the --prune date is kept, along
> with everything reachable from it." Is it safe to just run the mark_recent
> block after the bitmap_git block? Could add_unseen_recent_objects_to_traversal
> just be called at the start of the bitmap_git block if mark_recent?

So no, definitely not intentional.

I think we'd just want to run the whole mark_recent block after doing
the bitmap traversal.

There may be some subtlety with reusing the rev_info struct again. I
think we'd want to reset the pending objects list after calling into the
bitmap code. It _usually_ does an actual traversal that consumes the
list, but not necessarily. I think traverse_bitmap_commit_list()
probably ought to be the one to do it, so it behaves more like
traverse_commit_list(). (OTOH, I don't think it's _too_ bad if we don't;
we'd include those already-seen objects in our traversal, but they
should all by definition have the SEEN bit set, so we'd stop there).

I don't think we want to add_unseen_recent_objects_to_traversal() to
include it as part of the same traversal, for the same reason the
non-bitmap traversal does not combine them: the mark_recent traversal is
best-effort. We set revs->ignore_missing_links to be tolerant of
already-broken segments of history.

It's possible that we could do the second mark_recent traversal also
with bitmaps (but still separately). I can't offhand think of a reason
that ignore_missing_links wouldn't behave well there. But since we
expect it to be small, I'd be more comfortable just using the regular
traversal code.

-Peff
