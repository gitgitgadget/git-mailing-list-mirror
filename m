Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 741A71F4B6
	for <e@80x24.org>; Thu, 16 May 2019 21:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfEPVM2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 17:12:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:59864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727086AbfEPVM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 17:12:28 -0400
Received: (qmail 569 invoked by uid 109); 16 May 2019 21:12:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 21:12:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7022 invoked by uid 111); 16 May 2019 21:13:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 17:13:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 17:12:26 -0400
Date:   Thu, 16 May 2019 17:12:26 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190516211226.GE9816@sigill.intra.peff.net>
References: <20190515231617.GA1395@sigill.intra.peff.net>
 <20190516182646.173332-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516182646.173332-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 11:26:46AM -0700, Jonathan Tan wrote:

> > Pretty unlikely, but should we put some kind of circuit-breaker into the
> > client to ensure this?
> 
> I thought of this - such a server could, but it seems to me that it
> would be similar to a server streaming random bytes to us without
> stopping (which is already possible).

True. I was thinking mainly of the infinite-redirection protections we
put in place for https. But I agree that in general, since we don't have
inherent limits on the size of workloads, that servers can already troll
clients pretty hard in a variety of ways.

So I could go either way, though I do think it makes sense for on-demand
fetches for partial clones to avoid asking for thin packs as a general
principle. As a matter of fact, should partial clones _always_ avoid
asking for thin packs?  That would make this issue go away entirely.

Sometimes it would be more efficient (we do not have to get an extra
base object just to resolve the delta we needed) but sometimes worse (if
we did actually have the base, it's a win). Whether it's a win would
depend on the "hit" rate, and I suspect that is heavily dependent on
workload characteristics (what kind of filtering is in use, are we
topping up in a non-partial way, etc).

> > Off the top of my head, I am pretty sure your assumption holds for all
> > versions of Git that support delta-base-offset[1]. But that feels a lot
> > less certain to me. I could imagine an alternate server implementation,
> > for example, that is gluing together packs and does not try hard to
> > order the base before the delta, which would require it to use REF_DELTA
> > instead of OFS_DELTA.
> 
> A cursory glance makes me think that REF_DELTA against a base object
> also in the pack is already correctly handled. Right before the
> invocation of conclude_pack() (which calls fix_unresolved_deltas(), the
> function I modified), resolve_deltas() is invoked. The latter invokes
> resolve_base() (directly or through threaded_second_pass()) which
> invokes find_unresolved_deltas(), which invokes
> find_unresolved_deltas_1(), which seems to handle both REF_DELTA and
> OFS_DELTA.
> 
> Snipping the rest as I don't think we need to solve those if we can
> handle REF_DELTA being against an object in a pack, but let me know if
> you think that some of the points there still need to be addressed.

Right, REF_DELTA is definitely correctly handled currently, and I don't
think that would break with your patch. It's just that your patch would
introduce a bunch of extra traffic as we request bases separately that
are already in the pack.

-Peff
