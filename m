From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Properties of trees referencing commit objects (mode 160000)?
Date: Sun, 20 Mar 2016 16:22:02 -0700
Message-ID: <20160320232202.GB20803@x>
References: <20160319221348.GA5247@x>
 <20160320041803.GC18312@sigill.intra.peff.net>
 <20160320184524.GA16064@x>
 <20160320200724.GC6288@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 00:22:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahmfn-0006BA-MB
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 00:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbcCTXWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 19:22:12 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34019 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbcCTXWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 19:22:09 -0400
Received: from mfilter32-d.gandi.net (mfilter32-d.gandi.net [217.70.178.163])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 477E541C084;
	Mon, 21 Mar 2016 00:22:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter32-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter32-d.gandi.net (mfilter32-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id HfVFNcpXsson; Mon, 21 Mar 2016 00:22:05 +0100 (CET)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A950741C088;
	Mon, 21 Mar 2016 00:22:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160320200724.GC6288@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289390>

On Sun, Mar 20, 2016 at 04:07:25PM -0400, Jeff King wrote:
> On Sun, Mar 20, 2016 at 11:45:24AM -0700, Josh Triplett wrote:
> > > No, we do not follow "gitlinks" like this for reachability. Neither for
> > > pruning, nor for object transfer via push/fetch. So you'd need to have a
> > > separate reference to it (or history containing it).
> > 
> > Argh.  If I have a pile of disconnected commits, is there anything git
> > *would* follow to see them, other than a pile of refs?
> 
> I don't think so. We follow refs, tag "object" fields, and commit
> "parent" fields to get to commits, but never tree entries.

That does make sense, given your point (2) below about efficiency.

> And I don't think it works to just tweak the mode to 100644 for the
> commit entry; the checkout code will complain that it was expecting a
> blob and got a commit.

That much I assumed. :)

> > I suppose I could artificially generate a stack of merge commits with
> > those otherwise disconnect commits as parents, which would let me
> > reference them all from a single ref.  Still unsatisfying, though.
> 
> Yes, though you can do it all in one single merge commit. The tree of
> that merge commit wouldn't matter, it could literally just be a pointer
> to all of the parents (we used to have some limits on the number of
> parents, but I don't think we do anymore?).

I didn't want to assume that all the software assuming upper bounds on
octopus merges had disappeared.  And more importantly...

> If you just threw away that stacked merge and made a new one any time it
> was updated, I think it wouldn't end up very efficient for fetching. The
> client would say "I have giant-merge-commit X", and the server would say
> "well, I need to send you giant-merge-commit Y", but if it does not any
> longer have X, it cannot realize that Y includes 99% of what is in X.

...that.  And the linearly growing cost of recreating and working with
the merge commit as the number of parent commits grows.

> So I guess you'd want a history chain of those merges. I'm not quite
> sure what your application is, so I don't know if that would be a pain
> or not.

As it turns out, that fits fairly naturally.

I want to track the evolution of a patch series or other commit history,
through non-fast-forwarding actions like rebase, rebase -i, or commit
--amend.  Similar in spirit to reflog, but with intentional commits and
commit messages, and most importantly with the ability to share and
collaborate on it.  For each version of the patch series, I plan to
track the commit at the end of the series, and optionally the commit at
the base of the patch series (to simplify tracking of rebasing); I'll
use the tree object associated with the commit to track the cover
letter, and perhaps meta-changelog entries associated with v2/v3/vN of
the series.

Patch series almost always need to evolve through non-fast-forwarding
history.  And I've seen that done in two ways: either pull the patch
series out of git, put it in quilt or similar, and track the quilt
series with git; or pull the versioning of the patch series out of git
and track it with branch names like feature-v2, feature-2016-03-20,
feature-rebased, and feature-rebased-4.4-fixed-foo-fixed-bar.  That last
one closely matches a real-world example I've recently seen.  And that
starts to look a lot like the naming of files and documents in
organizations that haven't yet discovered the wonders of version
control.

I'd like to have the best of both worlds: handle the patch series in
git, *and* handle the versioning of the patch series in git.

> > (I'd also be tempted to ask whether a patch to teach git to follow
> > gitlinks for reachability and/or object transfer would be acceptable.)
> 
> As always, I reserve all judgement on patches until I see them. :)

Of course.  Obviously it's not possible to accept a patch that doesn't
exist yet, but it's possible to reject a patch that doesn't exist yet
based solely on description, saving the trouble of writing it. :)

> But I tend to think it would end up rather complex. Off the top of my
> head, these are the three gotchas I can think of:
> 
>   1. The reachability rules must be agreed upon between both sides of
>      the transfer. So you would need a protocol extension for "please
>      consider gitlinks reachable" so that the sender knows to include
>      them, and that when the client advertises commit X that can reach
>      Y via gitlink, it can assume that the client does not need Y.
> 
>   2. There may be some issues with efficiently finding shared history
>      during a transfer.  That process usually just looks at the commits,
>      and then we hand the set of have/want commits to the pack
>      generation code to figure out the full set of required objects (and
>      in particular, we do not comb through all of the "have" commits for
>      objects that might have become re-referenced; it's too expensive
>      for too little gain).
> 
>      But with the flag from (1), we'd have commits buried inside trees.
>      The packing code would figure out which objects to send, but I
>      suspect you'd end up with some inefficiencies where an internal
>      gitlink bumped from commit X to Y, and we _could_ know that the
>      client already has X, but digging it up doesn't happen with the
>      current code.
> 
>      I didn't think it through too hard, though, so perhaps it would all
>      just work.
> 
>   3. The reachability is usually an invariant in the repository, but
>      presumably this would be enabled through a config variable (it
>      _can't_ be on all the time, because then true external submodules
>      wouldn't work, and it can't just be "eh, reachable if you got it",
>      because then transfers cannot assume the other side has it and
>      would resend every time).
> 
>      So flipping that switch in an existing repository with gitlinks
>      would probably put it in a broken state until it fetches all of the
>      gitlinks.

This point in particular makes me completely disinclined to go down this
road.  It could never be mandatory, and having it optional seems
error-prone.

Thanks for the feedback and suggestions.

- Josh Triplett
