Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68BE20953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbdCPWFj (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:05:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:45441 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752051AbdCPWFi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:05:38 -0400
Received: (qmail 2335 invoked by uid 109); 16 Mar 2017 22:04:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 22:04:59 +0000
Received: (qmail 25107 invoked by uid 111); 16 Mar 2017 22:05:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 18:05:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 18:04:56 -0400
Date:   Thu, 16 Mar 2017 18:04:56 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Re-integrate sha1dc
Message-ID: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1703161315310.18484@i7.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1703161315310.18484@i7.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 01:24:02PM -0700, Linus Torvalds wrote:

> I suspect the first patch will not make it to the list since it's over 
> 100kB in size, but oh well.. Junio and Jeff will see it.

Yep, it didn't make it, but I got it.

> It "WorksForMe(tm)" and the integration patches are now fairly trivial, 
> since upstream already did the dieting and some of the semantic changes to 
> gits more traditional C code.

There are a few things I think are worth changing. The die() message
should mention the sha1 we computed. That will be a big help if an old
version of git tries to unknowingly push a colliding object to a newer
version. The user will see "collision on sha1 1234.." which gives them a
starting point to figure out where they got the bad object from.

And to make that work, we have to disable the safe_hash feature (which
intentionally corrupts a colliding sha1). We _could_ rip it out
entirely, but since it only kicks in when we see a collision, I doubt
it's impacting anything.

I also updated the timings in my commit message, and added a basic test.

> I did leave the C++ wrapper lines that the sha1dc header files have grown 
> in the meantime, I debated removing them but felt that "closer to 
> upstream" was worth it.

Yeah, I independently made the same decision.

So here's my version. It's on top of the hash.h tweak, as well.

  [1/5]: add collision-detecting sha1 implementation
  [2/5]: sha1dc: adjust header includes for git
  [3/5]: sha1dc: disable safe_hash feature
  [4/5]: Makefile: add USE_SHA1DC knob
  [5/5]: t0013: add a basic sha1 collision detection test

 Makefile                |   11 +
 hash.h                  |    2 +
 sha1dc/LICENSE.txt      |   30 +
 sha1dc/sha1.c           | 1808 +++++++++++++++++++++++++++++++++++++++++++++++
 sha1dc/sha1.h           |  122 ++++
 sha1dc/ubc_check.c      |  363 ++++++++++
 sha1dc/ubc_check.h      |   44 ++
 t/t0013-sha1dc.sh       |   19 +
 t/t0013/shattered-1.pdf |  Bin 0 -> 422435 bytes
 9 files changed, 2399 insertions(+)
 create mode 100644 sha1dc/LICENSE.txt
 create mode 100644 sha1dc/sha1.c
 create mode 100644 sha1dc/sha1.h
 create mode 100644 sha1dc/ubc_check.c
 create mode 100644 sha1dc/ubc_check.h
 create mode 100755 t/t0013-sha1dc.sh
 create mode 100644 t/t0013/shattered-1.pdf

-Peff
