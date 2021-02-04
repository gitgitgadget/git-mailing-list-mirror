Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D988C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 06:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4388D64E4D
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 06:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhBDGvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 01:51:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:50078 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhBDGvn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 01:51:43 -0500
Received: (qmail 2538 invoked by uid 109); 4 Feb 2021 06:51:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Feb 2021 06:51:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11835 invoked by uid 111); 4 Feb 2021 06:51:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Feb 2021 01:51:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Feb 2021 01:51:01 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] Makefile: remove "all" on "$(FUZZ_OBJS)"
Message-ID: <YBuZVfnc0ECuoKkK@coredump.intra.peff.net>
References: <20210128182310.26787-1-avarab@gmail.com>
 <20210201111715.10200-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210201111715.10200-2-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 12:17:10PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Adding this as a dependency was intentionally done in
> 5e472150800 (fuzz: add basic fuzz testing target., 2018-10-12).
> 
> I don't see why we need to prevent bitrot here under "all" for these
> in particular, but not e.g. contrib/credential/**/*.c
> 
> In any case, these files are rather trivial and from their commit log
> it seems the fuzz-all target is run by a few people already.

Part of me wants to love this commit, because I don't care about the
fuzz code (since I don't run it myself[1]).

But looking at "git log fuzz-*.c", I do think it will lead to bitrot.
Many of those commits are things that do not care about fuzzing, but
were just fixing up function interfaces as we go (e.g., my c8828530b,
though see [2]).

The difference between contrib/credential/ and this is that those
credential helpers do not rely on the rest of the source. They are
independent programs that can be built totally out of tree.

So I dunno. This puts the responsibility for fixing bitrot onto the
people who actually use them, which is nice. But often times it is
easier for the person making the original change to just fix them up
along with the others (because they understand the point of the change
better, and also because a bunch of rot doesn't accrue over time).

-Peff

[1] I just ran "make fuzz-all", and it barfed at the link step. It looks
    like I need to specify a bunch of llvm stuff manually. So no, I'd
    guess not a lot of people are running this. :)

[2] That one is particularly egregious because it fixed a copy-pasted
    version of a public function header. Yuck.
