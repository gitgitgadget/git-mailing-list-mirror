From: Jeff King <peff@peff.net>
Subject: Re: Git push performance problems with ~100K refs
Date: Fri, 30 Mar 2012 05:32:08 -0400
Message-ID: <20120330093207.GA12298@sigill.intra.peff.net>
References: <201203291818.49933.mfick@codeaurora.org>
 <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
 <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 11:32:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDYBv-0004il-GP
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 11:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760518Ab2C3JcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 05:32:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41048
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760496Ab2C3JcO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 05:32:14 -0400
Received: (qmail 13612 invoked by uid 107); 30 Mar 2012 09:32:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 05:32:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 05:32:08 -0400
Content-Disposition: inline
In-Reply-To: <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194342>

On Thu, Mar 29, 2012 at 08:43:06PM -0600, Martin Fick wrote:

> >It is trying to minimize the transfer cost.  By showing a ref to the
> >sending side, you prove you have chains of commits leading to that
> >commit
> >and the sender knows that it does not have to send objects that are
> >reachable from that ref. One thing you could immediately do is de-dup
> >the
> >100k refs but we may already do that in the current code.
> 
> I am sorry I don't quite understand what you are suggesting is taking
> up the CPU time?  It doesn't take that much CPU just to gather 100refs
> and send them to the other side, that would be i/o bound.  Could you
> explain what is happening on the receiving side that is so time
> consuming?

You said earlier that it is "git rev-list --objects --stdin --not --all"
taking up all the CPU. That is probably called by
check_everything_connected. And that is why it is slow when you push
even a small change, but fast when you push only a deletion (in the
latter case, we skip the check because there are no new objects).

As for why that rev-list is slow, my suspicion is that it may be
quadratic behavior in commit_list_insert_by_date as we process the set
of negative refs. Basically, we keep a priority queue of commits to be
processed in our graph walk, but the queue is stored as a linked list.
So insertion is O(n), and building a list of n items (especially if they
are not in sorted order) is O(n^2).

I've run into this before dealing with repos with many refs (at GitHub,
some of our alternates repositories hit 100K refs, although typically we
have a lot of duplicated refs, as we are storing identical tags from
many repositories).

But that's just a suspicion. I don't have time tonight to work out a
test case. Is it possible for you to run something like:

  # make a new commit on top of HEAD, but not yet referenced
  sha1=`git commit-tree HEAD^{tree} -p HEAD </dev/null`

  # now do the same "connected" test that receive-pack would do
  git rev-list --objects $sha1 --not --all

That should replicate the slow behavior you are seeing. If that works,
try running the latter command under "perf"; my guess is that you will
see commit_list_insert_by_date as a hot-spot.

Even doing this simple test on a moderate repository (my git.git has
~1100 refs), commit_list_insert_by_date accounts for 10% of the CPU
according to perf.

-Peff
