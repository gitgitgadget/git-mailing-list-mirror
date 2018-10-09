Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01FC71F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 04:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbeJIMGm (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 08:06:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:46992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725803AbeJIMGl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 08:06:41 -0400
Received: (qmail 11938 invoked by uid 109); 9 Oct 2018 04:51:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 04:51:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10976 invoked by uid 111); 9 Oct 2018 04:50:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Oct 2018 00:50:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Oct 2018 00:51:39 -0400
Date:   Tue, 9 Oct 2018 00:51:39 -0400
From:   Jeff King <peff@peff.net>
To:     Noam Postavsky <npostavs@users.sourceforge.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Message-ID: <20181009045138.GA11376@sigill.intra.peff.net>
References: <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
 <20180625162308.GA13719@sigill.intra.peff.net>
 <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
 <20180806212603.GA21026@sigill.intra.peff.net>
 <CAM-tV-_=4WuMGemm6RTB902-m8JfMKGp_OkQFuJMagPE8bOOtg@mail.gmail.com>
 <20180908161316.GA326@sigill.intra.peff.net>
 <CAM-tV-9N36puQHKQ38JxAxNR5Zen=3jM7pG7vHioYvvGTxLHCg@mail.gmail.com>
 <20181003042437.GA27034@sigill.intra.peff.net>
 <CAM-tV-88J3ZAALwZeEqTuvKXRwLzb848G0AET2Ec6ic85=7o8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM-tV-88J3ZAALwZeEqTuvKXRwLzb848G0AET2Ec6ic85=7o8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 06:32:06PM -0400, Noam Postavsky wrote:

> > which is admittedly pretty horrible, too, but at least resembles a
> > graph. I dunno.
> 
> Yeah, but it's lossy, so it doesn't seem usable for the test. Maybe
> doubling up some characters?
> 
> **  left
> R|  **B-B-M-M.      octopus-merge
> R|  R|Y\  B\  M\
> R|R/  Y/  B/  M/
> R|  Y|  B|  **  4
> R|  Y|  **  M|  3
> R|  Y|  M|M/
> R|  **  M|  2
> R|  M|M/
> **  M|  1
> M|M/
> **  initial

Yeah, I tried something similar, but it's hard to read as a graph since
the alignment is lost between lines. I agree the single-char version is
lossy, but I think in combination with checking the literal, uncolored
version, we'd be OK.

However, it may be best to just leave the original verbose version you
had. It's hard to read and to modify, but we don't plan for people to do
that very often. And it's at least simple.

> > I'm also not thrilled that we depend on the exact sequence of default
> > colors, but I suspect it's not the first time. And it wouldn't be too
> > hard to update it if that default changes.
> 
> Well, it's easy enough to set the colors explicitly. After doing this
> I noticed that green seems to be skipped. Not sure if that's a bug or
> not.

Hmm, yeah, that is weird. I think it's an artifact of the way we
increment the color selector, though, and not related to your patch (the
same thing happens before your fix, as well).

> > I think it's OK to have a dedicated script for even these two tests, if
> > it makes things easier to read. However, would we also want to test the
> > octopus without the problematic graph here? I think if we just omit
> > "left" we get that, don't we?
> 
> t4202-log.sh already does test a "normal" octopus merge (starting
> around line 615, search for "octopus-a"). But that is only a 3-parent
> merge. And adding another test is easy enough.
> [...]

Thanks, what you have here looks good.

> From cd9415b524357c2c8b9b20a63032c94e01d46a15 Mon Sep 17 00:00:00 2001
> From: Noam Postavsky <npostavs@users.sourceforge.net>
> Date: Sat, 1 Sep 2018 20:07:16 -0400
> Subject: [PATCH v5] log: Fix coloring of certain octupus merge shapes

This whole version looks good to me. "git am" is supposed to understand
attachments, but it seems to want to apply our whole conversation as the
commit message.

You may want to repost one more time with this subject in the email
subject line to fix that and to get the maintainer's attention. Feel
free to add my:

  Reviewed-by: Jeff King <peff@peff.net>

after your signoff. Thanks for sticking with this topic!

-Peff
