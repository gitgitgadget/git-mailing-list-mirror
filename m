From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT vs Other: Need argument
Date: Mon, 23 Apr 2007 16:22:49 -0700
Message-ID: <7vd51ud6ba.fsf@assigned-by-dhcp.cox.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<20070417104520.GB4946@moonlight.home>
	<8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	<Pine.LNX.4.64.0704181130150.12094@racer.site>
	<alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704191118050.8822@racer.site>
	<alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
	<4627ABBB.8060709@softax.com.pl>
	<alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
	<877is29b1l.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 01:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg7rz-0007KZ-N3
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 01:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbXDWXWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 19:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbXDWXWw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 19:22:52 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38054 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbXDWXWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 19:22:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423232251.KVVT1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 19:22:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qnNp1W00f1kojtg0000000; Mon, 23 Apr 2007 19:22:50 -0400
In-Reply-To: <877is29b1l.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	23 Apr 2007 11:54:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45379>

Carl Worth <cworth@cworth.org> writes:

> So, currently, all non-default branches have a sort of second-class
> status from the point of view of users that just want to track
> them.

For some time when people compared hg and git they said git
supports multiple branches in repository more naturally.  And
using more than one branch in a single repository, especially in
one with a working tree, is more convenient for certain things,
such as comparing the branches (both "diff A B" and "log A..B").

But that does not necessarily mean we are forced to use as small
number of repositories as possible and use branches to represent
related work.

If for example all the kernel related repositories in kernel.org
were actually represented as a single repository with hundreds
of branches, with default set to Linus's 'master', people who
would want to track subsystem maintainers' trees would feel less
convenient as they always have to first clone (perhaps with -n
because they are not interested in a checkout of Linus's tree)
and then 'checkout -b' for the subsystem branch of their choice.

But that is not how the kernel group organize the repositories
for their project.  Each subsystem maintainer have his own tree
or trees, and a repository can be about a topic or various
degree of doneness.  So at that level, all repositories are
equal and it is just a matter of picking the right URL to clone
from.

Instead of trying to make each branch the target of 'clone'
intended for one class of audience as your message implies, you
could publish one repository (you might arrange them to share
the objects via alternates to reduce storage requirements, but
that is an implementation detail and invisible to your users)
per an intended class of your audience.  Your work, inside one
repository done on multiple branches, could be pushed into more
than one repositories, each of which has "the default" (and
possibly "only") branch set to point at the theme of your branch
in your local repository.

I think something like this might even work out of the box.  On
the public box you publish your branch A and B on, have three
repositories (i.e. number of branches plus one) like this:


	cw-master.git/
        cw-A.git/
        cw-B.git/

Everything under cw-$X.git (for X in A B) are symlinks to the
corresponding place in cw-master.git/, except HEAD.  Make
cw-A.git/HEAD points at refs/heads/A while cw-B.git/HEAD points
at refs/heads/B.

And the maintainer (you) would push into cw-master.git/ and tell
people about cw-$X.git repositories but not necessarily about
cw-master.git/ repository.

Do not complain that the above is cumbersome to set up, not just
yet.  That is not my point.  The point is that you are trying to
solve this from the consumer side, but I am wondering if this is
actually a problem on the publisher side.  And _if_ the problem
is on the publishing side, git-clone on the client side to track
different branch is not the way to solve that problem.  Rather,
git-clone (or maybe a new program git-publish-repository) to
make it easier to set up the publishing side might be what we
need.
