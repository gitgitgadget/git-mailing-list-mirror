Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D5C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjC1UG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjC1UG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:06:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C7FD8
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:06:25 -0700 (PDT)
Received: (qmail 1807 invoked by uid 109); 28 Mar 2023 19:59:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 19:59:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1462 invoked by uid 111); 28 Mar 2023 19:59:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 15:59:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 15:59:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: win-test: unknown terminal "xterm-256color", was Re: [RFC PATCH
 6/6] ls-tree: introduce '--pattern' option
Message-ID: <20230328195942.GA1173031@coredump.intra.peff.net>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
 <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
 <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr>
 <xmqqtu20qinx.fsf@gitster.g>
 <d566eb68-6476-a193-2acb-10106a154d3d@gmx.de>
 <xmqqzg7ylye4.fsf@gitster.g>
 <20230328180859.GB18558@coredump.intra.peff.net>
 <xmqqbkkcfz9s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbkkcfz9s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 12:31:59PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So it should be fine to just set TERM=dumb everywhere. What actually
> > confuses me is that we try to do so already:
> >
> >   $ git grep -B1 dumb ci/lib.sh
> >   ci/lib.sh-# GitHub Action doesn't set TERM, which is required by tput
> >   ci/lib.sh:export TERM=${TERM:-dumb}
> >
> > Pushing a stripped-down workflow file to just run "echo $TERM" shows
> > that it seems to already be set by Actions to "dumb" on ubuntu-latest,
> > but is xterm-256color on windows-latest.
> >
> > So maybe we just want to make the line above unconditionally set $TERM?
> 
> I thought that Dscho earlier said xterm-256 is set by mingw when
> nothing is set to TERM, which explains why TERM=${TERM:-dumb} is
> not good enough to "fix" this one for them.

Ah, I took it to mean that in our code, we'd default to xterm256-color.
But perhaps it is the outer bash which is doing so, via that runtime. I
tested with a dummy workflow like:

  name: fake ci
  on: [push, pull_request]
  jobs:
    ubuntu:
      runs-on: ubuntu-latest
      steps:
        - name: check TERM
	- run: |
	  echo TERM=$TERM
    windows:
      runs-on: windows-latest
      steps:
        - name: check TERM
          shell: bash
          run: |
            echo TERM=$TERM

and got "dumb" for ubuntu (which is not set by us; this is before
ci/lib.sh is run) and "xterm256-color" for windows (I guess because it's
mingw bash).

At any rate, unconditionally setting TERM=dumb should cover all cases,
I'd think. I'm happy to prepare a patch.

-Peff
