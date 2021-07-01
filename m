Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7ECC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6815F61407
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhGAPoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:44:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:38602 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234025AbhGAPnx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 11:43:53 -0400
Received: (qmail 28053 invoked by uid 109); 1 Jul 2021 15:41:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 15:41:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16396 invoked by uid 111); 1 Jul 2021 15:41:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 11:41:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 11:41:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 1/3] bundle cmd: stop leaking memory from
 parse_options_cmd_bundle()
Message-ID: <YN3iIaovvG7XgLQP@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
 <patch-1.3-3d0d7a8e8b5-20210630T140339Z-avarab@gmail.com>
 <YNypPeoZTRiOxPPQ@coredump.intra.peff.net>
 <87v95vdxrc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v95vdxrc.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 08:00:50PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > So this code is perfectly fine and unavoidable. In the case you were
> > touching it was foo() that was calling die() directly, so we could work
> > around it with some conditionals. But from the leak-checker's
> > perspective the two cases are the same.
> 
> I've got you to blame for introducing SANITIZE=*. Now I've got these
> leak checkers all mixed up :)
> 
> Yes you're right, FWIW I (re-)wrote this commit message just before
> sending and should have said "a heap leak checker" instead of
> "SANITIZE=leak", I really meant valgrind.

Ah, OK, that makes more sense.

I think the distinction here isn't "heap leak checker" (since valgrind
does still look at the whole memory space to find references), but
rather the treatment of "still reachable" items. I think LSan/ASan
ignore these entirely.

> I originally ended with the "we are about to die" tracking because I was
> tracing things with valgrind, which does complain about this sort of
> thing. I.e.:
>     
>      24 bytes in 1 blocks are still reachable in loss record 8 of 21
>         at 0x48356AF: malloc (vg_replace_malloc.c:298)
>         by 0x4837DE7: realloc (vg_replace_malloc.c:826)
>         by 0x3C06F1: xrealloc (wrapper.c:126)
>         by 0x380EC9: strbuf_grow (strbuf.c:98)
>         by 0x381A14: strbuf_add (strbuf.c:297)
>         by 0x20ADC5: strbuf_addstr (strbuf.h:304)
>         by 0x20B66D: prefix_filename (abspath.c:277)
>         by 0x13CDC6: parse_options_cmd_bundle (bundle.c:55)
>         by 0x13D565: cmd_bundle_unbundle (bundle.c:170)
>         by 0x13D829: cmd_bundle (bundle.c:214)
>         by 0x1279F4: run_builtin (git.c:461)
>         by 0x127DFB: handle_builtin (git.c:714)
> 
> Re what I mentioned/asked in
> https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/ I was
> experimenting with doing leak checking in the tests.
> 
> In this case we have 21 in total under --show-leak-kinds=all (and it was
> 20 in v2 of this series).

IMHO these "still reachable" leaks are not interesting. They'll fall
into one of two categories:

  - allocations still on the stack when we exit() without unwinding.
    These are always uninteresting, since by definition we are exiting
    the process.

  - globals that hang on to allocations (which will still be present
    even if we exit the program by returning up through main()). Most of
    these will be items we intend to last for the program length (e.g.,
    fields in the_repository).

    It's _possible_ that some of these could be interesting. E.g., a
    program might have two phases: in the first, we rely on some
    subsystem which uses global variables to cache some data (say,
    parsed config values in remote.c or userdiff.c), and in the second
    phase we no longer use that subsystem. We could be instructing the
    subsystem to free up the memory after the first phase. But in
    practice this is awkward, because the program-level code doesn't
    know about subsystem allocations (or even which subsystems might
    have been recursively triggered).

    And while still-reachable tracking could be used to find
    opportunities like this, I think there's a better approach to
    finding these. If subsystems avoid global-variable caches and
    instead stick their allocations into context structs, then the
    memory is associated with those structs. So for example, if
    userdiff attached its storage to a diff_options, which is attached
    to a rev_info, then any "leaking" is all predicated on the rev_info
    (which the main program either cleans up, or annotates with UNLEAK).

> Maybe if we do end up with a test mode for this we shouldn't care about
> checkers like valgrind and only cater to the SANITIZE=leak mode.

I do find SANITIZE=leak to be a more useful tool in general, but I'm not
at all against using valgrind if people find it convenient. I just think
"reachable" leaks are not interesting enough to be part of what we're
searching for when we run the test suite.

> I'm still partial to the idea that we'll get the most win out of
> something that we can run in the tests by default, i.e. we'll only need
> to have a valgrind on the system & have someone run "make test" to run a
> (limited set of) tests with this.
> 
> Whereas SANITIZE=leak is always a dev-only feature people may not have
> on all the time.

That is exactly why I think "SANITIZE=leak" is better: it is easier for
people to run. valgrind is _extremely_ slow. It's also not available
everywhere; ASan/LSan aren't either, but they're pretty standard in
clang and gcc these days.

It is nice that valgrind can run on an un-instrumented binary, but I
sort of assume that anybody running "make test" will be able to build
the binary, since "make" is going to want to do that. I.e., I think
"make SANITIZE=leak test" is already doing what we want (we just need to
further annotate known-failures).

-Peff
