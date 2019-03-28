Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DC7202BB
	for <e@80x24.org>; Thu, 28 Mar 2019 01:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfC1BuA (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 21:50:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:38476 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726143AbfC1BuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 21:50:00 -0400
Received: (qmail 13142 invoked by uid 109); 28 Mar 2019 01:50:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Mar 2019 01:50:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2108 invoked by uid 111); 28 Mar 2019 01:50:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Mar 2019 21:50:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2019 21:49:58 -0400
Date:   Wed, 27 Mar 2019 21:49:58 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Puzzling Git backtrace
Message-ID: <20190328014957.GA7887@sigill.intra.peff.net>
References: <CAGyf7-F8cmzOuhi6zeJJ13iwGh_ie-uTiJYUzBwssvH+kCY+yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-F8cmzOuhi6zeJJ13iwGh_ie-uTiJYUzBwssvH+kCY+yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 05:49:27PM -0700, Bryan Turner wrote:

> I'm trying to assist a Bitbucket Server customer who is seeing some
> "git-upload-pack" processes "hang" on their server.
> 
> While investigating, we had them connect gdb to their processes (which
> are 2.10.0 built from source using a simple unzip-and-run-make
> approach) and get the backtraces for them. The output that they're
> seeing makes no sense to me, though, so I'm throwing this out to the
> list just to see if anyone has any idea how the processes could end up
> like this.

upload-pack didn't become a builtin until v2.18, so...

> When they attached to 32433 and printed its backtrace, though, things
> go a little sideways:
> 
> (gdb) attach 32433
> Attaching to program: /usr/bin/git, process 32433

The debugger needs to be using git-upload-pack as its executable, not
"git".

> (gdb) bt
> #0  0x00007f79d1aca240 in ?? ()
> #1  0x000000000045179e in mktree_line (allow_missing=4,
> nul_term_line=0, len=<optimized out>, buf=<optimized out>) at
> builtin/mktree.c:103
> #2  cmd_mktree (ac=<optimized out>, av=<optimized out>,
> prefix=<optimized out>) at builtin/mktree.c:173
> #3  0x0000000000000000 in ?? ()

And all of this is just trash, because it's matching the core with the
wrong binary.

I'm sure there's a way to switch binaries within gdb, but I don't know
it offhand. I'd just start a new gdb like:

  gdb git-upload-pack 32433

-Peff
