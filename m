Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA657C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FA224679
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA0XKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:10:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:45790 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726164AbgA0XKI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 18:10:08 -0500
Received: (qmail 4671 invoked by uid 109); 27 Jan 2020 23:10:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Jan 2020 23:10:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2018 invoked by uid 111); 27 Jan 2020 23:17:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jan 2020 18:17:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jan 2020 18:10:07 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200127231007.GB19360@coredump.intra.peff.net>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200109081150.GC3978837@coredump.intra.peff.net>
 <20200116223800.GM181522@google.com>
 <20200117210319.GA15460@coredump.intra.peff.net>
 <20200127222019.GA233139@google.com>
 <20200127224914.GB233139@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127224914.GB233139@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 02:49:14PM -0800, Emily Shaffer wrote:

> > >   - make sure that .gitmodules has enough information about which branch
> > >     to use for each submodule
> > 
> > Hum. I don't work with them day to day, but aren't we already in that
> > state? Is that not what the 'branch' option for each submodule means?
> 
> I've been corrected off-list that the 'branch' in .gitmodules is used
> during 'git submodule update --remote', but not during 'git submodule
> init' or 'git clone --recurse-submodules'. Then, for the problem in
> discussion for this thread, it seems like a better choice is something
> like 'git clone --recurse-submdoules --use-gitmodules' or whatever we
> want to call it - e.g., rather than fetching the branch where the server
> knows HEAD, ask the .gitmodules to figure out which branch?

Oof, I should have read this message before responding to the other one. ;)

> It seems like that ought to live separately from --single-branch. In the
> case where you very strictly only want to fetch one branch (not two
> branches) I suppose you'd want something like 'git clone
> --recurse-submodules --single-branch --branch=mysuperprojectbranch
> --use-gitmodules' to make sure that only one branch per repo comes down.
> 
> With n submodules of various naming schemas, provenance, etc., I don't
> think there's a good case for recursing --branch one way or another; it
> seems like filling out some config is the way to go.

Yeah, I do still think that it makes sense for clone to pass along
--single-branch, regardless, and then deal with branch selection problem
separately on top.

> I guess we could also teach it to take some input like
> --submodule-branch-spec=foo.txt, and/or a multiply provided
> --submodule-branch foo=foobranch --submodule-branch bar/baz=bazbranch.
> 
>   [foo.txt]
>   foo=foobranch
>   bar/baz=bazbranch
> 
> With that approach, then someone gets a little more flexibility than
> relying on what the .gitmodules has set up.

Yeah, I agree that the most general form is being able to specify the
mapping for each individually. At first I wondered why you'd ever _not_
want to just use the branches specified in .gitmodules. But I suppose
that gets embedded in the superproject history, which gets awkward as
those commits move between branches. E.g., for an android-like project,
you don't want to make a commit that says "use branch devel for all
submodules" on the devel branch of your superproject. Eventually that
will get merged to master, and you'd have to remember to switch it back
to "master".

So for the simple case, you probably do want to be able to say "use this
branch for cloning all submodules".

For the complex cases, you'd need that full mapping. But I think it may
be worth it to punt on that for now. Even if we eventually added such a
feature, I think we'd still want the simpler version anyway (because
when you _can_ use it, it's going to be much easier). So there's nothing
lost by doing the minimal thing now and waiting to see if more complex
use cases even show up.

Another thing occurs to me, though: should the binding of this submodule
default branch be written to disk (e.g., a config option)? I'm thinking
specifically that if you do:

  git clone --submodule-branch=devel -b devel superproject

and then later, you "git fetch" and find that somebody has added a new
submodule, you'd presumably want the devel branch of that, too?

-Peff
