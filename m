Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0398C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBBB61546
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhKSOsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:48:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:34888 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234402AbhKSOs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 09:48:29 -0500
Received: (qmail 8316 invoked by uid 109); 19 Nov 2021 14:45:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 14:45:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13160 invoked by uid 111); 19 Nov 2021 14:45:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 09:45:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 09:45:26 -0500
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] diff histogram: intern strings
Message-ID: <YZe4hqF6Jf14L5tb@coredump.intra.peff.net>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
 <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com>
 <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com>
 <88eaee89-4536-fba4-3aa0-c3693f58eae0@gmail.com>
 <nycvar.QRO.7.76.6.2111181631260.11028@tvgsbejvaqbjf.bet>
 <YZZ0e7CCGW5QbQlW@coredump.intra.peff.net>
 <86d38148-7b97-76aa-148b-346cc179615a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86d38148-7b97-76aa-148b-346cc179615a@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 10:05:32AM +0000, Phillip Wood wrote:

> On 18/11/2021 15:42, Jeff King wrote:
> > On Thu, Nov 18, 2021 at 04:35:48PM +0100, Johannes Schindelin wrote:
> > 
> > > I think the really important thing to point out is that
> > > `xdl_classify_record()` ensures that the `ha` attribute is different for
> > > different text. AFAIR it even "linearizes" the `ha` values, i.e. they
> > > won't be all over the place but start at 0 (or 1).
> > > 
> > > So no, I'm not worried about collisions. That would be a bug in
> > > `xdl_classify_record()` and I think we would have caught this bug by now.
> > 
> > Ah, thanks for that explanation. That addresses my collision concern from
> > earlier in the thread completely.
> 
> Yes, thanks for clarifying I should have been clearer in my reply to Stolee.
> The reason I was waffling on about file sizes is that there can only be a
> collision if there are more than 2^32 unique lines. I think the minimum file
> size where that happens is just below 10GB when one side of the diff has
> 2^31 lines and the other has 2^31 + 1 lines and all the lines are unique.

Right, that makes more sense (and we are not likely to lift the 1GB
limit anytime soon; there are tons of 32-bit variables and potential
integer overflows all through the xdiff code).

It's probably worth explaining this a bit in the commit message.

I also, FWIW, found the subject confusing. I expected "intern" to refer
to keeping a single copy of some strings. Maybe:

  Subject: diff histogram: skip xdl_recmatch for comparing records

or something?

-Peff
