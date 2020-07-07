Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185E7C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDE2206DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgGGWG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:06:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:51792 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgGGWG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 18:06:27 -0400
Received: (qmail 23677 invoked by uid 109); 7 Jul 2020 22:06:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2020 22:06:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32196 invoked by uid 111); 7 Jul 2020 22:06:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2020 18:06:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jul 2020 18:06:26 -0400
From:   Jeff King <peff@peff.net>
To:     Trygve Aaberge <trygveaa@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/2] Wait for child on signal death for aliases to
 externals
Message-ID: <20200707220626.GC2300296@coredump.intra.peff.net>
References: <20200704221839.421997-1-trygveaa@gmail.com>
 <20200704221839.421997-2-trygveaa@gmail.com>
 <20200706211403.GB85133@coredump.intra.peff.net>
 <20200707101959.qsuumtuelepnxore@aaberge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707101959.qsuumtuelepnxore@aaberge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 12:19:59PM +0200, Trygve Aaberge wrote:

> On Mon, Jul 06, 2020 at 17:14:03 -0400, Jeff King wrote:
> >     I guess to recreate that you'd need to trigger the pager inside the
> >     alias itself, like:
> > 
> >       $ git -c alias.foo='!{ echo foo; sleep 10; echo bar; } | less' foo
> >       ^C
> > 
> >     which does exhibit the annoying behavior (we exit, and pgrp loses
> >     the tty session leader bit, and the pager gets EIO).
> 
> Yes, that's correct. So it's a rather niche use case. The main thing for me
> was the first commit, but I figured I should fix this too while I was at it. I
> don't think I have any current use cases where I would need this fix, but I
> could imagine some existing. For instance, before stash list got the -p
> option, I had this alias:
> 
>   stash-p = !git show $(git stash list | cut -d: -f1)
> 
> And this is one use case where the pager is invoked inside the alias, so the
> first patch doesn't help, but the second one fixes it. While this alias isn't
> necessary anymore, there could be similar use cases.

Thanks for this real-world example. I agree that particular one isn't
necessary anymore, but to me it provides a compelling argument. It's not
all that far-fetched that somebody runs a git command that triggers a
pager inside a shell alias.

-Peff
