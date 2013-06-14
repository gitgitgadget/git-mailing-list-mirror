From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 4/5] stash: introduce 'git stash store'
Date: Fri, 14 Jun 2013 08:39:12 -0400
Message-ID: <CABURp0rsP-Z7uT46WtSpVV7j4OGdcApcpDswsHt79V9WYbfCoQ@mail.gmail.com>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com> <1371205924-8982-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 14:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTIA-0001uK-Ms
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 14:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab3FNMje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 08:39:34 -0400
Received: from mail-vb0-f43.google.com ([209.85.212.43]:45679 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab3FNMjd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 08:39:33 -0400
Received: by mail-vb0-f43.google.com with SMTP id e12so382637vbg.16
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6mtIIerb+czd/1a+VGHl11mRlRpTnoV3oxXj95GW5Rc=;
        b=wVsGrtb0G8FAMVlh7mcQypZN+oybCsTqi+X/t9KZe6HuL+PFikQMHIsdENXeXceZ56
         /FXl32p5Rkvofd1Z3mnHCHvGaW4ie3kqnmQcAajW90tki4m0r0DzU8+RnvQdiN1iDk8F
         V4/J5AsgcQnz5IxWK//D7ZptTg+PvnGX+2sMjMmA54oFdiRMCsJ7bM/dmX2OvV4BosMT
         7doj/H6KD5ihiGki4UgL28B5YjdpglG0Vls+PjT8xYaI9g3BwRVEf6syG2p1VeyaoSnO
         3wmICualwe3edDQLjicsnJVpcWoUjXgnH4vjWm6DU/7CPH8wn3a8i3asmSZE2/3ynbWF
         CAEQ==
X-Received: by 10.52.29.142 with SMTP id k14mr720082vdh.124.1371213572626;
 Fri, 14 Jun 2013 05:39:32 -0700 (PDT)
Received: by 10.58.243.34 with HTTP; Fri, 14 Jun 2013 05:39:12 -0700 (PDT)
In-Reply-To: <1371205924-8982-5-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227817>

On Fri, Jun 14, 2013 at 6:32 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> save_stash() contains the logic for doing two potentially independent
> operations; the first is preparing the stash merge commit, and the
> second is updating the stash ref/ reflog accordingly.  While the first
> operation is abstracted out into a create_stash() for callers to access
> via 'git stash create', the second one is not.  Fix this by factoring
> out the logic for storing the stash into a store_stash() that callers
> can access via 'git stash store'.
>
> Like create, store is not intended for end user interactive use, but for
> callers in other scripts.  We can simplify the logic in the
> rebase.autostash feature using this new subcommand.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-stash.txt |  7 +++++++
>  git-stash.sh                | 48 +++++++++++++++++++++++++++++++++++++++------
>  t/t3903-stash.sh            | 19 ++++++++++++++++++
>  3 files changed, 68 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 08cdf2f..ec3a9a3 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -17,6 +17,7 @@ SYNOPSIS
>              [-u|--include-untracked] [-a|--all] [<message>]]
>  'git stash' clear
>  'git stash' create [<message>]
> +'git stash' store [-m|--message <message>] [-e|--error <message>] <commit>
>
>  DESCRIPTION
>  -----------
> @@ -153,6 +154,12 @@ create::
>         object name, without storing it anywhere in the ref namespace.
>         This is probably not what you want to use; see "save" above.
>
> +store::
> +
> +       Store a given stash created via 'git stash create' (which is a
> +       dangling merge commit) in the stash ref, updating the stash
> +       reflog.  This is probably not what you want to use; see
> +       "save" above.

Here, again, I think you should explain more about this command.  Your
commit message explained it pretty well.

  + Like create, store is intended to be useful for scripts.

>
>  DISCUSSION
>  ----------
> diff --git a/git-stash.sh b/git-stash.sh
> index 64800b8..7985473 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -156,6 +156,43 @@ create_stash () {
>         die "$(gettext "Cannot record working tree state")"
>  }
>
> +store_stash () {
> +       while test $# != 0
> +       do
> +               case "$1" in
> +               -m|--message)
> +                       shift
> +                       stash_msg="$1"
> +                       ;;
> +               -e|--error)
> +                       shift
> +                       error_msg="$1"
> +                       ;;
> +               *)
> +                       break
> +                       ;;
> +               esac
> +               shift
> +       done
> +       test $# == 1 ||
> +       die "$(eval_gettext "\"$dashless store\" requires one <commit> argument")"
> +
> +       w_commit="$1"
> +       if test -z "$stash_msg"
> +       then
> +               stash_msg="Created via \"git stash store\"."
> +       fi
> +       if test -z "$error_msg"
> +       then
> +               error_msg="Cannot update $ref_stash with $w_commit."
> +       fi
> +
> +       # Make sure the reflog for stash is kept.
> +       : >>"$GIT_DIR/logs/$ref_stash"
> +       git update-ref -m "$stash_msg" $ref_stash $w_commit ||
> +       die "$(eval_gettext "$error_msg")"
> +}
> +
>  save_stash () {
>         keep_index=
>         patch_mode=
> @@ -227,12 +264,7 @@ save_stash () {
>                 clear_stash || die "$(gettext "Cannot initialize stash")"
>
>         create_stash "$stash_msg" $untracked
> -
> -       # Make sure the reflog for stash is kept.
> -       : >>"$GIT_DIR/logs/$ref_stash"
> -
> -       git update-ref -m "$stash_msg" $ref_stash $w_commit ||
> -               die "$(gettext "Cannot save the current status")"
> +       store_stash -m "$stash_msg" -e "Cannot save the current status." $w_commit

nit: this adds a period to the end of the message which it did not
have previously.

>         say Saved working directory and index state "$stash_msg"
>
>         if test -z "$patch_mode"
> @@ -549,6 +581,10 @@ create)
>         shift
>         create_stash "$*" && echo "$w_commit"
>         ;;
> +store)
> +       shift
> +       store_stash "$@"
> +       ;;
>  drop)
>         shift
>         drop_stash "$@"
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 5dfbda7..75189ec 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -637,4 +637,23 @@ test_expect_success 'stash where working directory contains "HEAD" file' '
>         test_cmp output expect
>  '
>
> +test_expect_success 'store called with invalid commit' '
> +       test_must_fail git stash store foo
> +'
> +
> +test_expect_success 'store updates stash ref and reflog' '
> +       git stash clear &&
> +       git reset --hard &&
> +       echo quux >bazzy &&
> +       git add bazzy &&
> +       STASH_ID=$(git stash create) &&
> +       git reset --hard &&
> +       ! grep quux bazzy &&
> +       git stash store -m quuxery $STASH_ID &&
> +       test $(cat .git/refs/stash) = $STASH_ID &&
> +       grep $STASH_ID .git/logs/refs/stash &&
> +       git stash pop &&
> +       grep quux bazzy
> +'
> +
>  test_done
> --
> 1.8.3.1.383.g0d5ad6b

Looks clean to me, but I didn't test it.

Phil
