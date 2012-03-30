From: Jeff King <peff@peff.net>
Subject: Re: Git push performance problems with ~100K refs
Date: Fri, 30 Mar 2012 05:40:52 -0400
Message-ID: <20120330094052.GB12298@sigill.intra.peff.net>
References: <201203291818.49933.mfick@codeaurora.org>
 <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
 <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
 <20120330093207.GA12298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 11:41:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDYKK-0006Cb-2w
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 11:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760107Ab2C3Jkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 05:40:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41057
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759343Ab2C3Jky (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 05:40:54 -0400
Received: (qmail 13712 invoked by uid 107); 30 Mar 2012 09:40:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 05:40:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 05:40:52 -0400
Content-Disposition: inline
In-Reply-To: <20120330093207.GA12298@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194343>

On Fri, Mar 30, 2012 at 05:32:08AM -0400, Jeff King wrote:

> But that's just a suspicion. I don't have time tonight to work out a
> test case. Is it possible for you to run something like:
> 
>   # make a new commit on top of HEAD, but not yet referenced
>   sha1=`git commit-tree HEAD^{tree} -p HEAD </dev/null`
> 
>   # now do the same "connected" test that receive-pack would do
>   git rev-list --objects $sha1 --not --all
> 
> That should replicate the slow behavior you are seeing. If that works,
> try running the latter command under "perf"; my guess is that you will
> see commit_list_insert_by_date as a hot-spot.
> 
> Even doing this simple test on a moderate repository (my git.git has
> ~1100 refs), commit_list_insert_by_date accounts for 10% of the CPU
> according to perf.

Actually, I did have time for a simple test. Doing:

  git rev-list HEAD |
  while read sha1; do
    echo $sha1 refs/heads/$sha1
  done >>packed-refs
  git pack-refs

in git.git slows down the test above considerably, and perf reports 90%
of the time spent in commit_list_insert_by_date. So I think that is
indeed the problem.

At one point, I looked at replacing the commit_list implementation with
a heap-based priority queue, but unfortunately many parts of the code
depend on the list-like nature and would need to be rewritten. We might
be able to hack around it by at least adding all of the initial items to
an unordered list, then sorting it into its final form.

-Peff
