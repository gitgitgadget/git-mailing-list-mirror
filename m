Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3962C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B90E60F13
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhIVUTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:19:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:52908 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237309AbhIVUTI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:19:08 -0400
Received: (qmail 11036 invoked by uid 109); 22 Sep 2021 20:17:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 20:17:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17923 invoked by uid 111); 22 Sep 2021 20:17:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Sep 2021 16:17:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Sep 2021 16:17:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
Message-ID: <YUuPYDkxjDIvIfwI@coredump.intra.peff.net>
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <xmqqmto48ufz.fsf@gitster.g>
 <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net>
 <xmqqzgs479d5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzgs479d5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 11:28:38AM -0700, Junio C Hamano wrote:

> > That feels a bit like we're playing a game of chicken with the compiler
> > in terms of what it may complain about. For example, sparse will
> > complain:
> >
> >   foo.c:1:5: warning: symbol 'dummy_for_dep_check' was not declared. Should it be static?
> >
> > Might compilers ever learn to warn of the same thing?
> 
> Certainly.  That is the reason why I said "direction", not
> "solution", and I do not think it is beyond our capability to come
> up with a minimal "C program" that would be lint clean to make it
> as a part of the "solution".
> 
> For example, would sparse or compilers complain about this?
> 
>     extern int incr(int); int incr(int i) { return i + 1; }

Fair enough. It is a game of chicken, but it is one that is easy to win. :)

I almost suggested using "git.c" as the dummy file, since we know it
must compile anyway. But that probably has other problems (it's more
expensive, and if it _does_ have an error, the results may be
confusing).

It's a shame we can't just try to do the _real_ compiles using the
auto-dependency stuff, and then fall back if they fail. But I think
there's a chicken-and-egg problem there with "make" doing real work, and
figuring out the dependencies to do real work.

> >  ifeq ($(COMPUTE_HEADER_DEPENDENCIES),auto)
> > -dep_check = $(shell $(CC) $(ALL_CFLAGS) \
> > +dep_check = $(shell $(CC) \
> >  	-c -MF /dev/null -MQ /dev/null -MMD -MP \
> >  	-x c /dev/null -o /dev/null 2>&1; \
> >  	echo $$?)
> 
> I am all for this simplification.  It takes us back to the state
> before 1816bf26 (Makefile: Improve compiler header dependency check,
> 2011-08-30).  But I think that is more or less orthogonal to the
> "you are not supposed to feed an empty compilation unit" issue.

Hmm, my suggestion was off the cuff without digging to see whether we
used to do something similar. ;)

I do worry a bit that we'd be regressing the case that commit tried to
fix. OTOH, I'm not sure I understand its commit message. It talks about
things in CFLAGS being a problem, but it looks like the original (and my
proposal here) would not look at CFLAGS at all? If people are putting
stuff into CC that will break when used without CFLAGS, then I feel like
the answer might be "don't do that". Or are there common situations
where $(CC) is not expected to behave sensibly on its own?

> > I'm also tempted by a hunk like this. Then we can set the REQUIRE flag
> > in a CI job (or locally for git devs who know they have gcc) and notice
> > an unexpected breakage in the auto test.
> >
> > @@ -1295,6 +1295,9 @@ ifneq ($(COMPUTE_HEADER_DEPENDENCIES),no)
> >  $(error please set COMPUTE_HEADER_DEPENDENCIES to yes, no, or auto \
> >  (not "$(COMPUTE_HEADER_DEPENDENCIES)"))
> >  endif
> > +ifdef REQUIRE_COMPUTE_HEADER_DEPENDENCIES
> > +$(error computed header dependencies required, but auto-check did not find them)
> > +endif
> >  endif
> 
> Yup, I like that, too.

I'm happy to submit that on top, or even turn the earlier hunk into a
patch.  But let's see what Ævar has to say to what's been discussed so
far. I don't want to derail his effort.

-Peff
