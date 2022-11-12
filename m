Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9719EC433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 16:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiKLQeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 11:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiKLQef (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 11:34:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BAD11A3C
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 08:34:32 -0800 (PST)
Received: (qmail 5266 invoked by uid 109); 12 Nov 2022 16:34:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 12 Nov 2022 16:34:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21519 invoked by uid 111); 12 Nov 2022 16:34:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 12 Nov 2022 11:34:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 12 Nov 2022 11:34:31 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/13] parse-options API: don't restrict OPT_SUBCOMMAND()
 to one *_fn type
Message-ID: <Y2/LF/qiZI99YuxM@coredump.intra.peff.net>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
 <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
 <25776063-a672-fc65-bed3-1bc8536ab8b3@web.de>
 <221105.86o7tlvxh0.gmgdl@evledraar.gmail.com>
 <46ee3f92-943f-10d5-7ec5-c68f1ced87ce@web.de>
 <221106.86k048w2f4.gmgdl@evledraar.gmail.com>
 <36337a3f-6443-f272-09f0-7ddb3c20d7a4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36337a3f-6443-f272-09f0-7ddb3c20d7a4@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 11:42:09AM +0100, René Scharfe wrote:

> > E.g. we have plenty of code that assumes ASCII, instead of catering to
> > EBCDIC, and assuming NULL is (void *)0, not (void *)123456 or whatever.
> 
> NULL is defined as "0" or "(void *)0" by C99 6.3.2.3 Pointers paragraph
> 3 and 7.17 Common definitions <stddef.h> paragraph 3.

I think he is alluding to the fact that while the standard requires that
a "0" constant refers to a NULL pointer, the representation does not
have to be all-bits-zero. So:

  char *foo = 0;

is fine, but:

  char *foo;
  memset(foo, 0, sizeof(&foo));

is not. And we absolutely do the latter in our code base anyway, because
it's convenient and unlikely to be a problem on practical platforms. And
I think it has always been our attitude in this community to let
engineering practicality trump strict adherence to the standard. But
"practicality" there should be measuring the tradeoff of how useful
something is versus how likely it is to bite us.

In the case under discussion, my gut feeling agrees with you, though.
I'm skeptical that equivalence of object and function pointers is all
that useful in practice. And your mention of CHERI seems like a
plausible way it could bite us.

-Peff
