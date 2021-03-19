Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4939DC433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 19:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16ACF61962
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 19:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCSTcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 15:32:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:42752 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhCSTb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 15:31:59 -0400
Received: (qmail 8916 invoked by uid 109); 19 Mar 2021 19:31:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Mar 2021 19:31:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5366 invoked by uid 111); 19 Mar 2021 19:31:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Mar 2021 15:31:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Mar 2021 15:31:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] builtin/pack-objects.c: ignore missing links with
 --stdin-packs
Message-ID: <YFT8LqAcCqpG2wyl@coredump.intra.peff.net>
References: <815623da67d283e8509fc4ac67e939c6140fc39a.1616168441.git.me@ttaylorr.com>
 <xmqqim5nm2g0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqim5nm2g0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 19, 2021 at 11:19:11AM -0700, Junio C Hamano wrote:

> > The traversal expects that it should be able to walk the ancestors of
> > all commits in a pack without issue. Ordinarily this is the case, but it
> > is possible to having missing parents from an unreachable part of the
> > repository. In that case, we'd consider any missing objects in the
> > unreachable portion of the graph to be junk.
> 
> Ah, OK.  So a pack that is being consolidated, or more likely a
> loose commit that is rolled into the smallest geometric group) may
> contain an unreachable commit, whose tree or blob has already been
> pruned, which is an expected state (i.e. tree or blob may have been
> older than the commit whose message may have been amended recently
> before the entire commit got abandoned).  And we do not want to alarm
> users by warning.

Yes, though it is not just warning, but rather that before this patch
we'd abort the whole repack.

> > This should be handled gracefully: since the traversal is best-effort
> > (i.e., we don't strictly need to fill in all of the name-hash fields),
> > we should simply ignore any missing links.
> 
> Or the entire set of objects that refer them can be omitted from the
> resulting set of objects (iow, consider a commit that lacks a tree
> or a blob to be checked out stale and prunable without downsides,
> and prune it and its remaining trees and blobs by leaving them out
> of the resulting pack), but I suspect that is a lot more involved
> change.

It is safe to omit the whole set from the name-hash traversal, which is
purely an optimization. But it would generally not be a good idea to
leave them out of the resulting pack, since that would mean deleting
them entirely from the repository (because we'll remove the old packs
they were in after pack-objects completes).

If they are truly unreachable, then it is not strictly wrong to delete
them (i.e., we are not corrupting a repository unless it was already
corrupted), but:

  - if the repository _is_ already corrupted, we are definitely making
    things worse

  - we generally try to keep even unreachable parts of the graph
    complete, doing things like keeping unreachable-but-old objects that
    are reachable from unreachable-but-recent. Again, we know here that
    the object graph is incomplete, so anybody pointing a ref at a
    descendant of our broken commit is already corrupting the
    repository. But it probably makes sense to follow the existing rules
    as much as possible, and not make such a situation worse.

> > It is a little over-eager, since it will also ignore missing links in
> > reachable parts of the packs (which would indicate a corrupted
> > repository), but '--stdin-packs' is explicitly *not* about reachability.
> > So this step isn't making anything worse for a repository which contains
> > packs missing reachable objects (since we never drop objects with
> > '--stdin-packs').
> 
> Yup.  I find the reasoning quite sensible.
> 
> Thanks, will queue.

I had seen and discussed the patch before it hit the list, but just to
make it explicit: it also looks good to me. ;)

-Peff
