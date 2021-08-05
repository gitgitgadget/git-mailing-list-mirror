Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8CCC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8F461104
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbhHEUkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:40:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:40764 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233465AbhHEUkc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 16:40:32 -0400
Received: (qmail 12764 invoked by uid 109); 5 Aug 2021 20:40:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Aug 2021 20:40:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7344 invoked by uid 111); 5 Aug 2021 20:40:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Aug 2021 16:40:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Aug 2021 16:40:16 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
Message-ID: <YQxMsDUNndA2KWbS@coredump.intra.peff.net>
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
 <YQr/vLNjZomIe1ME@coredump.intra.peff.net>
 <YQt/g0iZxAVgw66o@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQt/g0iZxAVgw66o@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 05, 2021 at 08:04:51AM +0200, Patrick Steinhardt wrote:

> > Nice. I've sometimes wondered if parse_object() should be doing this
> > optimization itself. Though we'd possibly still want callers (like this
> > one) to give us more hints, since we already know the type is
> > OBJ_COMMIT. Whereas parse_object() would have to discover that itself
> > (though we already incur the extra type lookup there to handle blobs).
> 
> Would certainly make it much harder to hit this pitfall. The only thing
> one needs to be cautious about is that we need to somehow assert the
> object still exists in our ODB. Otherwise you may look up a commit via
> the commit-graph even though the commit doesn't exist anymore.

True, though what I really wonder is what exactly people are depending
on parse_object() for. I.e., how many callers care about making sure it
exists, and how many would be happy to have things magically go faster?

I'm not sure of a good way to answer that question, but I agree it's the
sticking point on pushing the optimization down to that lower level.

(In case it's not clear, this is all a question for the future, and
shouldn't hold up your patch).

> > Do you have a lot of tags in your repository?
> 
> No, it's only about 2000 tags.

Hmm. In that case, I wonder if we could be using the ref peel data in
the opposite direction:

  0. With modern packed-refs, the file tells us definitely whether an
     object was peel-able or not.

  1. If it is peel-able, then do the same tag-peeling we do now.  This
     handles the intermediate stages, etc, and the optimization doesn't
     help us.

  2. If it isn't peel-able, then we know it's not a tag. We can
     _guess_ that it's a commit, because most refs that point to
     non-tags are, and try to look it up in the commit graph.

  3. If we do find it in the commit graph, we win. We saved having to
     call oid_object_info() to get the type.

  4. If we didn't, then we have to get the real type (it might simply be
     a commit that isn't in the graph files), and we lose. We did a
     pointless lookup in the graph file.

I think in general we'd win on balance, because most refs do point to
commits. But I'm not sure how big the win would be. You'd have to time
it on your weird 2M-ref case (though your numbers below suggest it may
be a few seconds).

(And I know I'm spouting a lot of micro-optimization ideas here; I won't
be offended if you don't feel like following up on them).

> > I wonder where the remaining 20s is going. 
> 
> Rebasing this commit on top of my git-rev-list(1) series [1] for the
> connectivity check gives another 25% speedup, going down from 20s to 14s
> (numbers are a bit different given that I'm on a different machine right
> now). From here on, it's multiple things which take time:
> 
>     - 20% of the time is spent sorting the refs in
>       `mark_complete_and_common_ref()`. This time around I feel less
>       comfortable to just disable sorting given that it may impact
>       correctness.
> 
>     - 30% of the time is spent looking up object types via
>       `oid_object_info_extended()`, where 75% of these lookups come from
>       `deref_without_lazy_fetch()`. This can be improved a bit by doing
>       the `lookup_unknown_object()` dance, buying a modest speedup of
>       ~8%. But this again has memory tradeoffs given that we must
>       allocate the object such that all types would fit.

Thanks, that all makes sense.

I think the suggestion I made above is similar to what you're thinking
with lookup_unknown_commit(), but would avoid the extra allocations.

-Peff
