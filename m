From: Theodore Tso <tytso@mit.edu>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 07:36:20 -0400
Message-ID: <20080604113620.GB7094@mit.edu>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com> <m3r6bdzm22.fsf@localhost.localdomain> <18c1e6480806040111s606701dfwc8a2ae5f742307b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 13:37:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3rJ7-00051q-7J
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 13:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbYFDLgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 07:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYFDLgk
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 07:36:40 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:51549 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752895AbYFDLgj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 07:36:39 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1K3rL2-0000d1-CL; Wed, 04 Jun 2008 07:39:32 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1K3rI1-0007NO-Ix; Wed, 04 Jun 2008 07:36:25 -0400
Content-Disposition: inline
In-Reply-To: <18c1e6480806040111s606701dfwc8a2ae5f742307b5@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83775>

On Wed, Jun 04, 2008 at 10:11:33AM +0200, David wrote:
> Here is an example:
> 
> o--o--O master
>        \
>         o--o--X--X--X--X--o--o topic
> 
> I want to copy the "X" patches from the topic branch over to master.
> The other patches aren't appropriate for master for whatever reason.
> eg, temporary debugging hacks, but I fixed a few problems in master in
> the X patches and now want to apply them on top of master, and keep
> working on "topic"
> 
> I want to end up with a tree like this:
> 
> 
> o--o--O--X'--X'--X'--X' master
>        \
>         o--o--X--X--X--X--o--o topic
>
> After getting the branches like this, I would then (try to) rebase
> topic like this:
> 
> o--o--O--X'--X'--X'--X' master
>                       \
>                        o'--o'--o'--o' topic
> 


OK, so assume the tree looks like this:

 o--o--O master
        \
         1--2--3--4--5--6--7--8 topic

First do a "git checkout topic; git rebase --interactive master", and
reorder the topic branch so it looks like this:

 o--o--O master
        \
         3--4--5--6--1--2--7--8 topic

Now find the commit ID for commit #6 above, and assuming that it's
f1dead2f, run the command "git checkout master; git merge f1dead2f".
Now the graph looks like this:

 o--o--O--3--4--5--6 master
                    \
                     1--2--7--8 topic

You could also use the command:

	"git update-ref refs/heads/master f1dead2f"

which keeps HEAD pointing at the topic branch, but the reason why I
suggested the "git checkout master; git merge f1dead2f" is that the
commands are generally more familiar to git newcomers, and I usually
want to do a test build and run the regression tests on master to make
sure things are clean.


> I say try to, because rebase sometimes gets a lot of dumb (to me,
> maybe I'm not using git correctly) conflicts in cases like this, so I
> end up manually rebasing, by making a new topic branch off master,
> cherry picking into it off the old topic branch, and then removing the
> old branch. Another case where multiple cherry picks would be nice :-)

Note that in the above set of commands, summarized as:

1) "git checkout topic; git rebase --interactive master"
   1a)  "make; make check" to build and run regression tests on the 
   	reordered topic branch.
2) "git checkout master; git merge f1dead2f" (this should be a fast forward)
   2a)  "make; make check" to build and run regression tests on the 
   	updated master branch.

There may be indeed conflicts at the first "git rebase --interactive",
but that's just git being conservative.  Usually it really isnt that
hard to resolve the conflicts, git add the files which required
fixups, and then doing a "git rebase --continue".  And you will have
to do the manual fixup regardless of whether you use "git rebase" or
"git cherry-pick"; the git rebase is just a more automated way of
doing things.

Regards,

						- Ted
