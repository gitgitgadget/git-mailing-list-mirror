Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4DDD20281
	for <e@80x24.org>; Sat,  4 Nov 2017 09:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932140AbdKDJ2z (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 05:28:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:46268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756488AbdKDJ2x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 05:28:53 -0400
Received: (qmail 1362 invoked by uid 109); 4 Nov 2017 09:28:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 04 Nov 2017 09:28:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7875 invoked by uid 111); 4 Nov 2017 09:29:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 04 Nov 2017 05:29:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Nov 2017 05:28:50 -0400
Date:   Sat, 4 Nov 2017 05:28:50 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, hkleynhans@bloomberg.net
Subject: Re: Git Open Source Weekend London 11th/12th November
Message-ID: <20171104092850.5fthdgvnihd3y4fm@sigill.intra.peff.net>
References: <CALgYhfO=6WfdzfGYwgw+cp2Tb58Yzx6YYvBtMCPNcJto5rMUCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALgYhfO=6WfdzfGYwgw+cp2Tb58Yzx6YYvBtMCPNcJto5rMUCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 01, 2017 at 04:36:24PM +0000, Thomas Gummerer wrote:

> Normally attendees work in small groups on a specific task to
> prevent anyone from getting stuck. Per usual, Bloomberg will
> provide the venue, mentors, snacks and drinks.  Bring your
> enthusiasm (and your laptop!) and come share in the fun!  The
> event is also open to everyone, so feel free to pass on the
> invite!

I think it will help if the experienced members of the community (both
those who will be at the event and not) can come up with some possible
topics to work on (though of course I'd be glad for participants to come
with their own itch to scratch).

We've started using the #leftoverbits tag to allow searching in the
archive:

  https://public-inbox.org/git/?q=leftoverbits

Some of those have since been completed, but others are left open.
There's not really a master list, but it's a potential source for
digging for gold (well, if you want to call leftover bugs gold :) ).

I started a list over the summer of larger items that people might want
to pick up. Here it is in no particular order:

 - the pager.<cmd> config is mis-designed, because our config keys
   cannot represent all possible command names (e.g., case folding and
   illegal characters). This should be pager.<cmd>.enable or similar.
   Some discussion in (this message and the surrounding thread):

     https://public-inbox.org/git/20170711101942.h2uwxtgzvgguzivu@sigill.intra.peff.net/

   But I think you could find more by searching the archive.

 - ditto for alias.* config, which has the same syntax problems.

 - auto-gc is sometimes over-anxious to run if you have a lot of
   unreachable loose objects. We should pack unreachables into a single
   pack. That solves the --auto problem, and is also way more efficient.
   The catch is expiration. Some discussion here (and especially
   down-thread):

     https://public-inbox.org/git/20170711101942.h2uwxtgzvgguzivu@sigill.intra.peff.net/

 - git-config's "--get-color" is unlike all the other types in that it
   takes a "default" value if the config key isn't set. This makes it annoyingly
   inconsistent, but there's also no way to ask Git to interpret other
   values (e.g., you might want it to expand "--path" or an "--int"). It
   would be nice to have a general "--default" option so you could do:

     # same as git config --get-color color.diff.old red
     git config --default red --color color.diff.old

   or

     # not currently possible to ask git to interpret "10k"
     git config --default 10k --int some.integer.key

 - git's internal config can parse expiration dates (see
   parse_expiry_date()), but you can't do so from git-config. It should
   probably have a type for "--expiry-date" (which would of course be
   more useful with the --default option above).

 - there's no efficient way to ask git-config for several keys with a
   specific type (or even multiple different types).  You can use
   "--list" to get their strings, but you can't get any interpretation
   (like colors, integers, etc). Invoking git-config many times can have
   a noticeable speed impact for a script. There should probably be a
   "--stdin" mode (or maybe "--get-stdin" if we would one day want to
   have a "--set-stdin") that takes a list of keys, optional types, and
   optional defaults (that "--default" again!) and outputs them to
   stdout.


Those were just sitting on my ideas list. I'm happy to go into more
detail if anybody's interested in discussing any of them. Some of them
may be half-baked.

And of course I'd be happy if people wanted to contribute more items to
the list.

-Peff
