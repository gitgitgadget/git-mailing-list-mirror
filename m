Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F081FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 18:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S946374AbdDTSfA (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 14:35:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:37031 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936262AbdDTSe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 14:34:59 -0400
Received: (qmail 25095 invoked by uid 109); 20 Apr 2017 18:34:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 18:34:57 +0000
Received: (qmail 6459 invoked by uid 111); 20 Apr 2017 18:35:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 14:35:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 14:34:55 -0400
Date:   Thu, 20 Apr 2017 14:34:55 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
Message-ID: <20170420183455.y5oz3hspz3v2g6yr@sigill.intra.peff.net>
References: <20170418194421.22453-1-git@jeffhostetler.com>
 <20170418194421.22453-2-git@jeffhostetler.com>
 <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
 <xmqqd1c9cdzi.fsf@gitster.mtv.corp.google.com>
 <20170419025608.xy5nvso6k6lb5z7g@sigill.intra.peff.net>
 <20170419031839.m2zgwywa2soejiqk@sigill.intra.peff.net>
 <40228c69-7946-3ef1-35de-4cea9b0312e4@jeffhostetler.com>
 <20170420161359.haolllw4ac5jjqx4@sigill.intra.peff.net>
 <4d400fb6-201e-e1ba-cc3a-935951ab3e14@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d400fb6-201e-e1ba-cc3a-935951ab3e14@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 02:08:46PM -0400, Jeff Hostetler wrote:

> > That's not the minimal change you were going for, but I think the end
> > result is simpler and more consistent.
> 
> OK, let me take a stab at something like that and
> see where it takes me.

Thanks.

I set the patch as a lump, but I think there are a few things going on
there:

  - the return value of register_rename_src() is actively dangerous (it
    points to memory which may be reallocated), so it's good that it
    goes away in favor of an "int"

  - we already refuse to do rename detection when there are duplicate
    dsts. This adds the same for srcs. I don't know if the same safety
    rules apply there, but it certainly seems like a reasonable and
    consistent precaution to say "this tree looks broken, let's skip
    rename detection". But it does mean a potential change in
    functionality in that corner case.

  - this patch probably adds "unsorted tree" to the list of breakages
    that would cause us to skip rename detection. I don't know if that's
    actually possible in practice (i.e., do we end up sorting the
    diffq elsewhere anyway?). I also wondered if it might run afoul of
    diffcore_order(), but that is applied after rename detection, so
    we're OK.

> WRT your earlier comment about how often we add or delete 4M
> files and then run status.  The use case that started this was a
> 1% sparse-checkout followed by a read-tree (which reset the
> skip-worktree bits) and then status (which thought 99% of the
> worktree had been deleted or maybe renamed).  There are probably
> other ways to get into this state, but that's how this started.

Right, that sounds plausible. I guess I just wondered if this is
something an average developer runs daily, or something that they would
run into once a year. Shaving 4s of CPU off of a once-a-year operation
is less exciting.

> The more subtle point is that -- for these obscenely large
> values of n -- any time I see an O(n log n) operation that could
> or should be O(n), I want to stop and look at it.

Heh. I spent a fair bit of time in Git's past turning O(n^2) operations
into O(n log n), so I feel your pain. I do think it's important to pay
attention to whole-operation numbers, though. Quite often you have an
O(n log n) with a small constant (like a single strcmp) coupled with
something linear but with a huge constant (like loading blob contents),
and micro-optimizations to the former get drowned out by the latter.

-Peff
