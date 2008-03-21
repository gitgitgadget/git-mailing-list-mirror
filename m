From: Jeff King <peff@peff.net>
Subject: Re: Switching branches without committing changes
Date: Thu, 20 Mar 2008 23:52:09 -0400
Message-ID: <20080321035209.GA2169@coredump.intra.peff.net>
References: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 04:53:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcYJK-0006j1-Gp
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 04:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbYCUDwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 23:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbYCUDwM
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 23:52:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1413 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbYCUDwM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 23:52:12 -0400
Received: (qmail 21104 invoked by uid 111); 21 Mar 2008 03:52:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 20 Mar 2008 23:52:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2008 23:52:09 -0400
Content-Disposition: inline
In-Reply-To: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77701>

On Thu, Mar 20, 2008 at 11:27:09PM -0400, Joe Fiorini wrote:

> I'm trying to switch branches without committing my changes.  Is this  
> possible?  For example, I'm working on a site, I'm testing the  
> implementation of a new technology (branch B), I'm not quite done there 
> (or I forget to commit everything) and I want to implement something else 
> new.  I create a new branch off of B, called B.1, and then make some 
> changes.  I commit only the changes that apply to B.1 and then try to go 
> back to B.  However, I get an error saying a file I changed in B is not 
> uptodate and it cannot merge.  What am I doing wrong and how can I get 
> back to B?

It sounds like you still have some changes in your working tree, and
that is preventing the branch switch.

Generally you would have stashed those changes before working on the
second task, like:

  git checkout B
  hack hack hack
  # oops, I want to work on some other topic
  git stash
  git checkout -b B.1 B
  hack hack hack
  git commit
  # now I'm ready to go back to my original work
  git checkout B
  git stash apply

That example uses git-stash, but you could just as easily do it with a
"work in progress" commit on a branch (which is how people did it before
git-stash was written). Now in your case, I get the impression you have
done this:

  git checkout B
  hack hack hack
  # oops, I want to work on some other topic
  git checkout -b B.1 ;# keeps all of your changes in the working tree
  hack hack hack
  # now my second topic is ready for commit
  git add ;# selectively, or with git add -p
  git commit
  # now I'm ready to go back to my original work
  git checkout B

but the last checkout doesn't work cleanly, because you have some
uncommitted changes in your working tree for some file 'A', but moving
from B.1 to B would also change 'A'.

So you actually need to merge those changes (actually, you are merging
the _undo_ of the B.1 changes) to get back to B. Unfortunately,
git-checkout is smart enough to do merges that don't touch the same
file, but not anything more complex. So instead, we can use stash again.
At this point, you can do:

  git stash
  git checkout B
  git stash apply

which will actually invoke the "real" merge machinery to correctly sort
out the changes.

So what you did isn't wrong, but you probably would have had a much
easier time if you stashed _before_ doing the B.1 work. It would have
made your git-add easier, and it makes testing more accurate (since you
never actually tested the state committed to B.1; you tested B.1 + your
changes that will be commited on top of B).

Make sense?

-Peff
