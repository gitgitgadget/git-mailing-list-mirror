Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1CBECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 21:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiH3Vc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiH3Vc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 17:32:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26EC89900
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:32:25 -0700 (PDT)
Received: (qmail 7917 invoked by uid 109); 30 Aug 2022 21:32:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Aug 2022 21:32:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30159 invoked by uid 111); 30 Aug 2022 21:32:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Aug 2022 17:32:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Aug 2022 17:32:24 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: validating signed/unsigned comparisons with Coccinelle, was Re:
 [PATCH 0/3] A couple of CI fixes regarding the built-in add --patch
Message-ID: <Yw6B6OB5gJhPVn5/@coredump.intra.peff.net>
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
 <p9p431r8-nq64-02sq-3049-n10rrn1o89o7@tzk.qr>
 <dc48ce59-530e-da74-93ad-9eb4a17e391c@gmail.com>
 <73spp934-1q41-1123-41no-q2337954op92@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73spp934-1q41-1123-41no-q2337954op92@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2022 at 11:12:24PM +0200, Johannes Schindelin wrote:

> On Tue, 30 Aug 2022, Phillip Wood wrote:
> 
> > I wonder if they would be interested in fixing the parsing bug we found
> > with Peff's UNUSED() series.
> 
> Could you point me to the relevant mail? I am sure that I can come up with
> an MCVE that will help them pinpoint the bug and fix it as quickly as they
> did with this here bug.

It's the sub-thread starting here:

  https://lore.kernel.org/git/220825.86ilmg4mil.gmgdl@evledraar.gmail.com/

I tried to put together a minimal example, which would be something
like:

  $ cat foo.c
  void old_function(int);
  void new_function(int);
  
  #if defined(__GNUC__)
  #define UNUSED(var) UNUSED_##var __attribute__((unused))
  #else
  #define UNUSED(var) UNUSED_##var
  #endif
  
  void foo(int UNUSED(bar), int x)
  {
  	old_function(x);
  }


  $ cat foo.cocci
  @@
  expression E;
  @@
  -old_function(E)
  +new_function(E)

but to my frustration, it actually works! If you add --verbose-parsing
to the spatch command, you can see it complaining about some of the
parsing. And it produces wrong outputs in the real-world with our actual
unused.cocci file. I suspect the example semantic patch might just need
to be a little more complicated.

-Peff
