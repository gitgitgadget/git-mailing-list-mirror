Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351F3C433FE
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhKTDps (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:45:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:35526 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234823AbhKTDpn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:45:43 -0500
Received: (qmail 10061 invoked by uid 109); 20 Nov 2021 03:42:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Nov 2021 03:42:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22602 invoked by uid 111); 20 Nov 2021 03:42:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 22:42:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 22:42:38 -0500
From:   Jeff King <peff@peff.net>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pager: fix crash when pager program doesn't exist
Message-ID: <YZhurgbXq7vhDTXC@coredump.intra.peff.net>
References: <20211119234745.26605-1-ematsumiya@suse.de>
 <YZhVA8DOjHu90gzs@coredump.intra.peff.net>
 <20211120023246.7ynehp5v3iypfr6w@cyberdelia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211120023246.7ynehp5v3iypfr6w@cyberdelia>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 11:32:46PM -0300, Enzo Matsumiya wrote:

> > GIT_PAGER=no-such-command git -p log
> > 
> > I had to run it with ASan to trigger a failure, as use-after-free bugs
> > aren't always deterministic.
> 
> Please use my reproducer as it's 100% reliable and consistent (same
> memory regions are affected).
> 
> I couldn't reproduce the issue with yours.

Our reproducers are triggering the same behavior. But it won't be 100%
reliable in the sense that the behavior is undefined. Depending upon
random details of the allocator, we may get a segfault, or see random
trash on the heap, or even see the old data. That's why I suggested
using ASan; it poisons the freed memory to reliably detect problems.

But at any rate, yes, it's clear that there is a bug here.

> > diff --git a/run-command.c b/run-command.c
> > index f40df01c77..92e00d9455 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -21,6 +21,7 @@ void child_process_clear(struct child_process *child)
> > {
> > 	strvec_clear(&child->args);
> > 	strvec_clear(&child->env_array);
> > +	child_process_init(child);
> > }
> > 
> > struct child_to_clean {
> 
> Of course this one works as well. And is more elegant IMHO.

Yeah, I think so, too.

> Should I submit a v2 or will you?

Why don't you put together a v2, and I can review it.

-Peff
