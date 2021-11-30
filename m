Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A5DC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhK3VFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:05:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:40502 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235624AbhK3VFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:05:53 -0500
Received: (qmail 14004 invoked by uid 109); 30 Nov 2021 21:02:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Nov 2021 21:02:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30257 invoked by uid 111); 30 Nov 2021 21:02:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Nov 2021 16:02:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Nov 2021 16:02:32 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: Will -fsyntax-only hide issues with -pedantic? I think not...
Message-ID: <YaaRaM8ApB36A9V2@coredump.intra.peff.net>
References: <211130.86ilw9epy3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211130.86ilw9epy3.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 02:13:11PM +0100, Ævar Arnfjörð Bjarmason wrote:

> The answer to $subject is not at all urgent, but I noticed we can get
> some (very modest) speed increases in the "pedantic" CI job when adding
> -fsyntax-only to CFLAGS. This currently requires monkeypatching out the
> "-o <target> -c" part hardcoded in the Makefile. See cebead1ebfb (ci:
> run a pedantic build as part of the GitHub workflow, 2021-08-08) for the
> pedantic job.
> 
> I.e. I'm aware of CFLAGS's -O<n> changing which warings we emit, but
> does -fsyntax-only?

I've never used -fsyntax-only. But I'd tend to doubt it, though, as I
wouldn't expect -fsyntax-only to run through the optimizer. And indeed,
the recent -O3 problem disappears there:

  $ gcc -fsyntax-only -I. -Wall -Werror -O3 refs.c
  [no output]

  $ gcc -o /dev/null -c -I. -Wall -Werror -O3 refs.c
  In file included from hashmap.h:4,
                   from cache.h:6,
                   from refs.c:5:
  In function ‘oidcpy’,
      inlined from ‘ref_transaction_add_update’ at refs.c:1070:3,
      inlined from ‘ref_transaction_update’ at refs.c:1099:2,
      inlined from ‘ref_transaction_verify’ at refs.c:1137:9:
  hash.h:262:9: error: argument 2 null where non-null expected [-Werror=nonnull]
    262 |         memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from git-compat-util.h:185,
                   from cache.h:4,
                   from refs.c:5:
  refs.c: In function ‘ref_transaction_verify’:
  /usr/include/string.h:43:14: note: in a call to function ‘memcpy’ declared ‘nonnull’
     43 | extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
        |              ^~~~~~
  cc1: all warnings being treated as errors

So there is at least one case we'd have potentially missed.

> I don't have any practical use for this now. We could squeeze some
> slight performance out of one CI jobs, but perhaps it'll be more
> interesting in the future.

I don't think the performance of the pedantic CI job is all that
interesting. But if we did want to reduce it, it seems like the simplest
thing is to just build with pedantic for the regular Linux build? If
we're usually pedantic-clean (and we are due to the exceptions in
config.mak.dev), then it doesn't hurt to just build and test with that
flag.

-Peff
