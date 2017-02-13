Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B901FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbdBMUJx (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:09:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:54382 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752809AbdBMUJw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:09:52 -0500
Received: (qmail 1469 invoked by uid 109); 13 Feb 2017 20:09:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 20:09:52 +0000
Received: (qmail 22354 invoked by uid 111); 13 Feb 2017 20:09:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 15:09:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 15:09:50 -0500
Date:   Mon, 13 Feb 2017 15:09:50 -0500
From:   Jeff King <peff@peff.net>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 0/5] stash: support pathspec argument
Message-ID: <20170213200950.m3bcyp52wd25p737@sigill.intra.peff.net>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net>
 <20170212193050.GA652@hank>
 <vpq7f4uxjmo.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vpq7f4uxjmo.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 03:14:55PM +0100, Matthieu Moy wrote:

> I don't remember doing this intentionally. The goal was really to
> prevent typos like "git stash -p drop" (which would have been
> interpreted as "git stash save -p drop" previously). So, let's consider
> this "only messages starting with - are accepted" as a bug: moving to
> the new "push" command it a nice opportunity to fix it without worrying
> about compatibility. A bit more about this in this old thread:

Yeah, I consider it a bug that we treat "-foo" as a message there.
Fortunately I think you really have to try hard to abuse it:

  # doesn't work, because "save" complains about "-foo" as an option
  git stash -foo

  # does save stash with message "-foo"
  git stash -- -foo

  # doesn't work, because _any_ non-option argument is rejected
  git stash -- use --foo option

> I think we can safely allow both
> 
>   git stash -p -- <pathspec...>
>   git stash push -p <pathspec...>
> 
> But allowing the same without -- is a bit more dangerous for the reason
> above:
> 
>   git stash -p drop
> 
> would be interpreted as
> 
>   git stash push -p drop
> 
> (i.e. limit the stash to file named "drop"), and this would almost
> certainly not be what the user wanted.

Is it really that dangerous, though? The likely outcome is Git saying
"nope, you don't have any changes to the file named drop". Of course the
user may have meant something different, but I feel like "-p" is a good
indicator that they are interested in making an actual stash.

Think about this continuum of commands:

  1. git stash droop

  2. git stash -p drop

  3. git stash -p -- drop

  4. git stash push -p drop

I think we can all agree that (4) is reasonable and safe. And I suspect
we'd all agree that (1) is suspect (you probably meant "drop", not "push
droop").

But between (2) and (3), I don't see much difference. The interesting
difference between (1) and (2) is the addition of "-p", which tells us
that the user expects to save a stash.

Another way of thinking of it is that "-p" as a command name is an alias
for "push -p". If you wanted to err on the conservative side, you could
literally implement it that way (so "git stash -k -p foo" would not
work; you'd have to use "git stash -p -k foo").

> > The other question is how we would deal with the -m flag for
> > specifying a stash message.  I think we could special case it, but
> > that would allow users to do things such as git stash -m apply, which
> > would make the interface a bit more error prone.  So I'm leaning
> > towards disallowing that for now.
> 
> We already have "git commit -m <msg> <pathspec...>", so I think stash
> should just do the same thing as commit. Or, did I miss something?

The complexity is that right now, the first-level decision of "which
stash sub-command am I running?" doesn't know about any options. So "git
stash -m foo" would be rejected in the name of typo prevention, unless
that outer decision learns about "-m" as an option.

-Peff
