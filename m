Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E2C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjC1UnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC1UnU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:43:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791D412B
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:43:19 -0700 (PDT)
Received: (qmail 2054 invoked by uid 109); 28 Mar 2023 20:43:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:43:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2098 invoked by uid 111); 28 Mar 2023 20:43:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:43:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:43:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: win-test: unknown terminal "xterm-256color", was Re: [RFC PATCH
 6/6] ls-tree: introduce '--pattern' option
Message-ID: <20230328204318.GA1274197@coredump.intra.peff.net>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
 <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
 <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr>
 <xmqqtu20qinx.fsf@gitster.g>
 <d566eb68-6476-a193-2acb-10106a154d3d@gmx.de>
 <xmqqzg7ylye4.fsf@gitster.g>
 <20230328180859.GB18558@coredump.intra.peff.net>
 <xmqqbkkcfz9s.fsf@gitster.g>
 <20230328195942.GA1173031@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328195942.GA1173031@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 03:59:42PM -0400, Jeff King wrote:

> At any rate, unconditionally setting TERM=dumb should cover all cases,
> I'd think. I'm happy to prepare a patch.

Hmph. So I started to do this, and notice there are a bunch of tput
calls in the ci/ scripts themselves.

So if I do a dummy workflow like this:

-- >8 --
name: fake ci
on: [push, pull_request]
jobs:
  ubuntu:
    runs-on: ubuntu-latest
    steps:
      - name: check TERM
        run: |
          echo TERM=$TERM
          echo $(tput setaf 1)this is setaf 1$(tput sgr0)
  windows:
    runs-on: windows-latest
    steps:
      - name: check TERM
        shell: bash
        run: |
          echo TERM=$TERM
          echo $(tput setaf 1)this is setaf 1$(tput sgr0)
-- 8< --

then I note two interesting things:

  - the attempted colorization does nothing on ubuntu, because it's
    already TERM=dumb

  - the colorization on windows works! But I thought it was exactly
    these sorts of tputs that are causing the error messages.

So now I'm more confused than ever. I have a feeling we would be better
off just using ansi codes instead of tput, as Johannes suggested
earlier. But given the twists and turns here, and the fact that nobody
really seems that bothered by the status quo, I'm inclined to just leave
it alone for now.

-Peff
