Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971B11F404
	for <e@80x24.org>; Thu, 16 Aug 2018 17:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeHPUga (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 16:36:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:57820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727973AbeHPUga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 16:36:30 -0400
Received: (qmail 10278 invoked by uid 109); 16 Aug 2018 17:36:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 17:36:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17827 invoked by uid 111); 16 Aug 2018 17:36:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 13:36:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 13:36:39 -0400
Date:   Thu, 16 Aug 2018 13:36:39 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 4/7] for_each_packed_object: support iterating in
 pack-order
Message-ID: <20180816173639.GB882@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
 <20180810231549.GD19875@sigill.intra.peff.net>
 <2ac79ea0-dd58-965d-1158-d08a7731e25d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ac79ea0-dd58-965d-1158-d08a7731e25d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 09:28:44AM -0400, Derrick Stolee wrote:

> On 8/10/2018 7:15 PM, Jeff King wrote:
> > diff --git a/commit-graph.c b/commit-graph.c
> > index b0a55ad128..69a0d1c203 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -730,7 +730,7 @@ void write_commit_graph(const char *obj_dir,
> >   				die("error adding pack %s", packname.buf);
> >   			if (open_pack_index(p))
> >   				die("error opening index for %s", packname.buf);
> > -			for_each_object_in_pack(p, add_packed_commits, &oids);
> > +			for_each_object_in_pack(p, add_packed_commits, &oids, 0);
> >   			close_pack(p);
> >   		}
> 
> This use in write_commit_graph() is actually a good candidate for
> pack-order, since we are checking each object to see if it is a commit. This
> is only used when running `git commit-graph write --stdin-packs`, which is
> how VFS for Git maintains the commit-graph.
> 
> I have a note to run performance tests on this case and follow up with a
> change on top of this series that adds the FOR_EACH_OBJECT_PACK_ORDER flag.

I doubt that it will show the dramatic improvement in CPU that I
mentioned in my commit message, because most of that comes from more
efficient use of the delta cache. But it's very rare for commits to be
deltas (usually it's just almost-twins due to cherry-picks and rebases).

So you may benefit from block cache efficiency on a cold-cache or on a
system under memory pressure, but I wouldn't expect much change at all
for the warm-cache case.

I doubt it will hurt, though; you'll pay for the revindex generation,
but that's probably not a big deal compared to walking all the objects.

One thing you _could_ do is stop walking through the pack when you see a
non-commit, since we stick all of the commits at the front. But that's
just what the code happens to do, and not a strict promise. So I think
it's a bad idea to rely on it (and in fact the delta-islands work under
discussion elsewhere will break that assumption).

-Peff
