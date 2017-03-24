Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A6C1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966174AbdCXSzt (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:55:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:51287 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965753AbdCXSzr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:55:47 -0400
Received: (qmail 24317 invoked by uid 109); 24 Mar 2017 18:55:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 18:55:46 +0000
Received: (qmail 5947 invoked by uid 111); 24 Mar 2017 18:56:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 14:56:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 14:55:44 -0400
Date:   Fri, 24 Mar 2017 14:55:44 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] log: if --decorate is not given, default to
 --decorate=auto
Message-ID: <20170324185543.uq4clqyvbdkahbzo@sigill.intra.peff.net>
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
 <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com>
 <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
 <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com>
 <xmqqmvcdmeuv.fsf@gitster.mtv.corp.google.com>
 <CAMMLpeR-zCpL5Gx=BoK8G9_wL2TBe-wD3VnsAShAuVVzS=Nirg@mail.gmail.com>
 <xmqqfui4f0pp.fsf@gitster.mtv.corp.google.com>
 <CAMMLpeRtzYM3a639DcNbhqAmz3dNkRebvQps-gusEKx+eQqPgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMMLpeRtzYM3a639DcNbhqAmz3dNkRebvQps-gusEKx+eQqPgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 10:52:34AM -0600, Alex Henrie wrote:

> Unfortunately, I think I found a bug. Even when using `git -p`, the
> function pager_in_use() always returns false if the output is not a
> TTY. So, `isatty(1) || pager_in_use()` and `color_stdout_is_tty ||
> (pager_in_use() && pager_use_color)` are redundant.
> 
> If we want to use `git -p log` in a test, we'll have to change the
> behavior of pager_in_use(). Alternatively, we could use
> `GIT_PAGER_IN_USE=1 git log` instead.

I see you ended up with a test that uses test_terminal, which is much
better (and your patch looks good to me).

But I was concerned that there might be a bug in pager_in_use(), so I
dug into it a little. I think the code there is correct; it's just
relaying the environment variable's value. Likewise, on the setting
side, I think the code is correct. We set the environment variable
whenever we start the pager in setup_pager().

I think what is confusing is that "git -p" does _not_ mean
"unconditionally use a pager". It means "start a pager if stdout is a
terminal, even if this command is not usually paged". So something like
"git -p log >actual" is correct not to trigger pager_in_use().

I also double-checked the documentation, which covers this case
accurately. So I think all is well, and there's nothing to fix. You
might want an option for "even though stdout is not a tty pretend like a
pager is in use", but that is exactly what GIT_PAGER_IN_USE=1 is for.

-Peff
