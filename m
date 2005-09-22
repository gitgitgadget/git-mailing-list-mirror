From: Petr Baudis <pasky@suse.cz>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 18:01:13 +0200
Message-ID: <20050922160113.GL21019@pasky.or.cz>
References: <E1EISTu-0000MI-Gz@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 18:01:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EITVe-0007JP-PY
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 18:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVIVQBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 12:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbVIVQBP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 12:01:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34699 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751127AbVIVQBP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 12:01:15 -0400
Received: (qmail 19200 invoked by uid 2001); 22 Sep 2005 18:01:13 +0200
To: Jon Loeliger <jdl@freescale.com>
Content-Disposition: inline
In-Reply-To: <E1EISTu-0000MI-Gz@jdl.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9132>

Dear diary, on Thu, Sep 22, 2005 at 04:55:26PM CEST, I got a letter
where Jon Loeliger <jdl@freescale.com> told me that...
>     I now know that Linus has updated his tree with new -rc2 parts.
>     I want it.  In fact, I want it on the "origin" or "master" branch.
>     (Or both.  And I don't know which.)
> 
>     How do I get Linus' updates and merge them into the "origin" branch
>     without changing to that branch first?
> 
>     I think I can fetch the Linus updates by doing something like this:
> 
> 	git fetch origin
>     or
> 	git fetch rsync://....path/to/linus-2.6-git
> 
>     That will just grab the Objects and throw them into my .git/objects.
> 
>     But how to do the merge?  I think that the merges all require
>     the "target branch" to be the "active"/checkedout branch, right?
>     I don't know how to now say "Merge-up those new Objects on the
>     origin branch".

[I say 'master', but I mean the whatever branch you are currently
working on.]

Your origin branch just represents what Linus has in his master branch.
You don't ever merge anything to it - if you fetch new stuff from Linus,
it simply gets updated to point at the newest Linus' stuff. You can then
merge your 'origin' branch to your 'master' branch, therefore getting
the newest Linus' stuff there.

About two nights ago I tried to describe all this branching stuff in
Cogito's README. It is aimed at Cogito, but generally appliable to GIT
as well. s/cg-/git-/, cg-update is git-pull, and instead of using
cg-branch-* you edit stuff in .git/remotes. It'd be interesting to know
how much more light it manages to shed on the issue, and generally what
do people think about it:


Understanding GIT branching and merging
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cogito's (inherited from GIT) concept of branching and merging may be a little
confusing at first, since it can be different from what you knew so far. First,
"branch" is too abstract word for us, so we will abandon it for now. We will
present two other key concepts instead:

	- Repository - when you did `cg-clone` or `cg-init`, you created
	  a repository. That is a kind of container holding (usually) all your
	  history and data.

	- Head - each repository has some heads available. Those are kind of
	  handles for various sequences of commit. A head contains simply a
	  pointer to the last commit in the sequence, and if you commit 'onto'
	  a head, the pointer will be advanced to the new commit. Your
	  "current" head is the one you are currently working on. It is
	  normally called 'master'.

Now let's take an hypothetical repository:

	repository
	+--------+
	|  master<  heads
	|   unoji<
	+--------+

Let's suppose that we want to fork off master's development. We have two
possibilities, either make new repository for it, or a new head.

Let's say that we want to fork it off for our work offline on a notebook,
so we will make it through cloning the repository to our notebook. What
will `cg-clone` do?

	+--------+
	+--------+
First it creates an empty repository

	+--------+
	$  origin<
	+--------+
Then it creates an 'origin' head, and will copy all the history from the
remote repository's 'master' head there. So this head exists to reflect
the state of the remote repository. The important point is that it is
called 'origin' in our new repository, even through it corresponds to
a 'master' head in the old repository. This is normal - you can name your
local heads whatever you want.

The dollar sign denotes that this head is associated with a "remote branch"
- a source location of the head is saved somewhere and you can fetch the
head and possibly push to it.

	+--------+
	|  master<
	$  origin<
	+--------+
Finally it copied over the 'origin' head to the 'master' head, which will
from now as your current head represent your local development in the
repository.

So you do some local development, do few commits on the 'master' head and
want to catch up with the upstream repository. You use 'cg-update', but what
will it do?

	+--------+
	|  master<
	$  origin< < < < <
	+--------+
First, it will populate your 'origin' head with the new commits from the
remote's 'master' head.

	+--------+
	|  master<-M-.
	$  origin>---'
	+--------+
Then, it will merge those new commits to your 'master' head.

Now let's imagine that there is also another head 'unoji' on the other side
besides 'master', containing some cool commits not in 'master' (it has such an
exotic name, after all...). You want to merge its commits to your head too?

	$ cg-branch-add r-unoji 'http://remote/repository#unoji'
	$ cg-fetch r-unoji

will make your repository look like

	+--------+
	|  master<
	$  origin<
	$ r-unoji<
	+--------+

with 'r-unoji' containing stuff from the remote's 'unoji' branch.

Ok, you did some development, but you decided not to merge it into upstream's
'master' yet since it is not yet stable enough. However, you want to upload it
into the upstream repository since it is public and you want people to be able
to try out your stuff. Easy, let's push it to a new head on the server.

	$ cg-branch-add upmirror 'git+ssh://remote/repository#nislu'

will make your repository look like:

	+--------+
	|  master<
	$  origin<
	$ r-unoji<
	$upmirror|
	+--------+

Note that 'upmirror' has no head associated, it has just the "remote branch"
info. That is because it needs no head since it's solely for pushing. It is
however normal to have a head (frequently it's the 'origin') both for pulling
and pushing.

	$ cg-push upmirror

will then make the remote repository look like:

	+--------+
	|  master<
	|   unoji<
	|   nislu<
	+--------+

with 'nislu' on the remote side corresponding to the 'master' in your local
repository.

Ok, so this is how it goes for multiple repositories, where the cloned
repositories are essentially single branches. Note that if you clone the
repository locally, it can be actually very cheap, basically for free with
`cg-clone -l` (but please read its documentation).

But what if you still do not want multiple repositories? The key here is to
change your "current head" from 'master' to some new head, and then to be
able to switch back and forth. This is unfortunately something Cogito does
not let you do directly right now, but you can use core GIT commands

	$ git-checkout -b aspyk

to create a new 'aspyk' head and switch to it, and

	$ git-checkout master

to switch back to 'master' later, etc. Note that between the switching,
Cogito will work just fine even if your current head is not 'master'.

You can get the list of available heads by

	$ cg-status -g

where the current head is marked by '>' and remote heads are marked by 'R'.
You can also get the list of source locations for remote heads by

	$ cg-branch-ls


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
