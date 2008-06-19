From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Thu, 19 Jun 2008 12:07:22 +0200
Message-ID: <20080619100722.GB14415@diana.vm.bytemark.co.uk>
References: <20080612053424.23549.64457.stgit@yoghurt> <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com> <20080617123138.GA6932@diana.vm.bytemark.co.uk> <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com> <20080617153247.GA12520@diana.vm.bytemark.co.uk> <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com> <20080618143633.GB30540@diana.vm.bytemark.co.uk> <b0943d9e0806180916m4af3970ck347408661e95663@mail.gmail.com> <20080618173246.GA1155@diana.vm.bytemark.co.uk> <b0943d9e0806190224v1b6434fesd3a54443422edaeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 12:08:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9H46-0005Dz-JO
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 12:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbYFSKHb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 06:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbYFSKHb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 06:07:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2831 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbYFSKHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 06:07:30 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K9H34-0003wO-00; Thu, 19 Jun 2008 11:07:22 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806190224v1b6434fesd3a54443422edaeb@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85466>

On 2008-06-19 10:24:28 +0100, Catalin Marinas wrote:

> 2008/6/18 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-06-18 17:16:10 +0100, Catalin Marinas wrote:
> >
> > > We could also easily use the commit message directly for
> > > metadata instead of .git/patches/<branch>/.
> >
> > Yes. This is true for any log scheme, though. (But I agree --
> > longer term, it would be very nice to have _only_ the log.)
>
> It would make collaboration using stgit stacks easier. I can start
> looking at this once we agree on the log structure.

Yes. Collaboration was one of the things I was thinking of when
starting all this. (If not for that, there would be little reason to
try to store the entire log under a _single_ ref.)

> After profiling (the stg-prof file), as expected, most of the time
> was spent in external Git calls which I tried to keep to a minimum.
> With your approach, you probably add at least 4-5 calls to Git (just
> a guess, I haven't counted) and, with a big repository, it will be
> visible (I have about 15 branches on my Linux kernel clone going
> back to the 2.6.12 kernel and the .git size is over 1/2GB after
> git-gc).

The extra git calls take constant time and don't depend on the size of
the repository. But they _are_ a problem. (Which could be solved by
making a new git command specifically for users like StGit that want
to make a small bunch of simple object read/write commands.)

> > > Making the first log entry special gets difficult with log
> > > pruning (unless you prune the whole log rather than entries
> > > older than a chosen time or number) since you might have to
> > > re-create all the chained log entries as the first log's sha1
> > > will probably change.
> >
> > You have to re-create all the commits anyway, since they all are
> > immutable, and all have a back pointer.
>
> Ah, OK. So, at least initially, we should only support the full log
> pruning.

How do you imagine we'd do anything except a "full" pruning? There are
grafts and shallow clones, I guess, but both of them have drawbacks.

> > > The applied patches are chained automatically via HEAD. For
> > > unapplied patches, we could add the correponding commits as
> > > parents of the logging commit (starting with the third parent as
> > > the first two are used for log chaining and applied patches). Do
> > > we hit any OS limit with the number of arguments?
> >
> > Not until long after we hit git limits to the number of parents of
> > a commit. I believe the octopus merge refuses to create merges
> > with more than about 25 parents, and we probably shouldn't do more
> > than that either. We'll have to do a tree of octopuses.
>
> For the first log only, we could chain the unapplied patches using
> commits with 2 parents. We just need to warn people not to stare at
> the <branch>.stgit directly :-)

We could make chains (or trees) of 16-parent commits -- that'd speed
it up by a factor of 15. :-)

> > > Since we only need the unapplied commits tracking for gc and
> > > pull reasons, we could only create that commit that references
> > > them when we prune the stack log and link it from the top one
> > > (but it won't be used by stgit).
> >
> > Yes, we need to create an "unapplied octopus" if and only if we
> > have unapplied patches that we can't prove are reachable from the
> > stack top or the branch head (we have to save both, in case the
> > user has done something such as git-committing on topp of the
> > stack and caused head !=3D top). Which is for the first log entry,
> > and in situations such as "stg pick --unapplied", but not for "stg
> > pop" and the like.
>
> Yes, but just chain unapplied commits rather than using octopus (you
> could try to the -mm series with 500+ patches and see what happens).

If there are a lot of unapplied patches, you don't want to throw that
factor of 15 away I think.

> > I do agree that we shouldn't try to use the octopuses to get hold
> > of the commits, though -- just to keep them reachable. We save the
> > sha1 along with the patch name elsewhere in a more convenient
> > form. (My proposed format does precisely this.)
>
> Yes, but you still have to refer the tree objects corresponding to a
> patch and extra work to generate the simplified log.

True. But only for patches that have changed. Which will rarely be a
lot of them, as I've said before.

> >  * Commit message: list the applied and unapplied patches with
> >    their commit sha1s.
>
> We don't even need to differentiate between applied and unapplied in
> the commit message as long as they are listed in order since one of
> the parents would represent the boundary between them.

Not if top !=3D head (which I'm convinced we want to allow the design t=
o
handle). See below.

> Since lib.stack is pretty well structured, we could later modify
> PatchOrder to use the log.

Certainly. This has been one of my evil master plans all along. ;-)
Though it would have to be restructured a bit since we can't just
write to a part of the log -- we have to write a complete log entry
all at once.

> >  * Parents: the previous log entry; branch head; something that
> >    (recusively) points to all unapplied commits, if necessary.
>
> As you pointed below, "branch head" should probably be the "stack
> top". We don't need to track the "branch head" if different, just
> need to fix up the error and add the patches to the stack. And,
> anyway, if one modifies the HEAD using git directly, the log will
> still point to the top of the stack.

If we ever want to be able to undo "stg repair", we have to be able to
represent an inconsistent state where head !=3D top. And it's actually
not difficult -- the patch series I posted recently does this. All it
takes is that we save both the branch head and the stack top, instead
of assuming that they are the same.

> The third head would only be needed for the first log entry or when
> we use pick --unapplied (in the latter, it only points to the
> unapplied commit).

Actually, except for the previous log entry, all the parents are just
there for gc's benefit. So we could just put all of them in the same
bucket -- branch head, stack top, and unapplied patches.

( By "bucket" I mean something like: if there are just a few of them,
  have them as direct parents of the log commit; otherwise, refer to
  them using a tree of octopuses. But in any case, just treat them as
  a set of sha1s that we need to have as ancestors but don't otherwise
  care about. )

> The third head shouldn't be used at all in the log, just created
> when needed.

Yes. And as I said, we could do the same for the head and top commits.

> >  * I'm pretty sure we want the kind of "simplified" log I have in
> >    my proposal. The full log in your proposal is going to look
> >    every bit as ugly as the one in mine.
>
> I agree it will look ugly but the simplified log adds an extra
> overhead on any stgit action. If we don't use stg log -g, a text
> only log command could show the diff. We can add it afterwards
> though if it is fast enough.

I'd actually say the opposite: until we have a good visualizer that
doesn't need the simplified log, we need to have the simplified log.
If I actually have to look at the diffs in the log, I find gitk
indispensible.

Plus, once we try to support merging logs, gitk on a simplified log
will be truly indispensible.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
