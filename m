Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5014CC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E230823405
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhAMNAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:00:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:54634 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbhAMNAI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 08:00:08 -0500
Received: (qmail 22368 invoked by uid 109); 13 Jan 2021 12:59:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 12:59:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29598 invoked by uid 111); 13 Jan 2021 12:59:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 07:59:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 07:59:27 -0500
From:   Jeff King <peff@peff.net>
To:     Arnaud Morin <arnaud.morin@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] patch-ids: handle duplicate hashmap entries
Message-ID: <X/7ur/IcCg1AqTdZ@coredump.intra.peff.net>
References: <20210109162440.GM31701@sync>
 <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
 <X/28IXBpse2dNZQH@coredump.intra.peff.net>
 <20210112153438.GC32482@sync>
 <X/3FwNPHqZqY+hv0@coredump.intra.peff.net>
 <xmqqy2gy3r5p.fsf@gitster.c.googlers.com>
 <20210113092448.GE32482@sync>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210113092448.GE32482@sync>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 09:24:48AM +0000, Arnaud Morin wrote:

> Without this patch, that's even worst, consistency is broken.
> Let me explain.
> 
> With your history example:
> 
>      ---o---o---M---o---o---W---o---o---M---o--- branch
>          \
>           o---o---o---M---o--- master
> 
> # WITHOUT PATCH
> If we imagine that master is having more commits count than branch.
> The result of rev-list will be like you described:
> $ git rev-list --left-right --cherry-pick branch...master
> <M
> <W
> 
> In other words, it's showing both W and M.
> 
> BUT, if we imagine now that master is having less commits count than branch.
> $ git rev-list --left-right --cherry-pick branch...master
> <W
> 
> It's only showing W!
> 
> So the result is not consistent, depending on which branch is having
> more commits.

Right. There's definitely a question of whether --cherry-pick is the
most useful thing in such a situation, but the current behavior was
simply broken. It did not behave as advertised, and it treated one side
of the history different from the other. So whether we want to do
anything else to help that case, I think this at least makes
--cherry-pick sane. :)

Here are two related histories to think about.

This is the same history, but the revert and re-do happens on both
sides (and this is actually the setup in the new test):

      ---o---o---M---o---o---W---o---o---M---o--- branch
          \
           o---o---M---o---o---W---o---o---M---o--- master

There we really _do_ want to clear out both M's (really, all four),
because we're doing so _from both sides_. And that is ultimately the
point of the cherry-pick option: show commits that were picked from one
side to the other.

Another interesting case is when the first "M" is actually bundled into
another commit, like:

      ---o---o---M+X---o---o---W---o---o---M---o--- branch
          \
           o---o---o--M---o--- master

where "M+X" has the changes from "M" plus some other changes. It will
get a different patch-id, and --cherry-pick would show both M+X and W,
but not M for either side. This is a limitation of the patch-id concept:
we are looking at whole commits, not overall changes.

I suspect for most operations we care less about "remove all
cherry-picks from both sides", but rather "give me one side, omitting
commits that are already on the other side" (because you want to rebase
or cherry-pick some subset).

-Peff
