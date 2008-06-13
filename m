From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 03:42:57 -0400
Message-ID: <20080613074257.GA513@sigill.intra.peff.net>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wincent Colaiuta <win@wincent.com>, Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K73xK-00042g-GP
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 09:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbYFMHnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbYFMHnB
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 03:43:01 -0400
Received: from peff.net ([208.65.91.99]:3015 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbYFMHnA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 03:43:00 -0400
Received: (qmail 2370 invoked by uid 111); 13 Jun 2008 07:42:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 03:42:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 03:42:57 -0400
Content-Disposition: inline
In-Reply-To: <48521EDA.5040802@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84845>

On Fri, Jun 13, 2008 at 09:16:42AM +0200, Andreas Ericsson wrote:

> To me, long-living stashes are useful because I can all of a sudden be
> pulled away from something I'm working on and set to work on something
> entirely different for up to 6 months (so far we haven't had a single
> emergency project run longer than that). It doesn't happen a lot, but
> it *does* happen.

So of course my first question is "then why didn't you use a branch?" :)

I'm not, by the way, trying to say "there is no good reason not to use a
branch." I am trying to figure out what the reasons are, because I
wonder if there is a more useful abstraction we can come up for handling
this situation.

Reading your (and others') responses, it seems like there are two
things:

  1. Stashing is about saying "save everything about where I am now with
     no hassle". IOW, it's one command, you don't have to decide what
     goes and what stays, and you can pull it back out with one command.
     And maybe there is a psychological component that you are not ready
     to "commit" such a work-in-progress (I am extrapolating here, but I
     know that when I first started with git, I was hesitant to commit
     because of my experience with other systems).

  2. Branches tend to get shared, and you don't want people to see your
     stashes, because they are messy works in progress.

To deal with '2', I wonder if it would be worth making some branches
inaccessible to pushing/pulling (either via config, or through a special
naming convention).

For '1', I guess the only solution would be some way of making a topic
branch easy to stash and restore. And that would end up looking quite a
bit like stash; I would think the interface would be "git notstash
branchname". Which we sort of have with "git stash save <message>"
already. We could say "if you didn't provide a message, then it will be
gc'ed eventually, but if you did, then it lives forever". That would
work fine for my workflow (I don't bother naming stashes, since I
generally unstash them immediately). But it seems like an accident
waiting to happen for unsuspecting users.

> I think these are the options we're faced with:
> 1. Never expire stashes (don't shoot the user)
> 2. Don't treat stashes specially (shoot the user)
> 3. Don't purge stashes when auto-gc-ing (let the users shoot themselves)
> 4. Make the behaviour configurable (let the users shoot themselves)
> 5. Double the expiration time on stashes and warn for them when they should
>   normally have expired (during gc, that is) (shoot the user, but warn first).

I am tempted by #3, which again matches my workflow. But again, it seems
like an accident waiting to happen for unsuspecting users.

So I think either #1 or #4 is reasonable. #4 probably isn't worth the
effort. If the stash reflog gets too cluttered, one can always expire or
clean it manually.

-Peff
