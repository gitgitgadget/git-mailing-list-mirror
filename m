From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [PATCH 4/4] git-stash: remove untracked/ignored directories when stashed
Date: Fri, 26 Aug 2011 18:04:47 -0700
Message-ID: <CAE1pOi0gZ6Dv3k0Eg5bJXygdvvAdBi7MKx_bZOaNTdtVbf3HRQ@mail.gmail.com>
References: <1314406767-17832-1-git-send-email-drafnel@gmail.com>
	<1314406767-17832-4-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, david@porkrind.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 03:04:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx7KQ-00088N-Ep
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 03:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab1H0BEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Aug 2011 21:04:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34027 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795Ab1H0BEt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 21:04:49 -0400
Received: by gwaa12 with SMTP id a12so3331114gwa.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 18:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6/xf/jC+uClP9OI7dx8lv6c7wSN1JfWXBEKnIJwh+0Y=;
        b=KkCqVGR4bjmb234riuK8xQemv4EZcR3hW7OD6afiiidszgs65O+aAuNzDZ6jYJQeCj
         ehPiaNfOFSM6TxvdxWBcApb9D53wNZ5K5OYoIru5UA5iik3w9Nsd03+2E28AoajvdEkq
         k7fjA+esFcx6DzAPxCMPpf43WAd3zO/gYoI/w=
Received: by 10.236.136.135 with SMTP id w7mr11572355yhi.51.1314407088027;
 Fri, 26 Aug 2011 18:04:48 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Fri, 26 Aug 2011 18:04:47 -0700 (PDT)
In-Reply-To: <1314406767-17832-4-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180215>

On 26 August 2011 17:59, Brandon Casey <drafnel@gmail.com> wrote:
> The two new stash options --include-untracked and --all do not remove=
 the
> untracked and/or ignored files that are stashed if those files reside=
 in
> a subdirectory. e.g. the following sequence fails:
>
> =C2=A0 mkdir untracked &&
> =C2=A0 echo hello >untracked/file.txt &&
> =C2=A0 git stash --include-untracked &&
> =C2=A0 test ! -f untracked/file.txt
>
> Within the git-stash script, git-clean is used to remove the
> untracked/ignored files, but since the -d option was not supplied, it=
 does
> not remove directories.
>
> So, add -d to the git-clean arguments, and update the tests to test t=
his
> functionality.
>
> Reported-by: Hilco Wijbenga <hilco.wijbenga@gmail.com>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
> =C2=A0git-stash.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0t/t3905-stash-include-untracked.sh | =C2=A0 26 ++++++++++++++++=
+++++++---
> =C2=A02 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 9d65250..c766692 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -240,7 +240,7 @@ save_stash () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test "$untrack=
ed" =3D "all" && CLEAN_X_OPTION=3D-x || CLEAN_X_OPTION=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -n "$u=
ntracked"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 git clean --force --quiet $CLEAN_X_OPTION
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 git clean --force --quiet -d $CLEAN_X_OPTION
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test "$keep=
_index" =3D "t" && test -n $i_tree
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-inclu=
de-untracked.sh
> index ca1a46c..ef44fb2 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -17,6 +17,8 @@ test_expect_success 'stash save --include-untracked=
 some dirty working directory
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 3 > file &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_tick &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 1 > file2 &&
> + =C2=A0 =C2=A0 =C2=A0 mkdir untracked &&
> + =C2=A0 =C2=A0 =C2=A0 echo untracked >untracked/untracked &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stash --include-untracked &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff-files --quiet &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff-index --cached --quiet HEAD
> @@ -40,14 +42,23 @@ index 0000000..d00491f
> =C2=A0+++ b/file2
> =C2=A0@@ -0,0 +1 @@
> =C2=A0+1
> +diff --git a/untracked/untracked b/untracked/untracked
> +new file mode 100644
> +index 0000000..5a72eb2
> +--- /dev/null
> ++++ b/untracked/untracked
> +@@ -0,0 +1 @@
> ++untracked
> =C2=A0EOF
> =C2=A0cat > expect.lstree <<EOF
> =C2=A0file2
> +untracked
> =C2=A0EOF
>
> =C2=A0test_expect_success 'stash save --include-untracked stashed the=
 untracked files' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "!" -f file2 &&
> - =C2=A0 =C2=A0 =C2=A0 git diff HEAD..stash^3 -- file2 >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test ! -e untracked &&
> + =C2=A0 =C2=A0 =C2=A0 git diff HEAD stash^3 -- file2 untracked >actu=
al &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expect.diff actual &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git ls-tree --name-only stash^3: >actual &=
&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expect.lstree actual
> @@ -67,15 +78,18 @@ cat > expect <<EOF
> =C2=A0?? actual
> =C2=A0?? expect
> =C2=A0?? file2
> +?? untracked/
> =C2=A0EOF
>
> =C2=A0test_expect_success 'stash pop after save --include-untracked l=
eaves files untracked again' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stash pop &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git status --porcelain >actual &&
> - =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual &&
> + =C2=A0 =C2=A0 =C2=A0 test "1" =3D "`cat file2`" &&
> + =C2=A0 =C2=A0 =C2=A0 test untracked =3D "`cat untracked/untracked`"
> =C2=A0'
>
> -git clean --force --quiet
> +git clean --force --quiet -d
>
> =C2=A0test_expect_success 'stash save -u dirty index' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 4 > file3 &&
> @@ -125,12 +139,16 @@ test_expect_success 'stash save --include-untra=
cked removed files got stashed' '
> =C2=A0cat > .gitignore <<EOF
> =C2=A0.gitignore
> =C2=A0ignored
> +ignored.d/
> =C2=A0EOF
>
> =C2=A0test_expect_success 'stash save --include-untracked respects .g=
itignore' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo ignored > ignored &&
> + =C2=A0 =C2=A0 =C2=A0 mkdir ignored.d &&
> + =C2=A0 =C2=A0 =C2=A0 echo ignored >ignored.d/untracked &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stash -u &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -s ignored &&
> + =C2=A0 =C2=A0 =C2=A0 test -s ignored.d/untracked &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -s .gitignore
> =C2=A0'
>
> @@ -143,12 +161,14 @@ test_expect_success 'stash save -u can stash wi=
th only untracked files different
> =C2=A0test_expect_success 'stash save --all does not respect .gitigno=
re' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stash -a &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "!" -f ignored &&
> + =C2=A0 =C2=A0 =C2=A0 test "!" -e ignored.d &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "!" -f .gitignore
> =C2=A0'
>
> =C2=A0test_expect_success 'stash save --all is stash poppable' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stash pop &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -s ignored &&
> + =C2=A0 =C2=A0 =C2=A0 test -s ignored.d/untracked &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -s .gitignore
> =C2=A0'
>
> --
> 1.7.6

Thanks Brandon! Especially for making me famous. ;-)
