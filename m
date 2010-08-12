From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and
 reapplying unnecessary patches
Date: Thu, 12 Aug 2010 15:34:15 +0200
Message-ID: <AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com> <1281592569-740-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	martinvz <martin.von.zweigbergk@gmail.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 15:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjXvk-0004O5-IX
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 15:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760129Ab0HLNeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 09:34:36 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60392 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760074Ab0HLNeg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 09:34:36 -0400
Received: by pzk26 with SMTP id 26so426786pzk.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 06:34:35 -0700 (PDT)
Received: by 10.114.120.9 with SMTP id s9mr92064wac.100.1281620075345; Thu, 12
 Aug 2010 06:34:35 -0700 (PDT)
Received: by 10.114.195.14 with HTTP; Thu, 12 Aug 2010 06:34:15 -0700 (PDT)
In-Reply-To: <1281592569-740-3-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153375>

On Thu, Aug 12, 2010 at 7:56 AM, Elijah Newren <newren@gmail.com> wrote=
:
> Prior to c85c79279df2c8a583d95449d1029baba41f8660, pull --rebase woul=
d run
> =A0git rebase $merge_head
> which resulted in a call to
> =A0git format-patch ... --ignore-if-in-upstream $merge_head..$cur_bra=
nch
>
> This resulted in patches from $merge_head..$cur_branch being applied,=
 as
> long as they did not already exist in $cur_branch..$merge_head.
> Unfortunately, when upstream is rebased, $merge_head..$cur_branch als=
o
> refers to "old" commits that have already been rebased upstream, mean=
ing
> that many patches that were already fixed upstream would be reapplied=
=2E
> This could result in many spurious conflicts, as well as reintroduce
> patches that were intentionally dropped upstream.
>
> So the algorithm was changed in c85c79279df2c8a583d95449d1029baba41f8=
660
> and d44e71261f91d3cc81293e0976bb40daa8abb583. =A0Defining $old_remote=
_ref to
> be the most recent entry in the reflog for @{upstream} that is an anc=
estor
> of $cur_branch, pull --rebase was changed to run
> =A0git rebase --onto $merge_head $old_remote_ref
> which results in a call to
> =A0git format-patch ... --ignore-if-in-upstream $old_remote_ref..$cur=
_branch
>
> The whole point of this change was to reduce the number of commits be=
ing
> reapplied, by avoiding commits that upstream already has or had.
>
> In the rebased upstream case, this change achieved that purpose. =A0I=
t is
> worth noting, though, that since $old_remote_ref is always an ancesto=
r of
> $cur_branch (by its definition), format-patch will not know what upst=
ream
> is and thus will not be able to determine if any patches are already
> upstream; they will all be reapplied.
>
> In the non-rebased upstream case, this new form is usually the same a=
s the
> original code but in some cases $old_remote_ref can be an ancestor of
> =A0 $(git merge-base $merge_head $cur_branch)
> meaning that instead of avoiding reapplying commits that upstream alr=
eady
> has, it actually includes more such commits. =A0Combined with the fac=
t that
> format-patch can no longer detect commits that are already upstream (=
since
> it is no longer told what upstream is), results in lots of confusion =
for
> users (e.g. "git is giving me lots of conflicts in stuff I didn't eve=
n
> change since my last push.")
>
> Fix the non-rebased upstream case by ignoring $old_remote_ref wheneve=
r it
> is contained in $(git merge-base $merge_head $cur_branch). =A0This sh=
ould
> have no affect on the rebased upstream case.

All this makes sense.

But can you explain when it happens? One possibility is when you don't
fork from the tracking branch as in:

Subject: Difference between pull --rebase and fetch+rebase 					=09
Message-ID: <27059158.post@talk.nabble.com>
=46rom: martinvz <martin.von.zweigbergk@gmail.com>

and this patch should also fix martinvz's issue (I've CC martinvz, can
you test this patch? Thanks).

Can you refer to commits with something like this?

c85c792 (pull --rebase: be cleverer with rebased upstream branches, 200=
8-01-26)

alias.one !git --no-pager show -s --pretty=3D'tformat:%h (%s, %ad)' --d=
ate=3Dshort

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> =A0git-pull.sh =A0 =A0 | =A0 34 ++++++++++++++++++++++------------
> =A0t/t5520-pull.sh | =A0 =A04 ++--
> =A02 files changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index a09a44e..54da07b 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -206,18 +206,6 @@ test true =3D "$rebase" && {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git diff-index --ignore-submodules --c=
ached --quiet HEAD -- ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die "refusing to pull with rebase: you=
r working tree is not up-to-date"
> =A0 =A0 =A0 =A0fi
> - =A0 =A0 =A0 oldremoteref=3D &&
> - =A0 =A0 =A0 . git-parse-remote &&
> - =A0 =A0 =A0 remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null=
)" &&
> - =A0 =A0 =A0 oldremoteref=3D"$(git rev-parse -q --verify "$remoteref=
")" &&
> - =A0 =A0 =A0 for reflog in $(git rev-list -g $remoteref 2>/dev/null)
> - =A0 =A0 =A0 do
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test "$reflog" =3D "$(git merge-base=
 $reflog $curr_branch)"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldremoteref=3D"$reflog=
"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> - =A0 =A0 =A0 done
> =A0}
> =A0orig_head=3D$(git rev-parse -q --verify HEAD)
> =A0git fetch $verbosity $progress $dry_run --update-head-ok "$@" || e=
xit 1
> @@ -273,6 +261,28 @@ then
> =A0 =A0 =A0 =A0exit
> =A0fi
>
> +if test true =3D "$rebase"
> +then
> + =A0 =A0 =A0 oldremoteref=3D &&
> + =A0 =A0 =A0 . git-parse-remote &&
> + =A0 =A0 =A0 remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null=
)" &&
> + =A0 =A0 =A0 oldremoteref=3D"$(git rev-parse -q --verify "$remoteref=
")" &&
> + =A0 =A0 =A0 for reflog in $(git rev-list -g $remoteref 2>/dev/null)
> + =A0 =A0 =A0 do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test "$reflog" =3D "$(git merge-base=
 $reflog $curr_branch)"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldremoteref=3D"$reflog=
"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 done
> +
> + =A0 =A0 =A0 o=3D$(git show-branch --merge-base $curr_branch $merge_=
head $oldremoteref)
> + =A0 =A0 =A0 if test "$oldremoteref" =3D "$o"
> + =A0 =A0 =A0 then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unset oldremoteref
> + =A0 =A0 =A0 fi
> +fi
> +

You've moved all the lines after the call to "git fetch". It changes
the behavior when the reflog is not enabled, as the old value of
remoteref is lost.

Thanks
Santi
