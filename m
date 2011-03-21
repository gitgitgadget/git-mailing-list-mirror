From: Jeff King <peff@peff.net>
Subject: Re: [bug] git checkout lies about number of ahead commits when
 switching from detached HEAD
Date: Mon, 21 Mar 2011 06:35:49 -0400
Message-ID: <20110321103549.GA16334@sigill.intra.peff.net>
References: <4D8525C9.2060203@gmail.com>
 <20110319222852.GB7116@sigill.intra.peff.net>
 <20110319224726.GC7116@sigill.intra.peff.net>
 <7vy64avdba.fsf@alter.siamese.dyndns.org>
 <20110320090111.GA15641@sigill.intra.peff.net>
 <7vd3llwrah.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 11:35:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1cSr-0007eB-DY
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 11:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab1CUKfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 06:35:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41420
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab1CUKfv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 06:35:51 -0400
Received: (qmail 11910 invoked by uid 107); 21 Mar 2011 10:36:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 06:36:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 06:35:49 -0400
Content-Disposition: inline
In-Reply-To: <7vd3llwrah.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169579>

On Sun, Mar 20, 2011 at 12:00:38PM -0700, Junio C Hamano wrote:

> "Let the one that has more information to do the clearing" is not about
> performance but about correctness and reusability potential.
> 
> When you insert a new traversal B in the existing codeflow before another
> traversal C, B knows not just which commits it started from (hence knows
> which commits were marked by it), but more importantly it also knows what
> mark bits were potentially modified. If the existing codeflow had another
> traversal A before you added B, and C took the marks A left on the objects
> into account while doing its work, the only sensible clean-up is to clear
> marks B touched (and no other marks) immediately after B, and we obviously
> do not want C (and any later traversals in other codepaths that we may
> later want to insert B) to have too much knowledge of which marks may have
> been clobbered by B.

I see what you are saying, but from a software engineering perspective,
I doubt it works very well in practice. The commit flags are basically
global variables. So imagine you have two traversals, A and C, and C
cares about some intermediate result from A. You want to add a new one,
B, in between the two, and have it clean up after itself. This is going
to work only if one of the two is the case:

  1. B does not use any of the same marks as A. Otherwise, it will end
     up clearing part of A's result during cleanup (not to mention that
     it may get a bogus result because of what was left from A).

  2. B works on a totally disjoint set of history from A and C.

I don't think (1) is that realistic in the general case. Sure, you might
only want to use TMP_MARK. But the revision walker behind the scenes is
using SEEN and UNINTERESTING, which is going to bring you into conflict.

For (2), there are cases where it works. In this recent bug, for
example, it would sometimes produce the correct results depending on the
exact traversal done in the orphan-warning (e.g., if you were exploring
way back in history near a tag, the traversal wouldn't come near the
commits needed to get the tracking info for the new branch).

But you can only know that it's a reasonable thing to do if you manually
analyze A, B, and C as a set, and even then only if you can know pretty
specifically what the inputs are. So there's no modularity, and in any
reasonably complex case you are not going to have enough control of the
inputs to be sure it isn't buggy.

So in my mind, the only way to keep sanity is to never insert a "B"
between an A and C who care about each other's results. And unless you
are specifically depending on a previous walk, each walk will want all
marks cleared (whether it's because the previous walker cleaned up, or
because we are clearing them before starting).


This whole global marks thing is really pretty nasty when you come right
down to it. I know why we do it; it's faster to dereference the pointer
rather than looking up the flags in some external per-revision-walker
hash table. But I wonder if we could come up with something else close
to it in speed that would allow per-walker flags.

We allocate commits from a custom allocator pool. I wonder if we could
use the offset from the commit pointer to the pool base to assign an
index to each commit, and then use that index to access an array of
flags in struct rev_info. There are a few problems:

  1. Our allocator has many pools, and we don't know which one is the
     right base. So I don't think the offset thing works, and we would
     be stuck assigning some index into each allocated object.

  2. We'd have to grow the rev_info array dynamically. The growth itself
     is probably not a huge deal, as its amortized constant effort. But
     on each flag access we'd have to do a bounds-check. I don't know if
     that would be measurable or not.

> > So how about this?
> >
> >   [1/3]: checkout: add basic tests for detached-orphan warning
> >   [2/3]: checkout: clear commit marks after detached-orphan check
> >   [3/3]: checkout: tweak detached-orphan warning format
> 
> Looks very sensible, except for the clear_marks(-1) that clears everything
> I have a slight doubt about.

I can change it to UNINTERESTING. As far as I can tell, that is the only
one set by prepare_revision_walk. It just felt like a leaky abstraction
for this code to have to know which flags might get set by the
underlying code. But obviously callers do need to know and care which
flags might be set and when.

-Peff
