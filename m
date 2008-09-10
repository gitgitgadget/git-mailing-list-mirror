From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 08:21:18 -0400
Message-ID: <20080910122118.GI21071@mit.edu>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 14:22:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdOic-0004rY-34
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 14:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbYIJMVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 08:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbYIJMVh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 08:21:37 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:44609 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752101AbYIJMVg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 08:21:36 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8ACLK8S011948;
	Wed, 10 Sep 2008 08:21:20 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8ACLI85024275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Sep 2008 08:21:19 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KdOhC-0002bE-9O; Wed, 10 Sep 2008 08:21:18 -0400
Content-Disposition: inline
In-Reply-To: <20080909225603.GA7459@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95514>

On Wed, Sep 10, 2008 at 12:56:03AM +0200, Stephen R. van den Berg wrote:
> The purpose I'd use the origin links for is to manage software projects
> that consist of 7 main branches which have branched in (on average) two
> year intervals, which never get merged anymore.  The only thing that
> happens is that there are backports amongst the branches about two per
> week.
> 
> The only way to perform the backports is by using cherry-pick.
> The history of each backport *is* important though.
> Since all the developers who care about the multiple release branches
> have all the relevant branches in their repository, the presence of
> a origin object is by no means random, it's a certainty.

I'd argue that the origin link is a bit too general for your proposed
use.  One of the problems with the origin link is that it is only a
one way pointer.  Given a newer commit, you know that it is (somehow)
weekly related to a older commit.  So your proposed workflow only
works if cherry-picks only happen in one direction.  That isn't always
true, especially in distributed environments where the bugfix might
happen on someone else's development branch, and then it gets pulled
in, or perhaps rebased in, and you want to know they are related.

I would argue the best way to do that is to store (either in the
object or in the free-form text area) not the link, which would have
to get renumbered but rather the identifier for the bug(s) that this
commit fixes.  So for example, consider a convention where in the body
of the free-form text area, before the Signed-off-by:, Acked-by:, and
CC: headers for those projects that use them, we add something like
the following:

Addresses-Bug: Red_Hat/149480, Sourceforge_Feature/120167

or

Addresses-Bug: Debian/432865, Launchpad/203323, Sourceforge_Bug/1926023

Once you have this information, it is not difficult to maintain a
berk_db database which maps a particular Bug identifier (i.e.,
Red_Hat/149480, or Debian/471977, or Launchpad/203323) to a series of
commits.

The advantage of this scheme is that if a bug has been fixed in
multiple branches, you can see the association between two commits in
two different branches very easily.  Furthermore, you get a link back
to the actual bug in one or more bug tracking systems, which the some
porcelain program could use to transform into a hot-link which when
clicked opens up a browser window to the bug in question.

In contrast, using your proposed origin scheme, if the bug was
originally created in some development branch, and then cherry picked
into two separate maintenance branches, if you don't have the
development branch in your repository (maybe for some reason that
development branch wasn't kept for some reason), the origin link in
the two maintenance branches would point to a non-existent commit ID,
and you wouldn't be able to estabish a linkage between them.  By using
an independent bug identifer as the way of creating the linkage,
you're preserving *much* more useful information, and you can reliably
establish a relationship between two commits.


In terms of your arguments about why free-form is bad, in another message:

>- No strict definition of what it means.
>- Diverging porcelain implementations making use of the field in ever so
>  slightly changing ways over the years.

This can be a problem regardless of where you store the information.
Whether you store it in the free-form text or in the git object
header, if you don't make sure it is well-defined, you're in trouble.

>- You cannot rely on the field being always available.

This is true regardless of where you store it; older versions of git
won't store the git origin link, for example, unless you plan to break
backwards compatibility with all existing git repositories, which
would be a bad idea.  :-)

One nice thing of using text in free-form text fields is that anyone
can enter it without needing a new version of git.  The downside is
that people could typo the header in some fashion.  But that can be
dealt with in a newer version of the git porcelain validates the bug
identifier and/or checks for obvious spelling mistakes and issues a
warning ("Looks like you may have mispelled 'Adresses-Bug'; perhaps
you should fix this via git commit --amend?").  

In contrast, if you put it in the git object header, there is no
possibility of using the field at all until you update to a version of
git that supports it.  And some developer on your project is using an
older version of git when they rebase or cherry-pick a commit, the
origin header will be completely lost; but if it is stored in the
free-form area, the information will be brought along for the ride for
free.

>- Automated "renumbering" becomes difficult at best.

This is actually one of the reasons why I don't like the origin link.
If you use the origin link, it's *still* not obvious whether you
should rewrite the commit ID or not.  For example, in some workflows,
you have two branches pointing to the same commit before you do the
rebase, where the rebase will only update the current branch pointer,
but there is another branch still pointing at the original series of
commits.  Worse yet, someone may have done a cherry-pick *before* the
rebase.  Hence, the only thing you can do is keep *both* commit ID's.
This means that over time, you can't get rid of any commit ID's when
you do a rebase, which means the number of commit ID's in the origin
link will always increase whenever you do a rebase or a cherry-pick.

This is why for the use case where you are trying to figure out
whether a bug exists in a particular branch, it is ***much*** better
to rendevous using a bug identifier; it provides an extra layer of
indirection which results in a much more stable identifer that is
guaranteed to work.


I understand it won't work for those cases where you don't have a bug
tracking identifer, but in fact, if you need this functionality at all
(and I am not convinced that you do), the ***much*** better approach
is to use the same approach as the bug tracking identifier, and add a
level of indirection.  How would that work in practice?  Whenever you
create a new commit, create a UUID which is assigned to the patch.
This UUID is not modified by git rebase or git cherry pick, and it
should be optionally kept or modified on a git commit --amend.
Ideally, said UUID would exported via git-format-patch, and imported
via git-am, and via systems that use patches, such as guilt or stg.
This becomes a handy way of recognizing patches even if they aren't
being stored in git --- for example, Andrew Morton's mm patch series.

Now, whether you store this UUID in the free-form text area, or in the
git object header, in the long run really doesn't matter.  You can
just as easily have porcelein suppress a line in the free-form text
area, as you can have the procelain print the UUID when it is stored
in the object header.

Yes, it means that you have to maintain a separate database so you can
easily find the list of commits that contain a particular UUID, but I
suspect you would need this in the case of the origin link concept
anyway, since sooner or later some of the more useful uses of said
link would require you to be able to find the commits which had origin
links to the original commit, which means you would need to create and
maintain this database anyway.  And the maintenance of this database
is purely optional; you only need it if you care about efficiently
looking up UUID's, and given "time git log > /dev/null" on the kernel
tree only takes six seconds on my laptop, and "git log > /dev/null"
only takes 0.148 seconds for e2fsprogs, for many projects you might
not even need the database to accelerate lookups via UUID.

    	      	  	      		 	     - Ted
