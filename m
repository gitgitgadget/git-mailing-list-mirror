From: Jeff King <peff@peff.net>
Subject: Re: Properties of trees referencing commit objects (mode 160000)?
Date: Sun, 20 Mar 2016 16:07:25 -0400
Message-ID: <20160320200724.GC6288@sigill.intra.peff.net>
References: <20160319221348.GA5247@x>
 <20160320041803.GC18312@sigill.intra.peff.net>
 <20160320184524.GA16064@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 21:07:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahjdN-0000PM-7I
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 21:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbcCTUH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 16:07:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:34985 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbcCTUH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 16:07:28 -0400
Received: (qmail 4276 invoked by uid 102); 20 Mar 2016 20:07:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 16:07:27 -0400
Received: (qmail 30392 invoked by uid 107); 20 Mar 2016 20:07:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 16:07:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2016 16:07:25 -0400
Content-Disposition: inline
In-Reply-To: <20160320184524.GA16064@x>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289382>

On Sun, Mar 20, 2016 at 11:45:24AM -0700, Josh Triplett wrote:

> Will git clone/checkout/etc handle it properly in that case, in the
> absence of a .gitmodules file?  Or would it only work with custom tools?

I think checkout just creates an empty tree for any gitlinks, and waits
for the submodule code to fill it in.  So you'd need a custom tool. It's
easy enough to test, though:

    git init repo &&
    cd repo &&
    echo content >file && git add file && git commit -m base &&
    printf '160000 commit %s\t%s' "$(git rev-parse HEAD)" linked >tree &&
    tree=$(git mktree <tree) &&
    commit=$(echo foo | git commit-tree $tree) &&
    git checkout $commit

> > No, we do not follow "gitlinks" like this for reachability. Neither for
> > pruning, nor for object transfer via push/fetch. So you'd need to have a
> > separate reference to it (or history containing it).
> 
> Argh.  If I have a pile of disconnected commits, is there anything git
> *would* follow to see them, other than a pile of refs?

I don't think so. We follow refs, tag "object" fields, and commit
"parent" fields to get to commits, but never tree entries.

And I don't think it works to just tweak the mode to 100644 for the
commit entry; the checkout code will complain that it was expecting a
blob and got a commit.

> I suppose I could artificially generate a stack of merge commits with
> those otherwise disconnect commits as parents, which would let me
> reference them all from a single ref.  Still unsatisfying, though.

Yes, though you can do it all in one single merge commit. The tree of
that merge commit wouldn't matter, it could literally just be a pointer
to all of the parents (we used to have some limits on the number of
parents, but I don't think we do anymore?).

If you just threw away that stacked merge and made a new one any time it
was updated, I think it wouldn't end up very efficient for fetching. The
client would say "I have giant-merge-commit X", and the server would say
"well, I need to send you giant-merge-commit Y", but if it does not any
longer have X, it cannot realize that Y includes 99% of what is in X.

So I guess you'd want a history chain of those merges. I'm not quite
sure what your application is, so I don't know if that would be a pain
or not.

> (I'd also be tempted to ask whether a patch to teach git to follow
> gitlinks for reachability and/or object transfer would be acceptable.)

As always, I reserve all judgement on patches until I see them. :)

But I tend to think it would end up rather complex. Off the top of my
head, these are the three gotchas I can think of:

  1. The reachability rules must be agreed upon between both sides of
     the transfer. So you would need a protocol extension for "please
     consider gitlinks reachable" so that the sender knows to include
     them, and that when the client advertises commit X that can reach
     Y via gitlink, it can assume that the client does not need Y.

  2. There may be some issues with efficiently finding shared history
     during a transfer.  That process usually just looks at the commits,
     and then we hand the set of have/want commits to the pack
     generation code to figure out the full set of required objects (and
     in particular, we do not comb through all of the "have" commits for
     objects that might have become re-referenced; it's too expensive
     for too little gain).

     But with the flag from (1), we'd have commits buried inside trees.
     The packing code would figure out which objects to send, but I
     suspect you'd end up with some inefficiencies where an internal
     gitlink bumped from commit X to Y, and we _could_ know that the
     client already has X, but digging it up doesn't happen with the
     current code.

     I didn't think it through too hard, though, so perhaps it would all
     just work.

  3. The reachability is usually an invariant in the repository, but
     presumably this would be enabled through a config variable (it
     _can't_ be on all the time, because then true external submodules
     wouldn't work, and it can't just be "eh, reachable if you got it",
     because then transfers cannot assume the other side has it and
     would resend every time).

     So flipping that switch in an existing repository with gitlinks
     would probably put it in a broken state until it fetches all of the
     gitlinks.

-Peff
