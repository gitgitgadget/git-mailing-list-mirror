Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95029C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5DD610C9
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhEQIww (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 04:52:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:56078 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235456AbhEQIwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 04:52:51 -0400
Received: (qmail 4576 invoked by uid 109); 17 May 2021 08:51:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 May 2021 08:51:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26589 invoked by uid 111); 17 May 2021 08:51:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 May 2021 04:51:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 May 2021 04:51:34 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git repack on shallow clone of large repo (linux kernel) hangs
 at "Enumerating objects"
Message-ID: <YKIulliGp8hyf5Y6@coredump.intra.peff.net>
References: <c98e51b0-d89b-9170-e3bc-69ac9ec5e114@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c98e51b0-d89b-9170-e3bc-69ac9ec5e114@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 16, 2021 at 08:09:56PM +0700, Bagas Sanjaya wrote:

> I have a shallow clone of linux-stable repo [1] on my computer. Now
> I'm trying to repack with `git repack -A -d`.
> 
> Before repacking, here is the object counts on my clone
> (`git count-objects -v`):
> 
> > count: 0
> > size: 0
> > in-pack: 3162206
> > packs: 17
> > size-pack: 3120393
> > prune-packable: 0
> > garbage: 0
> > size-garbage: 0
> 
> And I have 41496 commits (only on master).
> 
> And here are relevant config used:
> 
> > pack.deltacachesize=120M
> > pack.windowmemory=400M
> > pack.packsizelimit=650M
> > pack.autopacklimit=0
> 
> When I trigger repack operation, I expected that all objects on 17 packs
> are consolidated into several 650M-sized packs. However, in my case, repacking
> was hang at "Enumerating objects" stage, that is I stuck at:
> 
> "Eumerating objects: 902036"

You could try using strace or gdb to see what it's doing.

But as a guess, one thing that sometimes causes a stall near the end of
"enumerating objects" is loosening unreachable objects that are
currently packed. You told repack to use "-A", which asks to loosen
those objects so they aren't lost when the old packs are deleted (as
opposed to "-a").

You'd probably want to at least say "--unpack-unreachable=some.time" to
avoid writing out ones which are not even recent (and which is what "git
gc" will do under the hood).

But if you don't care about keeping them at all (e.g., because this is
not an active repository where other simultaneous operations may be
taking place, so you know it is safe to delete even recent ones), then
just "git repack -a -d" is probably your best bet.

-Peff
