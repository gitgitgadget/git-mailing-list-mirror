Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D4C433E0
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 10:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887596501E
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 10:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhCFKpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 05:45:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:54380 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhCFKpj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 05:45:39 -0500
Received: (qmail 12109 invoked by uid 109); 6 Mar 2021 10:45:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Mar 2021 10:45:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29364 invoked by uid 111); 6 Mar 2021 10:45:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Mar 2021 05:45:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 6 Mar 2021 05:45:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 2/4] Makefile/coccicheck: speed up and fix bug with
 duplicate hunks
Message-ID: <YENdUMLTM+cerfqJ@coredump.intra.peff.net>
References: <20210302205103.12230-1-avarab@gmail.com>
 <20210305170724.23859-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210305170724.23859-3-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 05, 2021 at 06:07:22PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Using --no-includes also fixes a subtle bug introduced in
> 960154b9c17 (coccicheck: optionally batch spatch invocations,
> 2019-05-06) with duplicate hunks being written to the
> generated *.patch files.
> 
> This is because that change altered a file-at-a-time for-loop to an
> invocation of "xargs -n X". This would not matter for most other
> programs, but it matters for spatch.
> 
> This is because each spatch invocation will maintain shared lock files
> in /tmp, check if files being parsed were changed etc. I haven't dug
> into why exactly, but it's easy to reproduce the issue[2]. The issue
> goes away entirely if we just use --no-includes, which as noted above
> would have made sense even without that issue.

This part still doesn't make any sense to me. If we are running with
SPATCH_BATCH_SIZE=1, which is the default, then "xargs -n" is still
going to run it in file-at-a-time mode. From spatch's perspective,
there's no difference between a for-loop and "xargs -n 1" (unless it
somehow cares about stdin, but it shouldn't).

Using strace, I do see it creating files in /tmp, but they are all named
after the process id, and cleaned up before exit. So I don't see how
they could interfere with each other (certainly not in a sequential run,
but even if you were to use "xargs -P" to get parallel runs, they seem
distinct).

If we increase the batch size, I'd expect _fewer_ duplicates. Because in
file-at-a-time mode with --all-includes, wouldn't every file that
mentions an include possibly end up emitting a patch for it?

The results you show here (which do replicate for me) imply something
much weirder is going on:

>     with xargs -n 1:
>           1 +++ b/convert.c
>           1 +++ b/strbuf.c
>     with xargs -n 2:
>           1 +++ b/convert.c
>           1 +++ b/strbuf.c
>     with xargs -n 4:
>           1 +++ b/convert.c
>           1 +++ b/strbuf.c

These results are wrong! They are not finding the entry in strbuf.h that
should be changed.

>     with xargs -n 16:
>           1 +++ b/convert.c
>           1 +++ b/strbuf.c
>           2 +++ b/strbuf.h
>     with xargs -n 64:
>           1 +++ b/convert.c
>           1 +++ b/strbuf.c
>           2 +++ b/strbuf.h
>     with xargs -n 128:
>           1 +++ b/convert.c
>           1 +++ b/strbuf.c
>           2 +++ b/strbuf.h

These ones are also wrong. Now we find the strbuf.h mention, but we are
finding it twice.

>     with xargs -n 512:
>           1 +++ b/convert.c
>           1 +++ b/strbuf.c
>           1 +++ b/strbuf.h

And this one, which is given all of the paths in one invocation gets it
right. I'd expect that over the "128" version, which is running two
independent spatch invocations. But the fact that "64" and "16" produce
exactly two duplicates makes little sense. And even less that 1, 2, and
4 don't find the header change at all.

Running the same test with a for loop produces the same (wrong) results
as "-n 1", as expected:

  $ for i in *.c; do
      spatch --sp-file test.cocci --all-includes --patch . $i 2>/dev/null
    done | grep -F +++ | sort | uniq -c
        1 +++ b/convert.c
        1 +++ b/strbuf.c

So in short I have no idea what spatch is doing. But I remain
unconvinced that there is anything wrong with the batch-size patch.

Running it like your patch will, feeding the header directly along with
--no-includes, does find the correct result:

  $ for i in *.c *.h; do
      spatch --sp-file test.cocci --no-includes --patch . $i 2>/dev/null
    done | grep -F +++ | sort | uniq -c
        1 +++ b/convert.c
        1 +++ b/strbuf.c
        1 +++ b/strbuf.h

though I am still concerned by René's example which is missing more
results.

-Peff
