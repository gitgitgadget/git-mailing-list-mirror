Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9A720FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 22:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbcF2WBE (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 18:01:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:38006 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751487AbcF2WBC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 18:01:02 -0400
Received: (qmail 2099 invoked by uid 102); 29 Jun 2016 22:00:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Jun 2016 18:00:53 -0400
Received: (qmail 31365 invoked by uid 107); 29 Jun 2016 22:01:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Jun 2016 18:01:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Jun 2016 18:00:49 -0400
Date:	Wed, 29 Jun 2016 18:00:49 -0400
From:	Jeff King <peff@peff.net>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
Message-ID: <20160629220049.GA4416@sigill.intra.peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net>
 <5774426F.3090000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5774426F.3090000@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 11:49:35PM +0200, Jakub Narębski wrote:

> > So this is the ideal case for generation numbers (the worst cases are
> > when the things you are looking for are in branchy, close history where
> > the generation numbers don't tell you much; but in such cases the
> > walking is usually not too bad).
> 
> There are other approaches (special indices) that help reachability
> queries beside "generation number".

Yes, though generation numbers can help with more questions (e.g., "what
is the merge base").

> By the way, what should happen if you add a replacement (in the git-replace
> meaning) that creates a shortcut, therefore invalidating generation numbers,
> at least in strict sense - committerdate as generation number would be still
> good, I think?

This is one of the open questions. My older patches turned them off when
replacements and grafts are in effect.

> > I have patches that generate and store the numbers at pack time, similar
> > to the way we do the reachability bitmaps. They're not production ready,
> > but they could probably be made so without too much effort. You wouldn't
> > have ready-made generation numbers for commits since the last full
> > repack, but you can compute them incrementally based on what you do have
> > at a cost linear to the unpacked commits (this is the same for bitmaps).
> 
> Do Git use EWAH / EWOK bitmaps for reachability analysis, or is it still
> limited to object counting?

At GitHub we are using them for --contains analysis, along with mass
ahead/behind (e.g., as in https://github.com/gitster/git/branches). My
plan is to send patches upstream, but they need some cleanup first.

-Peff
