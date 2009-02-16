From: Jeff King <peff@peff.net>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 17:43:30 -0500
Message-ID: <20090216224330.GA23764@sigill.intra.peff.net>
References: <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm> <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com> <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302> <4999BD54.8090805@gmail.com> <7vprhidpnc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 23:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZCD3-00042c-Dk
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 23:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbZBPWng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 17:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbZBPWng
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 17:43:36 -0500
Received: from peff.net ([208.65.91.99]:54320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbZBPWng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 17:43:36 -0500
Received: (qmail 23335 invoked by uid 107); 16 Feb 2009 22:43:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 16 Feb 2009 17:43:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2009 17:43:30 -0500
Content-Disposition: inline
In-Reply-To: <7vprhidpnc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110256>

On Mon, Feb 16, 2009 at 01:43:03PM -0800, Junio C Hamano wrote:

> Sergio Callegari <sergio.callegari@gmail.com> writes:
> 
> > ... is there some case where one wants
> > and has reasons to commit to a detached head before making a temporary
> > branch on it?
> 
> Absolutely. I do it all the time for minor fix-ups after applying other's
> patches on a newly created topic branch.

This question got me thinking. At the time that detached HEAD was
introduced, I argued for a loud warning message, claiming that for most
users, commiting on a detached HEAD was dangerous and unintentional and
there _should_ be a big warning message. And like then, committing on a
detached HEAD is still not something I generally do.

But then I realized there is actually one time: during interactive
rebase, which detaches HEAD during the rebase processs, and then puts
the final detached value back into the branch ref for you (or not, if
you abort).

Which made me think how such a process interacts with pushing into a
non-bare repo. If we are detached, the push cannot, by definition, touch
the ref pointed to by HEAD, since ther isn't one. But there is still
some sense of "current branch" recorded by rebase; after the rebase is
completed, it attempts to put a new value in the ref.

So this is still some conflict possible even with the current safety
valves. Fortunately, the ref update is smart enough to realize the value
has changed behind our back:

  $ git rebase --continue
  error: Ref refs/heads/master is at 5836aa51b217a1c88f32107cbcd606bece018657 but expected d2d7bf3fcaa927ef997dbcdaf9d9a9e176d6a8d0
  fatal: Cannot lock the ref 'refs/heads/master'.

But that doesn't give any hint to the user about what happened, or how
to fix it.

So:

  1. How can we improve this situation?

     One option is including "the branch we are rebasing on" in the list
     of refs to deny. I don't like that, though, because that becomes an
     ever-growing list of places for receive-pack to look, some of which
     are not even part of core git.

     I think the best bet is just detecting the situation (which we
     already do) and giving a sane recipe for resolution. Probably
     something like:

        git branch incoming master ;# stash newly pushed changes
        git branch -f master $old_sha1 ;# restore previous state
        git rebase --continue ;# finish the rebase
        git merge incoming ;# pull in the pushed changes

  2. Are there other "we are implicitly assuming $ref won't change
     behind our backs" long-term commands?

-Peff
