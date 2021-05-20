Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD972C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9DDD60FE7
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhETQvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 12:51:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:60788 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232199AbhETQvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 12:51:47 -0400
Received: (qmail 28694 invoked by uid 109); 20 May 2021 16:50:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 May 2021 16:50:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 910 invoked by uid 111); 20 May 2021 16:50:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 May 2021 12:50:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 May 2021 12:50:24 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] Speed up connectivity checks via quarantine dir
Message-ID: <YKaTUItbQ1pyMrrW@coredump.intra.peff.net>
References: <cover.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 09:13:18PM +0200, Patrick Steinhardt wrote:

> One of the issues I've found is the object connectivity check, which may
> run for a significant amount of time. The root cause here is that we're
> computing connectivity via `git rev-list --not --all`: if we've got many
> refs in the repository, computing `--not --all` is hugely expensive.
> 
> This commit series thus implements an alternative way of computing
> reachability, which reuses information from the object quarantine
> environment. Instead of doing a refwalk, we just look iterate over all
> packed and loose quarantined objects any for each of them, we determine
> whether their immediate references are all satisfied.

If I am reading the patches correctly, your definition of "satisfied"
is: the referenced object exists already on the receiving side.

But that's subtly different from the current rule, which is: the object
must be reachable from the current ref tips. The invariant that Git has
traditionally tried to maintain (for a repo not to be corrupt) is only
that we have the complete graph of objects reachable from the tips.

If we have an unreachable tree in the object database which references
blobs we don't have, that doesn't make the repository corrupt. And with
the current code, we would not accept a push that references that tree
(unless it also pushes the necessary blobs). But after your patch, we
would, and that would _make_ the repository corrupt.

I will say that:

  1. Modern versions of git-repack and git-prune try to keep even
     unreachable parts of the graph complete (if we are keeping object X
     that refers to Y, then we try to keep Y, too). But I don't know how
     foolproof it is (certainly the traversal we do there is "best
     effort"; if there's a missing reference that exists, we don't
     bail).

  2. This is not the only place that just checks object existence in the
     name of speed. When updating a ref, for example, we only check that
     the tip object exists.

So I suspect it might work OK in practice. But it is a pretty big
loosening of the current rules for pushes, and that makes me nervous.

There's another related change here that is actually a tightening of the
rules. The current code checks that the ref tips proposed by the sender
are valid.  If there are objects in the pack not needed for the ref
update, their connectivity isn't checked (though normal senders would
obviously avoid sending extra objects for no reason). Your "iterate over
all quarantined objects" makes that stricter.

I'm of two minds there:

  1. We could easily keep the original rule by just traversing the
     object graph starting from the ref tips, as we do now, but ending
     the traversal any time we hit an object that we already have
     outside the quarantine.

  2. This tightening is actually important if we want to avoid letting
     people _intentionally_ introduce the unreachable-but-incomplete
     scenario. Without it, an easy denial-of-service corruption against
     a repository you can push to is:

       - push an update to change a ref from X to Y. Include all objects
	 necessary for X..Y, but _also_ include a tree T which points to
	 a missing blob B. This will be accepted by the current rules
	 (but not by your patch).

       - push an update to change the ref from Y to C, where C is a
	 commit whose root tree is T. Your patch allows this (because we
	 already have T in the repository). But the resulting repository
	 is corrupt (the ref now points to an incomplete object graph).

If we wanted to keep the existing rule (requiring that any objects that
sender didn't provide are actually reachable from the current refs),
then we'd want to be able to check reachability quickly. And there I'd
probably turn to reachability bitmaps.

I suspect that "rev-list --use-bitmap-index" in the connectivity check
might help in some cases. Especially when you are looking at the union
of objects reachable from all refs, we can avoid a lot of fill-in
traversal (because if the bitmap for a recent ref includes the object in
an older ref, then we know the older ref is covered, even if it doesn't
have an on-disk bitmap at its tip). But I would not be at all surprised
if there are other slowdowns in the traversal code when you have a lot
of refs (e.g., I think we're pretty eager to parse all of the traversal
tips as part of the setup).

-Peff
