From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Tue, 17 Jun 2008 17:32:47 +0200
Message-ID: <20080617153247.GA12520@diana.vm.bytemark.co.uk>
References: <20080612052913.23549.69687.stgit@yoghurt> <20080612053424.23549.64457.stgit@yoghurt> <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com> <20080617123138.GA6932@diana.vm.bytemark.co.uk> <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 17:34:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8dC8-0003Uw-Kv
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 17:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758593AbYFQPdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2008 11:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758556AbYFQPdH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 11:33:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3250 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397AbYFQPdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 11:33:05 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K8dAt-0003Jz-00; Tue, 17 Jun 2008 16:32:47 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85307>

On 2008-06-17 15:11:42 +0100, Catalin Marinas wrote:

> 2008/6/17 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-06-17 11:24:53 +0100, Catalin Marinas wrote:
> >
> > > 2008/6/12 Karl Hasselstr=F6m <kha@treskal.com>:
> > >
> > > >  class _Directory(object):
> > > > -    def __init__(self, needs_current_series =3D True):
> > > > +    def __init__(self, needs_current_series =3D True, log =3D =
True):
> > >
> > > i.e. we make log =3D False here by default.
> >
> > I might not have understood precisely what you meant; but I don't
> > think API backwards compatibilty should be an issue here? I simply
> > fix all callers. If log should default to true or false is
> > immaterial -- it just means some extra text in one or the other of
> > two equally common cases.
>
> Not an issue, I just favour the existing one when the two cases are
> almost equal.

=46air enough. I'll change it.

> > > > +A stack log is a git branch. Each commit contains the complete=
 state
> > > > +of the stack at the moment it was written; the most recent com=
mit has
> > > > +the most recent state.
> > > > +
> > > > +For a branch C{I{foo}}, the stack log is stored in C{I{foo}.st=
git}.
> > >
> > > The main question. Is this history preserved after a git-gc?
> >
> > Yes. It's stored in a regular git branch. (The design is such that =
it
> > should even be possible to pull a stack log from another repository
> > and _still_ get everything you need.)
>
> But how are the patches recreated when undoing (the
> refs/patches/<branch>/* files)? Using the Bottom/Top tree ids that a
> patch had in the past? Are these trees still present after a git-gc?

The log actually _contains_ those trees, so there is no problem.

(Relatedly: I've still not written the code that recreates a patch
from the trees and info if its old commit object is no longer present,
but it should be straightforward -- there's even a TODO at the right
place in the code.)

> > > > +  - C{patches}: a tree containing one subtree for each patch, =
named
> > > > +    after that patch. Each such subtree contains:
> > > > +
> > > > +      - C{a}, C{b}: the patch's I{bottom} and I{top} trees.
> > > > +
> > > > +      - C{info}: a blob containing::
> > > > +
> > > > +          Author: <author name and e-mail>
> > > > +          Date: <patch timestamp>
> > > > +
> > > > +          <commit message>
> > >
> > > I might not fully understand this but can we not store just the
> > > commit object if the patch, which would have the bottom/top
> > > information.
> >
> > You can't store a commit object in a tree. (Well, with submodules
> > you can, but said commit object isn't protected from gc and won't
> > be included when pulling.) The idea with this format is that with
> > the two trees and the info file, you can recreate the patch's
> > commit -- not exactly, but close enough as makes no difference.
>
> What I meant is the SHA1 value of the patch commit instead of
> Bottom/Top, Author and Date. The corresponding commit object has all
> this information.

I think this question is settled by my answer above: the log actually
contains the trees in question, which it cannot do with the commit
object.

The applied and unapplied files do contain the sha1s of the patches'
commit objects, since most of the time they will still be there, and
we can just re-use them. But gc and pull don't "see" this kind of
pointer, so we can't rely on it.

> > > > +The simplified log contains no information not in the full log=
; its
> > > > +purpose is ease of visualization."""
> > >
> > > Ah, OK. But I think it would be more useful to see the diff
> > > between subsequent revisions of a stack rather than the full
> > > patch diff.
> >
> > Have you tried looking at a patch stack log (in gitk, say)?
>
> I tried "gitk master.stgit" and got scared :-)

You want gitk master.stgit^, which is the simplified log. Can you
guess why I added it? :-)

The full log unfortunately has to look like hell, because it needs
both the stack top and the previous log entry as ancestors (since
ancestry is the only way to point to other commit objects that
survives gc and cloning).

> > That is, "stg log -g" in this patch series.
>
> This is more readable.

(This is just gitk <branch>.stgit^.)

> > It shows you diffs between subsequent revisions of the simplified
> > log. I'm sure it's far from perfect, but I think it's actually
> > quite useful.
>
> It is useful, though it might take a bit of time to get used to it.

Yes, much like diffs take some time to get used to if you haven't seen
them before.

If you have ideas for a better way to visualize this, I'm all ears.

> It might also be a bit difficult if you want to revert some changes
> to a single patch but not do a full stack undo which would affect
> other patches.

The reset command can already reset just a single patch and not all of
them.

I agree that a "revert"-style command, which undoes just one update
and not everything that happened since then (for the entire stack or
just a single patch), is an intriguing idea. I haven't thought about
it much, but I'm sure it's doable. (In fact, it should be equivalent
to patch stack merging, which I wrote a post about some time ago if
you recall.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
