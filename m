Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EE0C32771
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 01:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329D2214AF
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 01:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgA1Bbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:31:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:45904 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728277AbgA1Bbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 20:31:41 -0500
Received: (qmail 5392 invoked by uid 109); 28 Jan 2020 01:31:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Jan 2020 01:31:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2932 invoked by uid 111); 28 Jan 2020 01:39:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jan 2020 20:39:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jan 2020 20:31:39 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200128013139.GA38223@coredump.intra.peff.net>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200109081150.GC3978837@coredump.intra.peff.net>
 <20200116223800.GM181522@google.com>
 <20200117210319.GA15460@coredump.intra.peff.net>
 <20200127222019.GA233139@google.com>
 <20200127224914.GB233139@google.com>
 <20200127231007.GB19360@coredump.intra.peff.net>
 <20200128010841.GD233139@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200128010841.GD233139@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 05:08:41PM -0800, Emily Shaffer wrote:

> > Yeah, I do still think that it makes sense for clone to pass along
> > --single-branch, regardless, and then deal with branch selection problem
> > separately on top.
> 
> Sure; I've got that ready to send shortly. It seems to grab HEAD of the
> remote for each submodule, and then checkout the specific commit ID the
> superproject wants - in my test case, that commit ID was a direct
> ancestor of 'master', so the single branch only got 'master'. I'm not
> sure how it would work with a commit ID which doesn't exist in the
> single branch that was fetched; I'll write a test and have a look.

Yeah, it's definitely worth exploring how that works. I thought we had
some kind of fallback for when we didn't manage to fetch the object. But
maybe I am confusing it with the fallback for "we tried to fetch this
specific object, but the other side doesn't allow that, so we grabbed a
branch instead".

> > So for the simple case, you probably do want to be able to say "use this
> > branch for cloning all submodules".
> 
> I think it still makes sense to call this out explicitly, yes? Or do you
> think that should just be the default?

Yes, I think it should be a separate option from "--branch".

> This made me think - I wonder if it makes sense to take
> --submodule-branch as a wildcarded spec instead. So in your case, I
> could say,
> 
>   git clone --submodule-branch *=devel -b devel superproject
> 
> And then I don't need to do anything differently for 'git fetch' later.
> This also opens the door for some repos getting special treatment:
> 
>   git clone --submodule-branch-file=foo.txt -b dev example
> 
>   foo.txt:
>   curl=stable-1.2.3
>   nlohmann=v2.28
>   example-*=dev
>   *=master

If we write it all as config, I think things may get simpler. IIRC,
there is already submodule.*.foo config in .git/config (that can mirror
and override what's in .gitmodules).

So if we had some config option for "clone this branch for the submodule
instead of HEAD", then that means you can do:

  git clone -c submodule.foo.clonehead=devel ...

and the result would be used by the submodule code, but also saved for
future invocations. Likewise, if there's no "clonehead" config for a
particular submodule, if we fall back to submodule.defaultclonehead,
then you could do:

  git clone -c submodule.defaultclonehead=devel ...

and it would also be saved as the default for future submodules.  And
all without having to invent a new submodule-branch-file format.

The name "clonehead" isn't great. I'm not sure if this ought to be
submodule.*.branch (since I don't quite know what that's used for). I
think you'll have to explore that a bit.

> I think that also tends to match the glob-expansion configs we use for
> other things. One thing sticking out to me about the idea of providing
> --submodule-branch is that you need to know what's in the repo before
> you clone it the first time, which being able to use globbing like this
> kind of helps with. But then, I suppose if you don't know what you're
> looking for, you're not also looking for a very precise filter on your
> clone ;)

Yeah; the scheme I outlined above only allow specifying the value for
one submodule, or the fallback default. It wouldn't allow arbitrary
globbing. But I also suspect nobody wants that. If you know what the
submodules are, then you can set up config for each. If you don't, then
"everything" is the only glob that makes sense.

-Peff
