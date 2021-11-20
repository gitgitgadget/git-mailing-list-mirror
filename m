Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA0C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhKTDlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:41:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:35522 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhKTDlS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:41:18 -0500
Received: (qmail 10055 invoked by uid 109); 20 Nov 2021 03:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Nov 2021 03:38:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22566 invoked by uid 111); 20 Nov 2021 03:38:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 22:38:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 22:38:14 -0500
From:   Jeff King <peff@peff.net>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pager: fix crash when pager program doesn't exist
Message-ID: <YZhtplvcVkY0Yzmt@coredump.intra.peff.net>
References: <20211119234745.26605-1-ematsumiya@suse.de>
 <YZhVA8DOjHu90gzs@coredump.intra.peff.net>
 <20211120023246.7ynehp5v3iypfr6w@cyberdelia>
 <20211120030621.2xbcz5usaqkh2ald@cyberdelia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211120030621.2xbcz5usaqkh2ald@cyberdelia>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 20, 2021 at 12:06:21AM -0300, Enzo Matsumiya wrote:

> On 11/19, Enzo Matsumiya wrote:
> > > When pager setup succeeds, the second run is a noop, because isatty(1)
> > > is no longer true. But for the case you're interested in, the first one
> > > fails, so we do try again. And I can reproduce your problem with:
> > 
> > No, it's not a noop such as that it's clear that things are different on
> > the second call.
> 
> Here I meant that setup_pager() is effectivelly called from 2 different places:
> 
> First backtrace:
> setup_pager()
> commit_pager_choice()
> run_builtin()
> handle_builtin()
> run_argv()
> cmd_main()
> 
> Second backtrace:
> setup_pager()
> cmd_log_init_finish()
> cmd_log_init()
> cmd_show()
> run_builtin()
> handle_builtin()
> run_argv()
> cmd_main()
> 
> Also, isatty(1) is not false in neither of the calls. Otherwise I
> wouldn't hit this bug (pager would be NULL and setup_pager() a noop as
> you said).

Right, I mean in the "normal" case that the pager actually starts, the
second call hits isatty(1), then git_pager() returns NULL, and we return
from setup_pager() immediately.

It is only in the broken-pager case that the bug you found is triggered
(which is probably why nobody has really noticed it).

-Peff
