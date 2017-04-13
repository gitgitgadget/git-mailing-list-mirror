Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6FD20960
	for <e@80x24.org>; Thu, 13 Apr 2017 21:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbdDMV3R (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 17:29:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:33246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751205AbdDMV3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 17:29:16 -0400
Received: (qmail 11974 invoked by uid 109); 13 Apr 2017 21:29:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 21:29:13 +0000
Received: (qmail 27805 invoked by uid 111); 13 Apr 2017 21:29:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 17:29:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Apr 2017 17:29:10 -0400
Date:   Thu, 13 Apr 2017 17:29:10 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danny Sauer <danny@dannysauer.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
Message-ID: <20170413212909.eb7zrhs7rzk6nxl6@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1704091238560.4268@virtualbox>
 <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com>
 <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
 <20170410171352.s7r7tzheadxjlulw@sigill.intra.peff.net>
 <CACsJy8B8osxd-0axJ9giaMYKuict2h1zW8TcYYuRFGXfBbdF0A@mail.gmail.com>
 <xmqqy3v6ow54.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DPFzgxqvPzpMbmoM4sMP7oSZ=eO6DJa+dv4sY=QKHjoA@mail.gmail.com>
 <20170412130145.jjnyait5234qsmys@sigill.intra.peff.net>
 <CACsJy8BbHDsk4qLhVA=0QJFPutcGJpGwWrjs0_DiscDM9Q9+pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BbHDsk4qLhVA=0QJFPutcGJpGwWrjs0_DiscDM9Q9+pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 08:11:22PM +0700, Duy Nguyen wrote:

> On Wed, Apr 12, 2017 at 8:01 PM, Jeff King <peff@peff.net> wrote:
> > I dunno. Maybe I am missing some subtle case, but it's not clear to me
> > what the user would be trying to do by having git stay in the original
> > directory.
> 
> Not sure if it really happens. But if we jump from worktree is inside
> original cwd and we have to jump to worktree, we set empty prefix, not
> "../../../" one. So we can't refer back to files relative to original
> cwd with prefix. I was kinda hoping "super prefix" would solve it, but
> that one seems designed specifically for submodules.

Ah, right. I think the issue is that "prefix" really serves two uses.
For things like command-line arguments, we use to find the original path
after we've moved. But we also use it for "where in the working tree
are we".

So with an out-of-tree cwd, we'd want to set the first one to the real
path ("../../whatever" or even just an absolute path), but the second
one would probably be empty (i.e., just pretend that we started from the
top-level).

But that would require first refactoring all of the cmd_* functions to
handle those prefixes separately.

-Peff
