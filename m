Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8830C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 18:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjC1SJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjC1SJD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 14:09:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3341B5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 11:09:00 -0700 (PDT)
Received: (qmail 1284 invoked by uid 109); 28 Mar 2023 18:09:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 18:08:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 453 invoked by uid 111); 28 Mar 2023 18:08:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 14:08:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 14:08:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: win-test: unknown terminal "xterm-256color", was Re: [RFC PATCH
 6/6] ls-tree: introduce '--pattern' option
Message-ID: <20230328180859.GB18558@coredump.intra.peff.net>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
 <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
 <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr>
 <xmqqtu20qinx.fsf@gitster.g>
 <d566eb68-6476-a193-2acb-10106a154d3d@gmx.de>
 <xmqqzg7ylye4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg7ylye4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2023 at 01:42:11PM -0700, Junio C Hamano wrote:

> > And to save on bandwidth/time (in a desperate attempt to counter the
> > ever-growing runtimes of Git's CI builds), I liberally exclude files from
> > the "minimal subset of Git for Windows' SDK", e.g. `/usr/lib/terminfo/`
> > and `/usr/share/terminfo/`. That's why `tput` cannot figure out what to do
> > with this `TERM` value.
> 
> Ah, so it is not like "you ship vt100 but not xterm-color yet the
> runtime insists you are by default on xterm-color", so "set it to
> something your terminfo database understands" would not work.  I am
> not sure what unintended fallouts there would be from setting it to
> dumb, though.  Our tests are designed for unattended testing, and
> they are even capable of running without control terminal, so it
> should be OK to force TERM=dumb, I guess.

We already force TERM=dumb in test-lib.sh, so the tests themselves
should behave the same. The original terminal is only used for colorized
output from the test harness itself. But I don't think we'd colorize
anyway in CI, since stdout is not a terminal (and we tend to further go
through "prove" anyway).

So it should be fine to just set TERM=dumb everywhere. What actually
confuses me is that we try to do so already:

  $ git grep -B1 dumb ci/lib.sh
  ci/lib.sh-# GitHub Action doesn't set TERM, which is required by tput
  ci/lib.sh:export TERM=${TERM:-dumb}

Pushing a stripped-down workflow file to just run "echo $TERM" shows
that it seems to already be set by Actions to "dumb" on ubuntu-latest,
but is xterm-256color on windows-latest.

So maybe we just want to make the line above unconditionally set $TERM?

-Peff
