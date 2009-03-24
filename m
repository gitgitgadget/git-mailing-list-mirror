From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add the --merged option to goto
Date: Tue, 24 Mar 2009 14:16:40 +0100
Message-ID: <20090324131640.GB4040@diana.vm.bytemark.co.uk>
References: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com> <20090323084507.GA6447@diana.vm.bytemark.co.uk> <b0943d9e0903230933n5b71a53elcfaa13f00883861d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 14:18:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm6WL-0005wd-8J
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 14:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092AbZCXNQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 09:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755782AbZCXNQu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 09:16:50 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:49675 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203AbZCXNQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 09:16:49 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lm6Ui-0001eq-00; Tue, 24 Mar 2009 13:16:40 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0903230933n5b71a53elcfaa13f00883861d@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114456>

On 2009-03-23 16:33:04 +0000, Catalin Marinas wrote:

> 2009/3/23 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2009-03-20 16:15:45 +0000, Catalin Marinas wrote:
> >> @@ -752,12 +752,13 @@ class Index(RunWithEnv):
> >> =A0 =A0 =A0 =A0 =A0assert current =3D=3D None or isinstance(curren=
t, Tree)
> >>
> >> =A0 =A0 =A0 =A0 =A0# Take care of the really trivial cases.
> >> - =A0 =A0 =A0 =A0if base =3D=3D ours:
> >> - =A0 =A0 =A0 =A0 =A0 =A0return (theirs, current)
> >> - =A0 =A0 =A0 =A0if base =3D=3D theirs:
> >> - =A0 =A0 =A0 =A0 =A0 =A0return (ours, current)
> >> - =A0 =A0 =A0 =A0if ours =3D=3D theirs:
> >> - =A0 =A0 =A0 =A0 =A0 =A0return (ours, current)
> >> + =A0 =A0 =A0 =A0if check_trivial:
> >> + =A0 =A0 =A0 =A0 =A0 =A0if base =3D=3D ours:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return (theirs, current)
> >> + =A0 =A0 =A0 =A0 =A0 =A0if base =3D=3D theirs:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return (ours, current)
> >> + =A0 =A0 =A0 =A0 =A0 =A0if ours =3D=3D theirs:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return (ours, current)
> >
> > Uh, what? What's the point of not doing this unconditionally?
>
> There are a few cases where my algorithm failed because the reverse
> applying of patches fell on one of those special cases (otherwise
> they wouldn't apply). The check_merged() function assumes that if a
> patch can be reversed in a given tree, it was already included in
> that tree.
>
> Let's assume that the tree corresponding to the top patch is T1. We
> have the following cases for reverse-applying a patch which fall
> under the trivial cases above (patch expressed as
> bottom_tree..top_tree):
>
> The empty patch cases should be ignored from such test (not done
> currently):
>
> T1..T1 =3D> merge(T1, T1, T1) =3D=3D T1
> T2..T2 =3D> merge(T2, T1, T2) =3D=3D T1
>
> The non-empty patch situations:
>
> T1..T2 =3D> merge(T2, T1, T1) =3D=3D T1
> T2..T1 =3D> merge(T1, T1, T2) =3D=3D T2
>
> The T1..T2 is pretty common and happens when the base of a patch
> wasn't modified. Reverse-applying such patch should not normally
> succeed but the merge() here uses one of those special cases. The
> merge() result is correct since we want two trees merged, T1 and T1,
> with a common base, T2, used a helper.
>
> The T2..T1 cases would succeed with both trivial checks and
> apply_treediff() and that's probably OK since if a patch generates
> the same tree when applied, the changes it makes were probably
> already included.
>
> Now I understand it better :-). Reading my explanation above, it
> seems that only the T1..T2 case matters and it can be taken care of
> in the check_merged() function. Checking whether the tree returned
> by merge() is different than "ours" should be enough for all the
> above cases.

Hmm. If the tip of the branch is T1, and we reverse-apply the patch
T1..T2, we get the merge (base T2, ours T1, theirs T1) ... yeah, I see
what you mean. The problem isn't that we give T1 as the result of this
merge -- that's actually the right thing to do -- the problem is that
you don't actually want a merge. What you want is patch application.
Maybe the apply_treediff method would do? See my other comment below.

> >> @@ -379,3 +385,25 @@ class StackTransaction(object):
> >> =A0 =A0 =A0 =A0 =A0assert set(self.unapplied + self.hidden) =3D=3D=
 set(unapplied + hidden)
> >> =A0 =A0 =A0 =A0 =A0self.unapplied =3D unapplied
> >> =A0 =A0 =A0 =A0 =A0self.hidden =3D hidden
> >> +
> >> + =A0 =A0def check_merged(self, patches):
> >> + =A0 =A0 =A0 =A0"""Return a subset of patches already merged."""
> >> + =A0 =A0 =A0 =A0merged =3D []
> >> + =A0 =A0 =A0 =A0temp_index =3D self.__stack.repository.temp_index=
()
> >> + =A0 =A0 =A0 =A0temp_index_tree =3D None
> >
> > There's no need to create a new temp index here. The transaction
> > object already has one.
>
> I had the impression that an Index object would hold some state and
> didn't want to break it. It seems OK to use as long as I don't touch
> self.temp_index_tree. See below for an updated patch:

Yes, an Index object owns a git index file.

And no, not quite. temp_index_tree is set to the tree we know is
stored in temp_index right now (or None if we don't know). The idea is
that we'll often want to read a tree into the index that's already
there, and by keeping track of this we'll get better performance.
(This works very well in practice.) Apologies if there aren't comments
explaining this ... the merge method has some docs on the subject.

I think what you should do is something like what merge() does:

  if temp_index_tree !=3D branch_tip:
      temp_index.read_tree(branch_tip)
      temp_index_tree =3D branch_tip
  try:
      temp_index.apply_treediff(patch_bottom, patch_top, quiet =3D True=
)
      temp_index_tree =3D temp_index.write_tree()
      return True
  except MergeException:
      return False

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
