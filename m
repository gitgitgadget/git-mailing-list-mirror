From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv3 2/2] pull: support rebased upstream + fetch + pull 
	--rebase
Date: Sun, 19 Jul 2009 09:27:43 +0200
Message-ID: <adf1fd3d0907190027s2bf5380er8e59a60d1a3637ad@mail.gmail.com>
References: <adf1fd3d0907170624t7c2bf8f5w35c03788fdd82422@mail.gmail.com>
	 <1247924785-31886-1-git-send-email-santi@agolina.net>
	 <7vk5253mg8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 09:27:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSQoM-0001Lm-AY
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 09:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbZGSH1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jul 2009 03:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbZGSH1o
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 03:27:44 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:34627 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbZGSH1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2009 03:27:43 -0400
Received: by an-out-0708.google.com with SMTP id d40so2578233and.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 00:27:43 -0700 (PDT)
Received: by 10.100.228.6 with SMTP id a6mr4363174anh.163.1247988463118; Sun, 
	19 Jul 2009 00:27:43 -0700 (PDT)
In-Reply-To: <7vk5253mg8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123546>

2009/7/18 Junio C Hamano <gitster@pobox.com>:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> Changes since v2:
>> =A0 - Hopefully enhance the commit log
>> =A0 - Use a 'for' loop for the reflog entries
>> =A0 - provide a default value in case there is no reflog
>> diff --git a/git-pull.sh b/git-pull.sh
>> index 4b78a0c..c8f1674 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -125,9 +125,16 @@ test true =3D "$rebase" && {
>> =A0 =A0 =A0 die "refusing to pull with rebase: your working tree is =
not up-to-date"
>>
>> =A0 =A0 =A0 . git-parse-remote &&
>> - =A0 =A0 reflist=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
>> + =A0 =A0 remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" =
&&
>> + =A0 =A0 oldremoteref=3D &&
>> + =A0 =A0 for reflog in $(git rev-list -g $remoteref 2>/dev/null)
>> + =A0 =A0 do
>> + =A0 =A0 =A0 =A0 =A0 =A0 test $reflog =3D $(git merge-base $reflog =
$curr_branch) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 oldremoteref=3D$reflog && break
>> + =A0 =A0 done
>> + =A0 =A0 [ -z "$oldremoteref" ] &&
>> =A0 =A0 =A0 oldremoteref=3D"$(git rev-parse -q --verify \
>> - =A0 =A0 =A0 =A0 =A0 =A0 "$reflist")"
>> + =A0 =A0 =A0 =A0 =A0 =A0 "$remoteref")"
>> =A0}
>
> If get_remote_merge_branch fails, oldremoteref is not initialized to =
empty
> string, the for loop is skipped and then the last step (by the way, p=
lease
> write that as 'test -z "$oldremoteref"') may not kick in, using whate=
ver
> random value the variable originally had in the environment.

Not a justification but it also happens with the original code.

>
> It probably makes more sense to do it in a slightly different order:
>
> =A0 =A0 =A0 =A0. git-parse-remote &&
> =A0 =A0 =A0 =A0oldremoteref=3D"$(get_remote_merge...)" &&

oldremotref must be a sha1, because it changes during the fetch. But
I'll use more o less this order.

> =A0 =A0 =A0 =A0remoteref=3D$oldremoteref &&
> =A0 =A0 =A0 =A0for old in $(git rev-list -g "$remoteref" 2>/dev/null)
> =A0 =A0 =A0 =A0do
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if test "$old" =3D "$(git merge-base "=
$old" "$current_branch")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oldremoteref=3D"$old"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0# and you do not need 'if test -z "$oldremoteref"' any=
more...
>
> But other than that, I agree that this is the most straightforward
> algorithm to express what you wanted to do. =A0I guess another possib=
ility
> is to instead look in the reflog of the _current_ branch to check how=
 the
> previous rebase was done, iow, find out onto which commit the recent =
part
> of the current branch was rebased to, and rebase onto the current rem=
ote
> tip using that as the base.

It supposes that it was rebased already, and you have to interpret the
reflog history. And there are situations where you don't get the same
answer, i.e you create a new local branch using another local branch
as the starting point but with the same upstream.

Santi
