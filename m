From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] fetch: opportunistically update tracking refs
Date: Wed, 15 May 2013 23:37:48 -0400
Message-ID: <20130516033748.GC13296@sigill.intra.peff.net>
References: <20130511161320.GA14990@sigill.intra.peff.net>
 <20130511161652.GD3270@sigill.intra.peff.net>
 <871u9cftjv.fsf@linux-k42r.v.cablecom.net>
 <87r4hcedra.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 16 05:37:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucp0t-0002hk-Bk
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab3EPDhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:37:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:44820 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab3EPDhu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:37:50 -0400
Received: (qmail 20861 invoked by uid 102); 16 May 2013 03:38:19 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 May 2013 22:38:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2013 23:37:48 -0400
Content-Disposition: inline
In-Reply-To: <87r4hcedra.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224470>

On Sun, May 12, 2013 at 11:41:45AM +0200, Thomas Rast wrote:

> >> We miss an opportunity to update "refs/remotes/origin/master"
> >> (or whatever the user has configured). Some users find this
> >> confusing, because they would want to do further comparisons
> >> against the old state of the remote master, like:
> >>
> >>   $ git pull origin master
> >>   $ git log HEAD...origin/master
> >
> > I agree with the patch, but I would use a different reasoning. Your
> > example here is not even correct because the range in the second command
> > would be empty unless the merge conflicted.
> 
> Meh, I just read this again and saw that you actually had *three* dots.
> Serves me right for writing a reply on the phone.
> 
> So the quoted part is indeed correct.

Yes, it's correct, but it is a bit subtle. A better example would
probably be:

  $ git status
  # On branch foo
  # Your branch is ahead of 'origin/master' by 2 commits.

  $ git pull origin master
  [pull 10 new commits]

  $ git status
  # On branch foo
  # Your branch is ahead of 'origin/master' by 13 commits.

That is technically true, but only because origin/master is now out of
date. The more interesting number is 3: the two commits we had already,
plus the new merge commit.

And of course there are infinite variations where you pull on one
branch, and then switch branches to compare on another. But they all
boil down to having an out-of-date view of origin/master that does not
reflect the most recent pull.

-Peff
