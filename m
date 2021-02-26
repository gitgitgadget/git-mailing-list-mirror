Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135D3C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E7164E09
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBZGAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 01:00:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:45502 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhBZGAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 01:00:41 -0500
Received: (qmail 11832 invoked by uid 109); 26 Feb 2021 05:59:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 05:59:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16179 invoked by uid 111); 26 Feb 2021 05:59:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 00:59:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 00:59:56 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        git@vger.kernel.org
Subject: Re: [QUESTION] Tracking HEAD changes?
Message-ID: <YDiOXDbN/JtUWgWu@coredump.intra.peff.net>
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net>
 <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
 <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
 <YDa/EupbrNa62r+D@coredump.intra.peff.net>
 <YDc3dinQ37FY8fhD@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDc3dinQ37FY8fhD@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 06:36:54AM +0100, Patrick Steinhardt wrote:

> > Hmm, I would have thought that the branch switch would trigger the hooks
> > because they're updating HEAD. I wonder if that is a bug (or lack of
> > feature :) ) in the transaction hooks, or something Patrick did
> > intentionally.
> 
> It was done semi-intentionally, or at least with the knowledge that
> symrefs aren't covered. This is mostly because they're not covered by
> the reference transaction mechanism itself.

Ah, right, I forgot about that. That might be something that we'd want
to fix if anybody wanted to use the transaction hooks to track the
complete state of refs.

At GitHub, our repository replication does track symbolic ref updates,
but we handle it outside of Git. Our normal ref updates use a few custom
bits of code similar to your transaction hooks in order to implement a
3-phase commit. But our symref updates don't; they just take a lock, run
git-symbolic-ref on each, and then vote on the result. This is slower
and less robust, but symbolic ref updates are relatively rare, so it
hasn't been a big deal.

-Peff
