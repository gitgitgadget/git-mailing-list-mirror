Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B6C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 06:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJUGZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJUGZR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 02:25:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802F38D227
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 23:25:14 -0700 (PDT)
Received: (qmail 10675 invoked by uid 109); 21 Oct 2022 06:25:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 06:25:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2473 invoked by uid 111); 21 Oct 2022 06:25:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 02:25:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 02:25:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ci: add address and undefined sanitizer tasks
Message-ID: <Y1I7SeRGikEtgx9t@coredump.intra.peff.net>
References: <xmqq8rlo62ih.fsf@gitster.g>
 <xmqqtu4bz2fw.fsf@gitster.g>
 <Y0SyH34tdXQK2qhA@coredump.intra.peff.net>
 <xmqqtu3xogxr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtu3xogxr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 10:59:28PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > You can make it a bit faster by running both at once as
> > SANITIZE=address,undefined.
> 
> With a single combined sanitier job, we saw failures at CI of p4
> tests, where the server "goes away" in the middle of tests, for
> apparently no reason, and I just speculated perhaps the tests taking
> too long may be causing an impatient server side to go away before
> the client side finishes its work or something.  After splitting the
> ASan and UBSan jobs into two and ejecting a topic out of 'seen', CI
> started passing for the first time in several days.

I am not too surprised to hear that. We flushed out many test races in
the past from using valgrind and SANITIZE. But I don't run the p4 tests
locally, so this is likely some of their first exposure to slower runs.

But if that is the case, then you are probably just papering over
failures here which will likely come back, at least racily.

I admit I was surprised how much slower the combined one is. Here are a
few timings on my laptop:

  $ for i in '' address undefined address,undefined; do
      echo -n "SANITIZE=$i"
      make SANITIZE=$i >/dev/null 2>&1 &&
      (cd t && time ./t3700-add.sh >/dev/null 2>&1)
      echo
    done

  SANITIZE=
  real	0m1.109s
  user	0m0.533s
  sys	0m0.589s
  
  SANITIZE=address
  real	0m1.816s
  user	0m0.999s
  sys	0m0.806s
  
  SANITIZE=undefined
  real	0m1.336s
  user	0m0.618s
  sys	0m0.710s

  SANITIZE=address,undefined
  real	0m2.928s
  user	0m1.304s
  sys	0m1.635s

Curiously, with CC=clang the results are closer to what I'd expect:

  SANITIZE=
  real	0m1.186s
  user	0m0.608s
  sys	0m0.579s
  
  SANITIZE=address
  real	0m1.910s
  user	0m1.014s
  sys	0m0.890s
  
  SANITIZE=undefined
  real	0m1.477s
  user	0m0.611s
  sys	0m0.865s
  
  SANITIZE=address,undefined
  real	0m2.309s
  user	0m1.126s
  sys	0m1.191s

I'm not sure what the takeaway is. If using two jobs produces
appreciably fewer races in practice, it may be worth doing. But I wonder
if just using clang would work better.

-Peff
