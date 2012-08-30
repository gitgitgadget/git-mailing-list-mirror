From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Thu, 30 Aug 2012 17:48:03 -0400
Message-ID: <20120830214802.GB18636@sigill.intra.peff.net>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
 <20120829205525.GA28696@sigill.intra.peff.net>
 <20120829210032.GA29179@sigill.intra.peff.net>
 <20120829210540.GA31756@sigill.intra.peff.net>
 <20120830125421.GA5687@sigill.intra.peff.net>
 <20120830130327.GB5687@sigill.intra.peff.net>
 <7vy5kws5jn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 23:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Cb0-00042k-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 23:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab2H3VsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 17:48:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48389 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab2H3VsF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 17:48:05 -0400
Received: (qmail 13310 invoked by uid 107); 30 Aug 2012 21:48:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Aug 2012 17:48:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2012 17:48:03 -0400
Content-Disposition: inline
In-Reply-To: <7vy5kws5jn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204568>

On Thu, Aug 30, 2012 at 09:33:48AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The script originally comes from here:
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/33566/focus=33852
> >
> > and the discussion implies that the AUTHOR_DATEs were added to avoid a
> > race condition with the timestamps. But why would that ever have worked?
> 
> I do not see how AUTHOR_DATE would affect anything there, either,
> other than to give reprodusible object names.  The test only sets
> committer-date upfront, so without setting author-date, you would
> still get different object names on commits.  Which suggests me that
> there may be something that tiebreaks based on object names?

Hmm. I wouldn't think so. The order should come from timestamps, with
ties broken by order of insertion, which in turn comes from traversal,
which depends only on parent order. We do check some raw sha1s in the
expected output, but it is only for blobs, not commits.  I guess it
could be some weirdness inside merge-recursive, though, and
not part of the merge-base computation.

So I really don't know how AUTHOR_DATE would change anything. And
indeed, after removing them it still passes on my machine.

However, I think I may understand why it fails if you tweak the
committer dates.

When my unstable-queue was used, I noticed that the merge bases returned
were the same (as you would expect), but that they came in a different
order. Which makes sense, as the order of multiple bases would not
necessarily be deterministic (they do not have an ancestry relationship,
or they would not be merge bases).

So the issue is that when you do a recursive merge with multiple bases,
the order in which you visit the recursive bases is going to impact the
exact conflicts you see. In theory, after the merge is done, you're
going to be at the same state, but the conflicts you see along the way
will be different. And it is this conflicted state that the test is
looking at.

The current test expects a particular order of merge bases based on the
same-second commit timestamps. There is no race condition because of the
setting of GIT_COMMITTER_DATE at the beginning (and _that_ is the real
thing that fixed the race conditions Dscho saw in the thread above; the
AUTHOR_DATE was just a red herring).

So the test is not broken or racy, which is good. It is just testing
something that is somewhat of an implementation detail. We could switch
it to use test_tick, and then adjust the expected output to look for the
expected conflict that git happens to generate in that case. But that is
no better than the current behavior.

But I'm not sure there is a way to test what it wants to test (that we
hit a conflict that involves one of the recursive merge bases) without
relying on the implementation detail. So I'm inclined to just leave it
in place.

-Peff
