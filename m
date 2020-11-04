Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DBCC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5EB2080D
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbgKDUww (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:52:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:48076 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgKDUwv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:52:51 -0500
Received: (qmail 11532 invoked by uid 109); 4 Nov 2020 20:52:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 20:52:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15975 invoked by uid 111); 4 Nov 2020 20:52:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 15:52:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 15:52:50 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 00/13] Add struct strmap and associated utility
 functions
Message-ID: <20201104205250.GF3629238@coredump.intra.peff.net>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 02, 2020 at 06:55:00PM +0000, Elijah Newren via GitGitGadget wrote:

> Changes since v2 (almost all of which were suggestions from Peff):

Thanks again for your work on this series, and your willingness to
listen to my various suggestions. ;)

This mostly looks good to me. I pointed out a few minor nits in reply to
individual patches, but there's at least one correctness problem, so
we'll need a v4.

> Things that I'm still unsure about:
> 
>  * strintmap_init() takes a default_value parameter, as suggested by Peff.
>    But this makes the function name strintmap_init_with_options() weird,
>    because strintmap_init() already takes one option, so it seems like the
>    name needs to replace "options" with "more_options". But that's kinda
>    ugly too. I'm guessing strintmap_init_with_options() is fine as-is, but
>    I'm wondering if anyone else thinks it looks weird and if so if there is
>    anything I should do about it.

You could drop default_value from strintmap_init_with_options(). I'd
_guess_ most callers would be happy with 0, but you'd know much better
than I what your first crop of callers will want.

I'm happy with it either way.

> Things Peff mentioned on v2 that I did NOT do:
> 
>  * Peff brought up some questions about mapping strintmap to an int rather
>    than an unsigned or intptr_t. I discussed my rationale in the thread

Yeah, I'm well convinced that what you have here is fine.

> Things Peff mentioned on v1 that are still not included and which Peff
> didn't comment on for v2, but which may still be worth mentioning again:
> 
>  * Peff brought up the idea of having a free_values member instead of having
>    a free_values parameter to strmap_clear(). That'd just mean moving the
>    parameter from strmap_clear() to strmap_init() and would be easy to do,
>    but he sounded like he was just throwing it out as an idea and I didn't
>    have a strong opinion, so I left it as-is. If others have
>    opinions/preferences, changing it is easy right now.

Yeah, I was mostly thinking out loud. What you have here looks fine to
me.

>  * Peff early on wanted the strmap_entry type to have a char key[FLEX_ALLOC]
>    instead of having a (const) char *key. I spent a couple more days on this
>    despite him not mentioning it while reviewing v2, and finally got it
>    working this time and running valgrind-free. Note that such a change
>    means always copying the key instead of allowing it as an option. After
>    implementing it, I timed it and it slowed down my important testcase by
>    just over 6%. So I chucked it. I think the FLEXPTR_ALLOC_STR usage in
>    combination with defaulting to strdup_strings=1 gives us most the
>    benefits Peff wanted, while still allowing merge-ort to reuse strings
>    when it's important.

Yes, I'd agree that FLEXPTR is a good middle ground. If I really manage
to find a caller later where I think the complexity might be worth
saving a few bytes, perhaps I'll try it then and get some real
measurements. My guess is that won't ever actually happen. :)

-Peff
