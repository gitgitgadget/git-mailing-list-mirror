Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7294FC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 14:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F10E206D7
	for <git@archiver.kernel.org>; Mon,  4 May 2020 14:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEDO7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 10:59:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:35788 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726445AbgEDO7i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 10:59:38 -0400
Received: (qmail 31129 invoked by uid 109); 4 May 2020 14:59:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 14:59:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17531 invoked by uid 111); 4 May 2020 14:59:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 10:59:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 10:59:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, martin.agren@gmail.com
Subject: Re: [PATCH 7/7] commit-graph.c: introduce '--[no-]check-oids'
Message-ID: <20200504145937.GA11373@coredump.intra.peff.net>
References: <cover.1586836700.git.me@ttaylorr.com>
 <1ff42f4c3d568dd25889d2808cda3edf38a36cb9.1586836700.git.me@ttaylorr.com>
 <20200415042930.GA11703@syl.local>
 <20200415043137.GA12136@syl.local>
 <20200422105536.GB3063@szeder.dev>
 <20200422233930.GB19100@syl.local>
 <20200424105957.GB5925@szeder.dev>
 <20200501223848.GH41612@syl.local>
 <20200503094005.GD170902@coredump.intra.peff.net>
 <xmqq5zddj6us.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zddj6us.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 03, 2020 at 09:55:39AM -0700, Junio C Hamano wrote:

> >> Does that seem reasonable?
> >
> > FWIW, I think that is the best direction. If anybody is depending on the
> > "commit-graph write will complain about non-commits" behavior, they
> > could only be doing so for a few versions; prior to v2.24.0 we did not.
> 
> If we had it for the past 180 days or so, that's not like " people
> have seen it for only a brief time", but working it around shouldn't
> be too difficult---they need to validate the input they feed to the
> command themselves (or do they need to do more?).

Yeah, my point wasn't so much that it was brief as that we've had it
both ways, and nobody was complaining about it before v2.24.0 (the
type-restriction change came as a side effect of another tightening).

But yeah, if somebody really wants that validation, they can do it
themselves with "cat-file --batch-check". Or even for-each-ref directly:

  git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
  awk '/commit/ { print $1 }' |
  git commit-graph write --stdin-commits

If you're using --stdin-commits, you're presumably processing the input
anyway (since otherwise you'd just be using --reachable).

I suppose you could argue the other way, too (that the user could be
filtering out non-commits). But so far we have one data point in either
direction, and it wants the more forgiving behavior. :)

-Peff
