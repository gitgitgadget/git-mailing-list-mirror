Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C751F453
	for <e@80x24.org>; Fri, 26 Oct 2018 08:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeJZRPP (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 13:15:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:55488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726014AbeJZRPP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 13:15:15 -0400
Received: (qmail 3562 invoked by uid 109); 26 Oct 2018 08:39:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Oct 2018 08:39:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26447 invoked by uid 111); 26 Oct 2018 08:38:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Oct 2018 04:38:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2018 04:39:05 -0400
Date:   Fri, 26 Oct 2018 04:39:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
Message-ID: <20181026083905.GA1705@sigill.intra.peff.net>
References: <87o9dar9qc.fsf@evledraar.gmail.com>
 <20181018225739.28857-1-avarab@gmail.com>
 <20181019220755.GA31563@sigill.intra.peff.net>
 <87ftx0dg4r.fsf@evledraar.gmail.com>
 <20181020185852.GA6234@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181020185852.GA6234@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 02:58:53PM -0400, Jeff King wrote:

> On Sat, Oct 20, 2018 at 01:14:28PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > > I'd guess this sort of thing is pretty rare. But I wonder if we're
> > > crossing the line of trying to assume too much about what the user's
> > > arbitrary code does.
> > >
> > > A simple depth counter can limit the fork bomb, and with a high enough
> > > depth would be unlikely to trigger a false positive. It could also
> > > protect non-aliases more reasonably, too (e.g., if you have a 1000-deep
> > > git process hierarchy, there's a good chance you've found an infinite
> > > loop in git itself).
> > 
> > I don't think this edge case you're describing is very plausible, and I
> > doubt it exists in the wild.
> > 
> > But going by my personal incredulity and a git release breaking code in
> > the wild would suck, so agree that I need to re-roll this to anticipate
> > that.
> 
> I agree it's probably quite rare, if it exists at all. But I also wonder
> how important looping alias protection is. It's also rare, and the
> outcome is usually "gee, I wonder why this is taking so long? ^C".

Hmph. So I was speaking before purely hypothetically, but now that your
patch is in 'next', it is part of my daily build. And indeed, I hit a
false positive within 5 minutes of building it. ;)

I have an alias like this:

  $ git help dotgit
  'dotgit' is aliased to '!git rev-parse 2>/dev/null || cd ~/compile/git; git'

The idea being that I can run "git dotgit foo" to run "git foo" in the
current directory, or if it is not a git repository, in my checkout of
git.git.

I use it in two ways:

  - some of my aliases know about it themselves. So I have an alias "ll"
    that does:

      $ git help ll
      'll' is aliased to '!git dotgit --no-pager log --no-walk=unsorted --format='%h (%s, %ad)' --date=short'

    with the idea being to produce a nice annotation for a commit id.
    Using "git dotgit" there lets me just run it from any directory,
    since 99% of the time I am working on git.git anyway.

  - I have a vim command defined:

      command! -nargs=* Git :call MaybeInlineCommand("git dotgit <args>")

    so I can do ":Git foo" inside vim and it uses either the current
    repo (e.g., if I'm writing a commit message) or git.git (e.g., if
    I'm writing an email and didn't start in the repo).

So of course the alias expansion is something like (in older versions of
Git):

  1. "git dotgit ll" runs the dotgit alias, which sees that we need to go
     to the git.git checkout

  2. that runs "git ll"

  3. that runs "git dotgit log"; this second dotgit invocation sees we're
     already in a repository and is a noop

  4. git-log runs

With your patch, step 3 complains:

  $ git dotgit ll
  fatal: alias loop detected: expansion of 'dotgit' does not terminate:
  dotgit <==
  ll ==>

So I would really prefer a depth counter that can be set sufficiently
high to make this case work. ;)


As an aside, I got to experience this error message as an unsuspecting
user would. Unfortunately the output was not super helpful for figuring
out the cause. I scratched my head for a while before remembering that
"ll" uses "dotgit" explicitly (which was quite apparent when running
GIT_TRACE=1, or "git help ll"). I think showing the alias definitions in
the loop output would have made it much more obvious (if perhaps a bit
uglier).  E.g., something like:

  fatal: alias loop...
  ==> dotgit is aliased to '!git rev-parse ...'
  <== ll is aliased to '!git dotgit ...'

-Peff
