From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 05:21:15 -0400
Message-ID: <20070805092115.GA12507@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804120243.GB9716@coredump.intra.peff.net> <85tzrfh3yg.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 11:21:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHcIc-0002IY-Vd
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 11:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXHEJVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 05:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbXHEJVT
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 05:21:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3901 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbXHEJVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 05:21:17 -0400
Received: (qmail 15118 invoked from network); 5 Aug 2007 09:21:20 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 09:21:20 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 05:21:15 -0400
Content-Disposition: inline
In-Reply-To: <85tzrfh3yg.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54969>

On Sat, Aug 04, 2007 at 02:36:07PM +0200, David Kastrup wrote:

> And it's actually worse after your explanations.  Previously I
> imagined to have a chance to figure this out on my own, by trying to
> abstract from what I see happening when using the various commands.
> 
> Now I think that I basically have no chance figuring this out on my
> own sufficiently well to be able to improve the documentation.

I see that Lars and others have provided some explanations in my
absence, but let me try to lay it out from basics, and hopefully between
all of our writing it will make sense. I'm going to try to be as basic
as possible, so if I am telling you something you already know, it's not
because I think you're stupid, but because I'm trying to be thorough.

Git history is a directed graph of commit objects, with each commit
object pointing to its parent (or parents if it is a merge). We have
human-readable names pointing into the history as well, which we call
refs, and generally store under the "refs/" hierarchy (with a few
exceptions, which I will mention in a minute).

There are a few different types of pointers (refs) that are useful to
us. They are differentiated by the types of things we want to do with
them.

  1. refs that track our ongoing commits. This process involves making
     a new commit object whose parent is the previous value of the ref,
     and then pointing the ref at the new commit. We generally call
     these refs "heads", "local branches", or just "branches", and they
     are stored in "refs/heads/".

  2. refs that point to a single commit and aren't changed. These refs
     are "tags", and we store them in "refs/tags/".

  3. refs that represent a remote repository's local branch. These are
     updated by git-fetch, which simply writes the new value of the
     pointer into our local copy, throwing out the old value.  These are
     called "remote tracking branches" and are stored in
     "refs/remotes/<remote>/<branch>".

  4. Temporary pointers to help out some multi-step operation that we're
     in the middle of. These include FETCH_HEAD and MERGE_HEAD.

There is an order of ref lookup which goes like:
  .git/<name>
  .git/refs/<name>
  .git/refs/tags/<name>
  .git/refs/heads/<name>
  .git/refs/remotes/<name>

It used to be the case (prior to git 1.5) that remote tracking branches
and local branches were stored in the same hierarchy (under
refs/heads/). This turned out to be problematic for many users, because
the operations that you perform on them don't play well together.

For example, let's say you have a branch "origin" representing Junio's
"master" branch. You check it out and make a commit. This rewrites the
"origin" ref, but it's safe because the new commit points to the old
value. Now you want to fetch more work from Junio, so you run
"git-fetch". But the value of Junio's ref doesn't ever reference your
work. If git-fetch copies the value of Junio's new ref into your
"origin", then it will throw away the work that you were done (i.e., no
ref will be pointing to it, or to any commit that references it). But if
git-fetch doesn't copy the value of Junio's new ref, then how will you
get to see his new work?

So it is a mistake to create commits on top of a remote tracking branch.
The new strategy is therefore to store them in refs/remotes, which is an
indicator that they are purely for remote tracking. If you attempt to
git-checkout a branch in refs/remotes, you will get a detached HEAD
rather than actually checking out that branch.

Normally "HEAD" is a pointer to a ref in refs/heads/ (which is itself a
pointer to a commit object) representing "the current branch." When HEAD
becomes detached, we mean that instead of pointing to a branch ref, it
points directly to a commit object. So when you do "git-checkout
origin/master" (which, unless you have a local branch named
"origin/master" will end up looking in refs/remotes/origin/master), it
doesn't put "refs/remotes/origin/master" in your HEAD, but rather the
_value_ of that ref.

The implication here is that commits you create on a detached HEAD are
not stored by any ref except HEAD, and will be lost when you move
the HEAD elsewhere (i.e., when you check out a different branch).

Tags are in a similar situation. You don't want to make commits on tags;
instead, you want to simply set them to a pre-existing commit. Thus when
you check out a tag, you get a detached HEAD (and we know it's a tag
because it's in refs/tags, not refs/heads).

So hopefully at this point you understand "local branch" and "remote
tracking branch."

To get to the final concept you mentioned, let's take a look at what
fetch and pull do.

Let's say you run:

  git-fetch git://git.kernel.org/pub/scm/git/git.git

That stores the value of Junio's current branch (which tends to be
"master") into your local FETCH_HEAD (stored in ".git/FETCH_HEAD").

And if you run:

  git-fetch git://git.kernel.org/pub/scm/git/git.git next

Then we store the value of Junio's next branch into your FETCH_HEAD.

And finally, if you run:

  git-fetch \
    git://git.kernel.org/pub/scm/git/git.git \
    next:refs/remotes/junio/next

then we store Junio's next branch in our FETCH_HEAD, but _also_ store it
in the remote tracking branch refs/remotes/junio/next.

The second argument to fetch is called a "refspec", and you can have
several of them. Because all of that gets tedious to type, we have the
concept of configured remotes, which are a shorthand for a URL and
associated refspecs. When you use "git-clone", it creates the following
config:

  [remote "origin"]
    url = git://git.kernel.org/pub/scm/git/git.git
    fetch = +refs/heads/*:refs/remotes/origin/*

The refspec in this case uses a wildcard to get _all_ of Junio's
branches, and store them by name under refs/remotes/origin. So we can
just say "git-fetch origin" and it will populate our FETCH_HEAD as well
as the refs/remotes/origin directory.

If we call "git-fetch" without any arguments, it will look up the
default remote in our configuration. git-clone also creates the
following config:

  [branch "master"]
    remote = origin
    merge = refs/heads/master

which means "if we are on the master branch, default fetches to the
remote 'origin'". I will explain the merge line in a minute.

So now we look at git-pull. Recall that a pull is basically a fetch
followed by a merge. If you run:

  git-pull git://git.kernel.org/pub/scm/git/git.git

it will do a git-fetch of that URL (grabbing the current branch),
followed by a git-merge of FETCH_HEAD.

If you run:

  git-pull origin master

it will fetch the "origin" remote, putting all branches into the
FETCH_HEAD (and storing them in refs/remotes/origin as a side effect).
Then it will pick the branch named 'master' out of FETCH_HEAD, and
merge it.

If you run:

  git-pull origin

it will fetch origin as usual, but which branch gets merged? The answer
is the value of the "merge" field in the 'branch "master"' section of
your config (which is generally created by git-clone).

And of course, if you run:

  git-pull

it will look up the remote to fetch in the config (just as "git-fetch"
would), and then find the branch to merge in the config.

So how do we this configuration set up? There are three ways:

  1. Edit your .git/config by hand. :)
  2. git-clone sets up a master/origin relationship, adding both the
     "remote" and "branch" sections.
  3a. Using git-remote, you can add new "remote" sections easily.
  3b. Using the --track option to git-branch, you can set up the
      "branch" section automatically.

What you had called a "remote-tracking branch" is really a branch for
which the 'branch "<name>"' config section has been set up (which could
come about in several ways). I haven't really seen a term such as
"remote-tracking branch" for this in use in the documentation (and I
think we both agree that is not the right term because of its confusing
similarity to remote tracking branches, discussed above).

I know that was a pretty long email, but hopefully you understand the
context of the terms a bit more, and I didn't bore you too much. ;)
Feel free to ask questions if there are parts that are unclear.

-Peff
