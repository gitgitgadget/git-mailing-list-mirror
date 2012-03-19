From: Jeff King <peff@peff.net>
Subject: Re: Feature request: don't require both bad and good when bisecting
Date: Mon, 19 Mar 2012 11:30:06 -0400
Message-ID: <20120319153006.GD24848@sigill.intra.peff.net>
References: <20120318212957.GS1219@chaosreigns.com>
 <4F67468B.4070502@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: darxus@chaosreigns.com, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 19 16:30:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9eXQ-0005FB-AC
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 16:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161538Ab2CSPaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 11:30:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53506
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161488Ab2CSPaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 11:30:10 -0400
Received: (qmail 31141 invoked by uid 107); 19 Mar 2012 15:30:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Mar 2012 11:30:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Mar 2012 11:30:06 -0400
Content-Disposition: inline
In-Reply-To: <4F67468B.4070502@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193432>

On Mon, Mar 19, 2012 at 03:45:31PM +0100, Andreas Ericsson wrote:

> On 03/18/2012 10:29 PM, darxus@chaosreigns.com wrote:
> > I'd like to be able to tell get only that I know the latest commit is bad,
> > and have it go find a good commit, then do the bisecting.  Maybe something
> > like the opposite of a binary search, start with the last commit, then
> > second to last, then 4th to last, 8th to last, etc., till it finds a good
> > commit.
> > 
> 
> Assuming the good commit is the 13'th from HEAD, you'd get the same nr
> of attempts by just specifying a commit 100 revisions in the past and
> doing the already implemented binary search as you would from trying 4
> commits at a time to get at the good one.
> 
> Binary search is a "divide and conquer" algorithm (running in O(log n)
> time), so it handles extremely large datasets very efficiently.

Yeah. The OP's suggestion is to search backwards, increasing the stride
exponentially. That would end up finding a good commit in O(lg n),
though not with any great accuracy (e.g., for an old bug, you'd end up
considering the whole first half of history as a single stride).  Since
bisection would then narrow the result in O(lg n), I think
asymptotically you are not any better off than you would be just
arbitrarily checking the root commit[1], and then starting the bisection
from there.

But both schemes run into a problem where old commits are often not very
testable. For example, when I am bisecting in git.git, I will run into
something like this:

  1. Some feature is introduced in v1.7.0.

  2. A bug in the feature is introduced in v1.7.2.

  3. Somebody notices and reports the bug in v1.7.5.

There is no point in testing anything prior to v1.7.0, as your test
cannot succeed before the feature existed. And worse, it will actively
break a bisection. Pre-v1.7.0 versions will appear buggy, but it is in
fact a _different_ bug than the one you are searching for (the bug is
that the feature isn't there yet). This has been discussed many times on
the list, but the short of it is that you will not get sensible
bisection results if you have multiple bugs (or a bug that comes and
goes throughout history).

So bisect really needs some input from the user to find a sensible
boundary. And finding that boundary (if the user doesn't already know
it) is generally a manual thing. Because it is usually easy for a human
to recognize that the failure mode for points (1) and points (3) above
are different, but hard to write a script that correctly tests for it.

IOW, my procedure for a bug like the above is usually to walk backwards
along major tagged versions, manually interpreting the results. When I
try v1.6.0 and my test blows up (because the feature isn't implemented),
I recognize it, dig a little with "git log" to find where it was
implemented, and only then write a script for automated bisection.

-Peff

[1] There can also be multiple roots, which makes a backwards-walking
    algorithm much more complex. I think instead you could simply test
    and mark all the roots, and then start the bisection from there. But
    again, you are unlikely to have written a test script that will work
    on such antique versions of the project.
