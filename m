Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291F4C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 19:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C362A23600
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 19:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgIXTQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 15:16:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:39902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgIXTQj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 15:16:39 -0400
Received: (qmail 6875 invoked by uid 109); 24 Sep 2020 19:16:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2020 19:16:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10271 invoked by uid 111); 24 Sep 2020 19:16:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2020 15:16:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Sep 2020 15:16:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH 0/2] drop unaligned loads
Message-ID: <20200924191638.GA2528003@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 24, 2020 at 10:22:20AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Then I did the same, but building with -DNO_UNALIGNED_LOADS. The latter
> > actually ran faster, by a small margin. Here are the hyperfine results:
> >
> >   [stock]
> >   Time (mean ± σ):      6.638 s ±  0.081 s    [User: 6.269 s, System: 0.368 s]
> >   Range (min … max):    6.550 s …  6.841 s    10 runs
> >
> >   [-DNO_UNALIGNED_LOADS]
> >   Time (mean ± σ):      6.418 s ±  0.015 s    [User: 6.058 s, System: 0.360 s]
> >   Range (min … max):    6.394 s …  6.447 s    10 runs
> >
> > For casual use as in reftables I doubt the difference is even
> > measurable. But this result implies that perhaps we ought to just be
> > using the fallback version all the time.
> 
> I like that one.  One less configurable knob that makes us execute
> different codepaths is one less thing to be worried about.

Here it is with a little more research, then, and a cleanup we can do on
top.

  [1/2]: bswap.h: drop unaligned loads
  [2/2]: Revert "fast-export: use local array to store anonymized oid"

 Makefile              |  1 -
 builtin/fast-export.c |  8 ++++----
 compat/bswap.h        | 24 ------------------------
 3 files changed, 4 insertions(+), 29 deletions(-)

-Peff
