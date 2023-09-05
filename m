Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64988C83F2C
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 15:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjIEP7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353715AbjIEHaS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 03:30:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA6E6
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 00:30:14 -0700 (PDT)
Received: (qmail 13729 invoked by uid 109); 5 Sep 2023 07:30:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Sep 2023 07:30:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19920 invoked by uid 111); 5 Sep 2023 07:30:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Sep 2023 03:30:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Sep 2023 03:30:13 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: allow branch selection through "vars"
Message-ID: <20230905073013.GI199565@coredump.intra.peff.net>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
 <20230830195113.GA1709824@coredump.intra.peff.net>
 <d000f469-2b7d-e037-c92e-013034490461@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d000f469-2b7d-e037-c92e-013034490461@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 03, 2023 at 10:59:37AM +0200, Johannes Schindelin wrote:

> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 1b41278a7f..c364abb8f8 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -21,6 +21,7 @@ concurrency:
> >  jobs:
> >    ci-config:
> >      name: config
> > +    if: vars.CI_BRANCHES == '' || contains(vars.CI_BRANCHES, github.ref_name)
> 
> This might be too loose a check, as branch names that are a substring of
> any name listed in `CI_BRANCHES` would be false positive match. For
> example, if `CI_BRANCHES` was set to `maint next seen`, a branch called
> `see` would be a false match.

Yes, I wrote it about it in the commit message. :)

My assumption is that this may be good enough, just because we are
realistically talking about the needs of a handful of Git developers.
Folks doing one-off patches would just push to their forks and get CI
(which they'd want in order to use GGG anyway). This is for people with
more exotic workflows, and my guess is that half a dozen people would
use this at all.

But we can make it more robust if we think somebody will actually run
into it in practice.

> Due to the absence of a `concat()` function (for more details, see
> https://docs.github.com/en/actions/learn-github-actions/expressions#functions),
> I fear that we'll have to resort to something like `contains(format(' {0} ',
> vars.CI_BRANCHES), format(' {0} ', github.ref_name))`.

Yeah, I had imagined checking startsWith() and endsWith(), but
auto-inserting the leading/trailing space as you suggest is even
shorter.

I think that contains() is more robust if used against an actual list
data structure.  But there doesn't seem to be any split()-type function.
So I don't see how to get one short of using fromJSON(). But coupled
with Phillip's use cases in the other part of the thread, maybe we
should have a JSON-formatted CI_CONFIG variable instead.

That requires the developer to hand-write a bit of JSON, but it's not
too bad (and again, I really think it's only a couple folks using this).

What do you think?

-Peff
