Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FA21FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939124AbdAGBOt (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:14:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:36288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933632AbdAGBOs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:14:48 -0500
Received: (qmail 29403 invoked by uid 109); 7 Jan 2017 01:14:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 01:14:48 +0000
Received: (qmail 21915 invoked by uid 111); 7 Jan 2017 01:15:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 20:15:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 20:14:46 -0500
Date:   Fri, 6 Jan 2017 20:14:46 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Trygve Aaberge <trygveaa@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 0/3] fix ^C killing pager when running alias
Message-ID: <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net>
References: <20170105142529.GA15009@aaberge.net>
 <20170106064032.eqxxer5mx5hsh2md@sigill.intra.peff.net>
 <20170106064752.iccrk656c6k2wrfy@sigill.intra.peff.net>
 <20170106072602.wkbzho5z3osz5hee@sigill.intra.peff.net>
 <20170106073224.5hsrib77tx5tgx7d@sigill.intra.peff.net>
 <3d433abf-71a2-4702-f62b-e254520dc32c@kdbg.org>
 <20170106194115.k5u5esv7t63mryvk@sigill.intra.peff.net>
 <2ed6f78b-7704-c724-c99b-e310c383c4e8@kdbg.org>
 <20170106232042.ptn6grtll5wpxhc4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106232042.ptn6grtll5wpxhc4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 06:20:42PM -0500, Jeff King wrote:

> > In general, I think it is wrong to wait for child processes when a signal
> > was received. After all, it is the purpose of a (deadly) signal to have the
> > process go away. There may be programs that know it better, like less, but
> > git should not attempt to know better in general.
> > 
> > We do apply some special behavior for certain cases like we do for the
> > pager. And now the case with aliases is another special situation. The
> > parent git process only delegates to the child, and as such it is reasonable
> > that it binds its life time to the first child, which executes the expanded
> > alias.
> 
> Yeah, I think I agree. That binding is something you want in many cases,
> but not necessarily all. The original purpose of clean_on_exit was to
> create a binding like that, but of course it can be (and with the
> smudge-filter stuff, arguably has been) used for other cases, too.
> 
> I'll work up a patch that makes it a separate option, which should be
> pretty easy.

Yeah, this did turn out to be really easy. I spent most of the time
trying to explain the issue in the commit message in a sane way.
Hopefully it didn't end up _too_ long. :)

The interesting bit is in the third one. The first is a necessary
preparatory step, and the second is a cleanup I noticed in the
neighborhood.

  [1/3]: execv_dashed_external: use child_process struct
  [2/3]: execv_dashed_external: stop exiting with negative code
  [3/3]: execv_dashed_external: wait for child on signal death

 git.c         | 36 +++++++++++++++---------------------
 run-command.c | 19 +++++++++++++++++++
 run-command.h |  1 +
 3 files changed, 35 insertions(+), 21 deletions(-)

-Peff
