Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC561F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403980AbfIFRET (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:04:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:42204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726936AbfIFRET (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:04:19 -0400
Received: (qmail 20576 invoked by uid 109); 6 Sep 2019 17:04:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 17:04:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5041 invoked by uid 111); 6 Sep 2019 17:06:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 13:06:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 13:04:17 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
Message-ID: <20190906170417.GA23181@sigill.intra.peff.net>
References: <cover.1567563244.git.me@ttaylorr.com>
 <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
 <20190904030456.GA28836@sigill.intra.peff.net>
 <20190904211847.GA20904@syl.local>
 <20190905064723.GC21450@sigill.intra.peff.net>
 <36bf0064-b563-74ed-4ae5-01745ced5d2e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36bf0064-b563-74ed-4ae5-01745ced5d2e@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 12:48:05PM -0400, Derrick Stolee wrote:

> > diff --git a/revision.h b/revision.h
> > index 4134dc6029..5c0b831b37 100644
> > --- a/revision.h
> > +++ b/revision.h
> > @@ -33,7 +33,7 @@
> >  #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)
> >  
> >  #define TOPO_WALK_EXPLORED	(1u<<27)
> > -#define TOPO_WALK_INDEGREE	(1u<<28)
> > +#define TOPO_WALK_INDEGREE	(1u<<24)
> 
> As an aside, these flag bit modifications look fine, but would need to
> be explained. I'm guessing that since you are adding a bit of data
> to struct object you want to avoid increasing the struct size across
> a 32-bit boundary. Are we sure that bit 24 is not used anywhere else?
> (My search for "1u<<24" found nothing, and "1 << 24" found a bit in
> the cache-entry flags, so this seems safe.)

Yeah, I'd definitely break this up into several commits with explanation
(though see an alternate I posted that just uses the parsed flag without
any new bits).

Bit 24 isn't used according to the table in objects.h, which is
_supposed_ to be the source of truth, though of course there's no
compiler-level checking. (One aside: is there a reason TOPO_WALK_* isn't
part of ALL_REV_FLAGS?).

And yes, the goal was to keep things to the 32-bit boundary. But in the
course of this, I discovered something interesting: 64-bit systems are
now padding this up to the 8-byte boundary!

The culprit is the switch of GIT_MAX_RAWSZ for sha256. Before then, our
object_id was 20 bytes for sha1. Adding 4 bytes of flags still left us
at 24 bytes, which is both 4- and 8-byte aligned.

With the switch to sha256, object_id is now 32 bytes. Adding 4 bytes
takes us to 36, and then 8-byte aligning the struct takes us to 40
bytes, with 4 bytes of wasted padding.

I'm sorely tempted to use this as an opportunity to move commit->index
into "struct object". That would actually shrink commit object sizes by
4 bytes, and would let all object types do the commit-slab trick to
store object data with constant-time lookup. This would make it possible
to migrate some uses of flags to per-operation bitfields (so e.g., two
traversals would have their _own_ flag data, and wouldn't risk stomping
on each other's bits).

The one downside would be that the index space would become more sparse.
I.e., right now if you're only storing things for commits in a slab, you
know that every slot you allocate is for a commit. But if we allocate an
index for each object, then the commits are less likely to be together
(so wasted memory and worse cache performance). That might be solvable
by assigning a per-type index (with a few hacks to handle OBJ_NONE).

Anyway, all of that is rather off the topic of this discussion.

-Peff
