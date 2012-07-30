From: =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>
Subject: Re: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 14:50:02 -0300
Message-ID: <CAHCkQtPS4+eoV_765DhbiZH_4zy98PKNEZ2f1XGx5rdLatZK7w@mail.gmail.com>
References: <7v6295rxmb.fsf@alter.siamese.dyndns.org>
	<1343670212-2992-1-git-send-email-dangra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:50:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svu6d-0005j7-2b
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368Ab2G3RuE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 13:50:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40132 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab2G3RuC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 13:50:02 -0400
Received: by pbbrp8 with SMTP id rp8so10171171pbb.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OSi7NDZgfvLU7ySTDUJA4uuXDKSUdTSQxlf1fTyuiT8=;
        b=aRUjXBr0g3nG45jaUVyw+0Qx0ODDag+lXIhhQ+oiR6dB4PKSq5VEl9Md3ipi7FIKCE
         PU00G5w/us2L5P1vonEpG2GgiuFhaOGFN/7Jekfz4eRJHkBDP1AsE2qEN6hUBfJVoJnZ
         UiMGnamkW0dqufd/GEcaSUKdqYsbLL5b2sSWAViJVSCnL2YjcJD+ZJ5bSweT5+cIBd2x
         e9xe99Dbl9uCr4bAwIGf5082YzW1q3dZQ/QYJE7ldY9c+UPmy3G3tdZ8vKQHZ6eunBwj
         vcHsR5aVNPoaYAgq7XtVJRPzJWpz5kNHNodkESDxIhgmfxQEy1JUOY2FsFVpkwLiyqCv
         /hAg==
Received: by 10.68.226.73 with SMTP id rq9mr36496646pbc.145.1343670602112;
 Mon, 30 Jul 2012 10:50:02 -0700 (PDT)
Received: by 10.68.62.226 with HTTP; Mon, 30 Jul 2012 10:50:02 -0700 (PDT)
In-Reply-To: <1343670212-2992-1-git-send-email-dangra@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202594>

On Mon, Jul 30, 2012 at 2:43 PM, Daniel Gra=C3=B1a <dangra@gmail.com> w=
rote:
> * Check submodule is correctly initialized and updated after cloning =
=2Edotfiles
>
> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
> ---

Ignore this patch, I am sending another without extra space after
standard output redirection.



>
> Remove $TRASH_DIRECTORY and "git rev-parse --verify HEAD" as suggeste=
d by Junio
>
>  t/t7409-submodule-detached-worktree.sh |   31 ++++++++++++++++++++++=
++-------
>  1 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submodu=
le-detached-worktree.sh
> index db75642..1d5a4c5 100755
> --- a/t/t7409-submodule-detached-worktree.sh
> +++ b/t/t7409-submodule-detached-worktree.sh
> @@ -15,7 +15,11 @@ TEST_NO_CREATE_REPO=3D1
>  test_expect_success 'submodule on detached working tree' '
>         git init --bare remote &&
>         test_create_repo bundle1 &&
> -       (cd bundle1 && test_commit "shoot") &&
> +       (
> +               cd bundle1 &&
> +               test_commit "shoot" &&
> +               git rev-parse --verify HEAD > ../expect
> +       ) &&
>         mkdir home &&
>         (
>                 cd home &&
> @@ -23,14 +27,27 @@ test_expect_success 'submodule on detached workin=
g tree' '
>                 git clone --bare ../remote .dotfiles &&
>                 git submodule add ../bundle1 .vim/bundle/sogood &&
>                 test_commit "sogood" &&
> +               (
> +                       unset GIT_WORK_TREE GIT_DIR &&
> +                       cd .vim/bundle/sogood &&
> +                       git rev-parse --verify HEAD > actual &&
> +                       test_cmp ../../../../expect actual
> +               ) &&
>                 git push origin master
> -       ) &&
> +       )
>         mkdir home2 &&
>         (
>                 cd home2 &&
> -               export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.do=
tfiles" &&
>                 git clone --bare ../remote .dotfiles &&
> -               git submodule update --init
> +               export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.do=
tfiles" &&
> +               git checkout master &&
> +               git submodule update --init &&
> +               (
> +                       unset GIT_WORK_TREE GIT_DIR &&
> +                       cd .vim/bundle/sogood &&
> +                       git rev-parse --verify HEAD > actual &&
> +                       test_cmp ../../../../expect actual
> +               )
>         )
>  '
>
> @@ -42,6 +59,7 @@ test_expect_success 'submodule on detached working =
pointed by core.worktree' '
>                 git clone --bare ../remote "$GIT_DIR" &&
>                 git config core.bare false &&
>                 git config core.worktree .. &&
> +               git checkout master &&
>                 git submodule add ../bundle1 .vim/bundle/dupe &&
>                 test_commit "dupe" &&
>                 git push origin master
> @@ -52,9 +70,8 @@ test_expect_success 'submodule on detached working =
pointed by core.worktree' '
>                 git config core.bare false &&
>                 git config core.worktree .. &&
>                 git pull &&
> -               git submodule update &&
> -               git submodule status &&
> -               test -d .vim/bundle/dupe
> +               git submodule update --init &&
> +               test -e .vim/bundle/dupe/shoot.t
>         )
>  '
>
> --
> 1.7.5.4
>
