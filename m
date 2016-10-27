Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1237520193
	for <e@80x24.org>; Thu, 27 Oct 2016 17:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938631AbcJ0RLZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 13:11:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:34925 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932442AbcJ0RLY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 13:11:24 -0400
Received: (qmail 14364 invoked by uid 109); 27 Oct 2016 17:11:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 17:11:23 +0000
Received: (qmail 21559 invoked by uid 111); 27 Oct 2016 17:11:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 13:11:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2016 13:11:21 -0400
Date:   Thu, 27 Oct 2016 13:11:21 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
Message-ID: <20161027171121.tsg2gy5gov5apihq@sigill.intra.peff.net>
References: <20161026215732.16411-1-sbeller@google.com>
 <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
 <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
 <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 10:01:02AM -0700, Stefan Beller wrote:

> >  That function can
> > be called from main() of platforms that cannot statically initialize
> > mutices,
> 
> By main you mean the main() in common-main.c or cmd_main in git.c ?

Any setup or initialization for library functions needs to go in main()
of common-main.c.  Otherwise, only builtins get it, and external
programs are left to segfault (or whatever).

> Those both look like the wrong place. Of course it would work adding it
> there, but it smells like a maintenance nightmare.

I agree it's ugly, but I suspect it would work OK in practice.
We don't have that many mutexes and initializing them is cheap.

Languages like C++ have non-constant initializers, and the compiler
takes care of running the startup code before main() begins. There's no
portable way to do that in C, but our cmd_main() is roughly the same
thing.

I still prefer the lazy initialization if it can work without incurring
measurable overhead. That's the normal way to do things in C; the only
complication here is the thread safety.

-Peff
