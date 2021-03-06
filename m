Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0B8C433E0
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A42B6501E
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhCFLAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:00:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:54416 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhCFK7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 05:59:52 -0500
Received: (qmail 12197 invoked by uid 109); 6 Mar 2021 10:59:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Mar 2021 10:59:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29449 invoked by uid 111); 6 Mar 2021 10:59:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Mar 2021 05:59:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 6 Mar 2021 05:59:51 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Makefile: fix bugs in coccicheck and speed it up
Message-ID: <YENgpz4/z4WgT50O@coredump.intra.peff.net>
References: <20190506234334.GA13296@sigill.intra.peff.net>
 <20210302205103.12230-1-avarab@gmail.com>
 <YEIGzXMDax83cwAx@coredump.intra.peff.net>
 <87im65tt3k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im65tt3k.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 05, 2021 at 06:20:47PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >   [after]
> >   $ make coccicheck
> >     SPATCH contrib/coccinelle/free.cocci
> >   make: *** [Makefile:2875: contrib/coccinelle/free.cocci.patch] Error 124
> 
> The "cat $@.log" is back, but there's still some issues with it on
> master now (I didn't change this) it'll spew a lot at you with xargs
> since we emit the whole error output for every file, seemingly, before
> cat-ing the file:
> 
>     make -j1 coccicheck SPATCH_FLAGS=--blahblah V=1 2>&1|grep -i example.*use|wc -l
>     464
> 
> Well, it's a bit better now on my series with a default batch size of 8:
> 
>     $ make -j1 coccicheck SPATCH_FLAGS=--blahblah V=1 2>&1|grep -i example.*use|wc -l
>     88
> 
> I got tired of dealing with the combination of shellscritp and make for
> the day. But maybe something to do as a follow-up if anyone's
> interested.

Hmm, yeah. xargs will keep going unless the command actually returns
255. I never noticed with syntax errors in the cocci files, because
those cause spatch to exit with 255!

IMHO that's likely to be the most common error, though probably "oops,
you don't have spatch installed" is a close second. But that one also
works well, because xargs (at least GNU xargs) will stop if it can't
run the program.

So it might be nice to have it bail on the first failure, but I don't
know that it's worth spending a lot of time on it.

-Peff
