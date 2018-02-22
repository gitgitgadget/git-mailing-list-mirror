Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4F51F404
	for <e@80x24.org>; Thu, 22 Feb 2018 21:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeBVVoF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 16:44:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:33368 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751330AbeBVVoE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 16:44:04 -0500
Received: (qmail 1714 invoked by uid 109); 22 Feb 2018 21:44:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 21:44:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8375 invoked by uid 111); 22 Feb 2018 21:44:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 16:44:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 16:44:02 -0500
Date:   Thu, 22 Feb 2018 16:44:02 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180222214402.GA30638@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222212402.GB256918@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180222212402.GB256918@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 01:24:02PM -0800, Jonathan Nieder wrote:

> >                              But my greater concern is that people who
> > work on git.c should not have to worry about accidentally violating this
> > principle when they add a new feature or config option.
> 
> That sounds like a combination of (6) and insufficient documentation
> or tests.  Ideas for how we can help prevent such accidents?

I don't think it's insufficient tests. How can we test against some
problem in the untrusted repository when the feature that would trigger
it has not been written yet?

E.g., imagine we begin to allow alias.* to override command names in
git.c. Now suddenly setting "alias.upload-pack" is a vulnerability.
Should we add a test for that _now_ as a precaution? I don't think so,
because we can't guess what new features are going to be added. So we'd
be lucky if such a test actually did anything useful.

A comment could help, but it seems quite likely that whatever feature
somebody is adding might not be right next to that comment (and thus not
seen). I think we're mostly relying on institutional knowledge during
review to catch these things. Which is not great, but I'm not sure where
we'd document that knowledge that people would actually see it at the
right time.

> > In other words, it seems like an accident waiting to happen. I'd be more
> > amenable to it if there was some compelling reason for it to be a
> > builtin, but I don't see one listed in the commit message. I see only
> > "let's make it easier to share the code", which AFAICT is equally served
> > by just lib-ifying the code and calling it from the standalone
> > upload-pack.c.
> 
> If we have so little control of the common code used by git commands
> that could be invoked by a remote user, I think we're in trouble
> already.  I don't think being a builtin vs not makes that
> significantly different, since there are plenty of builtins that can
> be triggered by remote users.  Further, if we have so little control
> over the security properties of git.c, what hope do we have of making
> the rest of libgit.a usable in secure code?

I agree that the situation is already pretty dicey. But I also think
that using the git wrapper is more risky than the rest of libgit.a.
There's tons of dangerous code in libgit.a, but upload-pack is smart
enough not to call it. And people modifying upload-pack have a greater
chance of thinking about the security implications, because they know
they're working with upload-pack. Whereas people are likely to touch
git.c without considering upload-pack at all.

The big danger in libgit.a is from modifying some low-level code called
by upload-pack in a way that trusts the on-disk contents more than it
should. My gut says that's less likely, though certainly not impossible
(a likely candidate would perhaps be a ref backend config that opens up
holes; e.g., if you could point a database backend at some random path).

> In other words, having to pay more attention to the git wrapper from a
> security pov actually feels to me like a *good* thing.  The git
> wrapper is the entry point to almost all git commands.  If it is an
> accident waiting to happen, then anything that calls git commands is
> already an accident waiting to happen.  So how can we make it not an
> accident waiting to happen? :)

But I don't think it _is_ an accident waiting to happen for the rest of
the commands. upload-pack is special. The point is that people may touch
git.c thinking they are adding a nice new feature (like pager config, or
aliases, or default options, or whatever). And it _would_ be a nice new
feature for most commands, but not for upload-pack, because its
requirements are different.

So thinking about security in the git wrapper is just a burden for those
other commands.

> > There's not much point for receive-pack. It respects hooks, so any
> > security ship has already sailed there.
> 
> Yet there are plenty of cases where people who can push are not
> supposed to have root privilege.  I am not worried about hooks
> specifically (although the changes described at [1] might help and I
> still plan to work on those) but I am worried about e.g. commandline
> injection issues.  I don't think we can treat receive-pack as out of
> scope.
> 
> And to be clear, I don't think you were saying receive-pack *is* out
> of scope.  But you seem to be trying to draw some boundary, where I
> only see something fuzzier (e.g. if a bug only applies to
> receive-pack, then that certainly decreases its impact, but it doesn't
> make the impact go away).

Right, I think command-line injection is a separate issue. My concern is
_just_ about "can we be run against on-disk repo contents". And nothing
matters for receive-pack there, because you can already execute
arbitrary code with hooks.

-Peff
