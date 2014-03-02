From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Sun, 2 Mar 2014 04:04:47 -0500
Message-ID: <CAPig+cQ7pd4mQTTsT2Kq3KL-erUdncBsYmFjt8aFWB5THE6Srw@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 10:05:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK2Ki-0000an-6x
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 10:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbaCBJFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 04:05:04 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:60015 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbaCBJEs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 04:04:48 -0500
Received: by mail-yh0-f48.google.com with SMTP id z6so2503862yhz.21
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 01:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=oFn2Z0/XQb0p9A69Z6EHyGYvI5qkNkN9QF6uLJ0u33k=;
        b=sQSO2gBnSOUnbpzYhCm9DBINxp9zip/dcagXUE19szpdH2eAqE0DZ5b4UOTWhKODmu
         R+egrwaFoS/xI/LhsVGFLUdWqkW4WnLENmw/xytK45XvuCH2DatC1KChRvUwwJNJtZOU
         SToSilX9dRKXPGilORHNT/9KyZU5jAnfGuX3gH7Vf2zan35FDkeiftNZbX6x+mFJVSlm
         DR5gpEdLYGgnrM3Xumr/ofSKDaClBOHVjNDarTnorUK/WqikwWLQLqGPCPhk0oXmdE6+
         XF81YDoe1KN3Wj+VriIQ33ZOWv5QAib3uFPDtzEW8YGm71HQB/f4djhnidzUvTQ2SdZC
         EtHQ==
X-Received: by 10.236.210.18 with SMTP id t18mr563962yho.67.1393751087901;
 Sun, 02 Mar 2014 01:04:47 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 01:04:47 -0800 (PST)
In-Reply-To: <1393728794-29566-4-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 0NEBd78aAmIRwt3fAQMz1dRXpf0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243144>

On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> "git rebase -e XYZ" is basically the same as
>
> EDITOR=3D"sed -i '1s/pick XYZ/edit XYZ/' $@" \
> git rebase -i XYZ^
>
> In English, it prepares the todo list for you to edit only commit XYZ
> to save your time. The time saving is only significant when you edit =
a
> lot of commits separately.

Should this accept multiple -e arguments? Based upon the above
justification, it sounds like it should, and I think that would be the
intuitive expectation (at least for me).

The current implementation, however, is broken with multiple -e argumen=
ts. With:

    git rebase -i -e older -e newer

'newer' is ignored entirely. However, with:

    git rebase -i -e newer -e older

it errors out when rewriting the todo list:

    "expected to find 'edit older' line but did not"

An implementation supporting multiple -e arguments would need to
ensure that the todo list extends to the "oldest" rev specified by any
-e argument.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-rebase.txt |  4 ++++
>  git-rebase--interactive.sh   | 17 ++++++++++++++---
>  git-rebase.sh                | 10 ++++++++++
>  3 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index 52c3561..b8c263d 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -359,6 +359,10 @@ unless the `--fork-point` option is specified.
>         user edit that list before rebasing.  This mode can also be u=
sed to
>         split commits (see SPLITTING COMMITS below).
>
> +-e::
> +--edit-one::
> +       Prepare the todo list to edit only the commit at <upstream>
> +
>  -p::
>  --preserve-merges::
>         Instead of ignoring merges, try to recreate them.
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index a1adae8..4762d57 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1040,9 +1040,20 @@ fi
>  has_action "$todo" ||
>         die_abort "Nothing to do"
>
> -cp "$todo" "$todo".backup
> -git_sequence_editor "$todo" ||
> -       die_abort "Could not execute editor"
> +if test -n "$edit_one"
> +then
> +       edit_one=3D"`git rev-parse --short $edit_one`"
> +       sed "1s/pick $edit_one /edit $edit_one /" "$todo" > "$todo.ne=
w" ||
> +               die_abort "failed to update todo list"
> +       grep "^edit $edit_one " "$todo.new" >/dev/null ||
> +               die_abort "expected to find 'edit $edit_one' line but=
 did not"
> +       mv "$todo.new" "$todo" ||
> +               die_abort "failed to update todo list"
> +else
> +       cp "$todo" "$todo".backup
> +       git_sequence_editor "$todo" ||
> +               die_abort "Could not execute editor"
> +fi
>
>  has_action "$todo" ||
>         die_abort "Nothing to do"
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 33face1..b8b6aa9 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -32,6 +32,7 @@ verify             allow pre-rebase hook to run
>  rerere-autoupdate  allow rerere to update index with resolved confli=
cts
>  root!              rebase all reachable commits up to the root(s)
>  autosquash         move commits that begin with squash!/fixup! under=
 -i
> +e,edit-one!        generate todo list to edit this commit
>  committer-date-is-author-date! passed to 'git am'
>  ignore-date!       passed to 'git am'
>  whitespace=3D!       passed to 'git apply'
> @@ -339,6 +340,10 @@ do
>         -NUM=3D*)
>                 NUM=3D"${1#-NUM=3D}"
>                 ;;
> +       --edit-one)
> +               interactive_rebase=3Dexplicit
> +               edit_one=3Dt
> +               ;;
>         --)
>                 shift
>                 break
> @@ -463,6 +468,11 @@ then
>                 ;;
>         *)      upstream_name=3D"$1"
>                 shift
> +               if test -n "$edit_one"
> +               then
> +                       edit_one=3D"$upstream_name"
> +                       upstream_name=3D"$upstream_name^"
> +               fi
>                 ;;
>         esac
>         upstream=3D$(peel_committish "${upstream_name}") ||
> --
> 1.9.0.40.gaa8c3ea
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
