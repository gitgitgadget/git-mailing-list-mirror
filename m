From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3] mergetool: Provide an empty file when needed
Date: Thu, 19 Jan 2012 23:53:53 -0800
Message-ID: <CAJDDKr71Q9ihLZdP1Pu=ebpvX0EPvW-9bN6kZz9MeuhYKZzh+Q@mail.gmail.com>
References: <7vy5t2g6za.fsf@alter.siamese.dyndns.org>
	<1327045655-3368-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jcwenger@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 20 08:54:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro9Ia-0002fr-Ra
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087Ab2ATHxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 02:53:54 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39850 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab2ATHxy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 02:53:54 -0500
Received: by yenm6 with SMTP id m6so131442yen.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 23:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8tWcQzekrzQ8Xse2tmxLKoXsN/q+dYcw5SND0fdrHhI=;
        b=BeZT8YyqL5OCfUyNbmhHQaR94lKP/i3p8S1WpErHTjK3cdi89R45QZ2RkROkcKyg1/
         9aNOXxv8yGGgHoOOtj+ybXCZ9qmtUadp7n2zQysxNGYbL6Xv7/U9FZmrXSsKrySCKEW4
         1AE7KHwoJwBdgCTq/8XD/qumvz2w2W5+/pLB8=
Received: by 10.236.189.105 with SMTP id b69mr11296243yhn.90.1327046033444;
 Thu, 19 Jan 2012 23:53:53 -0800 (PST)
Received: by 10.146.151.11 with HTTP; Thu, 19 Jan 2012 23:53:53 -0800 (PST)
In-Reply-To: <1327045655-3368-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188868>

On Thu, Jan 19, 2012 at 11:47 PM, David Aguilar <davvid@gmail.com> wrot=
e:
> Some merge tools cannot cope when $LOCAL, $BASE, or $REMOTE
> are missing. =C2=A0$BASE can be missing when two branches
> independently add the same filename. =C2=A0$LOCAL and $REMOTE
> can be missing when a delete/modify conflict occurs.
>
> Provide an empty file to make these tools happy.
>
> Reported-by: Jason Wenger <jcwenger@gmail.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> We now create the empty file in checkout_staged_file()
> as part of the error checking section.
>
> =C2=A0git-mergetool.sh =C2=A0 =C2=A0 | =C2=A0 =C2=A08 +++++---
> =C2=A0t/t7610-mergetool.sh | =C2=A0 27 ++++++++++++++++++++++++++-
> =C2=A02 files changed, 31 insertions(+), 4 deletions(-)


I certainly like this version the best.  This diff is smaller and it's
all handled in one place.  It should've been marked PATCH v4 ;-)

Thanks for the review.

> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 085e213..24bedc5 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -185,6 +185,8 @@ checkout_staged_file () {
>
> =C2=A0 =C2=A0 if test $? -eq 0 -a -n "$tmpfile" ; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mv -- "$(git rev-parse --show-cdup)$tmpfil=
e" "$3"
> + =C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 >"$3"
> =C2=A0 =C2=A0 fi
> =C2=A0}
>
> @@ -224,9 +226,9 @@ merge_file () {
> =C2=A0 =C2=A0 mv -- "$MERGED" "$BACKUP"
> =C2=A0 =C2=A0 cp -- "$BACKUP" "$MERGED"
>
> - =C2=A0 =C2=A0base_present =C2=A0 && checkout_staged_file 1 "$MERGED=
" "$BASE"
> - =C2=A0 =C2=A0local_present =C2=A0&& checkout_staged_file 2 "$MERGED=
" "$LOCAL"
> - =C2=A0 =C2=A0remote_present && checkout_staged_file 3 "$MERGED" "$R=
EMOTE"
> + =C2=A0 =C2=A0checkout_staged_file 1 "$MERGED" "$BASE"
> + =C2=A0 =C2=A0checkout_staged_file 2 "$MERGED" "$LOCAL"
> + =C2=A0 =C2=A0checkout_staged_file 3 "$MERGED" "$REMOTE"
>
> =C2=A0 =C2=A0 if test -z "$local_mode" -o -z "$remote_mode"; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "Deleted merge conflict for '$MERGED'=
:"
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 4aab2a7..2272743 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -39,6 +39,7 @@ test_expect_success 'setup' '
> =C2=A0 =C2=A0 echo branch1 change >file1 &&
> =C2=A0 =C2=A0 echo branch1 newfile >file2 &&
> =C2=A0 =C2=A0 echo branch1 spaced >"spaced name" &&
> + =C2=A0 =C2=A0echo branch1 both added > both &&
> =C2=A0 =C2=A0 echo branch1 change file11 >file11 &&
> =C2=A0 =C2=A0 echo branch1 change file13 >file13 &&
> =C2=A0 =C2=A0 echo branch1 sub >subdir/file3 &&
> @@ -50,6 +51,7 @@ test_expect_success 'setup' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -b submod-branch1
> =C2=A0 =C2=A0 ) &&
> =C2=A0 =C2=A0 git add file1 "spaced name" file11 file13 file2 subdir/=
file3 submod &&
> + =C2=A0 =C2=A0git add both &&
> =C2=A0 =C2=A0 git rm file12 &&
> =C2=A0 =C2=A0 git commit -m "branch1 changes" &&
>
> @@ -58,6 +60,7 @@ test_expect_success 'setup' '
> =C2=A0 =C2=A0 echo master updated >file1 &&
> =C2=A0 =C2=A0 echo master new >file2 &&
> =C2=A0 =C2=A0 echo master updated spaced >"spaced name" &&
> + =C2=A0 =C2=A0echo master both added > both &&
> =C2=A0 =C2=A0 echo master updated file12 >file12 &&
> =C2=A0 =C2=A0 echo master updated file14 >file14 &&
> =C2=A0 =C2=A0 echo master new sub >subdir/file3 &&
> @@ -69,18 +72,22 @@ test_expect_success 'setup' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -b submod-master
> =C2=A0 =C2=A0 ) &&
> =C2=A0 =C2=A0 git add file1 "spaced name" file12 file14 file2 subdir/=
file3 submod &&
> + =C2=A0 =C2=A0git add both &&
> =C2=A0 =C2=A0 git rm file11 &&
> =C2=A0 =C2=A0 git commit -m "master updates" &&
>
> =C2=A0 =C2=A0 git config merge.tool mytool &&
> =C2=A0 =C2=A0 git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$=
MERGED\"" &&
> - =C2=A0 =C2=A0git config mergetool.mytool.trustExitCode true
> + =C2=A0 =C2=A0git config mergetool.mytool.trustExitCode true &&
> + =C2=A0 =C2=A0git config mergetool.mybase.cmd "cat \"\$BASE\" >\"\$M=
ERGED\"" &&
> + =C2=A0 =C2=A0git config mergetool.mybase.trustExitCode true
> =C2=A0'
>
> =C2=A0test_expect_success 'custom mergetool' '
> =C2=A0 =C2=A0 git checkout -b test1 branch1 &&
> =C2=A0 =C2=A0 git submodule update -N &&
> =C2=A0 =C2=A0 test_must_fail git merge master >/dev/null 2>&1 &&
> + =C2=A0 =C2=A0( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file1 file1 ) &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file2 "spaced name" >/dev/null=
 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 )=
 &&
> @@ -101,6 +108,7 @@ test_expect_success 'mergetool crlf' '
> =C2=A0 =C2=A0 ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool "spaced name" >/dev/null 2>&1 =
) &&
> + =C2=A0 =C2=A0( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 )=
 &&
> =C2=A0 =C2=A0 ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
> @@ -131,6 +139,7 @@ test_expect_success 'mergetool on file in parent =
dir' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cd subdir &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0( yes "" | git mergetool ../file1 >/dev/nu=
ll 2>&1 ) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0( yes "" | git mergetool ../file2 ../space=
d\ name >/dev/null 2>&1 ) &&
> + =C2=A0 =C2=A0 =C2=A0 ( yes "" | git mergetool ../both >/dev/null 2>=
&1 ) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0( yes "d" | git mergetool ../file11 >/dev/=
null 2>&1 ) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0( yes "d" | git mergetool ../file12 >/dev/=
null 2>&1 ) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0( yes "l" | git mergetool ../submod >/dev/=
null 2>&1 ) &&
> @@ -212,6 +221,7 @@ test_expect_success 'deleted vs modified submodul=
e' '
> =C2=A0 =C2=A0 test_must_fail git merge master &&
> =C2=A0 =C2=A0 test -n "$(git ls-files -u)" &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file1 file2 spaced\ name subdi=
r/file3 >/dev/null 2>&1 ) &&
> + =C2=A0 =C2=A0( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1=
 ) &&
> =C2=A0 =C2=A0 ( yes "r" | git mergetool submod ) &&
> =C2=A0 =C2=A0 rmdir submod && mv submod-movedaside submod &&
> @@ -228,6 +238,7 @@ test_expect_success 'deleted vs modified submodul=
e' '
> =C2=A0 =C2=A0 test_must_fail git merge master &&
> =C2=A0 =C2=A0 test -n "$(git ls-files -u)" &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file1 file2 spaced\ name subdi=
r/file3 >/dev/null 2>&1 ) &&
> + =C2=A0 =C2=A0( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1=
 ) &&
> =C2=A0 =C2=A0 ( yes "l" | git mergetool submod ) &&
> =C2=A0 =C2=A0 test ! -e submod &&
> @@ -241,6 +252,7 @@ test_expect_success 'deleted vs modified submodul=
e' '
> =C2=A0 =C2=A0 test_must_fail git merge test6 &&
> =C2=A0 =C2=A0 test -n "$(git ls-files -u)" &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file1 file2 spaced\ name subdi=
r/file3 >/dev/null 2>&1 ) &&
> + =C2=A0 =C2=A0( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1=
 ) &&
> =C2=A0 =C2=A0 ( yes "r" | git mergetool submod ) &&
> =C2=A0 =C2=A0 test ! -e submod &&
> @@ -256,6 +268,7 @@ test_expect_success 'deleted vs modified submodul=
e' '
> =C2=A0 =C2=A0 test_must_fail git merge test6 &&
> =C2=A0 =C2=A0 test -n "$(git ls-files -u)" &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file1 file2 spaced\ name subdi=
r/file3 >/dev/null 2>&1 ) &&
> + =C2=A0 =C2=A0( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1=
 ) &&
> =C2=A0 =C2=A0 ( yes "l" | git mergetool submod ) &&
> =C2=A0 =C2=A0 test "$(cat submod/bar)" =3D "master submodule" &&
> @@ -279,6 +292,7 @@ test_expect_success 'file vs modified submodule' =
'
> =C2=A0 =C2=A0 test_must_fail git merge master &&
> =C2=A0 =C2=A0 test -n "$(git ls-files -u)" &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file1 file2 spaced\ name subdi=
r/file3 >/dev/null 2>&1 ) &&
> + =C2=A0 =C2=A0( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1=
 ) &&
> =C2=A0 =C2=A0 ( yes "r" | git mergetool submod ) &&
> =C2=A0 =C2=A0 rmdir submod && mv submod-movedaside submod &&
> @@ -294,6 +308,7 @@ test_expect_success 'file vs modified submodule' =
'
> =C2=A0 =C2=A0 test_must_fail git merge master &&
> =C2=A0 =C2=A0 test -n "$(git ls-files -u)" &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file1 file2 spaced\ name subdi=
r/file3 >/dev/null 2>&1 ) &&
> + =C2=A0 =C2=A0( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1=
 ) &&
> =C2=A0 =C2=A0 ( yes "l" | git mergetool submod ) &&
> =C2=A0 =C2=A0 git submodule update -N &&
> @@ -309,6 +324,7 @@ test_expect_success 'file vs modified submodule' =
'
> =C2=A0 =C2=A0 test_must_fail git merge test7 &&
> =C2=A0 =C2=A0 test -n "$(git ls-files -u)" &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file1 file2 spaced\ name subdi=
r/file3 >/dev/null 2>&1 ) &&
> + =C2=A0 =C2=A0( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1=
 ) &&
> =C2=A0 =C2=A0 ( yes "r" | git mergetool submod ) &&
> =C2=A0 =C2=A0 test -d submod.orig &&
> @@ -324,6 +340,7 @@ test_expect_success 'file vs modified submodule' =
'
> =C2=A0 =C2=A0 test_must_fail git merge test7 &&
> =C2=A0 =C2=A0 test -n "$(git ls-files -u)" &&
> =C2=A0 =C2=A0 ( yes "" | git mergetool file1 file2 spaced\ name subdi=
r/file3 >/dev/null 2>&1 ) &&
> + =C2=A0 =C2=A0( yes "" | git mergetool both>/dev/null 2>&1 ) &&
> =C2=A0 =C2=A0 ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1=
 ) &&
> =C2=A0 =C2=A0 ( yes "l" | git mergetool submod ) &&
> =C2=A0 =C2=A0 test "$(cat submod/bar)" =3D "master submodule" &&
> @@ -445,4 +462,12 @@ test_expect_success 'directory vs modified submo=
dule' '
> =C2=A0 =C2=A0 git submodule update -N
> =C2=A0'
>
> +test_expect_success 'file with no base' '
> + =C2=A0 =C2=A0git checkout -b test13 branch1 &&
> + =C2=A0 =C2=A0test_must_fail git merge master &&
> + =C2=A0 =C2=A0git mergetool --no-prompt --tool mybase -- base &&
> + =C2=A0 =C2=A0test "$(cat "$MERGED")" =3D "" &&
> + =C2=A0 =C2=A0git reset --hard master >/dev/null 2>&1
> +'
> +
> =C2=A0test_done
> --
> 1.7.9.rc2.1.g36b4c
>



--=20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 David
