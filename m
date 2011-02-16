From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Wed, 16 Feb 2011 13:10:28 +0100
Message-ID: <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 13:11:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpgDf-0004S3-TY
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 13:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759021Ab1BPMKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 07:10:51 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59104 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758999Ab1BPMKt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 07:10:49 -0500
Received: by vws16 with SMTP id 16so516754vws.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 04:10:48 -0800 (PST)
Received: by 10.229.231.9 with SMTP id jo9mr597724qcb.201.1297858248631; Wed,
 16 Feb 2011 04:10:48 -0800 (PST)
Received: by 10.229.225.8 with HTTP; Wed, 16 Feb 2011 04:10:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102152040370.14950@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166962>

On Wed, Feb 16, 2011 at 3:03 AM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Tue, 15 Feb 2011, Junio C Hamano wrote:
>
>> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>>
>> > diff --git a/git-rebase.sh b/git-rebase.sh
>> > index 5abfeac..1bc0c29 100755
>> > --- a/git-rebase.sh
>> > +++ b/git-rebase.sh
>> =A0 =A0 =A0 test -n "$upstream_name" &&
>> =A0 =A0 =A0 =A0 for reflog in $(git rev-list ...)
>> =A0 =A0 =A0 =A0 do
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>> =A0 =A0 =A0 done
>>
>> Don't you need to make sure $upstream_name is a branch (or a ref in
>> general that can have a reflog), or does it not matter because the
>> "rev-list -g" will die without producing anything and you are discar=
ding
>> the error message?
>
> Exactly as you suspect. Is it too ugly?

I also prefer Junio's version.

>
>> Now, a handful of random questions, none of them rhetorical, as I do=
n't
>> know the answers to any of them.
>>
>> Would it help if the code is made just as clever as the patch attemp=
ts to
>> be, when the user says
>>
>> =A0 =A0 =A0 git rebase origin/next~4
>>
>> IOW, use the reflog of origin/next even in such a case?
>
> Not sure. I think it seems too rare to worry about. In those cases,
> one could still use the good old '--onto' option manually. Also, if w=
e
> don't handle the ref~4 case, the "cleverness" can be disabled by usin=
g
> ref~0.

With ref~4 you are specifying a commit, so I would expect to rebase to
use it as such, not also as a branch ref.

>
>> > +do
>> > + =A0 if test $reflog =3D $(git merge-base $reflog $orig_head)
>> > + =A0 then
>> > + =A0 =A0 =A0 =A0 =A0 if test $reflog !=3D $(git merge-base $onto =
$reflog)
>> > + =A0 =A0 =A0 =A0 =A0 then
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 upstream=3D$reflog
>> > + =A0 =A0 =A0 =A0 =A0 fi
>> > + =A0 =A0 =A0 =A0 =A0 break
>> > + =A0 fi
>>
>> Do we always traverse down to the beginning of the reflog in the wor=
st
>> case?
>
> Yes.
>
>> Would bisection help to avoid the cost?
>
> I don't think the straight-forward use of bisection would work. If th=
e
> history looks something like below, where 'b' is the branch to rebase
> and 'u' is the upstream, we have to go through each entry in the
> reflog to find u@{3}.
>
>
> =A0 =A0 =A0 =A0.-u@{0}
> =A0 =A0 =A0 /
> =A0 =A0 =A0.---u@{1}
> =A0 =A0 /
> x---y-----u@{2}
> =A0 =A0 \
> =A0 =A0 =A0.---u@{3}---b
> =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0.-u@{4}
>
>
> I have an idea inspired by bisection, Thomas's exponential stride, an=
d
> what someone (you?) mentioned the other day about virtual merge
> commits. I haven't tried it out, but let me know what you think. I'll
> try to explain it using an example only:
>
> Exponential stride phase:
> 1. candidates=3D{ u@{0} }
> =A0 merge-base b $candidates -> y, _not_ in $candidates
> 2. candidates=3D{ u@{1} u@{2} }
> =A0 merge-base b $candidates -> y, _not_ in $candidates
> 3. candidates=3D{ u@{3} u@{4} u@{5} u@{6} }
> =A0 merge-base b $candidates -> u@{3}, in $candidates

Doesn't it indicate that u@{3} is the commit we are looking for? I
haven't found a counterexample...

If this is true the following patch can implement it for git-pull.sh an=
d
git-rebase.sh (sorry if it is space damaged):

diff --git i/git-pull.sh w/git-pull.sh
index 2cdea26..09ef0a9 100755
--- i/git-pull.sh
+++ w/git-pull.sh
@@ -189,14 +189,7 @@ test true =3D "$rebase" && {
 	. git-parse-remote &&
 	remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
 	oldremoteref=3D"$(git rev-parse -q --verify "$remoteref")" &&
-	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
-	do
-		if test "$reflog" =3D "$(git merge-base $reflog $curr_branch)"
-		then
-			oldremoteref=3D"$reflog"
-			break
-		fi
-	done
+	oldremoteref=3D$(git merge-base $curr_branch $oldremoteref $(git
rev-list -g $remoteref 2>/dev/null))
 }
 orig_head=3D$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules
--update-head-ok "$@" || exit 1
diff --git i/git-rebase.sh w/git-rebase.sh
index 0d245fe..4b3e131 100755
--- i/git-rebase.sh
+++ w/git-rebase.sh
@@ -448,18 +448,8 @@ esac

 require_clean_work_tree "rebase" "Please commit or stash them."

-test -n "$upstream_name" && for reflog in \
-	$(git rev-list -g $upstream_name 2>/dev/null)
-do
-	if test $reflog =3D $(git merge-base $reflog $orig_head)
-	then
-		if test $reflog !=3D $(git merge-base $onto $reflog)
-		then
-			upstream=3D$reflog
-		fi
-		break
-	fi
-done
+test -n "$upstream_name" &&
+upstream=3D$(git merge-base $orig_head $(git rev-list -g $upstream_nam=
e
2>/dev/null))

 # Now we are rebasing commits $upstream..$orig_head (or with --root,
 # everything leading up to $orig_head) on top of $onto
diff --git i/t/t3408-rebase-multi-line.sh w/t/t3408-rebase-multi-line.s=
h
index 6b84e60..bee4494 100755
--- i/t/t3408-rebase-multi-line.sh
+++ w/t/t3408-rebase-multi-line.sh
@@ -10,7 +10,12 @@ test_expect_success setup '
 	git add file &&
 	test_tick &&
 	git commit -m initial &&
+	>elif &&
+	git add elif &&
+	test_tick &&
+	git commit -m second &&

+	git checkout -b side HEAD^
 	echo hello >file &&
 	test_tick &&
 	git commit -a -m "A sample commit log message that has a long
@@ -18,13 +23,7 @@ summary that spills over multiple lines.

 But otherwise with a sane description." &&

-	git branch side &&
-
-	git reset --hard HEAD^ &&
-	>elif &&
-	git add elif &&
-	test_tick &&
-	git commit -m second
+	git checkout master

 '


It passes the "git pull --rebase" test and the basic "git rebase branch=
"
tests, but it fails basically with two type of tests: 1) those involvin=
g "git
rebase -i" (I'll try to debug those but I find it difficult to debug al=
l those
=46AKE_LINES), and those with "bad" reflogs as shown in the above patch=
 to
t3408 (see the next paragraph).

Trying to find the counterexample (and debugging the failing test
above) I've found one corner we don't handle (neither in git-pull.sh
nor in git-rebase.sh). It is the case when the upstream branch is
"fast-backwards" into an older commit without extra commits on top.
Something like this:

x---y----u@{1}---u@{2}---b
          \
           .---u@{0}

In this case the algorithm picks u@{1} instead of u@{2} (the
alternative algorithm has the same problem when u@{n} and u@{n+1} are
in different exponential phases.

Or the simple case in:

u@{2}---u@{0}
 \
  .---u@{1}=3Db

I think this is a very rare corner case as the upstream branch has to
be "fast-backward",  and you have to fetch this state. So far nobody
has found it, at least.

> Bisection phase:
> 1. candidates=3D{ u@{3} u@{4} }
> =A0 merge-base b $candidates -> u@{3}, in $candidates
> 2. candidates=3D{ u@{3} }
> =A0 merge-base b $candidates -> u@{3}, in $candidates, done
>
>
> It works for the few cases I have thought of, but it may break in
> other other cases. I just read about the virtual merge commits, so I'=
m
> not sure I understand correctly how that works eiter.

Me too.

HTH,
Santi
