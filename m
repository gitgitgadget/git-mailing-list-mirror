Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F68EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 22:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGBWCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 18:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGBWCs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 18:02:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826FC100
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 15:02:45 -0700 (PDT)
Received: (qmail 15688 invoked by uid 109); 2 Jul 2023 22:02:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 Jul 2023 22:02:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16458 invoked by uid 111); 2 Jul 2023 22:02:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 Jul 2023 18:02:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 2 Jul 2023 18:02:43 -0400
From:   Jeff King <peff@peff.net>
To:     Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan@kloetzke.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Steve Kemp <steve@steve.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] ref-filter: handle nested tags in --points-at option
Message-ID: <20230702220243.GA1534980@coredump.intra.peff.net>
References: <20230701205703.1172505-1-jan@kloetzke.net>
 <20230702125611.GA1036686@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230702125611.GA1036686@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 02, 2023 at 08:56:11AM -0400, Jeff King wrote:

> My biggest question would be whether this introduces any performance
> penalty for the more common cases (lightweight tags and single-level
> annotated tags). The answer is "no", I think; we are already paying the
> cost to parse every object to find out if it's a tag, and your new loop
> only does an extra parse if we see a tag-of-tag. Good.

Reading more carefully, I think this does actually change the
performance a bit, because we end up parsing the pointed-to commits, as
well. So here's before and after your patch running "git for-each-ref
--points-at=HEAD" on linux.git (785 refs, all but 3 are tags):

  Benchmark 1: ./git.old for-each-ref --points-at=HEAD
    Time (mean ± σ):      11.4 ms ±   0.2 ms    [User: 6.5 ms, System: 4.9 ms]
    Range (min … max):    11.0 ms …  12.3 ms    239 runs
  
  Benchmark 2: ./git.new for-each-ref --points-at=HEAD
    Time (mean ± σ):      20.6 ms ±   0.5 ms    [User: 10.4 ms, System: 10.2 ms]
    Range (min … max):    19.8 ms …  22.7 ms    133 runs
  
  Summary
    './git.old for-each-ref --points-at=HEAD' ran
      1.80 ± 0.06 times faster than './git.new for-each-ref --points-at=HEAD'

The absolute numbers are pretty small, but the percent change isn't
great. I'll send some patches in a minute that can be applied on top to
improve this case, as well as fix the other issues I pointed out in the
existing code.

-Peff
