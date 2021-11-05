Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97572C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 08:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695AF6120E
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 08:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhKEIUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 04:20:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:53706 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhKEIUb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 04:20:31 -0400
Received: (qmail 11140 invoked by uid 109); 5 Nov 2021 08:17:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 08:17:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15591 invoked by uid 111); 5 Nov 2021 08:17:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 04:17:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 04:17:49 -0400
From:   Jeff King <peff@peff.net>
To:     Vipul Kumar <kumar+git@onenetbeyond.org>
Cc:     git@vger.kernel.org
Subject: Re: List all commits of a specified file in oldest to newest order
Message-ID: <YYTorS1DiuTXv0/V@coredump.intra.peff.net>
References: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 04:10:31AM +0000, Vipul Kumar wrote:

> I want to list all commits (including renames) of a specified file in oldest
> to newest order. But when I run "git log --follow --reverse --
> <path/to/the/file>" command, I'm getting a single commit, which points to
> the "rename of the file". This behavior is weird to me because I expected to
> get list of all commit in oldest to newest order, whereas "git log --follow
> -- <path/to/the/file>" command works as expected.

This has to do with the hacky way --follow is implemented. We don't
compute the full set of commits to show ahead of time, but rather as we
traverse, we change which pathspec we'll match when we hit a commit that
has a rename. Whereas --reverse is applied before we even start the main
traversal, and instead collect all possible commits and then walk them
in reverse order.

So the very first commit we'll look at for --follow is the one that
created the file from the rename, at which point we'll start looking
only for the old name. But of course all of the other commits post-date
the rename, so they don't use that old name.

So yes, it's a bug in the sense that the behavior is nonsense and it
doesn't work as one might expect. But it's also the hacky "--follow"
working as designed, and is just a limitation of its approach. It would
need to be rewritten completely to work correctly.  Arguably we should
at least disallow the combination of --reverse and --follow for now, as
it will never help (OTOH, if there is nothing to follow it should behave
OK, and I suspect some people and scripts may add --follow "just in
case").

As a workaround, you can get what you want by two separate traversals:
one to collect the commits via --follow, and then another to actually
show them (but without doing any further walking). Like:

  git log --follow --format=%H -- $your_file |
  git log --stdin --no-walk --reverse [--oneline, -p, etc]

-Peff
