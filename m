From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/4] commit lists as priority queues
Date: Thu, 19 May 2011 17:23:49 -0400
Message-ID: <20110519212349.GA28589@sigill.intra.peff.net>
References: <20110519204851.GA28574@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:23:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAhI-0000C8-HE
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933164Ab1ESVXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:23:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47068
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932665Ab1ESVXv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:23:51 -0400
Received: (qmail 20676 invoked by uid 107); 19 May 2011 21:25:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 17:25:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 17:23:49 -0400
Content-Disposition: inline
In-Reply-To: <20110519204851.GA28574@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174005>

On Thu, May 19, 2011 at 04:48:51PM -0400, Jeff King wrote:

> By noting commits we have already added to the list, we can
> shrink the size of "n" in such a repo to the number of
> unique commits, which is on the order of what a normal repo
> would contain (it's actually more than a normal repo, since child repos
> may have branches at different states, but in practice it tends
> to be much smaller than the list with duplicates).
> 
> Here are the results on one particular giant repo
> (containing objects for all Rails forks on GitHub):
> 
>   $ git for-each-ref | wc -l
>   112514

So this seems to work pretty well for us in practice, because our
giant-refs use case is a big alternates repo, and of those ~112K refs,
there are only ~5K or so unique ones. Which is small enough that in this
timing:

>   [before]
>   $ git fetch --no-tags ../remote.git
>   63.52user 0.12system 1:03.68elapsed 99%CPU (0avgtext+0avgdata 137648maxresident)k
>   1856inputs+48outputs (11major+19603minor)pagefaults 0swaps
> 
>   $ git fetch --no-tags ../remote.git
>   6.15user 0.08system 0:06.25elapsed 99%CPU (0avgtext+0avgdata 123856maxresident)k
>   0inputs+40outputs (0major+18872minor)pagefaults 0swaps

The 6 seconds are not spent doing anything related to mark_complete, so
it's effectively fast enough (i.e., we made "n" small enough that the
O(n^2) behavior doesn't matter). But obviously there's still a
worst-case where you get bad behavior if you have a lot of unique refs.
I don't know if anybody has that situation in practice (it might be
something like creating a ref for every commit).

So I also considered a different approach, which is to use a better data
structure to hold the sorted commit list (a priority queue). That gives
a similar speedup:

  $ git fetch --no-tags ../remote.git
  6.20user 0.03system 0:06.25elapsed 99%CPU (0avgtext+0avgdata 123712maxresident)k
  0inputs+40outputs (0major+18885minor)pagefaults 0swaps

and actually has good asymptotic complexity. I also had a feeling we
could use a faster commit_list in other places, since get_revision is
all based around the same pop-and-push-the-parents workflow. But after
spending a few hours on it, it seems that _lots_ of places in the code
work on the assumption of a linked list (or at least doing very simple
in-order traversal), and the changes got very ugly very quickly. And
performance-wise, it doesn't seem to be a huge problem, mainly because:

  1. We don't tend to put more items in a commit_list than the width of
     the history graph. So our "n" tends to be in the dozens at most.

  2. We have the hack in fce87ae (Fix quadratic performance in
     rewrite_one., 2008-07-12) which works OK in practice.

So it's a lot of extra code, and I haven't found a case where it
actually improves performance. But here's that series, just for
reference. We may want to take 1/4, which is an unrelated cleanup.

  [1/4]: Makefile: sort TEST_PROGRAMS list
  [2/4]: basic priority queue implementation
  [3/4]: commit: add infrastructure for priority queues of commits
  [4/4]: fetch-pack: use priority queue for mark_complete

-Peff
