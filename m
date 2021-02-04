Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D238C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 07:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9E364F47
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 07:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhBDHHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 02:07:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:50088 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhBDHGz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 02:06:55 -0500
Received: (qmail 2560 invoked by uid 109); 4 Feb 2021 07:06:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Feb 2021 07:06:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11897 invoked by uid 111); 4 Feb 2021 07:06:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Feb 2021 02:06:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Feb 2021 02:06:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Makefile: add {program,xdiff,test,git}-objs &
 objects targets
Message-ID: <YBuc5iOCCHk4fPqs@coredump.intra.peff.net>
References: <20210128182310.26787-1-avarab@gmail.com>
 <20210201111715.10200-1-avarab@gmail.com>
 <xmqqft2edkfg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqft2edkfg.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 05:11:47PM -0800, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > A re-send of v1
> > (https://lore.kernel.org/git/20210128182310.26787-1-avarab@gmail.com)
> > + a trivial whitespace fix in 2/6.
> 
> I'll reproduce what it said for those who are reading from
> sidelines:
> 
>     As noted there I can just run "make git", which I'd somehow managed to
>     miss. So that complexity isn't needed.
> 
>     But Jeff King suggested a hack to just get you to the point of
>     git.o. I don't need that right now, but that seems sensible, so I
>     implemented it.
> 
>     At the start of this series I've got a patch to make "all" stop
>     redundantly depending on "FUZZ_OBJS", which also helps with such
>     "rebase -i --exec=..." use-cases.
> 
> I do not see much point in the goal, not quite.  You can do "make
> git.o" and "make git" and you do not have to build unrelated things.
> 
> Isn't that already happening at the tip of 'master' (or 'maint'), or
> am I missing something?

I guess I can take some of the blame since my name came up in the
justification above. ;)

The original use case I presented was quickly sifting through a series
of commits for "oops, which one broke the compile". And so I wanted
something like "make objects" to test each one as quickly as possible.
And while that's a useful (if ugly) goal, I think it was misguided:

  - I usually know where the breakage is (after all, I saw it in the end
    state). So "make foo.o" would be faster still! (it would be even
    more so if the Makefile didn't insist on running GIT-VERSION-GEN,
    but that's another story).

  - the link step in "make git" is not that much slower than building
    the objects. And it catches more breakages (like undefined
    functions). It doesn't catch problems in non-builtins, though.

  - really, "make all" is not even that much slower than "make git".
    It's a 200ms difference on my machine (wall-clock; "make -j16" helps
    a lot here). That adds up if you are testing 100 commits, but it
    probably isn't worth thinking too hard about.

I do like the cleanups earlier in the series (I have mixed feelings on
the first patch, though; see my comments there).

-Peff
