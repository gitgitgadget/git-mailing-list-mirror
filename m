Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1F2C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 17:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB612076E
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 17:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390180AbgJIRzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 13:55:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:55402 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731500AbgJIRzI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 13:55:08 -0400
Received: (qmail 9134 invoked by uid 109); 9 Oct 2020 17:55:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Oct 2020 17:55:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4508 invoked by uid 111); 9 Oct 2020 17:55:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Oct 2020 13:55:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Oct 2020 13:55:06 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Taylor Blau <me@ttaylorr.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
Message-ID: <20201009175506.GA957408@coredump.intra.peff.net>
References: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
 <20201007210609.GA1984296@coredump.intra.peff.net>
 <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
 <20201008120658.GA2689590@coredump.intra.peff.net>
 <52782500-274e-2c72-39e2-be4252959d47@gmail.com>
 <5bbdaed5-df29-8bfe-01c2-eb2462dcca22@gmail.com>
 <267a9f46-cce9-0bd3-f28d-55e71cc8a399@virtuell-zuhause.de>
 <0d25e0ab-31ab-54c2-b518-bd9c0b0c4b7a@gmail.com>
 <2f30099a-4a3d-00f7-bb08-ca6c1f76bcd4@virtuell-zuhause.de>
 <64de22fd-2e1b-aaab-3a8e-f6f1d630a46e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64de22fd-2e1b-aaab-3a8e-f6f1d630a46e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 01:46:07PM -0400, Derrick Stolee wrote:

> > Can you reproduce it if you do
> > 
> > git config core.commitGraph false
> > git config fetch.writeCommitGraph true
> > ?
> 
> I _can_ repro it in this case! I think there must be something
> very interesting going on where the commit-graph is parsed in
> _some_ places, but not in others. This is something that I can
> really start to dig into.

Here's a much more minimal reproduction:

  git init repo
  cd repo

  git commit --allow-empty -m one
  git rev-parse HEAD |
  git -c core.commitGraph=false \
      commit-graph write --split=no-merge --stdin-commits
  git rev-parse HEAD |
  git -c core.commitGraph=false \
      commit-graph write --split=no-merge --stdin-commits

  git commit --allow-empty -m two
  git rev-parse HEAD |
  git commit-graph write --split --stdin-commits

The final write will die() with the "unexpected duplicate" message.

-Peff
