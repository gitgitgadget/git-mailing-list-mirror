From: Theodore Tso <tytso@mit.edu>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 09:34:58 -0400
Message-ID: <20080625133458.GE20361@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Jeske <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 15:36:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBVAL-0002KQ-Bu
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 15:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbYFYNfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 09:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756050AbYFYNfH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 09:35:07 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:36854 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755985AbYFYNfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 09:35:06 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBV9I-0001sv-A4; Wed, 25 Jun 2008 09:35:00 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBV9G-000713-Oo; Wed, 25 Jun 2008 09:34:58 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86278>

On Wed, Jun 25, 2008 at 05:20:49AM -0000, David Jeske wrote:
> The other big one is ACLs in 'well named' repositories, so multiple
> people can safely be allowed to add changes to them, without giving
> them ability to blow away the repository. I can see this isn't the
> way all git users work, but at least a few users working this way
> now with shared push repositories. This is just making it
> 'safer'. Also seems pretty easy to do.

So this isn't true security, since someone determined (or an ingenious
enough fool) can always blow away repository if you allow them to add
changes; they could just add a change which rm's all of the files,
yes?  You just want to prevent something stupid.

Well, as long as they don't do non-fast forward updates (i.e., they
never do something like: "git push publish +head:head", or any other
incantation involving a leading '+' in the refspec), they should be
pretty safe.  I don't see how they would do any damage just due to
user confusion.  So I think git is pretty safe as-is.

> > This is also easy; you just establish remote tracking branches. I
> > have a single shell scripted command, git-get-all, which pulls from
> > all of the repositories I am interested in into various remote
> > tracking branches so while I am disconnected, I can see what other
> > folks have done on their trees.
> 
> Yes, so I'd have the same thing, except instead of a remote
> repository, it would be a pattern of the branch namespace, such as
> /origin/users/jeske/*.

And the advantage of using branch namespaces instead of separate
remote repositories is.... ?  I don't see any....

> Think about using CVS. user does "cvs up; hack hack hack; cvs commit
> (to server)". In git, this workflow is "git pull; hack; commit;
> hack; commit; git push (to server)". I want those interum "commits"
> to share the changes with the server. I want to change this to "git
> pull; hack; commit-and-share; hack; commit-and-share; git-push (to
> shared branch tag)"

OK, so *why* is it a good idea to ask people to share their
in-progress work?  What's the upside?  Maybe if the idea is as backup
if people are working from their laptops, and they're about to travel
internationally or some such, but in general, sharing in-progress work
is highly overrated.

The other thing is in your design assumption is that remote
repositories are somehow expensive, when in fact they are very cheap;
use either repo.or.cz or github; they support repo sharing so there
isn't major cost to letting each developer having their own repository
to push to.

So the way I would do things is to simply encourage people to do start
their work by branching off of an up-to-date master branch, but *not*
do any git pulls or git pushes.  They can use git commit as necessary
to save interim work, and they do all of this work on a private
branch.  When they are done doing their work, they should review the
git commit points and make sure they make sense; in some cases they
may be better off squashing the commits down to a single commit, or
possibly refactoring their work so that each individual commit is
free-standing, so that their series of commits is git-bisectable
(i.e., after each commit the tree will fully compile and fully pass
the project regression test suite).

Once they have done *that*, they make sure the master branch has been
fully updated, and then do a git-rebase on their feature branch so
that it is up-to-date with respect to master, and then they do a full
build and regression test.  Then they switch back to the master
branch, and do a "git push publish" --- where <publish> is defined in
.git/config to be something like this:

[remote "publish"]
	url = ssh://master.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
	push = refs/heads/master:refs/heads/master

This will *only* push the master branch (and not any of the feature
branches), and it will not allow non-fast forward merges.  Hence, if
the user screwed up and accidentally made changes to the master branch
(say, an accidental git-rebase while on the master branch, or
something else bone-headed), the git push will fail.  This gives you
the safety you desire about not accidentally screwing up the master branch.


And you're done.  The only reason why you need a per-user repository
if you want some safety in terms of backups in case the work being
done on the laptop gets destroyed, but you can get that pretty much
for free via git.or.cz or github.  I really don't buy the sharing
argument, because if you are in the middle of implementing a feature,
it's generally not useful for others to look at your in-progress work.

> I know that all of what I wrote above seems strange if you don't buy into the
> design assumptions. That it's critical to share a single server-repository,
> that it's critical to have a shared 'well known' branch that only trusts
> clients to add new changes to, etc.. However, these are important.

Yep.  And you still haven't justified why it's critical to share a
single server repository.  ***Why*** is that important?

And when you have shared push repositories, as long as users don't use
the '+', in practice they can only add new changes.  And if you don't
trust them not to use the '+' character in refspecs, are you really
going to trust them not to introduce either bone-headed mistakes into
the code?  Or to "git rm" the wrong files, git commit them, and then
merge that into the repository?  If all you care about is avoiding the
accidentally stupid user mistakes, then putting in a convenience
default so that "git push publish" always does what you want should be
good enough.

So fundamentally, yeah, I think your primary problem is with the
design assumptions, which haven't been justified at all.

       		    	  	       		     - Ted
