From: Jeff King <peff@peff.net>
Subject: Re: Managing websites with git
Date: Tue, 2 Dec 2008 11:55:07 -0500
Message-ID: <20081202165507.GA15826@coredump.intra.peff.net>
References: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com> <20081130170722.GJ6572@eratosthenes.sbcglobal.net> <20081130172717.GA7047@coredump.intra.peff.net> <87k5ajflp0.fsf@sparse.dyndns.org> <20081202011154.GA6390@coredump.intra.peff.net> <87vdu2po5l.fsf@sparse.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Riedy <jason@acm.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7YY2-0004yj-8r
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 17:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbYLBQzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 11:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754699AbYLBQzL
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 11:55:11 -0500
Received: from peff.net ([208.65.91.99]:4361 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659AbYLBQzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 11:55:10 -0500
Received: (qmail 13033 invoked by uid 111); 2 Dec 2008 16:55:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Dec 2008 11:55:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2008 11:55:07 -0500
Content-Disposition: inline
In-Reply-To: <87vdu2po5l.fsf@sparse.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102159>

On Tue, Dec 02, 2008 at 10:55:34AM -0500, Jason Riedy wrote:

> Ah, ok, thanks!  Issuing a warning makes sense.  I'm not sure if
> denying such a push by default does...

I don't know if Junio has made a decision on whether or when the default
should be flipped to 'deny'.

> > Doing git push $remote HEAD:branch-that-is-checked-out
> > has _never_ worked without further action on $remote. Now we're warning
> > about it.
> 
> It works just fine.  I suspect we have different definitions of
> "works".

Fair enough. To be more precise: such a push has always resulted in a
state on the remote end that the user must be aware of when making
further commits, and the result of _not_ being aware and blindly running
"git commit" is to accidentally revert all of the pushed changes. And
even if one _is_ aware, sorting out any existing changes in the index
from pushed changes can be difficult.

So yes, there are workflows that can legitimately make use of a push to
the current branch. But it is still a dangerous operation for a large
number of users (I would argue the majority, but I don't have actual
numbers) that we have seen numerous complaints about.

> To me, that push updates the branch's reference.  The working
> copy and index now may be out of sync, but neither the working
> copy nor the index is the branch's reference.  Trying to commit
> from the index correctly refuses.  The warning is a nice

How is committing from the index refused? Try this:

  mkdir parent &&
  (cd parent &&
    git init &&
    echo content >file &&
    git add file &&
    git commit -m one) &&
  git clone parent child &&
  (cd child &&
    echo changes >>file &&
    git commit -a -m two &&
    git push) &&
  (cd parent &&
    git commit -m oops &&
    git show
  )

You will find that you have just reverted the changes from 'two' with
'oops'.

Committing straight from the working tree (via "git commit <path>" or
"git commit -a") has the same problem.

> (And in context: I used to update the IEEE754 group's web site by
> a git push to the checked-out master, with a hook to reset
> everything.  Worked just fine (and very quickly) until they shut
> off shell access.  There was no need for an extra branch on the
> server side.)

Follow the earlier parts of the thread and you will see that is one of
the sane workflows that has been mentioned. You are aware of the lack of
sync (and you have a hook to address it) and you don't plan on having
any local changes (so sorting them out is easy -- you just "git reset
--hard" to take the pushed content).

> I'll try to find time when I encounter another.  I'm pretty sure
> that switching to denying pushes to checked-out branches is the
> first one that *really* will make me change how I work.

It shouldn't make you change how you work. At most, it will break an
existing setup until you set receive.denycurrentbranch to false (again,
if and when the default value changes). You can prepare for any such
change now by pre-emptively setting the config value.

-Peff
