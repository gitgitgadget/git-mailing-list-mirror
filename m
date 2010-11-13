From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] Use reflog in 'pull --rebase . foo'
Date: Sat, 13 Nov 2010 18:20:47 +0100
Message-ID: <AANLkTikmJVj9BM=K2oSYJvPV27Uzn_9SQhsLc9EQm8zQ@mail.gmail.com>
References: <1289590708-11064-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <m2pqu98urp.fsf@whitebox.home> <AANLkTiniwpk7ao=M4=5vuahczk6FscQYJE1rZx=wuBk_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 13 18:21:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHJmw-0001N2-Pm
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 18:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679Ab0KMRVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Nov 2010 12:21:10 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44144 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab0KMRVI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Nov 2010 12:21:08 -0500
Received: by qyk4 with SMTP id 4so641958qyk.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 09:21:07 -0800 (PST)
Received: by 10.229.241.78 with SMTP id ld14mr3226803qcb.188.1289668867433;
 Sat, 13 Nov 2010 09:21:07 -0800 (PST)
Received: by 10.229.105.76 with HTTP; Sat, 13 Nov 2010 09:20:47 -0800 (PST)
In-Reply-To: <AANLkTiniwpk7ao=M4=5vuahczk6FscQYJE1rZx=wuBk_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161390>

On Sat, Nov 13, 2010 at 1:09 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 5f47b18..2e1661d 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -63,11 +63,8 @@ get_default_remote () {
> =A0get_remote_merge_branch () {
> =A0 =A0 =A0 =A0case "$#" in
> =A0 =A0 =A0 =A00|1)
> - =A0 =A0 =A0 =A0 =A0 origin=3D"$1"
> - =A0 =A0 =A0 =A0 =A0 default=3D$(get_default_remote)
> - =A0 =A0 =A0 =A0 =A0 test -z "$origin" && origin=3D$default
> =A0 =A0 =A0 =A0 =A0 =A0curr_branch=3D$(git symbolic-ref -q HEAD)
> - =A0 =A0 =A0 =A0 =A0 [ "$origin" =3D "$default" ] &&
> + =A0 =A0 =A0 =A0 =A0 test -z "$1" || test "$1" =3D $(get_default_rem=
ote) &&
> =A0 =A0 =A0 =A0 =A0 =A0echo $(git for-each-ref --format=3D'%(upstream=
)' $curr_branch)
> =A0 =A0 =A0 =A0 =A0 =A0;;
> =A0 =A0 =A0 =A0*)

They are not equivalent, the last line (echo $(git for-each-ref...))
is always executed, not only when ask for the default remote. When
$origin !=3D $default the last line does not return the correct answer.
It should return nothing, it is not well defined. Or maybe it should
return the branch pointed by $origin/HEAD (I cannot test right now
what 'git pull $remote-not-the-default' merges).

And it has nothing to do with letting 'pull --rebase . for" work.

> @@ -89,7 +86,13 @@ get_remote_merge_branch () {
> =A0 =A0 =A0 =A0 =A0 =A0refs/heads/*) remote=3D${remote#refs/heads/} ;=
;
> =A0 =A0 =A0 =A0 =A0 =A0refs/* | tags/* | remotes/* ) remote=3D
> =A0 =A0 =A0 =A0 =A0 =A0esac
> -
> - =A0 =A0 =A0 =A0 =A0 [ -n "$remote" ] && echo "refs/remotes/$repo/$r=
emote"
> + =A0 =A0 =A0 =A0 =A0 [ -n "$remote" ] && case "$repo" in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "refs/heads/$remote"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "refs/remotes/$repo/$remot=
e"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> + =A0 =A0 =A0 =A0 =A0 esac
> =A0 =A0 =A0 =A0esac
> =A0}
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 0b489f5..0470a81 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -222,4 +222,11 @@ test_expect_success 'git pull --rebase does not
> reapply old patches' '
> =A0 =A0 =A0 =A0)
> =A0'
>
> +test_expect_success 'git pull --rebase against local branch' '
> + =A0 =A0 =A0 git checkout -b copy2 to-rebase-orig &&
> + =A0 =A0 =A0 git pull --rebase . to-rebase &&
> + =A0 =A0 =A0 test "conflicting modification" =3D "$(cat file)" &&
> + =A0 =A0 =A0 test file =3D "$(cat file2)"
> +'
> +
> =A0test_done

=46or the rest I think they are OK, and make sense.

HTH,
Santi
