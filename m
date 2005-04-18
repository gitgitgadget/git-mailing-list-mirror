From: David Roundy <droundy@abridgegame.org>
Subject: Re: Darcs and git: plan of action
Date: Mon, 18 Apr 2005 08:20:21 -0400
Message-ID: <20050418122011.GA13769@abridgegame.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Git Mailing List <git@vger.kernel.org>
X-From: darcs-devel-bounces@darcs.net Mon Apr 18 14:22:50 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNVGZ-00078N-1U
	for gcvdd-darcs-devel@m.gmane.org; Mon, 18 Apr 2005 14:22:16 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DNVJy-0000tw-Gp; Mon, 18 Apr 2005 08:25:46 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]
	helo=localhost) by abridgegame.org with esmtp (Exim 4.50)
	id 1DNVJw-0000gf-OG
	for darcs-devel@darcs.net; Mon, 18 Apr 2005 08:25:45 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DNVEj-0004ji-IG; Mon, 18 Apr 2005 08:20:21 -0400
To: darcs-devel@darcs.net
Mail-Followup-To: darcs-devel@darcs.net,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
User-Agent: Mutt/1.5.6+20040907i
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

Linus and gittish people,

I'm cc'ing you on this email, since Juliusz had some interesting ideas as
to how darcs could interact with git, which then gave me an idea concerning
which I'd like feedback from you.  In particular, it would make life (that
is, life interacting back and forth with git) easier if we were to embed
darcs patches in their entirety in the git comment block.  It's a bit of an
ugly idea, but would greatly simplify the two-way interaction between git
and darcs, since no information would be lost when a darcs patch was merged
into git.  See below for the discussion.

As I say, it's a bit ugly, and before we explore the idea further, it would
be nice to know if this would cause Linus to vomit in disgust and/or refuse
patches from darcs users.  Another slightly less noxious possibility would
be to store the darcs patch as a "hidden" file, if git were given the
concept of commit-specific files.  So then we could include in the commit
log something like "Darcs-patch:
780c057447d4feef015a905aaf6c87db894ff58c".  We could do this silently,
except that I wonder if fsck would delete these files, since they aren't
pointed to by any trees.

On Mon, Apr 18, 2005 at 12:02:15AM +0200, Juliusz Chroboczek wrote:
> David,
> 
> I've read git over the week-end.  I think I can see where it's coming
> from.
> 
> Git is basically a (userspace) filesystem with support for efficiently
> finding identical objects.  It's both simple and generic enough to be
> usable by us.

Right.

> You mentioned that you'd like to use git as a cache for Darcs; and I
> don't think I agree.  Caches are tricky -- they need to be kept in
> synch -- and they might result in unexpected performance (you need to
> update both the native and the cached data structures on every
> modification).

It's true that we'd need to keep the cache in sync, which would mean making
sure it gets updated with every repository-modifying darcs command, but
we've already got a cache that has those properties, and it seems like
modifying the interface to deal with a more complex cache would be
relatively straightforward, and would likely have other advantages, such as
if we wanted to implement a per-file cache to speed up annotate (since the
speed of annotate seems to be a relatively common concern).

Basically, I'm imagining that we'd have to replace writePristine and
write_dirty_Pristine with the applyPristine that Ian implemented for
efficiency reasons.  So we'd write to pristine by throwing patches at it,
and letting it do what it pleases with them.  Then we'd read from Pristine
as usual--but we might want to add interfaces for reading slurpies of older
versions from the pristine cache.  This would again be a helpful interface
anyways, since it might allow us, for example, to use checkpoints when
reading older versions.

> I'd rather remodularise Darcs so that the on-disk patch representation
> is decoupled from the in-memory representation, so that we can use
> various backends in the same way as we use the native repository
> format.

The problem I have with this is that "other" repository formats (e.g. git)
store "tree versions", not "changes", and I think it would be fragile to
try to store "changes" (in the darcs sense) in them.

> As you seem motivated by git (my motivation is slightly different -- I
> want to be able to pull from Arch and other widespread systems with
> dysfunctional user interfaces), I suggest that we start with that.

I see.  You're thinking of using darcs as a client for other SCMs.  That's
sort of how I'm thinking of darcs interacting with git, so we aren't so far
off in terms of goals.  My hope would tend to be that people would coalesce
around git--since Linus will be using git.  If everyone can interoperate
with git, we'd be able to interoperate with everyone, in a sense, anyways.

> I suggest we do the following:
> 
>  1. remove the assumption that patch IDs have a fixed format.  Patch
>     IDs should be opaque blobs of binary data that Darcs only compares
>     for equality.

I'm not really comfortable with this, although I can see that there is an
appeal to it, and that something like it may turn out to be necesary for
interacting with systems for which we can't create a simple mapping of
patch IDs.

>  2. get Darcs to pull from git.  By restricting ourselves to a fairly
>     simple command, this should be doable in finite time.

Okay, this is definitely a good goal.  See below for thoughts on how this
should be accomplished.

>  3. allow a patch to have multiple IDs; if the IDs associated to two
>     patches are not disjoint, then the patches are the same patch.

This I find a bit confusing.  So a patch can have two IDs, presumably
something like a "darcs ID" and a "git ID"? I can see that this might
simplify some things, but am not sure how it would work.  The IDs would
have to have a hierarchy, so that you wouldn't ever end up with the "same"
patch having disjoint IDs in two cases.

>  4. allow applying to git repos of non-merger patches.

Here's where I think I'd differ.  I think when dealing with git (and
probably also with *any* other SCM (arch being a possible exception), we
need to consider the exchange medium to be not a patch, but a tag.  Git
only knows about "versions" of the tree, which in darcs terminology is a
tag.  It *does* know about the (possibly multiple) parents of a given
version, so we have a "context" for the patch--provided those two (or
one...) parents are treated as tags.

So in pulling from git, I'd treat each git change as a patch followed by a
tag.  When pulling from git, unfortunately, the contents of that patch will
be determined by our diff algorithm, so if we want long-term stability we
might need to mummify a variant of the diff algorithm that we agree not to
change, and to always use when computing patches from a git archive.  This
tagging (and I imagine the tags will look something like
"git:0c16636264037e8b5ccd38b28ecd191aebc67389") will mean that we can
create a single-patch darcs "patch bundle" for any given git commit.  Which
is to say, that we'll be able to "see" a git repository as an odd-looking
darcs repository.

This means that getting a fresh darcs repository from git would potentially
involve a whole lot of merging...

Putting darcs patches *into* git is more complicated, since we'll want to
get them back again without modification.  Normal "hunk" patches would be
no problem, provided we never change our diff algorithm (which has been
discussed recently, in the context of making hunks better align with blocks
of code).  We could perhaps tell users not to use "replace" patches.  But
avoiding "mv" patches would be downright silly.  So we're somehow going to
have to either sneak this sort of metadata into the git repository, or
we're going to have to store just the darcs "patch ID" in the git
repository, and require that darcs users get the actual patch from
somewhere else.  I had been imagining the latter, but now I'm wondering if
the former is a reasonable possibility.

Linus has said that he figures an SCM needs to be built on top of git, and
that SCM--rather than git itself--would be the one that would know about
things like file renames, probably by storing some sort of rename metadata.
I wonder if we could perhaps store the entire darcs patch in the git
commit? It seems a bit abusive, but would certainly be the easiest way to
interface losslessly with git.  So when we pull from git, we'd look in the
commit log for the magic words indicating that this is really a darcs
patch.  If so, we could handle it natively.  If not, we'd know it was
actually a "gittish" entity, and requires that we diff a couple of trees to
find the actual patch to be used with darcs' patch theory.

The ugliness of this idea is that it involves storing redundant
information.  And I think we'll have a bit of an excercise in commutation
and merging when we get the patches from a git repository, since in git
they'll be stored in tree form, but that's something we'll have to do even
to create a read-only darcs mirror of a git repository.

We could perhaps alleviate the pain by perhaps not including the actual
contents of new or deleted files in the patch, but instead retrieve those
from git directly.  But that might be more trouble than it's worth, at
least for the first sketch.

>  5. think about mergers.

Since git stores a branched history rather than a linear history, I'm not
sure that we'll ever need to store mergers in git.  Instead, we could just
commute until the mergers disappear (which might be a bit scary), and then
store *that* in git.  On the other hand, if this is to inefficient, and if
we store actual darcs patches in git, then we wouldn't perhaps need to
worry about mergers as a special case.

> Whether we end up with a useful implementation of Darcs/git or not,
> this will result in a more modular Darcs, and hence one that will be
> easier to optimise.
> 
> What do you think?

Err, I think I've answered that one... :)
-- 
David Roundy
http://www.darcs.net
