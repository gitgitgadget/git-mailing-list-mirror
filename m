Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F915C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 06:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJUGEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJUGEa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 02:04:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B48DF9C
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 23:04:24 -0700 (PDT)
Received: (qmail 10636 invoked by uid 109); 21 Oct 2022 06:04:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 06:04:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2141 invoked by uid 111); 21 Oct 2022 06:04:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 02:04:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 02:04:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: force -O0 when compiling with SANITIZE=leak
Message-ID: <Y1I2Z9K4iaAr+GiP@coredump.intra.peff.net>
References: <Y07yeEQu+C7AH7oN@nand.local>
 <Y08BPbWBj7SNluXq@coredump.intra.peff.net>
 <Y08JZVDgJpJvrBiz@coredump.intra.peff.net>
 <221018.86k04whkgf.gmgdl@evledraar.gmail.com>
 <Y0+i1G5ybdhUGph2@coredump.intra.peff.net>
 <939ccb0c-005c-4f98-a6ca-3f8e5cda1641@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <939ccb0c-005c-4f98-a6ca-3f8e5cda1641@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 08:57:31PM +0200, Rubén Justo wrote:

> "-O2" is what goes public, testing it, directly or indirectly, is useful.
> Another thing is the pay-off..

Sort of. The leak-check build itself is not what goes public, so we have
already diverged from a release build. But yes, if there were cases that
-O2 caught that -O0 did not, that would be of interest.

But are there?

I.e., we already know of false positives with -O2. Are there false
negatives with -O0?

The example you give below goes the other way:

> "False positives" makes me think the leak checker does its best.  And the
> compiler.  This "-O0 leak" is ignored by both, with "-O2":
> 
> 	void func()
> 	{
> 		malloc(1024);
> 		exit(1);
> 	}

It is a false negative with -O2. Which again seems to argue for using
-O0.

> UNLEAK(), "-O0" as a /second opinion/ /confirmation/, some attention to the
> false positives,... are things that doesn't sound so bad.  Maybe there is a
> better way.  Dunno.

I don't know why we'd want to prefer -O2 if we know it produces worse
results, but don't have any cases where it produce better ones (or even
a plausible explanation for why it might). Sure, we could squelch its
false positives with UNLEAK(), but:

  - that's per-site work, versus setting -O0 once

  - UNLEAK() suppresses false positives, but it also would suppress true
    positives (e.g., if the code later changed and somebody introduced a
    leak). It seems better to avoid that if possible.

-Peff
