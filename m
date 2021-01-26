Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA97C41620
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AD920679
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbhAZWFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:05:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:39760 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbhAZVRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 16:17:25 -0500
Received: (qmail 26772 invoked by uid 109); 26 Jan 2021 21:16:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Jan 2021 21:16:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3737 invoked by uid 111); 26 Jan 2021 21:16:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 16:16:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 16:16:37 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Makefile: micro-optimize light non-test builds
Message-ID: <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
References: <20210126160708.20903-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126160708.20903-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 05:07:04PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This small series speeds up builds where you just want to get to a
> working "git" binary, but don't care about running git's own tests, or
> about making/installing fallbacks for "git svn" et al (which we do
> even with NO_PERL).

I have to wonder if you really care about non-builtins here. If not,
then doesn't "make git" do what you want?

I recently did something similar, but a bit more extreme. I have a
100-patch series introducing annotations/fixes for -Wunused-parameter. I
rebased it on master, and the end result had a compile error (a
previously unused and annotated parameter became used). So I wanted not
just to fix it, but to put the fix in the right commit.

Doing:

  git rebase -x 'make -j16'

builds each commit and stops when we hit the breakage, which is nice.
But it takes a while to build, and a non-trivial bit of time is spent
generating libgit.a, running the linker, making builtin hardlinks, etc.

I ended up putting:

  objects: $(LIB_OBJS) $(BUILTIN_OBJS) git.o

into my config.mak, and then "make objects" is quite fast. Probably too
gross a hack to carry in our Makefile, but I was tempted to send it.

-Peff
