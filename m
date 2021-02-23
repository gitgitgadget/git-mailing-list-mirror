Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A77AC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F67264E6C
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhBWUQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:16:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:42160 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232377AbhBWUP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:56 -0500
Received: (qmail 27224 invoked by uid 109); 23 Feb 2021 20:15:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 20:15:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3612 invoked by uid 111); 23 Feb 2021 20:15:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 15:15:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 15:15:12 -0500
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YDViUPT4JhGJLjji@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <xmqq7dmz5iw5.fsf@gitster.g>
 <YDVM9U7zLstNBVq2@coredump.intra.peff.net>
 <1724378.IzK8VI2DXP@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1724378.IzK8VI2DXP@mfick-lnx>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:54:56PM -0700, Martin Fick wrote:

> > Yeah, this is definitely a heuristic that can get out of sync with
> > reality. I think in general if you have base pack A and somebody pushes
> > up B, C, and D in sequence, we're likely to roll up a single DBC (in
> > that order) pack. Further pushes E, F, G would have newer mtimes. So we
> > might get GFEDBC directly. Or we might get GFE and DBC, but the former
> > would still have a newer mtime, so we'd create GFEDBC on the next run.
> > 
> > The issues come from:
> > 
> >   - we are deciding what to roll up based on size. A big push might not
> >     get rolled up immediately, putting it out-of-sync with the rest of
> >     the rollups.
> 
> Would it make sense to somehow detect all new packs since the last rollup and 
> always include them in the rollup no matter what their size? That is one thing 
> that my git-exproll script did. One of the main reasons to do this was because 
> newer packs tended to look big (I was using bytes to determine size), and 
> newer packs were often bigger on disk compared to other packs with similar 
> objects in them (I think you suggested this was due to the thickening of packs 
> on receipt). Maybe roll up all packs with a timestamp "new enough", no matter 
> how big they are?

That works against the "geometric" part of the strategy, which is trying
to roll up in a sequence that is amortized-linear. I.e., we are not
always rolling up everything outside of the base pack, but trying to
roll up little into medium, and then eventually medium into large. If
you roll up things that are "too big", then you end up rewriting the
bytes more often, and your amount of work becomes super-linear.

Now whether that matters all that much or not is perhaps another
discussion. The current strategy is mostly to repack all-into-one with
no base, which is the worst possible case. So just about any rollup
strategy will be an improvement. ;)

-Peff
