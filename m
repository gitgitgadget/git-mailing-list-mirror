From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and
 reapplying unnecessary patches
Date: Thu, 12 Aug 2010 16:37:25 +0200
Message-ID: <AANLkTikLhe9+6ovLT99qG9wwDjXVmT8_81xuN8P31eve@mail.gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
 <1281592569-740-3-git-send-email-newren@gmail.com> <AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	martinvz <martin.von.zweigbergk@gmail.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 16:37:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjYuq-0004sU-Dm
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 16:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933709Ab0HLOhu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 10:37:50 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62186 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933641Ab0HLOht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 10:37:49 -0400
Received: by pzk26 with SMTP id 26so451351pzk.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 07:37:49 -0700 (PDT)
Received: by 10.114.130.13 with SMTP id c13mr188858wad.68.1281623865164; Thu,
 12 Aug 2010 07:37:45 -0700 (PDT)
Received: by 10.114.195.14 with HTTP; Thu, 12 Aug 2010 07:37:25 -0700 (PDT)
In-Reply-To: <AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153377>

On Thu, Aug 12, 2010 at 3:34 PM, Santi B=E9jar <santi@agolina.net> wrot=
e:
> On Thu, Aug 12, 2010 at 7:56 AM, Elijah Newren <newren@gmail.com> wro=
te:

[...]

>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>> =A0git-pull.sh =A0 =A0 | =A0 34 ++++++++++++++++++++++------------
>> =A0t/t5520-pull.sh | =A0 =A04 ++--
>> =A02 files changed, 24 insertions(+), 14 deletions(-)
>>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index a09a44e..54da07b 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -206,18 +206,6 @@ test true =3D "$rebase" && {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git diff-index --ignore-submodules --=
cached --quiet HEAD -- ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die "refusing to pull with rebase: yo=
ur working tree is not up-to-date"
>> =A0 =A0 =A0 =A0fi
>> - =A0 =A0 =A0 oldremoteref=3D &&
>> - =A0 =A0 =A0 . git-parse-remote &&
>> - =A0 =A0 =A0 remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/nul=
l)" &&
>> - =A0 =A0 =A0 oldremoteref=3D"$(git rev-parse -q --verify "$remotere=
f")" &&
>> - =A0 =A0 =A0 for reflog in $(git rev-list -g $remoteref 2>/dev/null=
)
>> - =A0 =A0 =A0 do
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test "$reflog" =3D "$(git merge-bas=
e $reflog $curr_branch)"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 then
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldremoteref=3D"$reflo=
g"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
>> - =A0 =A0 =A0 done
>> =A0}
>> =A0orig_head=3D$(git rev-parse -q --verify HEAD)
>> =A0git fetch $verbosity $progress $dry_run --update-head-ok "$@" || =
exit 1
>> @@ -273,6 +261,28 @@ then
>> =A0 =A0 =A0 =A0exit
>> =A0fi
>>
>> +if test true =3D "$rebase"
>> +then
>> + =A0 =A0 =A0 oldremoteref=3D &&
>> + =A0 =A0 =A0 . git-parse-remote &&
>> + =A0 =A0 =A0 remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/nul=
l)" &&
>> + =A0 =A0 =A0 oldremoteref=3D"$(git rev-parse -q --verify "$remotere=
f")" &&
>> + =A0 =A0 =A0 for reflog in $(git rev-list -g $remoteref 2>/dev/null=
)
>> + =A0 =A0 =A0 do
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test "$reflog" =3D "$(git merge-bas=
e $reflog $curr_branch)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldremoteref=3D"$reflo=
g"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
>> + =A0 =A0 =A0 done
>> +
>> + =A0 =A0 =A0 o=3D$(git show-branch --merge-base $curr_branch $merge=
_head $oldremoteref)
>> + =A0 =A0 =A0 if test "$oldremoteref" =3D "$o"
>> + =A0 =A0 =A0 then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unset oldremoteref
>> + =A0 =A0 =A0 fi
>> +fi
>> +
>
> You've moved all the lines after the call to "git fetch". It changes
> the behavior when the reflog is not enabled, as the old value of
> remoteref is lost.

Something like this?

=46ix the non-rebased upstream case by only setting $old_remote_ref
with commits not ancestors of $remoteref or $merge_head. This should
have no affect on the rebased upstream case.

diff --git c/git-pull.sh w/git-pull.sh
index a09a44e..c1617d5 100755
--- c/git-pull.sh
+++ w/git-pull.sh
@@ -214,7 +214,10 @@ test true =3D "$rebase" && {
        do
                if test "$reflog" =3D "$(git merge-base $reflog $curr_b=
ranch)"
                then
-                       oldremoteref=3D"$reflog"
+                       if test "$reflog" !=3D $(git merge-base $reflog
$remoteref)
+                       then
+                               oldremoteref=3D"$reflog"
+                       fi
                        break
                fi
        done
@@ -273,6 +276,14 @@ then
        exit
 fi

+if test true =3D "$rebase"
+then
+       if test "$oldremoteref" =3D $(git merge-base $oldremoteref $mer=
ge_head)
+       then
+               unset oldremoteref
+       fi
+fi
+
 merge_name=3D$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || e=
xit
 case "$rebase" in
 true)

(also attached because of whitespace damage)

HTH,
Santi
