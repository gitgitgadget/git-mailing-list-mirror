From: Jeff King <peff@peff.net>
Subject: Re: Pretty format specifier for commit count?
Date: Thu, 22 Jan 2015 07:52:43 -0500
Message-ID: <20150122125243.GB19681@peff.net>
References: <20150119012926.GA24004@thin>
 <54BD0C85.1070001@drmicha.warpmail.net>
 <20150120011724.GA1944@thin>
 <20150120214952.GA18778@peff.net>
 <20150120231110.GC14475@cloud>
 <54C0CCA2.3060307@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: josh@joshtriplett.org, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 13:52:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEHFh-0006SR-J5
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 13:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbbAVMwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 07:52:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:37273 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750916AbbAVMwo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 07:52:44 -0500
Received: (qmail 17073 invoked by uid 102); 22 Jan 2015 12:52:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 06:52:44 -0600
Received: (qmail 8898 invoked by uid 107); 22 Jan 2015 12:53:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 07:53:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2015 07:52:43 -0500
Content-Disposition: inline
In-Reply-To: <54C0CCA2.3060307@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262827>

On Thu, Jan 22, 2015 at 11:10:42AM +0100, Michael J Gruber wrote:

> We do have a linear history when we walk with --first-parent :)

Yes, but I do not think it is robust to adding new commits on top. E.g.,
given:

  A--B--C---F
      \    /
       D--E

a --first-parent walk from F will show F-C-B-A. Now imagine the branch
advances to I:

          G--H---I
         /      /
  A--B--C---F--J
      \    /
       D--E

A walk from I will show I-H-G-C-B-A. F is no longer mentioned at all,
and A, B, and C are now at different positions.

This might be OK in Josh's case. I have an intuition that commits can
only be _removed_ in this case. Which means position from the _top_
might change, but the position from the root will always be the same
(and that is what he wants to be stable).  But I did not think hard
enough to convince myself that this is always the case.

> So, for the changelog for commits "on a branch", where "on a branch" is
> not the git concept but defined by "git rev-list --first-parent" (more
> like hg branches), the count from root would be deterministic and the
> right concept given the appropriate branch workflow.

Certainly the distance to root is deterministic. But I think we are
really counting "number of commits to be output between the root and
this commit". I guess if:

  1. You only ever start from one traversal point.

  2. You are picking only one parent for each merge.

then we know that our queue of commits to examine only ever has 0 or 1
items in it. And therefore a commit is either shown in the same
position from the end, or not shown at all. Because once we get there,
it is deterministic which commits we will show.

> Generation numbers are monotonous but may increase by steps greater than
> 1 on that "branch" if I remember them correctly. I.e., merge commits are
> "weighted" by the number of commits that get merged in.

Sort of. It is the longest distance to (any) root from the commit. So it
is the max() of the generations of the parents, plus one. So for a
simple branch/merge between two lines of development, the increase is
the number of commits that are merged. But a branch that has its own
branches will not increase the generation count by the total number of
commits, but rather by the longest individual sub-branch.

-Peff
