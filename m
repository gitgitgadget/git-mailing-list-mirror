From: Jeff King <peff@peff.net>
Subject: Re: Odd problems trying to build an orphaned branch
Date: Thu, 5 Nov 2015 19:18:32 -0500
Message-ID: <20151106001832.GB9963@sigill.intra.peff.net>
References: <1bf03e2146ceb5bb36b81f1ce64354b0.squirrel@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: alan@clueserver.org
X-From: git-owner@vger.kernel.org Fri Nov 06 01:18:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuUjv-0007v9-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 01:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965997AbbKFASi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 19:18:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:53770 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965929AbbKFASf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 19:18:35 -0500
Received: (qmail 14149 invoked by uid 102); 6 Nov 2015 00:18:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 18:18:35 -0600
Received: (qmail 20577 invoked by uid 107); 6 Nov 2015 00:19:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 19:19:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Nov 2015 19:18:32 -0500
Content-Disposition: inline
In-Reply-To: <1bf03e2146ceb5bb36b81f1ce64354b0.squirrel@clueserver.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280949>

On Thu, Nov 05, 2015 at 01:16:54PM -0800, alan@clueserver.org wrote:

> I created an orphan branch from 3.12-rc1. I then used git format-patch to
> generate patches from 3.12-rc1 to HEAD. (Over 7000 patches.) I use git am
> to apply them to the orphan branch. At patch 237 it fails to apply. (It
> appears the patch is from a block of code added with a merge commit, but
> it is somewhere in the middle of the block.)
> 
> Are merge commits supposed to screw up git-format-patch?

Yes. There is no defined format for merge patches, so git-format-patch
cannot show them. What you're trying to do won't work.

If your goal is to have the history at HEAD truncated at 3.12-rc1, you
are probably better off using a graft and having "filter-branch" rewrite
the history based on that. That will preserve merges and the general
shape of history.

> I also tried using clone with depth and --single-branch set.  It ignored
> the depth setting and gave me the whole branch all the way back to 2.6.x.

Was it a local clone? Depth is ignored for those (it _should_ print a
warning). If so, try --no-local to make it act like a "regular" clone.

> I tried using graft and filter-branch. None of the descriptions are very
> clear. None of them worked either. Filter-branch died on a commit
> somewhere in 2.6 land that had no author. (Which is outside of the commits
> I want to keep.)

I suspect you need to graft more than just the commit at v3.12-rc1. For
example, consider this history graph:

  --A--B--C--D---G--H
           \    /
            E--F

If we imagine that H is the current HEAD, and D is our tag (v3.12-rc1),
then making a cut between D and C will not have any effect on the side
branch that contains E and F. Commits A and B are still reachable
through them.

You can find the complete set of boundary commits like this:

  git log --boundary --format='%m %H' v3.12-rc1..HEAD

and then graft them all like this:

  git log --boundary --format='%m %H' v3.12-rc1..HEAD |
    grep ^- | cut -d' ' -f2 >.git/info/grafts

Then you should be able to run "git filter-branch" to rewrite the
history based on that.

I think you can probably get the same effect by running:

  git filter-branch v3.12-rc1..HEAD

Of course that leaves only the problem that filter-branch is
horrendously slow (for the kernel, most of the time goes to populating
the index for each commit; I think filter-branch could probably learn to
skip this step if there is no index or tree filter at work).

> I tried creating an orphan branch and using cherry-pick
> v3.12-rc1..linux-3.12.y. It blew up on the first merge commit it hit. I
> tried adding in "-m 1" to try to get it to pick a parent, but then it died
> on the first commit because it was not a merge.

That won't do what you want. Cherry-pick doesn't preserve merges. When
you pick a merge and choose a mainline, it is effectively saying "treat
that as the only interesting parent" and squashes the result down to a
single non-merge commit.

If you wanted to follow this path (starting at an orphan and moving the
patches over), I think rebase's "--preserve-merges" would be your best
bet. It used to have some corner cases, though, and I don't know if
those were ever fixed. I'd say filter-branch is the most-supported way
to do what you want.

> All I want to do is take a branch from linux-stable and create a branch
> that contains just the commits from where it was branched off of master
> until it hits HEAD. That is it. All the scripts that I have seen that
> claim to do just what I want break when it hits a merge or a bogus author.
> (How that got into linux-stable, I have no idea. The commit is 10 year
> old!)

As an aside, which commit caused the bogus-author problem? Filter-branch
generally tries to preserve or fix problems rather than barfing, exactly
because it is often used to rewrite-out crap. I wonder if there is
something it could be doing better (though again, I think in your case
you are hitting the commit only because of an incomplete cut with your
grafts).

-Peff
