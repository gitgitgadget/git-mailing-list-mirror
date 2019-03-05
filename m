Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07BD120248
	for <e@80x24.org>; Tue,  5 Mar 2019 04:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfCEEPR (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:15:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:38770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726590AbfCEEPR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:15:17 -0500
Received: (qmail 681 invoked by uid 109); 5 Mar 2019 04:15:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:15:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28508 invoked by uid 111); 5 Mar 2019 04:15:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:15:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:15:15 -0500
Date:   Mon, 4 Mar 2019 23:15:15 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bartosz Baranowski <bbaranow@redhat.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] bisect: fix internal diff-tree config loading
Message-ID: <20190305041515.GC19800@sigill.intra.peff.net>
References: <20190222061949.GA9875@sigill.intra.peff.net>
 <20190222062133.GB10248@sigill.intra.peff.net>
 <CAP8UFD0+MSaU4KmD_pfHnCDFoqr9H99Fp9tBP-Qw+vs+ambgFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0+MSaU4KmD_pfHnCDFoqr9H99Fp9tBP-Qw+vs+ambgFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 03, 2019 at 06:59:19PM +0100, Christian Couder wrote:

> On Fri, Feb 22, 2019 at 7:21 AM Jeff King <peff@peff.net> wrote:
> >
> > When we run our internal diff-tree to show the bisected commit, we call
> > init_revisions(), then load config, then setup_revisions(). But that
> > order is wrong: we copy the configured defaults into the rev_info struct
> > during the init_revisions step, so our config load wasn't actually doing
> > anything.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > It does feel a little weird loading config at all here, since it would
> > potentially affect other in-process operations.
> 
> I like that this patch fixes a bug, but this still triggers some
> wondering/comments.
> 
> Would it be better or at least less weird to load it at the beginning
> of `git bisect`?

I guess you mean at the beginning of bisect--helper? That would be OK
with me, too, and maybe would be a little less weird. But if bisect is
slowly becoming a single binary, maybe we should just wait for that.

> Or is the real problem a limitation of the config system, that prevent
> us from temporarily loading, and then maybe unloading, some config?

It's less the config system, and more the way Git is written. ;)
Typically parsing the config means setting a bunch of globals, and
forgetting what their original values are. That's not something the
config system can fix.

-Peff
