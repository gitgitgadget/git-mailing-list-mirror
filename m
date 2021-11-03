Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE3FC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EE861058
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhKCLdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 07:33:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:52088 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhKCLdS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 07:33:18 -0400
Received: (qmail 4996 invoked by uid 109); 3 Nov 2021 11:30:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Nov 2021 11:30:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18457 invoked by uid 111); 3 Nov 2021 11:30:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Nov 2021 07:30:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Nov 2021 07:30:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: replace most hardcoded object lists with
 $(wildcard)
Message-ID: <YYJy4BuX6JI6p+aV@coredump.intra.peff.net>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <YX5T+wt0hSkxkLHA@coredump.intra.peff.net>
 <211031.86a6ip47ib.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211031.86a6ip47ib.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 31, 2021 at 02:00:42PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Likewise, they could go into a conditional-src/ directory (or some
> > less-horrible name) to keep them distinct without needing an explicit
> > list in the Makefile. That's sort of the flip-side of putting all the
> > other LIB_OBJS ones into lib/.
> 
> The goal here was just to get us rid of tiresome merge conflicts when
> two things are added to adjacent part of these lists going forward,
> rather than some source-tree reorganization. I didn't search around and
> didn't find that 2011-era thread.

Right, sorry, I didn't mean to sidetrack. That was just the only
discussion I could find on the topic. I agree that it's worth
considering the two topics (moving files around vs Makefile changes)
separately.

> Even if we carefully trickle those in at a rate that doesn't conflict
> with anything in-flight, the end result will be that e.g.:
> 
>     git log -- lib/grep.c
> 
> Will stop at that rename commit, similar to builtin/log.c, unless you
> specify --follow etc. Just that doesn't make it worth it to me. Likewise
> sha1_file.c to sha1-file.c to object-file.c, which is a case I run into
> every time I get a "git log" pathspec glob wrong.

Agreed. One of the arguments back when we started to move around a few
files is that this dog-fooding would encourage us to make --follow mode
better. That hasn't really happened, though.

> I didn't notice before submitting this but this patch breaks the
> vs-build job, because the cmake build in "contrib" is screen-scraping
> the Makefile[1].
> 
> What's the status of that code? It's rather tiresome to need to patch
> two independent and incompatible build systems every time there's some
> structural change in the Makefile.

My opinion when we took in the cmake topic was that it would be OK for
people working on the main Makefile to break cmake. It's an add-on and
the people who care about cmake are the ones who will do the work to
track the Makefile.

But since there's a CI job that will nag you if it fails, that kind of
makes it everybody's problem in practice. That doesn't change my opinion
on how things _should_ work, but I have done small fixups as necessary
to stop the nagging.

> I hadn't looked in any detail at that recipe before, but it the vs-build
> job has a hard dependency on GNU make anyway, since we use it for "make
> artifacts-tar".
> 
> So whatever cmake special-sauce is happening there I don't see why
> vs-build couldn't call out "make" for most of the work it's doing, isn't
> it just some replacement for what the "vcxproj" target in
> config.mak.uname used to do?

The big question for me is whether that really is a hard dependency.
Obviously "make artifacts-tar" is for the CI job, but is the cmake stuff
supposed to work for regular users without relying on having GNU make at
all? I have no clue.

-Peff
