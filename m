Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CA6C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1474264D73
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBPMtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:49:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:33972 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhBPMtF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:49:05 -0500
Received: (qmail 12955 invoked by uid 109); 16 Feb 2021 12:48:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 12:48:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23586 invoked by uid 111); 16 Feb 2021 12:48:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 07:48:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 07:48:22 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] fsck: make symlinked .gitignore and .gitattributes a
 warning
Message-ID: <YCu/FoLl8p15mwio@coredump.intra.peff.net>
References: <YCsBA002yv8XpppM@coredump.intra.peff.net>
 <YCsBRUQkrAm8l2gz@coredump.intra.peff.net>
 <87y2foaltl.fsf@evledraar.gmail.com>
 <YCsc0OePtrotjeg5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCsc0OePtrotjeg5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 08:16:00PM -0500, Jeff King wrote:

> That said, they'd probably want to checkout those old commits, too. So
> we probably do need a config override, even if it's a broad one ("trust
> me, this repo is OK, just allow symlinks for these special files").

Another option here is setting core.symlinks to false. That works more
broadly than just the one symlink, though.

It might be possible to apply that same setting (perhaps automatically,
even) to just these .gitattributes, etc, metafiles. That may get tricky,
though, as we'd need to do it not just on checkout, but any time we're
considering the file (because we wouldn't want "git add" to re-add it as
a non-symlink, nor git-diff to report it, etc).

> > So aren't we both making the fsck check too loose and the client too
> > strict? Would anyone care if this was an error on fsck if we did the "is
> > outside repo?" check?
> 
> An outside-the-repo check would probably be less invasive, but:
> 
>   - it still allows broken setups
> 
>   - it's significantly more complex. I know that the implementation I
>     showed errs on the side of complaining in at least some cases
>     (because it doesn't know if intermediate paths are themselves
>     symlinks). But I'd worry there are also cases where it covers too
>     little, nullifying the protection.

Adding to the "complexity" point: it's also impossible to implement via
fsck, where we do not have the full path of the tree entry. We could
live without the fsck support if need be, though.

I am beginning to wonder if just opening them all with O_NOFOLLOW (and a
hacky 2-syscall fallback for portability) might be less ugly than all of
this.

-Peff
