Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CB7C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 04:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBOEVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 23:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjBOEVY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 23:21:24 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07429359F
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 20:21:18 -0800 (PST)
Received: (qmail 5753 invoked by uid 109); 15 Feb 2023 04:21:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Feb 2023 04:21:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9684 invoked by uid 111); 15 Feb 2023 04:21:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Feb 2023 23:21:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Feb 2023 23:21:17 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, John Cai <johncai86@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Message-ID: <Y+xdvck3ZKZCewim@coredump.intra.peff.net>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
 <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
 <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com>
 <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk>
 <Y+b2l4Le2gTxGwO8@coredump.intra.peff.net>
 <CABPp-BFnCzWH6Aai0ZYv1fR7GMfXqiAE3n8q1Gcrhh-Zv_wTjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFnCzWH6Aai0ZYv1fR7GMfXqiAE3n8q1Gcrhh-Zv_wTjA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 06:35:00PM -0800, Elijah Newren wrote:

> > Just a small counter-point, since I happened to be looking at myers vs
> > patience for something elsewhere in the thread, but:
> >
> >   git show 35bd13fcd2caa4185bf3729655ca20b6a5fe9b6f builtin/add.c
> 
> "fatal: bad object 35bd13fcd2caa4185bf3729655ca20b6a5fe9b6f"
> 
> Is that a local commit of yours?

Oh, sorry. It's not my commit, but it may have been something I picked
up off the list. The version from Junio is 20b813d7d3d.

>    * They had two people annotating the diffs and independently
> scoring them, and then checked for agreement between their answers
> afterwards.  (No, they didn't always agree, but they did have
> substantial agreement.)

Kind of a weird methodology. I'd think you'd do better to put those
diffs in front of a lot of people to get a consensus. But OK...

> For the (again, non-identical) diffs modifying non-code, they found
> (see table 11) that:
>    * 14.9% of the myers diffs are better
>    * 13.4% of the histogram diffs are better
>    * 71.6% of the diffs have equal quality
> 
> For the (non-identical) diffs modifying code, they found (again, see
> table 11) that:
>    * 16.9% of the myers diffs are better
>    * 62.6% of the histogram diffs are better
>    * 20.6% of the diffs have equal quality
> 
> A ratio of 4 to 1 for histogram being better on code diffs is pretty
> weighty to me.

Interesting. They do slightly worse on non-code, but probably not enough
to worry about.

Despite my complaint above, I do find those results compelling. Or at
least, it is much closer to being real data than anything I have seen
before, so it seems like the best guide we have. :)

Like I said, I don't have a very strong opinion myself. Mostly I wanted
to note that while it is easy for us to remember the times we saw a
Myers diff, said "yuck", and tried patience and it was better, most of
us may be blind to the opposite case. If patience is not the default,
most of us would not have hit "yuck" case for it at all.

FWIW, I coincidentally hit this case earlier today where patience does a
_much_ better job than myers:

  https://lore.kernel.org/git/Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net/

So don't count me as an objection, but just a curious observer. ;)

-Peff
