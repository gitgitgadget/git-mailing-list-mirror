Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67E12023D
	for <e@80x24.org>; Wed, 24 May 2017 09:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939412AbdEXJzJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 05:55:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:57366 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758273AbdEXJzE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 05:55:04 -0400
Received: (qmail 18593 invoked by uid 109); 24 May 2017 09:55:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 May 2017 09:55:01 +0000
Received: (qmail 9618 invoked by uid 111); 24 May 2017 09:55:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 May 2017 05:55:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 May 2017 05:55:00 -0400
Date:   Wed, 24 May 2017 05:55:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/15] handle_revision_arg: stop using "dotdot" as a
 generic pointer
Message-ID: <20170524095459.ojcarze45ery76oi@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
 <20170519125006.gbvzr2dqrcycmpx7@sigill.intra.peff.net>
 <xmqqzie3gegc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzie3gegc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 11:45:39AM +0900, Junio C Hamano wrote:

> > It may make sense to pull each of these into its own helper. I didn't
> > really look because they're so small, and because the return semantics
> > seemed confusing to me. Some of them return, and some of them keep
> > parsing. Some of them restore the NUL they overwrite, and some do not.
> >
> > I didn't dig in to see if there are weird corner cases where they
> > misbehave.
> 
> I do not quite know what corner cases you meant, but I agree that
> many places in the codepath we forget to restore "^" we temporarily
> overwrite.  I suspect that none of them is deliberately leaving "^"
> unrestored and they are just being careless (or they truly do not
> care because they assume nobody will look at arg later).
> 
> And I think not restoring cannot be a correct thing to do.  After
> all of these parsing, add_rev_cmdline() wants to see arg_ intact.
> 
> But let's keep reading; perhaps they are addressed in a later patch,
> or they are left as-is, and either is OK.

I don't really know what corner cases I meant, either. :) I just saw
that the code looked funny, but nobody noticed for the common cases, so
I presumed any misbehavior would be from uncommon ones.

As far as "maybe not restoring is intentional", I wondered if there are
cases where we might allow multiple marks. E.g., if we wanted to allow
"foo^@^!", then we might need to progressively pull items off the end,
shortening the string. But I don't think that can be correct:

  - these marks generally don't make sense to combine in the first place

  - even if we allowed combinations, since we make only a single pass
    through the function, we'd require the combinations to come in a
    particular order

  - even if it were intentional to do so, we'd still be adding weird
    stuff to add_rev_cmdline(), as you noted

But I had some other questions, too, about what's supposed to be in the
"name" field of "pending" in some of these cases. For instance, try:

  git tag foo 6a0bc7cf0efbefa5a949d958947e68e29534f04d
  git log --oneline --source foo^-

All of the commits are marked as coming from "foo". That's because of
two things:

  1. When we parse "^-", we turn the first character to NUL. So our call
     to add_parents_only() sees just "foo", with no tail.

  2. We never restore the "^". So later when we add "foo" itself, the
     arg name is still "foo".

So arguably that's correct (these all came from "foo", which is a
resolvable name, and I think that's what the name field of
add_pending_object is going for). But that means add_rev_cmdline() sees
the same munged string, which is probably wrong. We can't possibly get
that case right with munging since the add_rev_cmdline() and
add_pending_object() calls come in pairs. We'd have to actually copy the
pending name into a separate string instead.

So like I said, I was sufficiently confused about what was supposed to
happen that I didn't try fixing it.

-Peff
