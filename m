Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDBE202AC
	for <e@80x24.org>; Thu,  6 Jul 2017 07:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbdGFHQK (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 03:16:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:60660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752661AbdGFHQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 03:16:09 -0400
Received: (qmail 12857 invoked by uid 109); 6 Jul 2017 07:16:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Jul 2017 07:16:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13304 invoked by uid 111); 6 Jul 2017 07:16:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Jul 2017 03:16:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jul 2017 03:16:07 -0400
Date:   Thu, 6 Jul 2017 03:16:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
Message-ID: <20170706071606.doxirwm6cqx3duzg@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
 <xmqqh8yqix7p.fsf@gitster.mtv.corp.google.com>
 <20170705212757.3ygxiasbi2e7v27p@sigill.intra.peff.net>
 <xmqqa84ih5ao.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa84ih5ao.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 05, 2017 at 03:45:03PM -0700, Junio C Hamano wrote:

> > I did make the ordering intentional. We process each reflog sequentially
> > in turn. I don't think it would be wrong to interleave them by date, but
> > I actually think it's useful for somebody who switches that behavior to
> > consciously update the test. Maybe it's worth calling out in the commit
> > message.
> >
> > I stopped short of actually documenting and guaranteeing that behavior
> > to the user. I don't know how comfortable we would be changing it later.
> 
> I somehow feel that the "showing all entries from HEAD and then
> showing all from side" is simply a buggy behaviour.  I do not think
> our users would terribly mind if we changed it later.  But I may be
> missing the reason why (sometimes?) the sequential behaviour may be
> useful.

If we think it's buggy, we can fix it now. But I'm not convinced that
sequential iteration is that bad. It's at least _simple_ and easy to
explain. The only other thing that would make sense to me is sorting the
entries by date (reflog date, not commit date) and showing them in that
order. But that gives rise to some funny corner cases.

What do we do if there's clock skew within the reflog (e.g., somebody
fixed their skewed clock such that HEAD@{5} is less recent than
HEAD@{6}). Do we show them out of order then (even if only a single
reflog is being shown?).

Or do we try some complicated sort where entries compare sequentially
within a given reflog, but use date comparisons between different logs?
I don't think that can work with a normal comparison sort, as it makes
the comparison non-transitive.

But maybe we could do a pseudo-list-merge, where we treat the reflogs as
queues and always pick from the queue with the most recent timestamp.

That would probably be pretty easy to retrofit on the iteration from the
current series.

-Peff
