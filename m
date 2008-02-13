From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: new stacked git feature
Date: Thu, 14 Feb 2008 00:52:04 +0100
Message-ID: <20080213235204.GA10335@diana.vm.bytemark.co.uk>
References: <20080111194946.GA7504@redhat.com> <1202834567.14175.68.camel@pc1117.cambridge.arm.com> <20080213000806.GB25839@diana.vm.bytemark.co.uk> <b0943d9e0802131429p76f0981cm6e54a6a07042f229@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jason Baron <jbaron@redhat.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Yann Dirson <ydirson@altern.org>, git <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 00:53:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPRQK-0002os-HE
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 00:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762178AbYBMXxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 18:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761719AbYBMXxU
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 18:53:20 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3067 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759818AbYBMXxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 18:53:19 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JPROW-0003AU-00; Wed, 13 Feb 2008 23:52:04 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0802131429p76f0981cm6e54a6a07042f229@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73828>

On 2008-02-13 22:29:34 +0000, Catalin Marinas wrote:

> On 13/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> >   * Every time the patch stack is modified (that is, any time an
> >     StGit command modifies anything at all), a new commit is made
> >     to a log branch. Each StGit branch has one such log branch.
>
> We already have another commit for the patch history. If we add
> this, we end up with 3 commit for each patch command. People already
> complained that StGIT is slow, I wouldn't go this route.

I intend to get rid of the current per-patch log. It doesn't save
enough information to be useful anyway.

As for the speed: we'll have to write one blob and one tree per
modified patch, plus one top-level tree and a small constant number of
blobs. (Caveat: my current implementation is too stupid to realize
that not all patches were modified all the time.) These simple
create-an-object-from-data-on-stdin commands should be fast enough
that this won't be a problem (and if a dozen extra calls to git is too
expensive, we'll just have to build a git command that can take them
all in one go).

> For undo, can we not keep the HEAD of the old stacks in a simple
> text file?

We could. (We'd have to keep the sha1s of all the patches there,
though, and not just HEAD. And the applied/unapplied files.)

> Or maybe use reflogs and only allow as many undos as information
> available in reflog.

Yes, complemented by some extra files (see above). That's certainly a
reasonable choice.

I'd like to try my scheme out first, however. It's potentially more
powerful, since it can be pulled between repositories and maybe even
merged.

> >   2. The merged stack base is created with a normal recursive
> >      merge.
>
> A recursive merge with the HEAD of another stack containing similar
> patches? If yes, when pushing it is likely that the patches already
> in the base will be emptied during a three-way merge.

No, a merge of the stack _bases_, with all patches popped off. And
this would be a regular git merge, so no emptying of patches.

> >   3. When a conflicting patch is pushed, we do the following:
> >
> >        1. For each of .ours, .theirs, .base0, ..., create a new
> >           "b" tree just like we do when we normally push a patch.
> >           If there are conflicts, autoresolve them like
> >           merge-recursive does internally.
> >
> >        2. Create the single new "b" tree by making a recursive
> >           merge of all these updated "b" trees. Represent any
> >           conflicts like we usually do when pushing patches.
>
> My idea is to merge each patch with the corresponding commit in the
> other branch and leave the base unchanged (like "stg sync"). The
> difficulty is in identifying which commit from the other branch has
> to be used. We could try guessing by the number of changes or just
> using the subject line, assuming that it won't change (or an extra
> id field in the commit text).

I was thinking about the same thing: just match up the patches with
the same name. If the user has renamed a patch, she can coalesce the
two manually.

> I find this workflow pretty difficult to implement since the StGIT
> patches are pretty volatile. It might be better to use topic
> branches instead.

I agree that it's far from certain that this will be a very useful
workflow. But I'm willing to bet a couple of day's work that it is, so
I'll build a prototype and see.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
