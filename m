From: Johan Herland <johan@herland.net>
Subject: Re: RFC: Making submodules "track" branches
Date: Wed, 9 Jun 2010 16:37:43 +0200
Message-ID: <201006091637.43726.johan@herland.net>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com> <201006091022.18896.johan@herland.net> <C0EA2469-DA5B-413E-9AB4-F79954DBE3AE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 16:45:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMMX7-0000td-3y
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 16:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757925Ab0FIOpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 10:45:30 -0400
Received: from smtp.opera.com ([213.236.208.81]:52924 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757921Ab0FIOp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 10:45:29 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2010 10:45:29 EDT
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o59EbhDA029206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 Jun 2010 14:37:49 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <C0EA2469-DA5B-413E-9AB4-F79954DBE3AE@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148781>

On Wednesday 09 June 2010, Steven Michalske wrote:
> On Jun 9, 2010, at 1:22 AM, Johan Herland wrote:
> > On Wednesday 09 June 2010, Jens Lehmann wrote:
> >> Am 08.06.2010 23:52, schrieb Johan Herland:
> >>> [1]: Say your submodule usually tracks a branch, but you're
> >>> creating some tag in the super-repo, and you want that tag to
> >>> uniquely identify
> >>> the submodule. You achieve this by making sure the tagged commit
> >>> removes the relevant "branch =3D whatever" line from .gitmodules,
> >>> and records the appropriate submodule version in the super-repo
> >>> tree. Then, you can revert the .gitmodules change on the next
> >>> commit to resume tracking the submodule branch.
> >>>
> >>> Now, whenever you checkout the tag, you will always get the exact
> >>> same
> >>> version of the submodule, although the submodule otherwise tracks
> >>> some
> >>> branch.
> >>
> >> Won't work anymore when we would use 0{40} or drop it from the
> >> tree. AFAICS always-tip and referencing a certain commit don't mix
> >> well.
> >
> > AFAICS, it would still work as long as it exists in the tree for
> > that specific commit (but is missing/0{40} in other commits).
> >
> > We're not mixing "always-tip" and "exact-commit" in the same
> > commit. We use "always-tip" in regular commits, and then temporaril=
y
> > switch to "exact-commit" in the commits where a certain submodule
> > version is required.
>
> When making a tag, could the notes system be used for marking what
> commit was exactly on the submodule, perhaps include the closest
> remote commits as well?
>
>
> Something like
>
> Submodule Status:
> 	["foo"]
> 		branch =3D subtopic:SHA
>
> This assumes that git notes are shared/cloned......

I don't think this is a good use of notes. We already have an=20
infrastructure for recording the exact submodule version used (the=20
submodule entry in the superproject tree), and I see no reason why we=20
should not use that in this case.

> Other thoughts.
>
>
> Things that should still work with tracking submodules.
> 	- bisect   - Must be able to identify that a submodule change
> introduced the bug.

When tracking submodule commits (the default), this is just a matter of=
=20
recursively applying the bisect operation to the good/bad submodule=20
commits identified by the superproject bisect.

When tracking submodule branches, you can no longer use bisect in the=20
superproject to find bugs in the submodule, since it would always check=
=20
out the same (i.e. latest) version of the submodule (I'm assuming that=20
we're not switching submodule branches in .gitmodules here...).

In the tag scenario I present which is quoted above, we're switching=20
between tracking submodule commits (in the commits that are tagged),=20
and tracking submodule branches (in the other commits), so bisect would=
=20
be next to useless (unless you limit the bisect to only look at the=20
tagged commits).

Alternatively, we could reconsider the question I asked =C6var initiall=
y=20
in this thread:

<quote>
When do you update the commit reference in the submodule? "never" would=
=20
work (since you're checking out a different commit anyway), "always"=20
would also work (for the same reason), but would litter the superrepo=20
history with submodule updates. There may be a better alternative=20
somewhere in between.
</quote>

So if we _always_ (or often) update the submodule commit reference in=20
the superproject, then we could disregard the branch tracking while=20
bisecting and checkout the commit referenced from the super-repo. That=20
would hopefully be as useful as if we'd tracked submodule commits=20
explicitly.

But again, the more often we update the submodule commit reference=20
(while still primarily tracking a _branch_ in the submodule), the more=20
we "litter" the superproject history with these updates.

> 	- archive  - Should it use the version from the commit, or the
> latest?

Good question. In principle, since you've explicitly asked to track a=20
branch, the only assumption Git can make is that you really want the=20
_latest_ version of that subdmodule/branch.

Again we're back to the question of if/how often we record update=20
submodule commits in the superproject, when the submodule primarily=20
tracks a branch: If we're religious about recording our submodule=20
commit references in the superproject, then we can temporarily=20
disregard the branch tracking in order to get a somewhat realistic=20
submodule update history.

>       - rebase   - update all of the submodule commits?=20

Again, depends. If you really want branch-tracking, rebase will not=20
change the submodule (unless you change which branch is tracked=20
in .gitmodules).

Here, I don't see a good rationale for updating submodules though. If=20
you're tracking submodule branches, then a superproject rebase won't=20
affect what's at the tip of a submodule branch.

=2E..unless you're talking about rebasing "foo" onto "bar in the=20
superproject causing a corresponding rebase of "subfoo" onto "subbar"=20
in the submodule, which is a whole 'nother can of worms...

> 	- checkout - tip vs commit

No question. If you've specified branch-tracking in .gitmodules, you ge=
t=20
tip, otherwise you get commit.

> 	- reset --hard - Good question... not sure.... probably depend on
> tip vs commit like checkout.

As above, a reset --hard in the superproject does not affect what's at=20
the tip of some submodule branch, so if you've chosen to track=20
submodule branches, a reset --hard will not touch the submodule (unless=
=20
the reset changes .gitmodules, obviously)

> 	- More????
>
> I would rather the submodule entree in the tree be always updated to
> what is in the submodule on the commit, so that the history is always
> there.

I see your point, as this would enable you to temporarily disable=20
branch-tracking after the fact (typically for debugging purposes). But=20
we still have to weigh its usefulness (in practice) against the cost of=
=20
adding these extra commit references.

After all, even if Git does not do this automatically, you could still=20
fairly easily add a pre-commit hook in the superproject that stages all=
=20
submodule references.

> Then actions updating the repository from remotes=20
> automatically pull the latest version.  I feel that the submodule if
> automatically be pulled, merged, etc, than the submodule should get a
> commit, with the message about this being an automatic update of the
> submodule.  Checking out is a different story.... checking out a
> branch tip of the super gets the latest tip from the submodule.  When
> you commit, the submodule gets it's auto commit, then a second commit
> for the code changes.  checking out a previous revision should
> probably put the sub module to the state it was in at that point in
> time.  Creating a branch and adding new content would update
> according to the rules.  but show the change of the subproject as
> from the super's at the branch point, not the tip.
>
> This way older gits have a submodule to work with and newer gits will
> do the right thing.
>
> Example:
>
> s-y-y-z
> A-B-C-D
> \
>   \F-G
> s-z-z
>
> F is branched when the latest sub module is at z  but shows the
> change from s not z because A the parent of F was created with the
> submodule at s
>
> Situational Example:
>
> I am developing away and as I progress in development I get a
> regression bug, so I run git bisect from the last stable release with
> out this bug, and it starts bisecting away.
>
> In the mode where we don't store the state of the project I can't
> bisect the changes against the subproject, where my bug might have
> been introduced from.

No, you would have to run a separate bisect in the subproject. What's=20
wrong about that?

> So that issue should be probably handled in the git bisect code, that
> is "Make git bisect submodule aware"  in more verbose terms, when
> bisecting a super project the sub modules should undergo bisection as
> well.  This is a permutation that will expand rapidly, but some
> thoughts on how to dig into the bisection issues.
> This is another email ;-)
>
>
> Rebase:
> 	With the auto commit of submodule scheme, a rebase would change the
> tracking branches to the latest of the tracked version. and auto
> merge and record the previous submodule revision in the commit
> message of the submodule auto commit.

Not sure I understand what you're getting at here. Say you're tracking=20
submodule branches (in the superproject's .gitmodules). Now, you do a=20
rebase in the superproject. If the rebase does not change .gitmodules=20
(i.e. which branch is tracked in the submodule), then there is nothing=20
to be done in the submodule (it has already checked out the tip of that=
=20
branch). If the rebase _does_ change .gitmodules - let's say there's a=20
conflict in which submodule branch to track - then you first resolve=20
that conflict in the superproject, to track the appropriate submodule=20
branch. Then the tip of that branch is simply checked out in the=20
submodule. You may want to record this update in the superproject,=20
either by recording a separate commit, or by amending into the rebased=20
commit.

Now, it might be that the correct resolution of the superproject's=20
rebase conflict requires a nested rebase in the submodule, but this is=20
certainly not a conclusion that Git can reach independently, so you=20
will have to do the nested rebase manually, and then record the rebased=
=20
branch in the superproject's .gitmodules (and optionally commit the=20
updated submodule reference).

> Checkout with nonexistant submodule sha:
> 	This is the case where the submodules ref was not pushed publicly,
> so, the contents are not available.  You get a nice warning and the
> tip of the submodules branch gets checked out for that submodule.

If the .gitmodules specifies branch "foo" to be checked out in the=20
submodule, and branch "foo" does not exist in the submodule, then=20
that's the same type of error as if the superproject specifies a commit=
=20
SHA1 for the submodule, and that commit does not exist in the=20
submodule.

Granted, in the branch case, we can make it more network/remote-aware,=20
by checking for both "foo" and "origin/foo" before giving up.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
