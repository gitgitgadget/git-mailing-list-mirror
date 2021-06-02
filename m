Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C770C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250CE613D2
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFBUQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:16:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:44440 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhFBUQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:16:12 -0400
Received: (qmail 2401 invoked by uid 109); 2 Jun 2021 20:14:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Jun 2021 20:14:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20758 invoked by uid 111); 2 Jun 2021 20:14:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Jun 2021 16:14:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Jun 2021 16:14:27 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <YLfmo8kl0URnGgp5@coredump.intra.peff.net>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local>
 <YLfgy94sbmStC0mR@coredump.intra.peff.net>
 <20210602201150.GA29388@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602201150.GA29388@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 08:11:50PM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > And so when he gets this error:
> > 
> >   fatal: fsync error on '.git/objects/pack/tmp_pack_NkPgqN': Interrupted system call
> > 
> > presumably we were in fsync() when the signal arrived, and unlike most
> > other platforms, the call needs to be restarted manually (even though we
> > set up the signal with SA_RESTART). I'm not sure if this violates POSIX
> > or not (I couldn't find a definitive answer to the set of interruptible
> > functions in the standard). But either way, the workaround is probably
> > something like:
> 
> "man 3posix fsync" says EINTR is allowed ("manpages-posix-dev"
> package in Debian non-free).

Ah, thanks. Linux's fsync(3) doesn't mention it, and nor does it appear
in the discussion of interruptible calls in signals(7). So I was looking
for a POSIX equivalent of that signals manpage but couldn't find one. :)

> >   #ifdef FSYNC_NEEDS_RESTART
> 
> The wrapper should apply to all platforms.  NFS (and presumably
> other network FSes) can be mounted with interrupts enabled.

I don't mind that, as the wrapper is pretty low-cost (and one less
Makefile knob is nice). If it's widespread, though, I find it curious
that nobody has run into it before now.

-Peff
