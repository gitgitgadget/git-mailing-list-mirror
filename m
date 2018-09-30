Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C2F1F454
	for <e@80x24.org>; Sun, 30 Sep 2018 04:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeI3K67 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 06:58:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:36574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726644AbeI3K66 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 06:58:58 -0400
Received: (qmail 11333 invoked by uid 109); 30 Sep 2018 04:27:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Sep 2018 04:27:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9531 invoked by uid 111); 30 Sep 2018 04:27:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 30 Sep 2018 00:27:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Sep 2018 00:27:35 -0400
Date:   Sun, 30 Sep 2018 00:27:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
Message-ID: <20180930042735.GA32120@sigill.intra.peff.net>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
 <20180926184914.GC30680@sigill.intra.peff.net>
 <3677a12b-5b9b-ad2a-1e3a-7de251baa40d@rasmusvillemoes.dk>
 <20180929082108.GJ2174@sigill.intra.peff.net>
 <xmqq4le89p91.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4le89p91.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 10:39:54AM -0700, Junio C Hamano wrote:

> Suppose "git foo" is aliased to a command "git bar".
> 
> The best case is when "git bar -h" knows that it is asked to give us
> a short usage.  We get "foo is aliased to bar" followed by the short
> usage for "bar" and everything is visible above the shell prompt
> after all that happens.
> 
> The second best case is when "git bar" simply does not support "-h"
> but actively notices an unknown option on the command line to give
> the usage message.  We see "foo is aliased to bar" followed by "-h
> is an unknown option; supported options are ..." and everything is
> visible above the shell prompt after all that happens.

Right, these are the ones we hope for.

> The worst case is when "git bar" supports or ignores "-h" and
> produces reams of output.  Sending the "aliased to" message to the
> standard error means that it is scrolled out when the output is
> done, or lost even when "git foo -h | less" attempts to let the
> reader read before the early part of the output scrolls away.

This is the "who-knows-what" case I meant here:

>> It is a little funny, I guess, if you have a script which doesn't
>> respond to "-h", because you'd get our "foo is aliased to git-bar"
>> message to stderr, followed by who-knows-what. But as long as it's to
>> stderr (and not stdout), I think it's not likely to _break_ anything.

And I think this has to be stderr. We're polluting the output of the
aliased command with our extra message, so we have two choices:

  1. Pollute stderr, and risk copious stdout (or a pager) scrolling it
     off the screen.

  2. Pollute stdout, at which point our message may be confused as part
     of the actual output of the command (and that may not even be
     immediately noticed if it is passed through a shell pipeline or
     into a file).

Choice (2) seems like a regression to me. Choice (1) is unfortunate in
some cases, but is no worse than today's behavior.

(Obviously I'm not including choices like not running the sub-command at
all, but I think that would be even worse).

> Even the first two "better" cases share the same glitch if the "foo
> is aliased to bar" goes to the standard error output.  Parse-options
> enabled commands tend to show a long "-h" output that you would need
> to say "git grep -h | less", losing the "aliased to" message.
> 
> At least it seems to me an improvement to use standard output,
> instead of standard error, for the alias information.

...so I'd disagree with this.

> In practice, however, what the command that "git foo" is aliased to
> does when given "-h" is probably unknown (because the user is asking
> what "git foo" is in the first place), so perhaps I am worried too
> much.  When the user does not know if the usage text comes to the
> standard output or to the standard error, and if the usage text is
> very long or not, they probably would learn quickly that the safest
> thing to do is to
> 
> 	$ git unknown-command -h >&2 | less
> 
> And at that point, it does not matter which between the standard
> output and the standard error streams we write "unknown-command is
> aliased to ...".

Yeah. I think if "git foo -h" produces a bunch of output you didn't
expect, then "git help foo" or "git foo --help" may be the next thing
you reach for. That's not so different than running the command even
without any aliases involved.

-Peff
