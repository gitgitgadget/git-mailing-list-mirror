Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3321C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66DA60F6F
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhJZVNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:13:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:47408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235666AbhJZVNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:13:54 -0400
Received: (qmail 10612 invoked by uid 109); 26 Oct 2021 21:11:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Oct 2021 21:11:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13924 invoked by uid 111); 26 Oct 2021 21:11:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Oct 2021 17:11:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Oct 2021 17:11:29 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
Message-ID: <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
 <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
 <YXhjstW2XAnixEqh@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXhjstW2XAnixEqh@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 04:23:14PM -0400, Taylor Blau wrote:

> So this all feels like a bug in ASan to me. I'm curious if it works on
> your system, but in the meantime I think the best path forward is to
> drop the last patch of my original series (the one with the three
> UNLEAK() calls) and to avoid relying on this patch for the time being.

Bugs aside, I'd much rather see UNLEAK() annotations than external ones,
for all the reasons we introduced UNLEAK() in the first place:

  - it keeps the annotations near the code. Yes, that creates conflicts
    when the code is changed (or the leak is actually fixed), but that's
    a feature. It keeps them from going stale.

  - leak-checkers only know where things are allocated, not who is
    supposed to own them. So you're often annotating the wrong thing;
    it's not a strdup() call which is buggy and leaking, but the
    function five layers up the stack which was supposed to take
    ownership and didn't.

And if we avoid any annotation bugs by doing so, that's icing on the
cake. :)

-Peff
