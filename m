From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 16:16:30 +0200
Message-ID: <20080910141630.GB7397@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Sep 10 16:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdQWJ-0000jD-Op
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 16:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbYIJOQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 10:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbYIJOQd
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 10:16:33 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43746 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbYIJOQc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 10:16:32 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 82AEA5465; Wed, 10 Sep 2008 16:16:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080910122118.GI21071@mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95520>

Theodore Tso wrote:
>On Wed, Sep 10, 2008 at 12:56:03AM +0200, Stephen R. van den Berg wrote:

>use.  One of the problems with the origin link is that it is only a
>one way pointer.  Given a newer commit, you know that it is (somehow)
>weekly related to a older commit.  So your proposed workflow only
>works if cherry-picks only happen in one direction.  That isn't always
>true, especially in distributed environments where the bugfix might
>happen on someone else's development branch, and then it gets pulled
>in, or perhaps rebased in, and you want to know they are related.

Well, the definition of the origin link (and a back/forwardport) is that:
- You (as a developer) consider the link relevant for posterity (IOW,
  you consider it to be a proper back/forwardport which should be
  recognisable as such).
- The back/forwardport always has to reference some existing (stable) commit.

Especially the second condition always holds at the time of creation of
the backport (or forwardport, for that matter).  I'm not quite sure
which circumstances you allude to above which would violate this
requirement, can you elaborate on that?

>I would argue the best way to do that is to store (either in the
>object or in the free-form text area) not the link, which would have
>to get renumbered but rather the identifier for the bug(s) that this

The renumbering is not a problem, renumbering is a rare operation since
a project's history is supposed to be stable.  And even if renumbering
is performed, it is a well understood operation of which the renumbering
of the origin links imposes a negligible overhead on top of the existing
renumbering overhead.

>commit fixes.  So for example, consider a convention where in the body
>of the free-form text area, before the Signed-off-by:, Acked-by:, and
>CC: headers for those projects that use them, we add something like
>the following:

>Addresses-Bug: Red_Hat/149480, Sourceforge_Feature/120167
>or
>Addresses-Bug: Debian/432865, Launchpad/203323, Sourceforge_Bug/1926023

>Once you have this information, it is not difficult to maintain a
>berk_db database which maps a particular Bug identifier (i.e.,
>Red_Hat/149480, or Debian/471977, or Launchpad/203323) to a series of
>commits.

This is nice, I admit, but it has the following downsides:
- It is nontrivial to automate this on execution of "git cherry-pick".
- In a distributed environment this requires a network-reachable bug
  database.
- A network-reachable bug database means that suddenly git needs network
  access for e.g. cherry-pick, revert, gitk, log --graph, blame.
- Network queries for commits containing references kind of kills
  performance.
- Some backports don't have entries in a bug database because they
  weren't bugs to begin with, in which case it becomes impossible to add
  an identifier to the commit message after the fact.
- It relies heavily on tools outside of git-core, which raises the
  threshold for using it.

>The advantage of this scheme is that if a bug has been fixed in
>multiple branches, you can see the association between two commits in
>two different branches very easily.  Furthermore, you get a link back
>to the actual bug in one or more bug tracking systems, which the some
>porcelain program could use to transform into a hot-link which when
>clicked opens up a browser window to the bug in question.

I'm not opposed to links like this, but I consider them a useful extra.
The link back is computationally of the same order of magnitude to find
all existing children of a certain commit; which is well understood and
within reach in most cases.

>In contrast, using your proposed origin scheme, if the bug was
>originally created in some development branch, and then cherry picked
>into two separate maintenance branches, if you don't have the
>development branch in your repository (maybe for some reason that
>development branch wasn't kept for some reason), the origin link in
>the two maintenance branches would point to a non-existent commit ID,
>and you wouldn't be able to estabish a linkage between them.  By using

Yes, you would.  You'd notice that either:
- One origin will point to the other commit (recommended practice,
  cherry-pick ripple-through, so to speak).
- Both origin links point to the same non-existent commit.

>In terms of your arguments about why free-form is bad, in another message:

>>- No strict definition of what it means.
>>- Diverging porcelain implementations making use of the field in ever so
>>  slightly changing ways over the years.

>This can be a problem regardless of where you store the information.

True.  The point is that specifying a definition for a origin
headerfield will narrow down how it is and can be used.  Free-form is
just that, free-form, and merely defines things by convention.

>Whether you store it in the free-form text or in the git object
>header, if you don't make sure it is well-defined, you're in trouble.

Free form can take the form of plaintext explanations detailing the
relationship in a foreign language (worst case example).

>>- You cannot rely on the field being always available.

>This is true regardless of where you store it; older versions of git
>won't store the git origin link, for example, unless you plan to break
>backwards compatibility with all existing git repositories, which
>would be a bad idea.  :-)

True.  What I was alluding to, is that if someone includes a
back/forwardport link in the free-form part of the commit message, then
you cannot predict how they'll do that.  In case of the origin link,
*if* it is used, it will always look the same.

>One nice thing of using text in free-form text fields is that anyone
>can enter it without needing a new version of git.  The downside is

Git is rather portable, I'd say, so anyone wanting to use the new
feature can be bothered to upgrade.

>that people could typo the header in some fashion.  But that can be
>dealt with in a newer version of the git porcelain validates the bug
>identifier and/or checks for obvious spelling mistakes and issues a
>warning ("Looks like you may have mispelled 'Adresses-Bug'; perhaps
>you should fix this via git commit --amend?").  

You mean you'd prefer some kind of AI solution to aid the user in
writing misspelling-free bug identifiers over a simple clean origin link
in the header of a commit message?

>In contrast, if you put it in the git object header, there is no
>possibility of using the field at all until you update to a version of
>git that supports it.  And some developer on your project is using an
>older version of git when they rebase or cherry-pick a commit, the
>origin header will be completely lost; but if it is stored in the
>free-form area, the information will be brought along for the ride for
>free.

Same as above:
If developers care about the backport information, they *can* be
bothered to upgrade git.  It's not rocketscience.

>>- Automated "renumbering" becomes difficult at best.

>This is actually one of the reasons why I don't like the origin link.
>If you use the origin link, it's *still* not obvious whether you
>should rewrite the commit ID or not.  For example, in some workflows,
>you have two branches pointing to the same commit before you do the
>rebase, where the rebase will only update the current branch pointer,
>but there is another branch still pointing at the original series of
>commits.  Worse yet, someone may have done a cherry-pick *before* the
>rebase.  Hence, the only thing you can do is keep *both* commit ID's.
>This means that over time, you can't get rid of any commit ID's when
>you do a rebase, which means the number of commit ID's in the origin
>link will always increase whenever you do a rebase or a cherry-pick.

The recommended practice here is quite simple:

- Origin links should only be created pointing to stable commits (i.e.
  commits which you'd be willing to publish or already have published).

- This implies that pointing an origin link at a commit in a strain that
  you still want to rebase is asking for trouble.  Doing this is akin to
  doing a merge between two branches and then you start rebasing 4
  commits *below* the mergepoint.  Don't do that.

- The only special case I'd allow is if you rebase a strain and the
  origin link points from one of the commits in the strain to be rebased
  back *into* the same strain being rebased (most likely a revert).
  Rebase can be bothered to renumber the origin link in this case.

And when you stick to those rules, the problem you're describing doesn't
happen.

>This is why for the use case where you are trying to figure out
>whether a bug exists in a particular branch, it is ***much*** better
>to rendevous using a bug identifier; it provides an extra layer of
>indirection which results in a much more stable identifer that is
>guaranteed to work.

Unless that commit already lies in the past, and you have no way to
actually add the bugid to the commit.

>(and I am not convinced that you do), the ***much*** better approach
>is to use the same approach as the bug tracking identifier, and add a
>level of indirection.  How would that work in practice?  Whenever you
>create a new commit, create a UUID which is assigned to the patch.

This only works if you know at time of commit that you want to backport
it at some later date.

>Now, whether you store this UUID in the free-form text area, or in the
>git object header, in the long run really doesn't matter.  You can
>just as easily have porcelein suppress a line in the free-form text
>area, as you can have the procelain print the UUID when it is stored
>in the object header.

True.  It's almost as much work.  Though it seems rather silly to start
suppressing lines in the free-form text area, if one can add a proper
headerfield.

>Yes, it means that you have to maintain a separate database so you can
>easily find the list of commits that contain a particular UUID, but I
>suspect you would need this in the case of the origin link concept
>anyway, since sooner or later some of the more useful uses of said
>link would require you to be able to find the commits which had origin
>links to the original commit, which means you would need to create and
>maintain this database anyway.

That isn't true.  Finding commits which have origin links to a certain
commit is just as hard as finding all children of a certain commit.
It's not exactly instant, but it is not a big problem, and depending on
the amount of repositorytraversal you already are doing, it might even
be a negligible amount of extra overhead.

>  And the maintenance of this database
>is purely optional; you only need it if you care about efficiently
>looking up UUID's, and given "time git log > /dev/null" on the kernel
>tree only takes six seconds on my laptop, and "git log > /dev/null"
>only takes 0.148 seconds for e2fsprogs, for many projects you might
>not even need the database to accelerate lookups via UUID.

The database needs to be available to anyone doing a clone of the
repository, which implies that:
- It needs to be network based.
- It needs controlled write access (which is a mess).
- It is slow during blame/gitk operations.
- It is rather nontrivial to get things setup such that someone (after
  cloning the repository) is able to run cherry-pick/gitk/blame/revert
  and have those commands use the database transparently.
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"
