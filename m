Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03FF1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 20:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbcHXUW2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 16:22:28 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43042 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbcHXUW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 16:22:27 -0400
Received: from mfilter14-d.gandi.net (mfilter14-d.gandi.net [217.70.178.142])
        by relay4-d.mail.gandi.net (Postfix) with ESMTP id 1E6B2172097;
        Wed, 24 Aug 2016 22:21:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter14-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
        by mfilter14-d.gandi.net (mfilter14-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id dQsmOiruu8QW; Wed, 24 Aug 2016 22:21:37 +0200 (CEST)
X-Originating-IP: 207.236.147.202
Received: from x (unknown [207.236.147.202])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id CAC6B172094;
        Wed, 24 Aug 2016 22:21:35 +0200 (CEST)
Date:   Wed, 24 Aug 2016 16:21:33 -0400
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
Message-ID: <20160824202133.olvifmet3g4yeswr@x>
References: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
 <20160821142634.dorgzldjvc3qiaby@x>
 <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
 <20160823065359.34cirqig56fugnwy@x>
 <b2f7ff11-23b4-1065-2207-43f736c91988@gmail.com>
 <xmqq60qqu3rl.fsf@gitster.mtv.corp.google.com>
 <b264e17a-12ff-69ca-f130-78d2635a0f85@gmail.com>
 <20160824142024.xnaehfo2spw26apj@x>
 <165ac159-29e8-10d1-49ee-e5ff6543d0d2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <165ac159-29e8-10d1-49ee-e5ff6543d0d2@gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 07:05:17PM +0200, Jakub Narębski wrote:
> W dniu 24.08.2016 o 16:20, Josh Triplett pisze:
> > On Wed, Aug 24, 2016 at 03:16:56PM +0200, Jakub Narębski wrote:
> [...]
> >> Not really.
> >>
> >> The above means only that the support for new syntax would be not
> >> as easy as adding it to 'git rev-parse' (and it's built-in equivalent),
> >> except for the case where submodule uses the same object database as
> >> supermodule.
> >>
> >> So it wouldn't be as easy (on conceptual level) as adding support
> >> for ':/<text>' or '<commit>^{/<text>}'.  It would be at least as
> >> hard, if not harder, as adding support for '@{-1}' and its '-'
> >> shortcut.
> > 
> > Depends on which cases you want to handle.  In the most general case,
> > you'd need to find and process the applicable .gitmodules file, which
> > would only work if you started from the top-level tree, not a random
> > treeish.  On the other hand, in the most general case, you don't
> > necessarily even have the module you need, because .git/modules only
> > contains the modules the *current* version needed, not every past
> > version.
> 
> There is an additional problem, namely that directory with submodule
> can be renamed.
> 
> I don't know if there is an existing API, but assuming modern
> git-submodule (with repository in .git/modules) you would have to
> do the following steps for <revision>:<path/to/submodule>//<path>:
> 
>  * look up <revision>:.gitmodules for module which 'path'
>    is <path/to/submodule>; let's say it is named <submodule>
>  * check if <revision>:<path/to/submodule> commit object
>    is present in .git/modules/<submodule>
>  * look up this object

This also assumes your lookup started with a <committish> and not an
intermediate <treeish>, but that'll work in many cases.

> > As an alternate approach (pun intended): treat every module in
> > .git/modules as an alternate and just look up the object by hash.  
> 
> This could be a good fallback, to search through all submodules.
> 
> > Or, teach git-submodule to store all the objects for submodules in the
> > supermodule's .git/objects (and teach git's reachability algorithm to
> > respect refs in .git/modules, or store their refs in
> > .git/refs/submodules/ or in a namespace).
> 
> And fallback to this fallback could be searching through supermodule
> object repository.

I'd flip those around: first search registered .gitmodules, then look up
the object in the superproject (since you have it at hand), and then
maybe search every submodule.

> >> Josh, what was the reason behind proposing this feature? Was it
> >> conceived as adding completeness to gitrevisions syntax, a low-hanging
> >> fruit?  It isn't (the latter).  Or was it some problem with submodule
> >> handling that you would want to use this syntax for?
> > 
> > This wasn't an abstract/theoretical completeness issue.  I specifically
> > wanted this syntax for practical use with actual trees containing
> > gitlinks, motivated by having a tool that creates and uses such
> > gitlinks. :)
> 
> Could you explain what you need in more detail?  Is it a fragment
> of history of submodule, a contents of a file at given point of
> superproject history, diff between file-in-submodule and something
> else, or what?

As part of git-series, I have commits, whose trees contain various
gitlinks, such as "series" and "base".  Those gitlinks point to commits
in the same repository.  I'd like to use those gitlinks everywhere I
could use any other committish, such as a branch name.  In particular,
I'd like to write things like some_feature:series:path/to/file ("what
does path/to/file look like in the current version of some_feature"),
some_feature:series^ ("what's the second-to-last commit in
some_feature"), some_feature~5:series:path/to/file ("what did
path/to/file look like in an older version of some_feature"), or
some_feature~5:base..some_feature~5:series~2 ("all but the last two
patches in some_feature~5").  Those should work with show, diff,
format-patch, log, etc.

> >> As for usefulness: this fills the hole in accessing submodules, one
> >> that could be handled by combining plumbing-level commands.  Namely,
> >> there are 5 states of submodule (as I understand it)
> >>
> >>  * recorded in ref / commit in supermodule
> >>  * recorded in the index in supermodule
> >>  - recorded in ref / commit in submodule
> >>  - recorded in the index in submodule
> >>  - state of worktree in submodule
> >>
> >> The last three can be easyly acessed by cd-ing to submodule.  The first
> >> two are not easy to get, AFAIUC.
> > 
> > Right.  I primarily care about those first two cases, especially the
> > first one: given a commit containing a gitlink, how can I easily dig
> > into the linked commit?
> 
> All right.
> 
> Though you can cobble it with plumbing... just saying.

Sure, but that makes the expression much more complex.
