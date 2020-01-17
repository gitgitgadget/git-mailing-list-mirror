Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7272C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56A62083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgAQVDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:03:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:39196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729799AbgAQVDU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 16:03:20 -0500
Received: (qmail 13550 invoked by uid 109); 17 Jan 2020 21:03:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Jan 2020 21:03:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19488 invoked by uid 111); 17 Jan 2020 21:09:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2020 16:09:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Jan 2020 16:03:19 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200117210319.GA15460@coredump.intra.peff.net>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200109081150.GC3978837@coredump.intra.peff.net>
 <20200116223800.GM181522@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200116223800.GM181522@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 16, 2020 at 02:38:00PM -0800, Emily Shaffer wrote:

> > I have no idea how common this kind of thing would be, and I expect in
> > most cases your patch would do what people want. But we might need to be
> > better about retrying without those options when the first clone fails.
> 
> Yeah, that's interesting. A retry sounds like a pretty solid approach,
> although if someone's being cautious and using --single-branch I wonder
> if that's really something they want (since that's avoiding grabbing
> extraneous branches).
> 
> I suppose at the very least, --single-branch without --branch should
> become recursive. Whether --branch should become recursive, I'm not
> totally sure.

Yeah, I think it may be worth separating out how to think about the two
options. It's a lot more plausible to me that --single-branch would want
to recurse than --branch.

> The two scenarios I see in conflict are this:
> - Superproject branch "foo"
>   - submodule A branch "foo"
>   - submodule B branch "foo"
> and
> - Superproject branch "foo"
>   - submodule A branch "bar"
>   - submodule B branch "baz"
> 
> If we propagate --branch, the first scenario Just Works, and the second
> scenario requires something like:
> 
>  git clone --recurse-submodules=no --single-branch --branch foo https://superproject
>  git submodule update --init --single-branch --branch bar A/
>  git submodule update --init --single-branch --branch baz B/
> 
> (I guess if the superproject knows what branch it wants for all the submodules,
> you could also just do "git submodule update --init --single-branch" and
> have it go and ask for all of them.)
> 
> If we don't propagate --branch, the second scenario Just Works, and the
> first scenario requires something like:
> 
>  git clone --recurse-submodules=no --single-branch --branch foo https://superproject
>  git submodule update --init --single-branch --branch foo
> 
> (That is, I think as long as 'update' takes --branch, even if it's not
> passed along by 'clone', it should still work OK when delegating to
> everyone.)
> 
> Let me know if I misunderstood what you were worried about.

Right, that's exactly my concern. You're making one case work but
breaking the other.

It really seems like there's no particular reason to assume that the
superproject branch corresponds to the submodule branch (or even
submodules of submodules). I imagine it would in some cases (like trying
to replace the use of "repo" in Android), but that's just one model.

It would make more sense to me to either (or both):

  - make sure that .gitmodules has enough information about which branch
    to use for each submodule

  - offer an extra option for the default branch to use for any
    submodules. This is still not general enough to cover all situations
    (e.g., the bar/baz you showed above), but it at least makes it
    relatively easy to cover the simple cases, without breaking any
    existing ones.

-Peff
