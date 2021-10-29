Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76727C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5305E60FC1
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhJ2VHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:07:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:49818 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhJ2VHa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:07:30 -0400
Received: (qmail 23847 invoked by uid 109); 29 Oct 2021 21:05:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Oct 2021 21:05:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22929 invoked by uid 111); 29 Oct 2021 21:05:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Oct 2021 17:05:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Oct 2021 17:05:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
Message-ID: <YXxh/GMuy+sBViVY@coredump.intra.peff.net>
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
 <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
 <YXhjstW2XAnixEqh@nand.local>
 <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
 <211027.86v91iyis4.gmgdl@evledraar.gmail.com>
 <YXkWhFGS/uTAnsI1@coredump.intra.peff.net>
 <211027.865ytixjcw.gmgdl@evledraar.gmail.com>
 <YXxf/+dwx5giy6im@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXxf/+dwx5giy6im@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 04:56:31PM -0400, Jeff King wrote:

> > E.g. (to reinforce your point) try compiling with SANITIZE=leak and running:
> > 
> >     $ TZ=UTC t/helper/test-tool date show:format:%z 1466000000 +0200
> >     1466000000 -> +0000
> >     +0200 -> +0000
> >     
> >     =================================================================
> >     ==335188==ERROR: LeakSanitizer: detected memory leaks
> >     
> >     Direct leak of 3 byte(s) in 1 object(s) allocated from:
> >         #0 0x7f31cdd21db0 in __interceptor_malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:54
> >         #1 0x7f31cdb04e4a in __GI___strdup string/strdup.c:42
> >     
> >     SUMMARY: LeakSanitizer: 3 byte(s) leaked in 1 allocation(s).
> 
> So these should be real leaks. Of course with the lousy stack trace it's
> hard to see what they are. But I don't see how UNLEAK() is responsible
> for making the lousy stack trace. You could try compiling with LSan but
> _not_ -DSUPPRESS_ANNOTATED_LEAKS and see if the result is similarly bad
> (but I expect it to be, since test-date.c does not have any UNLEAK()
> calls in it).

I just tested this, and it is unrelated to UNLEAK(). Interestingly,
compiling with SANITIZE=address does give the correct stack trace, so I
think LSan is just buggy here for some reason.

We usually suppress leaks with ASAN_OPTIONS because there are so many
(and we want to get at the more important signal of actual memory
errors). But it wouldn't be hard to have that setting respect your
PASSING_SANITIZE_LEAK variables. The big downside is that ASan runs of
the test suite are much more expensive.

Hmm. A little googling turns up LSan's fast_unwind_on_malloc option. And
indeed:

  $ LSAN_OPTIONS=fast_unwind_on_malloc=0 t/helper/test-tool date show:format:%z 1466000000 +0200
  1466000000 -> +0000
  +0200 -> +0000
  
  =================================================================
  ==39628==ERROR: LeakSanitizer: detected memory leaks
  
  Direct leak of 3 byte(s) in 1 object(s) allocated from:
      #0 0x7fa664e39b94 in __interceptor_malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:56
      #1 0x7fa664c124aa in __GI___strdup string/strdup.c:42
      #2 0x557636c40c2e in xstrdup /home/peff/compile/git/wrapper.c:29
      #3 0x557636b2ae52 in parse_date_format /home/peff/compile/git/date.c:991
      #4 0x557636aedb0e in show_dates t/helper/test-date.c:39
      #5 0x557636aedee1 in cmd__date t/helper/test-date.c:116
      #6 0x557636aec1f0 in cmd_main t/helper/test-tool.c:127
      #7 0x557636aec30d in main /home/peff/compile/git/common-main.c:52
      #8 0x7fa664babe49 in __libc_start_main ../csu/libc-start.c:314
      #9 0x557636aebec9 in _start (/home/peff/compile/git/t/helper/test-tool+0xcec9)
  
  SUMMARY: LeakSanitizer: 3 byte(s) leaked in 1 allocation(s).

So perhaps we ought to be setting that by default.

-Peff
