Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4640FC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 18:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A94B2072E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 18:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgCVSpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 14:45:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:47260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725785AbgCVSpU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 14:45:20 -0400
Received: (qmail 30292 invoked by uid 109); 22 Mar 2020 18:45:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 18:45:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2499 invoked by uid 111); 22 Mar 2020 18:55:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 14:55:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 14:45:19 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: looking up object types quickly, was Re: [PATCH 1/1] commit-graph.c:
 avoid unnecessary tag dereference when merging
Message-ID: <20200322184519.GA654322@coredump.intra.peff.net>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <20200321172716.GA39461@syl.local>
 <20200322053635.GA578498@coredump.intra.peff.net>
 <20200322110424.GC2224@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200322110424.GC2224@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 12:04:24PM +0100, SZEDER Gábor wrote:

> > > Where the last step is taking all commits listed in any pack, which is
> > > cheap to iterate.
> > 
> > I'm not sure it's all that cheap. It has to find the type of every
> > object in every pack. And finding types involves walking delta chains.
> 
> Indeed, that's just about the most expensive way to find all commits,
> in my experience it can be well over a magnitude slower than
> '--reachable'.

They don't necessarily produce the same set of commits, of course, but
for the purposes of "commit-graph write" I think they can generally be
considered interchangeable.

The speed depends on a couple of factors. One is just the makeup of the
repository: tree size, how many are deltas, etc. But a big one is
whether commit-graphs are already enabled. :)

On linux.git without commit-graphs, both of these take about 7.5s for
me:

  git cat-file --batch-all-objects --unordered --batch-check='%(objecttype) %(objectname)'

  git rev-list --all

But with graphs, the latter takes about 700ms.

I was coincidentally thinking about this problem ("show me all commits")
for something unrelated recently, and I do think that cat-file
invocation could be sped up in some cases. Here are a few ideas:

1. If the pack has a .bitmap file, it contains 4 "type" bitmaps that you
   can use to quickly determine the type of a given object. But:

   - the current code for loading bitmaps files is slower than we'd
     need; it indexes all of the commit bitmaps, but we wouldn't use
     them. So we'd want something that just loads the type bitmaps and
     stops.

   - you have to know the bit position of the object you're interested
     in, which implies computing the revidx. We could provide a "bit
     position" cache in the bitmap file (basically one uint32_t for each
     object giving the packfile order position, but stored in pack .idx
     order).

   Neither is too hard a problem, but it's clearly not just a small
   patch to consult the bitmap.

   It could be patched directly into oid_object_info_extended(), which
   could do individual type lookups this way. But it would be faster
   still if callers could say "I'm only interested in commits", in which
   case we could just quickly walk the commit-type bitmap in one pass
   (to get the commits in just that packfile, and then go through the
   other objects the old-fashioned way).

2. The commit-graph file can quickly tell us whether an object is a
   commit. But unfortunately it can give us a definite "yes", but not a
   definite "no" (because it might be a commit that just isn't (yet) in
   the graph file). So we'd have to find the real type of any
   non-commits, and I think that's where we spend the bulk of our time
   anyway.

3. To find the type of a delta object, we have to walk back to a base
   object with a concrete type. When we access the actual object
   contents, we cache intermediate bases to avoid digging down the same
   chain over and over. But I don't think there's any such cache for the
   type lookup. So if you have a 50-deep delta chain and want the type
   of each object, you'll walk down 49 links, then 48 links, and so on.
   It probably wouldn't be that hard to have a small type cache (or just
   allow the existing cache to have entries for "I know the type, but
   don't have the contents").

I suspect (1) would give the biggest speedup, but is more work and
requires bitmaps. I think (3) is likely to give a moderate win and
probably isn't that big a patch.

-Peff
