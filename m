Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAE7C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 08:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC636108D
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 08:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhJZI4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:56:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:46538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233877AbhJZI4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 04:56:16 -0400
Received: (qmail 8818 invoked by uid 109); 26 Oct 2021 08:53:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Oct 2021 08:53:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5532 invoked by uid 111); 26 Oct 2021 08:53:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Oct 2021 04:53:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Oct 2021 04:53:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 5/6] config.c: free(expanded) before die(), work
 around GCC oddity
Message-ID: <YXfCH7I1XwH+Vetu@coredump.intra.peff.net>
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
 <patch-v3-5.6-9a44204c4c9-20211022T175227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-5.6-9a44204c4c9-20211022T175227Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 08:19:38PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On my GCC version (10.2.1-6), but not the clang I have available t0017
> will fail under SANITIZE=leak on optimization levels higher than -O0,
> which is annoying when combined with the change in 956d2e4639b (tests:
> add a test mode for SANITIZE=leak, run it in CI, 2021-09-23).

This one really makes me sad. The resulting code is more complicated,
and what guarantee do we have that we won't run into similar problems
with other die() calls?

If we're getting false positives, I'd rather see us work around them
with annotations, or a better compiler (I couldn't reproduce with gcc
10.3.0 or 11.2.0 from Debian, so I doubt there is even much point in
reporting it upstream).

> We really do have a memory leak here in either case, as e.g. running
> the pre-image under valgrind(1) will reveal. It's documented
> SANITIZE=leak (and "address", which exhibits the same behavior) might
> interact with compiler optimization in this way in some cases. Since
> this function is called recursively it's going to be especially
> interesting as an optimization target.

I don't see how we have a leak. If we hit this die code-path then we
never exit the function. I can't reproduce the problem, but it sounds
like -O2 is reusing the stack space of "expanded" to prepare for the
die() call? IMHO that is not an actual leak. It is still in scope from
the perspective of C, and anyway we are about to exit from within the
die().

If we were to do anything in the code itself, I'd much prefer to hit it
with an UNLEAK().

-Peff
