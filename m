Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2CC11F461
	for <e@80x24.org>; Thu, 22 Aug 2019 04:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfHVEPa (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 00:15:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:51964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725294AbfHVEPa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 00:15:30 -0400
Received: (qmail 27471 invoked by uid 109); 22 Aug 2019 04:15:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Aug 2019 04:15:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17664 invoked by uid 111); 22 Aug 2019 04:16:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Aug 2019 00:16:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Aug 2019 00:15:29 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] diff: skip GITLINK when lazy fetching missing objs
Message-ID: <20190822041529.GA4347@sigill.intra.peff.net>
References: <xmqqblwjtu1b.fsf@gitster-ct.c.googlers.com>
 <20190820213924.154253-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190820213924.154253-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 02:39:24PM -0700, Jonathan Tan wrote:

> > Jonathan Tan <jonathantanmy@google.com> writes:
> > 
> > > In 7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-08),
> > > diff was taught to batch the fetching of missing objects when operating
> > > on a partial clone, but was not taught to refrain from fetching
> > > GITLINKs. Teach diff to check if an object is a GITLINK before including
> > > it in the set to be fetched.
> > 
> > OK, so in a lazy repository, running "git diff" (or "git log") could
> > have resulted in "git fetch" of a history of a submodule, which may
> > likely have failed?
> 
> Yes - it would attempt to fetch the submodule commit (as stated in the
> GITLINK) from the superproject, which is very unlikely to succeed. (And
> succeeding would allow the operation to continue, but will cause the
> superproject to have unrelated objects in its object store, which is not
> what we want anyway.)

I wondered what would happen when it does not succeed. It looks like the
whole diff process just dies.

The batch fetch is purely an optimization, because we'd eventually fetch
the individual objects on demand. If the batch one fails, should we
continue with the operation? That leaves any error-handling for the
overall operation to the "real" code. And it would also mean that this
bug became an annoying error message,

But certainly your fix is the right thing to do regardless.

Tangential to your fix, but I also noticed while poking at this that
we're pretty aggressive about fetching objects, even if they won't be
needed. I know we touched on this briefly when discussing the original
patch, and the logic can get pretty complicated, so we punted. But there
are a few cases that I think might have a good cost/benefit ratio:

  1. a --raw diff without renames doesn't need the blobs (and even with
     renames, it only needs added/deleted entries). I imagine that being
     able to "git log --raw" on a full history without pulling in a
     bunch of blobs might be worthwhile (and a fairly common operation).

  2. Files that exceed bigFileThreshold or are marked as binary via
     gitattributes will generally be skipped during the file-level diff,
     without even loading them. These are the minority of files, but
     they also have an outsized cost to fetching them (and in fact may
     be the very thing people are trying to avoid with a blob filter).

Again, not anything to hold up your patch, but just cataloging some
future work for this area.

-Peff
