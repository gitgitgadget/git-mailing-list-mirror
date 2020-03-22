Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93B4C4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 05:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BFA20753
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 05:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCVFtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 01:49:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:46792 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725892AbgCVFtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 01:49:18 -0400
Received: (qmail 23532 invoked by uid 109); 22 Mar 2020 05:49:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 05:49:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29714 invoked by uid 111); 22 Mar 2020 05:59:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 01:59:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 01:49:16 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200322054916.GB578498@coredump.intra.peff.net>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
 <20200322002005.GA48038@syl.local>
 <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 08:23:13PM -0400, Derrick Stolee wrote:

> On 3/21/2020 8:20 PM, Taylor Blau wrote:
> > On Sat, Mar 21, 2020 at 08:03:01PM -0400, Derrick Stolee wrote:
> >> On 3/21/2020 2:50 PM, Junio C Hamano wrote:
> >>> Do we need to worry about INFO_QUICK and SKIP_FETCH_OBJECT in this
> >>> codepath, by the way?
> >>
> >> I was coming back to this thread to bring up these exact flags for
> >> consideration. The good news is that in a partial clone with any
> >> amount of filtering we will still have all reachable commits, which
> >> are necessary for the commit-graph to make sense. The only ones that
> >> would fail has_object_file() are ones removed by GC, but they may
> >> still exist on the remote. So without SKIP_FETCH_OBJECT, we would
> >> generate a network call even if the server has GC'd to remove the
> >> commits. This gets particularly bad when the server returns all
> >> reachable objects from that commit!
> > 
> > That makes sense. Do you think something like this should be applied?
> > +       int flags = OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT;
> [...]
> 
> Yes, I think this is the appropriate update. Thanks!

I'm not so sure.

In a non-partial clone, when would expect QUICK to matter? If we find
the object is missing, then either:

  - we are racing with repack, and we would benefit from double-checking
    that the object really is gone

  - we used to have it (since it was mentioned in the graph file) but it
    went away

Using QUICK means we won't waste time double-checking in the second
case. But it means we won't catch the first case, and we may generate a
new graph file that omits the object. They're both optimizations, and I
don't think we're impacting correctness[1], but it's not clear to me
whether one is a win over the other. We don't generally expect objects
we have to go away often.

Skipping fetching seems a little more straight-forward to me. If we had
it in a graph file, presumably we had the actual object before, too. And
either we're in the first case above (we really do have it and just need
to double-check) in which case not saying QUICK would be enough. Or we
intentionally got rid of it. In which case downloading it just to
generate a cache is quite silly.

So it seems like SKIP_FETCH_OBJECT but _not_ QUICK might be reasonable
here.

-Peff

[1] I'm actually not quite sure about correctness here. It should be
    fine to generate a graph file without any given commit; readers will
    just have to load that commit the old-fashioned way. But at this
    phase of "commit-graph write", I think we'll already have done the
    close_reachable() check. What does it mean to throw away a commit at
    this stage? If we're the parent of another commit, then it will have
    trouble referring to us by a uint32_t. Will the actual writing phase
    barf, or will we generate an invalid graph file?
