Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEEEC1F667
	for <e@80x24.org>; Fri, 18 Aug 2017 11:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbdHRL5x (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 07:57:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:42586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751774AbdHRL5v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 07:57:51 -0400
Received: (qmail 4347 invoked by uid 109); 18 Aug 2017 11:57:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 11:57:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1599 invoked by uid 111); 18 Aug 2017 11:58:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 07:58:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Aug 2017 07:57:49 -0400
Date:   Fri, 18 Aug 2017 07:57:49 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Peter Eckersley <peter.eckersley@gmail.com>,
        git@vger.kernel.org
Subject: Re: Weirdness with git change detection
Message-ID: <20170818115749.vgfcaa44az5upm2s@sigill.intra.peff.net>
References: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
 <d047a884-b698-c25b-59e9-3a2704f79fb3@web.de>
 <20170711070618.dq52o67ixvjudafg@sigill.intra.peff.net>
 <CAOYJvnLCwR7CkG32E_r5BcVm5tFt5zsgYe7TUW3hVGBtQBHzGw@mail.gmail.com>
 <20170711073433.ghcz3lku3ux54fib@sigill.intra.peff.net>
 <decbd316-5194-120d-824e-b5cee1f0822c@web.de>
 <20170711082435.a53iuw26oxawcfyq@sigill.intra.peff.net>
 <fa4b367d-a984-6f42-a2bd-6bfcabed7c2a@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa4b367d-a984-6f42-a2bd-6bfcabed7c2a@grubix.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 08:56:03AM +0200, Michael J Gruber wrote:

> > The idea being that users could run "git lint" if they suspect something
> > funny is going on. I dunno. It may be a dead-end. Most such
> > oddities are better detected and handled during actual git operations if
> > we can. So this would really just be for things that are too expensive
> > to detect in normal operations.
> 
> Typically, that problem arises when you turn a filter on or off at some
> point in your history. Since "attributes" can come from various sources,
> especially the versioned ".gitattributes" file, unversioned per-repo
> .git/info/attributes, and global attributes, "git diff" may apply
> different attributes depending on what you diff (versioned blob, workdir
> file, out-of-tree file).
> [...]

Yeah, I agree that we cannot catch every problematic case (for all the
reason you give here). It does seem like a large number of problems
people report have to do with checkout of in-tree .gitattributes,
though. So my thinking was if we could cover that case, it might help
people (even if we leave many problems unnoticed).

But...

> I've found that when I decide to use a filter like that, the best
> approach is to either apply it retroactively (filter-branch,
> unversionsed attributes, that is clean all stored blobs) or make a
> commit where I specifically note the switch (versioned .gitattributes
> plus affected blob changes) and what config should go along with it.

One problem is that people need to know to run the lint command. And if
they know enough that this is a problem worthy of checking via a linter,
then they could perhaps just as easily do the in-tree blob changes.

I say "perhaps" because I don't think it's as easy as running a single
"git fix-my-stale-blobs". I wonder if rather than a linter, we ought to
just have an option to "git checkout" or something to ignore stat data
and re-checkout any entries for which convert_to_working_tree() isn't a
noop.

That serves both as a repair tool and as a linter (since running "git
diff" on the result would show you what needs to be fixed). It wouldn't
solve the user-education problem, but at least it would give a simple
solution that could be passed along to users.

I dunno. I don't do line ending conversion, so I don't really run into
this issue myself.

-Peff
