From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Tue, 23 Apr 2013 18:45:52 -0400
Message-ID: <CABURp0onypkDFiovYP4s0UuBV+oFp3rPv1Jq8dGbxZhKU_sgsQ@mail.gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com> <1366725724-1016-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 00:46:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUlyd-0002Xi-6x
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 00:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737Ab3DWWqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 18:46:14 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:39502 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab3DWWqN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 18:46:13 -0400
Received: by mail-vc0-f175.google.com with SMTP id lf10so1188735vcb.6
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 15:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aGXYBoPeYWy8YLWA1ImxGeM4wnXFqZbCuO4YmejQvR8=;
        b=YAxcrqIjN0Tdah37SZAC4ycQPn4ncVrKDopTRgNng3Y8hF47UvTXufOlLmH5NzPyHn
         JM9ycyJX3DvkZcOZdBN541X6RD65a6ag3BvJhXXsEXyvArCoFZoAcUzxZCFDKuPZnpLh
         l5ib5/S3a2b5AIfXcllpH1w9KtkVRyzdggWcAtPsZ8LcfCQT3NuKNnHtn/2DoscaW14k
         aDdwHqOyuijbj7ex7EGie3HHispBOMCDdlXKFBYF5cuhwjM/0a8VePczUg35543bk99T
         FAMJ/PcHVyApS13Wxl3qCrndFqujmMJoOPHtirhL488KPSanEFkEm9hN7Y4UhiM+eIHy
         Enkg==
X-Received: by 10.52.76.6 with SMTP id g6mr20377103vdw.13.1366757172901; Tue,
 23 Apr 2013 15:46:12 -0700 (PDT)
Received: by 10.58.219.34 with HTTP; Tue, 23 Apr 2013 15:45:52 -0700 (PDT)
In-Reply-To: <1366725724-1016-8-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222214>

On Tue, Apr 23, 2013 at 10:02 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> This new feature allows a rebase to be executed on a dirty worktree.
> It works by creating a temporary stash and storing it in
> $state_dir/autostash before the operation, and applying it after a
> successful operation.  It will be removed along with the $state_dir if
> the operation is aborted.
>
> The feature creates a special stash that does not affect the normal
> stash's reflogs, and will therefore be invisible to the end user.
> This special stash is essentially a dangling merge commit which has
> reasonable lifetime specified by gc.pruneexpire (default 2 weeks).
>
> Most significantly, this feature means that a caller like pull (with
> pull.rebase set to true) can easily be patched to remove the
> require_clean_work_tree restriction.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/config.txt     |  8 ++++++++
>  Documentation/git-rebase.txt | 10 ++++++++++
>  git-rebase.sh                | 38 +++++++++++++++++++++++++++++++++++---
>  3 files changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c67038b..03ad701 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1867,6 +1867,14 @@ rebase.stat::
>  rebase.autosquash::
>         If set to true enable '--autosquash' option by default.
>
> +rebase.autostash::
> +       When set to true, automatically create a temporary stash
> +       before the operation begins, and apply it after the operation
> +       ends.  This means that you can run rebase on a dirty worktree.
> +       However, use with care: the final stash application after a
> +       successful rebase might result in non-trivial conflicts.
> +       Defaults to false.
> +
>  receive.autogc::
>         By default, git-receive-pack will run "git-gc --auto" after
>         receiving data from git-push and updating refs.  You can stop
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index aca8405..c84854a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -208,6 +208,9 @@ rebase.stat::
>  rebase.autosquash::
>         If set to true enable '--autosquash' option by default.
>
> +rebase.autostash::
> +       If set to true enable '--autostash' option by default.
> +
>  OPTIONS
>  -------
>  --onto <newbase>::
> @@ -394,6 +397,13 @@ If the '--autosquash' option is enabled by default using the
>  configuration variable `rebase.autosquash`, this option can be
>  used to override and disable this setting.
>
> +--[no-]autostash::
> +       Automatically create a temporary stash before the operation
> +       begins, and apply it after the operation ends.  This means
> +       that you can run rebase on a dirty worktree.  However, use
> +       with care: the final stash application after a successful
> +       rebase might result in non-trivial conflicts.
> +
>  --no-ff::
>         With --interactive, cherry-pick all rebased commits instead of
>         fast-forwarding over the unchanged ones.  This ensures that the
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 8412d81..c8fddfe 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -13,6 +13,7 @@ git-rebase --continue | --abort | --skip | --edit-todo
>   Available options are
>  v,verbose!         display a diffstat of what changed upstream
>  q,quiet!           be quiet. implies --no-stat
> +autostash!         automatically stash/stash pop before and after
>  onto=!             rebase onto given branch instead of upstream
>  p,preserve-merges! try to recreate merges instead of ignoring them
>  s,strategy=!       use the given merge strategy
> @@ -64,6 +65,7 @@ apply_dir="$GIT_DIR"/rebase-apply
>  verbose=
>  diffstat=
>  test "$(git config --bool rebase.stat)" = true && diffstat=t
> +autostash="$(git config --bool rebase.autostash || echo false)"
>  git_am_opt=
>  rebase_root=
>  force_rebase=
> @@ -143,6 +145,24 @@ move_to_original_branch () {
>         esac
>  }
>
> +apply_autostash () {
> +       if test -f "$state_dir/autostash"
> +       then
> +               stash_sha1=$(cat "$state_dir/autostash")
> +               git stash apply $stash_sha1 2>&1 >/dev/null ||
> +               die "
> +$(eval_gettext 'Applying autostash resulted in conflicts.
> +Either fix the conflicts now, or run
> +       git reset --hard
> +and apply the stash on your desired branch:
> +       git stash apply $stash_sha1
> +at any time.')" &&
> +               echo "Applied autostash"
> +       fi
> +       git gc --auto &&
> +       rm -rf "$state_dir"
> +}

Because I am in a git-rebase which has apparently failed, I would
expect 'git rebase --abort' would save me here.  But it does not and
you have given me some unique instructions to try to recover.  I
suppose rebase--abort cannot be made to recover in this case because
this is a rebase-wrapper and all of my rebase-state is already
discarded.  But I would much prefer to have the normal "undo"-ability
of git-rebase here, once I realize I have made a mistake or
encountered conflicts I am not prepared to handle right now.


> +
>  run_specific_rebase () {
>         if [ "$interactive_rebase" = implied ]; then
>                 GIT_EDITOR=:
> @@ -153,8 +173,7 @@ run_specific_rebase () {
>         ret=$?
>         if test $ret = 0
>         then
> -               git gc --auto &&
> -               rm -rf "$state_dir"
> +               apply_autostash
>         fi
>         exit $ret
>  }
> @@ -248,6 +267,9 @@ do
>         --stat)
>                 diffstat=t
>                 ;;
> +       --autostash)
> +               autostash=true
> +               ;;
>         -v)
>                 verbose=t
>                 diffstat=t
> @@ -348,7 +370,7 @@ abort)
>                 ;;
>         esac
>         output git reset --hard $orig_head
> -       rm -r "$state_dir"
> +       apply_autostash
>         exit
>         ;;
>  edit-todo)
> @@ -487,6 +509,16 @@ case "$#" in
>         ;;
>  esac
>
> +if test "$autostash" = true && ! require_clean_work_tree --quiet
> +then
> +       stash_sha1=$(git stash create) || die "$(gettext "Cannot autostash")" &&
> +       mkdir -p "$state_dir" &&
> +       echo $stash_sha1 >"$state_dir/autostash" &&
> +       stash_abbrev=$(git rev-parse --short $stash_sha1) &&
> +       echo "$(gettext "Created autostash: $stash_abbrev")" &&
> +       git reset --hard
> +fi
> +
>  require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
>
>  # Now we are rebasing commits $upstream..$orig_head (or with --root,
> --
> 1.8.2.1.578.ga933817
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
