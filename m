Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C191F597
	for <e@80x24.org>; Mon, 16 Jul 2018 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeGPUVX (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 16:21:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:48316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728061AbeGPUVX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 16:21:23 -0400
Received: (qmail 12268 invoked by uid 109); 16 Jul 2018 19:52:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 19:52:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14906 invoked by uid 111); 16 Jul 2018 19:52:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 15:52:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 15:52:26 -0400
Date:   Mon, 16 Jul 2018 15:52:26 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716195226.GB25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716191505.857-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 12:15:05PM -0700, Elijah Newren wrote:

> The basic problem here, at least for us, is that gc has enough
> information to know it could expunge some objects, but because of how
> it is structured in terms of several substeps (reflog expiration,
> repack, prune), the information is lost between the steps and it
> instead writes them out as unreachable objects.  If we could prune (or
> avoid exploding) loose objects that are only reachable from reflog
> entries that we are expiring, then the problem goes away for us.  (I
> totally understand that other repos may have enough unreachable
> objects for other reasons that Peff's suggestion to just pack up
> unreachable objects is still a really good idea.  But on its own, it
> seems like a waste since it's packing stuff that we know we could just
> expunge.)

No, we should have expunged everything that could be during the "repack"
and "prune" steps. We feed the expiration time to repack, so that it
knows to drop objects entirely instead of exploding them loose.

So the leftovers really are objects that cannot be deleted yet. You
could literally just do:

  find .git/objects/?? -type f |
  perl -lne 's{../.{38}$} and print "$1$2"' |
  git pack-objects .git/objects/pack/cruft-pack

But:

  - that will explode them out only to repack them, which is inefficient
    (if they're already packed, you can probably reuse deltas, not to
    mention the I/O savings)

  - there's the question of how to handle timestamps. Some of those
    objects may have been _about_ to expire, but now you've just put
    them in a brand-new pack that adds another 2 weeks to their life

  - the find above is sloppy, and will race with somebody adding new
    objects to the repo

So probably you want to have pack-objects write out the list of objects
it _would_ explode, rather than exploding them. And then before
git-repack deletes the old packs, put those into a new cruft pack. That
_just_ leaves the timestamp issue (which is discussed at length in the
thread I linked earlier).

> git_actual_garbage_collect() {
>     GITDIR=$(git rev-parse --git-dir)
> 
>     # Record all revisions stored in reflog before and after gc
>     git rev-list --no-walk --reflog >$GITDIR/gc.original-refs
>     git gc --auto
>     wait_for_background_gc_to_finish
>     git rev-list --no-walk --reflog >$GITDIR/gc.final-refs
> 
>     # Find out which reflog entries were removed
>     DELETED_REFS=$(comm -23 <(sort $GITDIR/gc.original-refs) <(sort $GITDIR/gc.final-refs))

This is too detailed, I think. There are other reasons to have
unreachable objects than expired reflogs. I think you really just want
to consider all unreachable objects (like the pack-objects thing I
mentioned above).

-Peff
