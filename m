Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F689EE0212
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 00:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjINAaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 20:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINAaP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 20:30:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983351720
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 17:30:11 -0700 (PDT)
Received: (qmail 25514 invoked by uid 109); 14 Sep 2023 00:30:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Sep 2023 00:30:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1886 invoked by uid 111); 14 Sep 2023 00:30:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Sep 2023 20:30:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Sep 2023 20:30:10 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] replacing ci/config/allow-ref with a repo variable
Message-ID: <20230914003010.GA1709842@coredump.intra.peff.net>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
 <8624fc43-ab42-442b-a141-851fc35dd24f@gmail.com>
 <20230901173214.GA1947546@coredump.intra.peff.net>
 <d3d1109b-3a1f-4e8b-be8d-6581d45f1b81@gmail.com>
 <20230905072444.GH199565@coredump.intra.peff.net>
 <fcdc682b-cf6c-4db9-9970-be136f48de58@gmail.com>
 <20230911093616.GA1605460@coredump.intra.peff.net>
 <59b423e9-d99e-4817-8a33-c50419593740@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59b423e9-d99e-4817-8a33-c50419593740@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2023 at 04:16:48PM +0100, Phillip Wood wrote:

> On 11/09/2023 10:36, Jeff King wrote:
> > On Thu, Sep 07, 2023 at 11:04:33AM +0100, Phillip Wood wrote:
> > Looking at the ci-config branch of phillipwood/git.git, I see this in
> > your allow-refs:
> > 
> >        refs/heads/main|refs/heads/master|refs/heads/maint|refs/heads/next|refs/heads/seen|refs/tags/gitgui-*|refs/tags/pr-[0-9]*|refs/tags/v[1-9].*)
> > 
> > So you do use multiple prefixes, though all in refs/tags/.  Do you
> > actually push tags for which you do want to run CI,
> 
> Yes, but not very often - I could probably just reject all tags and start
> the CI manually when I want it (assuming that's an option). Thanks for
> digging into the various options, it sounds like it is possible so long as
> we don't want multiple prefixes.

I'll additionally have to switch to using the full refname in the
matches, but that is probably a reasonable thing to do anyway (it makes
config a bit more verbose, but it is obviously much more flexible).

We can do the loop-unroll thing if we really want to support multiple
prefixes, but if you're OK with it, let's try the single-prefix way and
see if anybody runs into problems (I'm still convinced there's only a
few of us using this stuff anyway). I'm hesitant to do the unroll just
because it requires picking a maximum value, with a bizarre failure if
you happen to have 4 prefixes or whatever.

I'll see if I can polish up what I showed earlier into a patch.

(BTW, one other thing I tried was using fromJSON(vars.CI_CONFIG) in the
"on" expression, which in theory would allow globbing. But it doesn't
look like expressions work at all in that context. And even if they did,
I'm not sure we could make it work such that an empty CI_CONFIG used
some defaults, since there's no conditional-expression ternary
operator).

> Aside: what I'd really like is to be able to set an environment variable
> when I push to skip or force the CI
> 
> 	GITHUB_SKIP_CI=1 git push github ...
> 
> but that would require support from the git client, the protocol and the
> server.

We have the necessary bits at the protocol: push-options. But it's up to
the server-side hooks to decide which ones are meaningful and to do
something useful with them. It looks like GitLab supports:

  git push -o ci.skip=1 ...

but I don't think GitHub respects any equivalent option.

-Peff
