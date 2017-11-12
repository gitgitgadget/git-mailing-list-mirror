Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580331F42B
	for <e@80x24.org>; Sun, 12 Nov 2017 11:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750780AbdKLL53 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 06:57:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:53828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750735AbdKLL52 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 06:57:28 -0500
Received: (qmail 24252 invoked by uid 109); 12 Nov 2017 11:57:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 11:57:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14406 invoked by uid 111); 12 Nov 2017 11:57:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 06:57:41 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 11:57:26 +0000
Date:   Sun, 12 Nov 2017 11:57:25 +0000
From:   Jeff King <peff@peff.net>
To:     "Dominik Mahrer (Teddy)" <teddy@teddy.ch>
Cc:     git@vger.kernel.org
Subject: Re: NO_MSGFMT
Message-ID: <20171112115725.c2pjhpwpcjeh4xbr@sigill.intra.peff.net>
References: <b6b12040-100f-5965-6dfd-344c84dddf96@teddy.ch>
 <20170813045813.i42mgwn3dmm6u52o@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170813045813.i42mgwn3dmm6u52o@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 13, 2017 at 12:58:13AM -0400, Jeff King wrote:

> On Sat, Aug 12, 2017 at 03:44:17PM +0200, Dominik Mahrer (Teddy) wrote:
> 
> > Hi all
> > 
> > I'm compiling git from source code on a mashine without msgfmt. This leads
> > to compile errors. To be able to compile git I created a patch that at least
> > works for me:
> 
> Try:
> 
>   make NO_MSGFMT=Nope NO_GETTEXT=Nope
> 
> This also works:
> 
>   make NO_GETTEXT=Nope NO_TCLTK=Nope
> 
> The flags to avoid gettext/msgfmt are sadly different between git itself
> and git-gui/gitk, which we include as a subproject. It would be a useful
> patch to harmonize though (probably by accepting both in all places for
> compatibility).

I saw somebody else today run into problems about gettext, so I thought
I'd revisit this and write that patch. It turns out the situation is
slightly different than I thought. So no patch, but I wanted to report
here what I found.

It's true that the option is called NO_GETTEXT in git.git, but NO_MSGFMT
in the tcl programs we pull in. So I figured to start with a patch that
turns on NO_MSGFMT automatically when NO_GETTEXT is set. But it's
not necessary.

The gitk and git-gui tests actually check that msgfmt is available.
If it isn't, they automatically fall back to using a pure-tcl
implementation. So there's generally no need to set NO_MSGFMT at
all.

But that fallback is implemented using tcl. So if you _also_ don't have
tcl installed (and I don't), you get quite a confusing output from make:

  $ make -j1 
    SUBDIR git-gui
    MSGFMT po/pt_pt.msg Makefile:252: recipe for target 'po/pt_pt.msg' failed
make[1]: *** [po/pt_pt.msg] Error 127

If you run with V=1, you can see that it's not running msgfmt at all,
but:

  tclsh po/po2msg.sh --statistics --tcl -l pt_pt -d po/ po/pt_pt.po 

So my takeaways are:

  1. You should never need to set NO_MSGFMT; it falls back
     automatically.

  2. If you don't have gettext, you should set NO_GETTEXT to tell the
     rest of git not to use it.

  3. If you see msgfmt errors even after NO_GETTEXT, try NO_TCLTK.

-Peff
