Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45677207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 08:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968128AbdD0IyP (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 04:54:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:41144 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968102AbdD0IyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 04:54:13 -0400
Received: (qmail 4981 invoked by uid 109); 27 Apr 2017 08:54:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 08:54:10 +0000
Received: (qmail 21734 invoked by uid 111); 27 Apr 2017 08:54:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 04:54:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 04:54:08 -0400
Date:   Thu, 27 Apr 2017 04:54:08 -0400
From:   Jeff King <peff@peff.net>
To:     Stephen Kent <smkent@smkent.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Add color slots for branch names in "git status --short
 --branch"
Message-ID: <20170427085408.ugbor7mb6hflalh2@sigill.intra.peff.net>
References: <201704556286334.8b7dc718029e6dd189dadb3703bfa@localhost>
 <xmqqzifb8ubt.fsf@gitster.mtv.corp.google.com>
 <201704235826023.e27fbbda3fdd0930bd9ff5eaaba99@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201704235826023.e27fbbda3fdd0930bd9ff5eaaba99@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 10:40:30PM -0700, Stephen Kent wrote:

> I've updated the commit message and updated one of the existing unit tests
> for this feature. Patch version 2 will follow shortly after this email.

Thanks, and sorry for the slow reply.

> There is an existing color slot "color.status.branch" for the branch name in
> the default (long) status format which is different than the new color
> config slots this patch adds.
> 
> I'm wondering if it makes sense to also use color.status.branch for the
> local branch color in short-format. On the other hand, I have configured
> different colors in the short and long status format for the local branch
> name and I find it useful for them to be separate color slots.

Hrm. That does kind of make sense to me. But I'm not sure it is worth
the backwards-compatibility weirdness. E.g., if I have
color.status.branch set to "red" right now, that may look OK in the long
status. But if we started picking it up for the local branch in "git
status --short -b", then you'd end up with two red names.

So I think we can probably just call it a historical wart that the short
and long formats use two different color config schemes.

> > I don't know if it's worth converting them or not. If we leave them all
> > as strcasecmp(), I don't mind your camelCase names, for readability.
> 
> I chose the localBranch and remoteBranch camel case names for consistency
> with the existing "color.decorate.remoteBranch" color config slot in
> log-tree.c. The documentation for color.decorate.remoteBranch uses that
> camel case name, but the config option is case-insensitive.

Ah, I knew as soon as I said "we usually" that you would reveal a
counter-example from the code. :)

I think it's OK to leave it as-is for your patch. If somebody wants to
clean up the useless strcasecmps in the slot name parsers, we can do
that separately (but it's not really hurting anything, so it may not be
worth caring about).

> I see the existing tests for git status in t7508. The unit tests set up some
> mock repository modifications to test git status output, so I've modified
> one of the tests to include a custom color for the local branch in git
> status -sb.

What you have in your v2 makes sense. Usually we try to avoid modifying
existing tests (as opposed to adding new ones), because it mixes up what
is actually being tested. But in this case, the test is exactly about
testing the colors, so that's the right place to put it.

> t7508 doesn't seem to contain any tests that include an ahead or behind
> commit count, so I didn't make any test changes for the remote tracking
> branch color. What's the best course of action here?

I think it would be reasonable to set up an ahead/behind situation at
the start of the script so that we exercise that code through the
various invocations. So I tried that, and behold, it found a bug. :)

I'll post the patch in a minute.

-Peff
