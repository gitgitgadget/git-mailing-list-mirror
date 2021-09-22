Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F4C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A886060527
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhIVRzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:55:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:52714 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhIVRzN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 13:55:13 -0400
Received: (qmail 10224 invoked by uid 109); 22 Sep 2021 17:53:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 17:53:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15999 invoked by uid 111); 22 Sep 2021 17:53:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Sep 2021 13:53:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Sep 2021 13:53:42 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 0/3] Makefile: make "sparse" and "hdr-check" non-.PHONY
Message-ID: <YUttpgkU6eCOxMj/@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <YUqQzn5vFDpbF5dM@coredump.intra.peff.net>
 <c13b050c-abb9-c669-b92c-930f2b43ce10@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c13b050c-abb9-c669-b92c-930f2b43ce10@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 05:58:16PM +0100, Ramsay Jones wrote:

> > All three seem pretty reasonable to me.
> 
> Heh, interesting. My initial reaction was completely negative! ;-P
> (and not just mildly negative either, but 'you must be kidding').
> 
> However, I then thought 'I must be missing something, I'm being
> stupid and about to embarrass myself in public!'. So, I have
> been trying hard to understand what these patches are trying to
> accomplish and just what it is I'm missing. But, I'm coming up
> blank ...

I think the point is just avoiding repeated work. If you just manually
run "make sparse" once in a while, then caching the result probably
isn't of much value. But if you plan to run, say:

  git rebase -x 'make sparse'

then it would be nice for it to avoid checking the same files over and
over.

> At the heart of my unease is dependencies (or rather the lack) for
> the 'synthetic object files' *.hco and *.sp. (Also, the addition
> of even more 'shrapnel' to the build directories - I wrote a patch
> to remove the useless *.hcc files just after commit b503a2d515e was
> included, but didn't get around to submitting it).

I don't consider them shrapnel if they're holding useful results. :) But
I agree that this does make "ls" in the top-level increasingly cluttered
(curiously, I find that's something I rarely do, but probably because
I'm so used to knowing where everything is in this project).

Perhaps writing them to build-cruft/%.hco instead would help there. I
guess there may be some complications around directory creation.

But overall, I do agree that if we can't make the dependencies solid
here, this is not worth doing. Sacrificing correctness of the checks for
reduced computation is not a good idea.

> Hmm, odd:
>   
>   $ find . -iname '*.hcc' | sed s/.hcc// | sort >zz
>   $ find . -iname '*.hco' | sed s/.hco// | sort >xx
>   $ diff zz xx
>   90d89
>   < ./merge-strategies
>   137d135
>   < ./reftable/slice
>   152d149
>   < ./sha1-lookup
>   198,202d194
>   < ./vcs-svn/fast_export
>   < ./vcs-svn/line_buffer
>   < ./vcs-svn/sliding_window
>   < ./vcs-svn/svndiff
>   < ./vcs-svn/svndump
>   $ 
> 
> ... just noticed in passing, I didn't investigate.

I think some of that is cruft from old runs. We no longer have
vcs-svn/*.c at all, for example.

> Now, by definition, every '*.hcc' file depends on git-compat-util.h, so
> after changing that header an 'hdr-check' should check every header:
> 
>   $ touch git-compat-util.h
>   $ make hdr-check
>       HDR git-compat-util.h
>   $ 

Yeah, I think this is similar to the header-dependency thing I brought
up for the sparse files. My thinking was that it wouldn't matter for the
hdr-check, because by definition if a header you include changes, then
we'd check it independently. But it's possible for foo.h to be fine
itself, but bar.h which includes it to fail because of a change in foo.h
(e.g., removing a type declaration).

> Hmm, not quite. So, the sparse target should have similar problems:
>   
>   $ make sparse
>       * new build flags
>       SP abspath.c
>   ...
>       SP remote-curl.c
>   $ 
> 
> OK, that works.

Sort of. Your "new build flags" is what saved you there, which was
triggered by something outside of your example commands. :)

As you saw below (and I showed in my earlier email), it doesn't work in
the general case.

>   $ make clean
>   ...
>   rm -f GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
>   $ find . -iname '*.sp' | wc -l
>   452
>   $ 
>  
> Ah, yes, you may want to add the removal of the 'synthetic objects' to the
> make clean target!

Agreed.

> As I said, I don't quite understand what these patches want to do, so I can't
> offer any solutions. :( Well, you could *add* the necessary dependencies,
> of course, but that could lead to a rabbit hole which I would not want to
> go down!

I think depending on the ".o", as I mentioned earlier, is a good way of
quickly getting those dependencies without having to specify any logic.
Even though we don't use the ".o" file itself, it's a proxy for "all the
things the .c file depends on".

-Peff
