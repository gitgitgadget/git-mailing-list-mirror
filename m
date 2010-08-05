From: Jeff King <peff@peff.net>
Subject: Re: jk/tag-contains (Re: What's cooking in git.git (Jul 2010, #05;
 Wed, 28))
Date: Thu, 5 Aug 2010 13:56:40 -0400
Message-ID: <20100805175640.GB15760@sigill>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
 <20100730183709.GC18544@coredump.intra.peff.net>
 <20100731060703.GA21207@burratino>
 <20100731123328.GA5273@coredump.intra.peff.net>
 <7vocdlpsmw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 19:56:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh4gT-0002Xy-Rc
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 19:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384Ab0HER4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 13:56:45 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55791 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630Ab0HER4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 13:56:44 -0400
Received: (qmail 29684 invoked by uid 111); 5 Aug 2010 17:56:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.116)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 05 Aug 2010 17:56:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Aug 2010 13:56:40 -0400
Content-Disposition: inline
In-Reply-To: <7vocdlpsmw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152697>

On Sun, Aug 01, 2010 at 09:04:23PM -0700, Junio C Hamano wrote:

> Sorry, but I am right in the middle of phisically moving, so my weekend
> and evening git time has been nil recently.

Didn't you just do that? ;P

> >> Additional things to do (this is mostly a note to myself):
> >> 
> >>  - refuse to commit with a timestamp long before any parent
> >
> > Agreed.
> 
> You need to be careful here, though.  What if you pulled from somebody
> whose clock is set grossly in the future?

Reading the rest of this thread and thinking about it more, I think
warning is the best thing we can do. Because only the user is in a
position to know whether it is their clock or the previous commit that
is in error. And if it is the previous commit, then only the user knows
what the next logical step is: redo the commit, complain to somebody
else, or just ignore and continue.

> I wonder if we can make fsck to notice a commit with a wrong timestamp
> (i.e. older than some of its parents) and make a note of it (hopefully
> they are miniscule minority)---then during the revision traversal when we
> hit such a commit, we perhaps ignore its timestamp (pretending as if its
> timestamp is one of its children or parent---I haven't thought about the
> details, but the note fsck leaves can record what adjusted timestamp
> should be used) to fix the issue?

That's basically a finer-grained version of what I implemented. Mine
finds the _worst_ skew for the whole graph, and never lets you optimize
a traversal cutoff more than that skew. So it is nicely bounded
space-wise, as it is always a single integer, but you waste effort on
the entire traversal because a couple of commits are skewed. Yours
optimizes perfectly, but needs O(skewed commits) storage. Which is
probably a better tradeoff when the number of skewed commits is tiny
(which is what we expect).

I think your technique would work, but with one note. You probably want
to pull the timestamp from the parent (pulling from the child makes no
sense to me, as there can be an infinite number of children), but you
need to process the parent first and pull from its _corrected_
timestamp. Because at least in the linux-2.6 case, there is a run of
skewed commits. So if you have something like:

  A -- B -- C -- D

A, timestamp = 1000
B, timestamp = 900
C, timestamp = 950
D, timestamp = 1100

where obviously the timestamps are shortened to be readable, but are
meant to be seconds-since-epoch.  You'd probably want to end up with:

A, timestamp = 1000
B, timestamp = 1001
C, timestamp = 1002
D, timestamp = 1100

which means recursing all the way to the root, and fixing timestamps as
you back out.

This seems like just a straight sha1->int mapping, which presumably one
could do using "git notes". Though I worry it could slow down traversal
for all of the lookup misses for non-skewed commits.

-Peff
