Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BA8C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9785620663
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCXGOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:14:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:49100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725951AbgCXGOf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 02:14:35 -0400
Received: (qmail 15209 invoked by uid 109); 24 Mar 2020 06:14:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Mar 2020 06:14:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21305 invoked by uid 111); 24 Mar 2020 06:24:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Mar 2020 02:24:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Mar 2020 02:14:34 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200324061434.GD610977@coredump.intra.peff.net>
References: <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
 <20200322002005.GA48038@syl.local>
 <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
 <20200322054916.GB578498@coredump.intra.peff.net>
 <20200322154439.GA53402@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322154439.GA53402@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 09:44:39AM -0600, Taylor Blau wrote:

> > Using QUICK means we won't waste time double-checking in the second
> > case. But it means we won't catch the first case, and we may generate a
> > new graph file that omits the object. They're both optimizations, and I
> > don't think we're impacting correctness[1], but it's not clear to me
> > whether one is a win over the other. We don't generally expect objects
> > we have to go away often.
> >
> > Skipping fetching seems a little more straight-forward to me. If we had
> > it in a graph file, presumably we had the actual object before, too. And
> > either we're in the first case above (we really do have it and just need
> > to double-check) in which case not saying QUICK would be enough. Or we
> > intentionally got rid of it. In which case downloading it just to
> > generate a cache is quite silly.
> 
> I was going to write that I'm not entirely sure of this, but I tried to
> talk myself through it below, and I think that the right flag is *only*
> OBJECT_INFO_SKIP_FETCH_OBJECT.

Re-reading what I wrote, I think I didn't say it very well. But yes,
that's what I think we ought to do, too: only use SKIP_FETCH_OBJECT.

-Peff
