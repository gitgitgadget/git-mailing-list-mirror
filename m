Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7D7C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D51261211
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhKDKB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 06:01:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:52972 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhKDKB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 06:01:29 -0400
Received: (qmail 8283 invoked by uid 109); 4 Nov 2021 09:58:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 09:58:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32311 invoked by uid 111); 4 Nov 2021 09:58:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Nov 2021 05:58:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Nov 2021 05:58:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alejandro Sanchez <asanchez1987@gmail.com>
Subject: Re: [PATCH 2/2] prompt.c: add and use a GIT_TEST_TERMINAL_PROMPT=true
Message-ID: <YYOu2i48Br9sOz4V@coredump.intra.peff.net>
References: <20190524062724.GC25694@sigill.intra.peff.net>
 <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
 <patch-2.2-964e7f4531f-20211102T155046Z-avarab@gmail.com>
 <YYJ5IpvGRoDvp8V6@coredump.intra.peff.net>
 <211103.864k8tjmmp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211103.864k8tjmmp.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 04:12:43PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I'm fine with it either way, my reading of your 2019-ish commits was
> that you did that not to intentionally get that behavior, but to work
> around that test issue.
> 
> So we do always want the "read from stdin" behavior, so I can get those
> bisect tests by just changing its behavior too, with no need for the
> test variable? If so I'm fine with that.

Yes. The thing that makes it OK to do from a backwards-compatibility
standpoint is that even though the tools read from /dev/tty now, they
also insist that stdin is a tty. So in practice it will always be the
same thing (technically you _could_ redirect stdin from a different tty,
but that's sufficiently bizarre that I think we can discount it).

> I think it's a good thing in general to have a not-for-password
> git_prompt() API, because it makes it easy to make that use some
> readline-like API, i.e. one that would have tab completion, and handle
> the loop some (but not all) callers have around handling retries etc,
> we'd also be able to translate the "Y" "n" characters...

Yeah, I'd be OK with that direction, but I think it is not really the
same thing that the existing git_prompt() was designed for (where you
most certainly don't want readline-ish things like history for your
password).

Perhaps a good first step is not so much splitting git_prompt() into two
pieces, as simply renaming it in place. It really was designed for the
credential request and not much else, but the name is a bit more
generic.

But I'd probably wait on that until we were looking at actually adding a
functional readline-ish interface before even doing that.

-Peff
