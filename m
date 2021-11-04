Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87630C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 10:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5CF611C9
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 10:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhKDKUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 06:20:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:52986 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbhKDKUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 06:20:11 -0400
Received: (qmail 8363 invoked by uid 109); 4 Nov 2021 10:17:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 10:17:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32476 invoked by uid 111); 4 Nov 2021 10:17:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Nov 2021 06:17:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Nov 2021 06:17:33 -0400
From:   Jeff King <peff@peff.net>
To:     Cyrus Vafadari <cvafadari@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Checkout tracking behavior with <start_point>?
Message-ID: <YYOzPVi5TAoyGNAs@coredump.intra.peff.net>
References: <CAMd+_QCDN5UwwC=ZRcT4Y3p1x7kCQ1TEVf5321Ykx4xrhv-YOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMd+_QCDN5UwwC=ZRcT4Y3p1x7kCQ1TEVf5321Ykx4xrhv-YOA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 11:08:29AM -0400, Cyrus Vafadari wrote:

> I am an avid user of this pattern: "git checkout -b my_branch
> upstream/3.2.x", using "start_point" to build my backported patch
> against an old feature version. But in this case, the default tracking
> is against 3.2.x, rather than my new feature branch. So, then, when I
> push I specify to update the tracking against the new branch name.
> There are also various default behaviors for push, which I won't
> enumerate here, but in the end I need to specify tracking.
> 
> I'm wondering if there is some usage/pattern I'm missing?

I think it all depends on your workflows and how you use the upstream
information. For instance, I start most of my branches off of the tip of
the remote master, similar to you:

  git checkout -b my-topic origin/master

I want to keep that as the upstream for various commands. E.g.,
"git-rebase -i" will use the fork point of the branch by default,
without even having to say "@{upstream}".

When I push, it goes to a remote branch with a matching name (because I
have push.default set to "current"). If I want to look at the
remote-repo version (say, to compare what's happened since I last
pushed), I use the "@{push}" shortcut to refer to it (rather than
"@{upstream}"). So for example I often do:

  git range-diff @{push}...HEAD

to see what hasn't yet been pushed (range-diff rather than a regular
"log" because I'm usually rewriting commits via rebase).

Now that's just what _I_ do. There's nothing wrong with setting the
upstream to the push destination if your workflows prefer that (e.g.,
because you are collaborating with somebody else on the branch and want
to be able to pull or rebase just the parts that haven't been pushed).
And that's why we have "push -u".

But no, I don't think there's a way to set the upstream to that push
destination at the time you run "git checkout". I don't think it would
be an unreasonable config option to have. Once upon a time it was very
tricky to say "the thing that I would push to by default", because those
rules were all just encoded inside of git-push. But these days you
should be able to reuse the logic that powers @{push}.

-Peff
