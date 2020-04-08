Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B141C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 22:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5D620730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 22:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDHWiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:38:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:37634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726467AbgDHWiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 18:38:23 -0400
Received: (qmail 14161 invoked by uid 109); 8 Apr 2020 22:38:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Apr 2020 22:38:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13410 invoked by uid 111); 8 Apr 2020 22:48:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2020 18:48:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Apr 2020 18:38:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH] clean: explicitly `fflush` stdout
Message-ID: <20200408223821.GD3468797@coredump.intra.peff.net>
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
 <20200408201454.GB2270445@coredump.intra.peff.net>
 <xmqqr1wxoddc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1wxoddc.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 08, 2020 at 02:51:11PM -0700, Junio C Hamano wrote:

> > Agreed. I guess it didn't affect people on other platforms much because
> > stdout to a terminal is generally line-buffered on POSIX systems. But
> > it's better not to rely on that, plus it could create confusion if
> > somebody tried to manipulate the interactive operation through a pipe
> > (e.g., driving it from a GUI or something).
> 
> Hmph, I thought it was more common to do prompts etc. on the
> standard error stream, which tends to make the buffering of the
> output less of a problem, but apparently these prompts are given to
> the standard output.

The prompts in git-add--interactive.perl go to stdout, as do the ones
for "am --interactive". I think that's reasonable, if you think of it as
the main output of the program.

At one point the "am" ones actually went to /dev/tty, but IMHO that's a
mistake. In 99% of cases it behaves the same as looking at stdin/stdout
(because they're connected to the terminal anyway), and in the other 1%
it's just as likely to be the wrong thing as the right. Plus it makes
testing much harder.

> I am also OK to sprinkle fflush(stdout) but in
> the longer term, it would probably be a good idea to introduce a
> helper to "prompt then grab input" or "read user input" (if the
> former, we'd be able to bring consistency into "which between the
> standard output or the standard error does a prompt come?", and if
> the latter we'd do fflush(NULL) before reading), especially if there
> are many git subcommands that go interactive.

Agreed. There is git_prompt(), but that does the tty thing, which I
think we'd want to avoid in most cases. It's used by the credential
code, which really does want to use a terminal to do things like turn
off character echoing. Plus it's not the main function of the program,
but rather a side effect (so we have to avoid disrupting the main
stdin/stdout).

-Peff
