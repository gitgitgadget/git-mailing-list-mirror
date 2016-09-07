Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0E720705
	for <e@80x24.org>; Wed,  7 Sep 2016 08:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbcIGIjy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 04:39:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:39207 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750938AbcIGIjv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 04:39:51 -0400
Received: (qmail 11814 invoked by uid 109); 7 Sep 2016 08:39:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 08:39:49 +0000
Received: (qmail 1699 invoked by uid 111); 7 Sep 2016 08:39:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 04:39:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 04:39:47 -0400
Date:   Wed, 7 Sep 2016 04:39:47 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
Message-ID: <20160907083947.b7q7ebe62xsr6447@sigill.intra.peff.net>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
 <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net>
 <alpine.DEB.2.20.1609061827290.129229@virtualbox>
 <alpine.DEB.2.20.1609061839370.129229@virtualbox>
 <alpine.DEB.2.20.1609061843120.129229@virtualbox>
 <655b42d8-baa9-e649-2b3c-5b7bfc914bc5@drmicha.warpmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <655b42d8-baa9-e649-2b3c-5b7bfc914bc5@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 10:27:34AM +0200, Michael J Gruber wrote:

> Now, I can't reproduce C on Linux[*], so there is more involved. It
> could be that my patch just exposes a problem in our start_command()
> etc.: run-command.c contains a lot of ifdefing, so possibly quite
> different code is run on different platforms.

Maybe, though my blind guess is that it is simply that on Linux we can
open /dev/tty directly, and console-IO on Windows is a bit more
complicated.

You might also check your GPG versions; between gpg1.x and gpg2, the
passphrase input handling has been completely revamped.

> It would be great if someone with a Windows environment could help our
> efforts in resolving issue C, by checking what is actually behind[**]: I
> can't believe that capturing stderr keeps gpg from reading stdin, but
> who knows. Maybe Jeff of pipe_command() fame? I'll put him on cc.

I know nothing about Windows, but I'd be surprised if gpg is reading
from stdin, as opposed to /dev/tty. It's probably more to do with how
gpg finds the "tty" on Windows (presumably it looks at stderr for that).

Anyway, I wrote pipe_command() in such a way as to be prepared for
exactly this kind of thing, so it would be trivial to extend it to an
extra descriptor. The trouble is that run_command() doesn't understand
anything except stdin/stdout/stderr. We can open an extra pipe() before
calling run_command(), and make sure it is not marked CLOEXEC. I don't
know if there are other portability concerns, though.

-Peff
