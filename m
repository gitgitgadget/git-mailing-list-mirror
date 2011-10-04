From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] remote: support --all for the prune-subcommand
Date: Tue, 4 Oct 2011 03:56:08 -0400
Message-ID: <20111004075608.GC7308@sigill.intra.peff.net>
References: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
 <20111004070006.GA6824@sigill.intra.peff.net>
 <CABPQNSZrfxhyA3em8TN2=d7pAHopZMgRg47baKnDT9h14=rxkA@mail.gmail.com>
 <20111004071332.GA7308@sigill.intra.peff.net>
 <CABPQNSZ-ELfFuxmKMqXCQaAgMZMRsZG3S5wWJLsjkYVvK6aGug@mail.gmail.com>
 <CABPQNSb7NYTac5uWSegK9rmYz1n0yt1GJWHKUtLg1k_OYHdDNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:56:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAzrL-0001L4-Lf
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 09:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab1JDH4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 03:56:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52018
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754945Ab1JDH4L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 03:56:11 -0400
Received: (qmail 4621 invoked by uid 107); 4 Oct 2011 08:01:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 04:01:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 03:56:08 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSb7NYTac5uWSegK9rmYz1n0yt1GJWHKUtLg1k_OYHdDNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182741>

On Tue, Oct 04, 2011 at 09:40:22AM +0200, Erik Faye-Lund wrote:

> > Hmm, you might want to do that on, say, a mobile network to save
> > bandwidth; i.e throw away the stale branches, but not yet update the
> > non-stale ones because downloading the objects might take a long time
> > (and/or be expensive).
> >
> > So with that in mind, I actually think my patch makes sense in some
> > cases, but it certainly is less useful that I originally though ;)
> 
> Strike that part; I hadn't had my morning coffee yet. It might make
> sense to have similar _functionality_, but having this as a flag to
> "git fetch" instead of "git remote prune" strikes me as the only sane
> approach.

I agree that "git fetch --prune-only" (or something similar) would be a
natural way to do it.

> In fact, I'm not sure I understand why we simply do not always prune
> by default.

I think the original rationale was that we didn't want fetch to be
"lossy". That is, if I were using upstream's "foo" branch as part of my
work (to diff against, or whatever), then doing a "git fetch" to update
should not suddenly make it hard to do my work. And not just hard as in
"I notice that it's gone and I adapt my workflow". But that you no
longer have _any_ record of where upstream's "foo" branch used to point,
so even doing something like:

  git rebase --onto new-foo foo my-topic

is impossible.

These days we have reflogs, so you would hope to do something like:

  git rebase --onto new-foo foo@{1} my-topic

But ref deletion also deletes the reflog completely, so that doesn't
work.

The right solution, IMHO, is that ref deletion should actually keep the
reflog around in a graveyard of some sort. Entries would expire
naturally over time, as they do in regular reflogs. And then it becomes
a lot safer to prune on every fetch, because you still have 90 days look
at the reflog.

There is still one sticky point, which is that your branch config may
refer to an upstream branch that gets pruned. That will break some
operations (as well it should, as the branch is gone, and the user needs
to adapt their config appropriately). It might be nice if we noticed
when accessing a ref that it doesn't exist but has a deleted reflog, so
we can give the user better advice.

> If a user wants to keep another user's branch, surely the most sane
> thing would be to make a local branch of it?

Unfortunately there are some management problems there. How do I keep my
local branch up to date with what I fetch? I have to keep checking out
and merging on every fetch (or use some plumbing), which is a pain. But
if I don't, then when the upstream branch goes away, I still have no
clue where its tip was right before it got pruned.

-Peff
