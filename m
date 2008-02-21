From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: new stacked git feature
Date: Thu, 21 Feb 2008 08:45:43 +0100
Message-ID: <20080221074543.GB8250@diana.vm.bytemark.co.uk>
References: <20080111194946.GA7504@redhat.com> <1202834567.14175.68.camel@pc1117.cambridge.arm.com> <20080213000806.GB25839@diana.vm.bytemark.co.uk> <b0943d9e0802131429p76f0981cm6e54a6a07042f229@mail.gmail.com> <20080213235204.GA10335@diana.vm.bytemark.co.uk> <b0943d9e0802201506w353b5c05vece9f99730d7663c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jason Baron <jbaron@redhat.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Yann Dirson <ydirson@altern.org>, git <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 08:47:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS69O-0007xI-6E
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 08:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbYBUHqu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2008 02:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbYBUHqu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 02:46:50 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3414 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbYBUHqt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 02:46:49 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JS67j-0002Ez-00; Thu, 21 Feb 2008 07:45:43 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0802201506w353b5c05vece9f99730d7663c@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74606>

On 2008-02-20 23:06:07 +0000, Catalin Marinas wrote:

> On 13/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2008-02-13 22:29:34 +0000, Catalin Marinas wrote:
> >
> > > On 13/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >
> > I intend to get rid of the current per-patch log. It doesn't save
> > enough information to be useful anyway.
>
> I use it from time to time. The commit message gives you the commit
> id of the patch at that time and the commit diff gives you the
> changes made by a refresh. It's mainly useful if you ran refresh and
> don't remember what changes you've added.

Ah, OK. Well, the per-branch log will be able to give you all of that.

> > These simple create-an-object-from-data-on-stdin commands should
> > be fast enough that this won't be a problem (and if a dozen extra
> > calls to git is too expensive, we'll just have to build a git
> > command that can take them all in one go).
>
> As I said in the other e-mail, it needs a run through stg-prof to
> see what the impact is with large number of patches.

Agreed.

> > > A recursive merge with the HEAD of another stack containing
> > > similar patches? If yes, when pushing it is likely that the
> > > patches already in the base will be emptied during a three-way
> > > merge.
> >
> > No, a merge of the stack _bases_, with all patches popped off. And
> > this would be a regular git merge, so no emptying of patches.
>
> OK, but we would need the StGIT information about stack bases to be
> passed between repositories.

Yes.

> > > My idea is to merge each patch with the corresponding commit in
> > > the other branch and leave the base unchanged (like "stg sync").
> > > The difficulty is in identifying which commit from the other
> > > branch has to be used. We could try guessing by the number of
> > > changes or just using the subject line, assuming that it won't
> > > change (or an extra id field in the commit text).
> >
> > I was thinking about the same thing: just match up the patches
> > with the same name. If the user has renamed a patch, she can
> > coalesce the two manually.
>
> Ah, OK. But how do we pass the patch name information? I think the
> commit log wouldn't be enough as it can be easily modified.

The per-branch log will contain this information.

> There is also a situation when patches on the remote stack were
> reordered and with some conflicts fixed. In this case, merging gets
> even more complicated (I think darcs solves this by making all the
> patches immutable but the base feature of StGIT is that patches are
> easily modifiable).

The scheme I described should be able to handle this. When a patch is
pushed, its base is set, and we can just make a normal 3-way merge.

Consider a stack with two patches, a:A->B and b:B->C (A, B, and C are
commits). In one branch, this is modified to a:A->B1 and b:B1->C1; and
in the other, the patch order is changed so we get b:A->X and a:X->C.

When we merge these, the base is unchanged (so still A), and the patch
order is b, a (since it was changed in one branch but not the other).

  1. First we push b. The A->X variant applies trivially, but the
     B1->C1 variant needs the standard 3-way merge. The merge is
     force-resolved (that is, any conflicts are ignored, and just
     stored in the result tree); call the result Y. Then we make a
     3-way merge with C as ancestor and X and Y as ours and theirs;
     the result (possibly fixed up manually by the user) is stored as
     the new patch top -- call it Z. So now we have pushed b:A->Z.

  2. Then we push a. Both the A->B1 and the X->C variants need 3-way
     merging, since we apply the patch on top of Z; call the resulting
     (possibly force-resolved) trees P and Q. Then we make a 3-way
     merge with B as ancestor and P and Q as ours and theirs; the
     result (possibly fixed up manually by the user) is stored as the
     new patch top -- call it R. So now we have pushed a:Z->R.

> It would be nice to allow an easy workflow for people trying to
> share the same repository and benefit from StGIT. There was a recent
> thread on the Linux kernel lists about a new branch, linux-next,
> which included some discussions on GIT, patch management, rebasing
> etc. Some people mentioned that they ended up using classic patch
> management (quilt) and storing the patches in a repository which can
> be shared between developers.

Yes, absolutely. And this is precisely what we'll get out of this if
it pans out. But if it doesn't, the _same_ per-branch log format can
be used with a different conflict resolution scheme -- for example, we
could compute the diff text for each of the patches and just merge
those, which gives the same result as if the user had stored patches
in the repository.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
