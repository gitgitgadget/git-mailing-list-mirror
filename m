Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA4EC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 13:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiLQNzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 08:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiLQNzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 08:55:03 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9049B13F11
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:55:02 -0800 (PST)
Received: (qmail 2083 invoked by uid 109); 17 Dec 2022 13:55:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Dec 2022 13:55:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23047 invoked by uid 111); 17 Dec 2022 13:55:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Dec 2022 08:55:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Dec 2022 08:55:01 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] git: remove unneeded casts
Message-ID: <Y53KNbX7SO+FOoKf@coredump.intra.peff.net>
References: <pull.1396.git.git.1671032126602.gitgitgadget@gmail.com>
 <Y5o9NNVx7dFLhIMd@coredump.intra.peff.net>
 <221215.86edt12bte.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221215.86edt12bte.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2022 at 11:07:24AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Excluding compat/ the diff is the below. Some of it's broken, but some
> of it suggests things that are worth picking up, e.g. the return value
> of xmalloc() being cast (a C++-ism), "(char *)NULL" (do we ever need to
> cast NULL?)

Yeah, getting rid of explicit casts to/from void (as in xmalloc()) is a
good thing, IMHO.

Casting NULL is trickier. In normal assignment, no, it should never be
needed. When passed to a variadic function (which covers all the cases
in your patch below), the compiler needs to know that it's a pointer,
and not the integer 0. So of the two allowed null pointer constants,
only one is guaranteed to work:

  execl(foo, 0); /* bad! there's nothing to say it's a pointer */
  execl(foo, (char *)0); /* ok */

though whether it matters in practice depends on your ABI, I think.

But what about NULL? My copy of C99 (7.17.3) says it "expands to an
implementation-defined null pointer constant". So it could be either of
those.

And that is backed up by looking at "git log -S')NULL'", which yields
5d314759d7 (Cast execl*() NULL sentinels to (char *), 2010-07-24).

That said, I think we have lots of bare NULLs passed to variadic
functions. Any function with LAST_ARG_MUST_BE_NULL will have a NULL in
each of its callers, and we do not bother casting most of them. So I
think this is one of those "technically could violate the standard, but
OK in practice" things.

-Peff
