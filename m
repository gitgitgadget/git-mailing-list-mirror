Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FCAC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3696121F
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbhIWReZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:34:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:53652 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242612AbhIWReX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:34:23 -0400
Received: (qmail 15450 invoked by uid 109); 23 Sep 2021 17:32:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Sep 2021 17:32:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29678 invoked by uid 111); 23 Sep 2021 17:32:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Sep 2021 13:32:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Sep 2021 13:32:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
Message-ID: <YUy6QoCG/X9qslim@coredump.intra.peff.net>
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <xmqqmto48ufz.fsf@gitster.g>
 <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net>
 <xmqqzgs479d5.fsf@gitster.g>
 <YUuPYDkxjDIvIfwI@coredump.intra.peff.net>
 <8735pw6w8z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735pw6w8z.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 12:40:04AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > It's a shame we can't just try to do the _real_ compiles using the
> > auto-dependency stuff, and then fall back if they fail. But I think
> > there's a chicken-and-egg problem there with "make" doing real work, and
> > figuring out the dependencies to do real work.
> 
> Isn't this just a chicken & egg problem because we've made it a chicken
> & egg problem? I.e. this WIP hack seems to work for me to avoid it:

Possibly, but...

> -$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
> +ifeq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
> +$(C_DEP_OBJ): $(GENERATED_H)
> +$(C_DEP_OBJ): %.dep : %.c command-list.h
> +	$(QUIET_DEP)$(CC) -MF $*.dep -MQ $*.o -MM $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<

I don't think this last dependency is quite right. The .dep for foo.c
must rely not only on foo.c, but also all of its recursive headers (if
it includes foo.h and then foo.h changes to include bar.h, we need to
update the dep file). So it really needs to depend on everything in its
own .dep file, too.

> I.e. here every *.c file depends on a corresponding *.dep file, we
> generate the *.dep files and *.c files seperately, instead of making the
> *.dep a "while we're at it" as we make the *.o.
> [...]
> It also makes "git clean -dxf; make -j8 all" take ~17s on my box instead
> of ~13s.

I definitely think that's easier to reason about, but I'm not surprised
you found that it was slower. To get a more apples-to-apples comparison,
I compiled with -j1. I also use -O0 as my default, which makes the
"real" compilation a relatively smaller portion. I got 47s without your
patch, and 60s with. That seems non-trivial.

I also noticed that "make clean" built all the deps. I think that could
be fixed, but we're piling fixes upon fixes.

So I'm not really sure what we're gaining by splitting this all up.
Given that our original problem is just fixing the test for "do we
support computed dependencies", I think we can solve that pretty easily
and move on.

> So maybe I've talked myself out of there being an inherent dependency
> graph violation with the current schema, i.e. the current one seems like
> an easily solved bug.

Yeah, AFAIK the current system is pretty robust and battle-tested. I'd
be cautious of messing with it unless there's a big gain to be seen.

> One good thing the above approach still gives you is that you can use
> GCC or Clang to make the dependency graph, but then use another compiler
> to compile, i.e. we could have a $(GCC_LIKE) in addition to $(CC), so if
> I'm compiling with xlc or suncc I can still use the present GCC just to
> create the dependency graph.

Keep in mind the worst case in not using the dependency graph is just
that a header update in an incremental compile may cause some extra
compilation. It's really not _that_ bad, and especially so for folks who
aren't actively doing development.

-Peff
