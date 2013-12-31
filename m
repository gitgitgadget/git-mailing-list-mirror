From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH/RFC] Introduce git submodule add|update --attach
Date: Tue, 31 Dec 2013 15:05:54 -0500
Message-ID: <CABURp0pQHw7qvG_tq8oK=6DBOUoYy=Rb5othV+zBpNonuv=PLw@mail.gmail.com>
References: <1388368184-18418-1-git-send-email-ceztko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 31 21:06:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vy5aI-0006Ws-Nk
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 21:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527Ab3LaUGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 15:06:18 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:59834 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187Ab3LaUGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Dec 2013 15:06:16 -0500
Received: by mail-wg0-f41.google.com with SMTP id y10so15131508wgg.4
        for <git@vger.kernel.org>; Tue, 31 Dec 2013 12:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4ciR7B+w33kuVib01TN1ICFrasnEA0YvzApTUpOCL7g=;
        b=VZkOSOuwfYMi/9alOEsnES23ZZMN8YSDM8SFKs9j4PpN/dc0TXChneX5847kjDZ16Y
         MTZliulOgXhC90S9B+PRmWsmm8E/xnIR0F6xY93H+6/YU+7U9T0ud/cZPJ39UVxAUFha
         LfZ/vO3bEJAuK8k0EVkKeaTzg17E+lzCf0kRrDK9McWGAh6Lm39RV+7jpA2Hsg2Dqlp3
         pxLyAET6HN2DKkojRmFZpOgXkUK5xqBOf04oGMa3eFopEEF3fDwbIoaFt6DgemIYXVwy
         ERJRAP0uFZQSj0OZJsUnXIGpx25Lu+NYWQ598AP90imkZ46PCiE38wqbUGdV5R0qIv0a
         ZZVw==
X-Received: by 10.180.89.134 with SMTP id bo6mr29229295wib.1.1388520374763;
 Tue, 31 Dec 2013 12:06:14 -0800 (PST)
Received: by 10.227.202.130 with HTTP; Tue, 31 Dec 2013 12:05:54 -0800 (PST)
In-Reply-To: <1388368184-18418-1-git-send-email-ceztko@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239843>

On Sun, Dec 29, 2013 at 8:49 PM, Francesco Pretto <ceztko@gmail.com> wrote:
>
> by default "git submodule" performs its add or update operations on a detached
> HEAD. This works well when using an existing full-fledged/indipendent project as
> the submodule, as there's less frequent need to update it or commit back
> changes. When the submodule is actually a large portion of shareable code
> between  different projects, and the superproject needs to track very closely
> the evolution of the submodule (or the other way around), I feel more confortable
> to reattach the HEAD of the submodule with an existing branch. This can be as
> simple as having a superproject "project1" in branch "master" with a submodule
> "common" attached to the branch "master-project1" or, in a more development
> workflow, "project1" in branch "featureA" with the same submodule "common"
> attached to a similarly named branch "featureA". Doing this in git requires me
> the following:
>
> # Maintainer
> $ git submodule add --branch "master-project1" <repository> common
> $ git commit -m "Added submodule"
> $ git config -f .gitmodules submodule.common.ignore all
> $ git push
> $ cd <path>
> $ git checkout "master-project1"
>
> # Developer
> $ git pull
> $ git submodule init
> $ git submodule update --remote
> $ cd <path>
> $ branch="$(git config -f ..\.gitmodules submodule.common.branch)"; git checkout $branch
>
> While the burden for the repository maitainer/administrator is acceptable, in
> the developer point of view there are two problems:
> 1) Checking out an attached HEAD of a specified branch as when using "--remote"
> is not really simple as it could be and could require lauching of scrips or
> reading some repository specific documentation. Also in Windows platform the
> syntax for inline shell evaluation of commands is less known between users;
> 2) There's no way to store a similar default behaviour in the repository except
> by using scripts. Also recently submodule.<modulename>.update custom !commands
> in no more supported when stored in .gitmodules [1].
>
> The attached patch tries to solve these problems by introducing an "--attach"
> switch to the "add" and "update" submodule commands and a "--detach" switch just
> for the "update" command. It also add the support for an 'submodule.<name>.attach'
> property when updating. Using the "--attach" switch when adding a submodule does:
> - create the submodule checking out an attached HEAD;
> - set the 'submodule.<name>.attach' property to 'true';
> - set the 'submodule.<name>.ignore' property to 'all' (this is useful as
> attaching to the branch doesn't require tracking of revision sha1).
>
> The rationale of setting 'attach' and 'ignore' properties when adding a
> submodule with the "--attach" switch is to give a convenient default behaviour.
> No other properties are set: the repository responsible will still be required
> to configure a different 'submodule.<name>.update' behaviour separetely, if he
> wants that.
>
> When updating, using the '--attach' switch or operating in a repository with
> 'submodule.<name>.attach' set to 'true' will:
> - checkout a branch with an attached HEAD if the repository was just cloned;
> - perform a fast-forward only merge of changes if it's a 'checkout' update,
> keeping the HEAD attached;
> - reattach the HEAD prior performing a 'merge', 'rebase' or '!command' update
> operation if the HEAD was found detached.

I need to understand this "reattach the HEAD" case better. Can you
give some examples of the expected behavior when merge, rebase or
!command is encountered?


> '--attach' or 'submodule.<name>.attach' set to true also implies '--remote', as
> it's needed the origin HEAD sha1 to verify the current HEAD state.
>
> A '--detach' switch is also available. Using the '--detach' switch or
> operating in a repository with 'submodule.<name>.attach' set to 'false' during
> update will:
> - checkout a detached HEAD if the repository was just cloned (same behaviour as
> before);
> - detach the HEAD prior performing a 'merge', 'rebase' or '!command' update
> operation if the HEAD was found attached.
>
> 'submodule.<name>.attach' works the same way as 'submodule.<name>.update'
> property: git copies the values found in ".gitmodules" in ".git/config" when
> performing an "init" command. "update" looks for the values in ".git/config"
> only.
>
> '--attach' and '--detach' switches override an opposite behaviour of 'submodule.<name>.attach'
> properties.
>
> The patch is small (touches only git-submodule.sh) and 100% additive with
> respect to currently documented behaviour: when using "add" and "update"
> commands without the introduced switches and properties, git shall operate as
> before. As a bonus (but this was done to ease conditionals and keep the code
> clean) it also clarifies and validates the content of 'submodule.<name>.update'
> during 'update' command, warning the user if it's not one of the supported
> values 'checkout', 'merge', 'rebase' and 'none'. Please note that 'checkout'
> update command was documented in upstream "Documentation/gitmodules.txt" [2] as
> a valid 'submodule.<name>.update' value and code in upstream "git-submodule.sh"
> implicitly assumes it as recognized value. "Documentation/git-submodule.txt"
> doesn't mention it properly and I guess this is the reason why it wasn't
> considered for the validation in [1] patch.
>
> Using this patch, the previous workflow becomes:
>
> # Maintainer
> $ git submodule add --branch "master-project1" --attach <repository> <path>
> $ git commit -m "Added submodule"
> $ git push
>
> # Developer
> $ git pull
> $ git submodule init
> $ git submodule update
>
> Is there interest in supporting this workflow and seeing this patch applied?
>
> Thanks,
> Francesco
>
> [1] http://marc.info/?l=git&m=138610752125816&w=2
> [2] Documentation/gitmodules.txt: "If 'checkout' (the default)..."
>
> Signed-off-by: Francesco Pretto <ceztko@gmail.com>
> ---
>  Documentation/git-submodule.txt |  37 ++++++---
>  Documentation/gitmodules.txt    |  11 ++-
>  git-submodule.sh                | 172 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 197 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index bfef8a0..452376d 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -10,13 +10,14 @@ SYNOPSIS
>  --------
>  [verse]
>  'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
> -             [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
> +             [--reference <repository>] [--attach] [--depth <depth>]
> +             [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
> -             [-f|--force] [--rebase] [--reference <repository>] [--depth <depth>]
> -             [--merge] [--recursive] [--] [<path>...]
> +             [-f|--force] [--rebase] [--reference <repository>] [--attach | --detach]
> +             [--depth <depth>] [--merge] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
>               [commit] [--] [<path>...]
>  'git submodule' [--quiet] foreach [--recursive] <command>
> @@ -107,6 +108,10 @@ is the superproject and submodule repositories will be kept
>  together in the same relative location, and only the
>  superproject's URL needs to be provided: git-submodule will correctly
>  locate the submodule using the relative URL in .gitmodules.
> ++
> +If `--attach` is specified, the submodule will be registered to be
> +checked out with an an attached HEAD. Also `submodule.<name>.attach` will
> +be set to `true` and `submodule.<name>.ignore` will be set to `all`.
>
>  status::
>         Show the status of the submodules. This will print the SHA-1 of the
> @@ -156,12 +161,15 @@ it contains local modifications.
>  update::
>         Update the registered submodules, i.e. clone missing submodules and
>         checkout the commit specified in the index of the containing repository.
> -       This will make the submodules HEAD be detached unless `--rebase` or
> -       `--merge` is specified or the key `submodule.$name.update` is set to
> -       `rebase`, `merge` or `none`. `none` can be overridden by specifying
> -       `--checkout`. Setting the key `submodule.$name.update` to `!command`
> -       will cause `command` to be run. `command` can be any arbitrary shell
> -       command that takes a single argument, namely the sha1 to update to.
> +       This will make the submodules HEAD be detached unless `--attach` is
> +       specified or `submodule.$name.attach` is set to `true`. The last setting
> +       can always be overridden specifying `--detach`. Update mode can be
> +       selected specifying `--checkout`, `--rebase` or `--merge` switches
> +       or setting the key `submodule.$name.update` to `checkout`, `rebase`,
> +       `merge` or `none`. `none` will cause the submodule to be skipped during
> +       the update. Setting the key `submodule.$name.update` to `!command` will
> +       cause `command` to be run. `command` can be any arbitrary shell command
> +       that takes a single argument, namely the sha1 to update to.
>  +
>  If the submodule is not yet initialized, and you just want to use the
>  setting as stored in .gitmodules, you can automatically initialize the
> @@ -270,6 +278,17 @@ OPTIONS
>         be overridden by setting the `submodule.<name>.branch` option in
>         either `.gitmodules` or `.git/config` (with `.git/config` taking
>         precedence).
> +
> +--attach::
> +       This option is only valid for the add and update commands. Cause the

Grammar: 'Causes the result'

> +       result of an add or update operation to be an attached HEAD. In the
> +       update command , if `submodule.<name>.branch` is not set, it will

typo: space before comma.

Also, the pronoun "it" here is unclear to me.  Does this convey the
correct meaning?

   In the update operation, the branch named by 'submodule.<name>.branch' is
   checked out as the new HEAD of the submodule repository. If
   'submodule.<name>.branch' is not set, the 'master' branch is
checked out as the
   new HEAD of the submodule.

> +       default to `master`. Note: for the update command `--attach` also
> +       implies `--remote`.
> +
> +--detach::
> +       This option is only valid for the update command. Cause the result

 Grammar: 'Causes the result'

> +       of the update operation to be forcedly a detached HEAD.

"Forcedly" is a bit strong, maybe, slightly misplaced, and not a word,
besides.   How's this, instead:

   Forces the result of the update operation to be a detached HEAD in
the submodule.

>  +
>  This works for any of the supported update procedures (`--checkout`,
>  `--rebase`, etc.).  The only change is the source of the target SHA-1.
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index f7be93f..e6c3360 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -37,8 +37,10 @@ submodule.<name>.url::
>
>  submodule.<name>.update::
>         Defines what to do when the submodule is updated by the superproject.
> -       If 'checkout' (the default), the new commit specified in the
> -       superproject will be checked out in the submodule on a detached HEAD.
> +       If 'checkout' (the default), the new commit (or the branch, when using
> +       the '--attach' switch or the 'submodule.<name>.attach' property is set
> +       to 'true' during an update operation) specified in the superproject will
> +       be checked out in the submodule.

IMHO, this wording is overcomplicated by this change.  How about:

       If 'checkout' (the default), the new commit specified in the superproject
       (or branch, with '--attach') will be checked out in the submodule.

>         If 'rebase', the current branch of the submodule will be rebased onto
>         the commit specified in the superproject. If 'merge', the commit
>         specified in the superproject will be merged into the current branch

Does the 'merge', 'rebase' and '!command' description need to be
updated, too?  Here and above it seems to still suggest the old
behavior is kept when --attach is used.


> @@ -54,6 +56,11 @@ submodule.<name>.branch::
>         If the option is not specified, it defaults to 'master'.  See the
>         `--remote` documentation in linkgit:git-submodule[1] for details.
>
> +submodule.<name>.attach::
> +       Determine if the update operation will produce a detached HEAD or not.
> +       Valid values are `true` or `false`. If the property is set to `true`
> +       and `submodule.<name>.branch`, it will default to `master`

I think you mean "...and 'submodule.<name>.branch' is not set, it
will...", right?

Some explanation of what happens when it _is_ set would be useful
here, too, I think.  But maybe I do not understand the nuances yet.

> +
>  submodule.<name>.fetchRecurseSubmodules::
>         This option can be used to control recursive fetching of this
>         submodule. If this option is also present in the submodules entry in
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2677f2e..3951fa2 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -5,11 +5,11 @@
>  # Copyright (c) 2007 Lars Hjemli
>
>  dashless=$(basename "$0" | sed -e 's/-/ /')
> -USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
> +USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--attach] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--attach | --detach] [--merge] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
>     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
> @@ -36,6 +36,7 @@ update=
>  prefix=
>  custom_name=
>  depth=
> +attach=
>
>  # The function takes at most 2 arguments. The first argument is the
>  # URL that navigates to the submodule origin repo. When relative, this URL
> @@ -352,6 +353,9 @@ cmd_add()
>                         custom_name=$2
>                         shift
>                         ;;
> +               --attach)
> +                       attach="true"
> +                       ;;
>                 --depth)
>                         case "$2" in '') usage ;; esac
>                         depth="--depth=$2"
> @@ -475,8 +479,17 @@ Use -f if you really want to add it." >&2
>                         cd "$sm_path" &&
>                         # ash fails to wordsplit ${branch:+-b "$branch"...}
>                         case "$branch" in
> -                       '') git checkout -f -q ;;
> -                       ?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> +                       '')
> +                               git checkout -f -q
> +                               ;;

Is this whitespace change intentional and necessary?

> +                       ?*)
> +                               if test -n "$attach"
> +                               then
> +                                       git checkout -f -q "$branch"
> +                               else
> +                                       git checkout -f -q -B "$branch" "origin/$branch"
> +                               fi
> +                               ;;
>                         esac
>                 ) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
>         fi
> @@ -491,6 +504,12 @@ Use -f if you really want to add it." >&2
>         then
>                 git config -f .gitmodules submodule."$sm_name".branch "$branch"
>         fi &&
> +       if test -n "$attach"
> +       then
> +               # We'll stay stick to the HEAD, no need to track revision sha1
> +               git config -f .gitmodules submodule."$sm_name".attach "true"
> +               git config -f .gitmodules submodule."$sm_name".ignore "all"
> +       fi &&
>         git add --force .gitmodules ||
>         die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
>  }
> @@ -622,7 +641,7 @@ cmd_init()
>                    test -z "$(git config submodule."$name".update)"
>                 then
>                         case "$upd" in
> -                       rebase | merge | none)
> +                       checkout | rebase | merge | none)

This belongs in a commit of its own.

>                                 ;; # known modes of updating
>                         *)
>                                 echo >&2 "warning: unknown update mode '$upd' suggested for submodule '$name'"
> @@ -632,6 +651,23 @@ cmd_init()
>                         git config submodule."$name".update "$upd" ||
>                         die "$(eval_gettext "Failed to register update mode for submodule path '\$displaypath'")"
>                 fi
> +
> +               # Copy "attach" setting when it is not set yet
> +               if attached="$(git config -f .gitmodules submodule."$name".attach)" &&
> +                  test -n "$attached" &&
> +                  test -z "$(git config submodule."$name".attach)"
> +               then
> +                       case "$attached" in
> +                       true | false)
> +                               ;; # Valid attach flag values
> +                       *)
> +                               echo >&2 "warning: invalid attach flag value for submodule '$name'"
> +                               upd=none
> +                               ;;
> +                       esac
> +                       git config submodule."$name".attach "$attached" ||
> +                       die "$(eval_gettext "Failed to register attached option for submodule path '\$displaypath'")"
> +               fi
>         done
>  }
>
> @@ -750,6 +786,14 @@ cmd_update()
>                 --reference=*)
>                         reference="$1"
>                         ;;
> +               --attach)
> +                       if test "$attach" = "false" ; then usage ; fi
> +                       attach="true"
> +                       ;;
> +               --detach)
> +                       if test "$attach" = "true" ; then usage ; fi
> +                       attach="false"
> +                       ;;
>                 -m|--merge)
>                         update="merge"
>                         ;;
> @@ -800,11 +844,44 @@ cmd_update()
>                 name=$(module_name "$sm_path") || exit
>                 url=$(git config submodule."$name".url)
>                 branch=$(get_submodule_config "$name" branch master)
> +               if test -n "$attach"
> +               then
> +                       attach_module=$attach
> +               else
> +                       attach_module=$(git config submodule."$name".attach)
> +                       case "$attach_module" in
> +                       '')
> +                               ;; # Unset attach flag
> +                       true|false)
> +                               ;; # Valid attach flag values
> +                       *)
> +                               echo >&2 "warning: invalid attach flag value for submodule '$name'"
> +                               attach_module=
> +                               ;;
> +                       esac
> +               fi
> +               if test "$attach_module" = "false"
> +               then
> +                       # Normalize attach 'false' flag value
> +                       attach_module=
> +               fi
>                 if ! test -z "$update"
>                 then
>                         update_module=$update
>                 else
>                         update_module=$(git config submodule."$name".update)
> +                       case "$update_module" in
> +                       '')
> +                               ;; # Unset update mode
> +                       checkout | rebase | merge | none)
> +                               ;; # Known update modes
> +                       !*)
> +                               ;; # Custom update command
> +                       *)
> +                               update_module=
> +                               echo >&2 "warning: invalid update mode for submodule '$name'"
> +                               ;;
> +                       esac

Probably belongs to the same "other" commit mentioned before.

>                 fi
>
>                 displaypath=$(relative_path "$prefix$sm_path")
> @@ -836,7 +913,7 @@ Maybe you want to use 'update --init'?")"
>                         die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
>                 fi
>
> -               if test -n "$remote"
> +               if test -n "$remote" -o -n "$attach_module"
>                 then
>                         if test -z "$nofetch"
>                         then
> @@ -850,7 +927,16 @@ Maybe you want to use 'update --init'?")"
>                         die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
>                 fi
>
> -               if test "$subsha1" != "$sha1" -o -n "$force"
> +               head_rev_ref=$(clear_local_git_env; cd "$sm_path" && git rev-parse --abbrev-ref HEAD) ||
> +               die "$(eval_gettext "Unable to determine revision ref in submodule path '\$sm_path'")"
> +               if test "$head_rev_ref" = "HEAD"
> +               then
> +                       # Determine if the HEAD is detached
> +                       head_detached="true"
> +               fi
> +
> +               if test "$subsha1" != "$sha1" || test -n "$attach_module" -a -n "$head_detached" ||
> +                       test -z "$attach_module" -a -z "$head_detached" || test -n "$force"
>                 then
>                         subforce=$force
>                         # If we don't already have a -f flag and the submodule has never been checked out
> @@ -870,40 +956,102 @@ Maybe you want to use 'update --init'?")"
>                         fi
>
>                         # Is this something we just cloned?
> +                       just_cloned=
>                         case ";$cloned_modules;" in
>                         *";$name;"*)
>                                 # then there is no local change to integrate
> -                               update_module= ;;
> +                               update_module="checkout"
> +                               just_cloned=yes
> +                               ;;
>                         esac
>
> +                       if test -z "$update_module"
> +                       then
> +                               # Fallback to checkout
> +                               update_module="checkout"
> +                       fi
> +
> +                       command_pre=:
> +                       suffix_pre=
> +                       if test "$update_module" = "checkout"
> +                       then
> +                               if test -n "$attach_module" -a -z "$just_cloned"
> +                               then
> +                                       # We need to attach to the HEAD/switch the branch prior
> +                                       # performing any fast-forward update
> +                                       command_pre="git checkout $subforce -q"
> +                                       suffix_pre=$branch
> +                               fi
> +                       else
> +                               if test -n "$attach_module" -a -n "$head_detached"
> +                               then
> +                                       # We need to reattach to the head
> +                                       command_pre="git checkout $subforce -q"
> +                                       suffix_pre=$branch
> +                               elif test -z "$attach_module" -a -z "$head_detached"
> +                               then
> +                                       # We need to detach from the head
> +                                       command_pre="git checkout $subforce -q"
> +                                       suffix_pre=$sha1
> +                               fi
> +                       fi
> +
>                         must_die_on_failure=
> +                       custom_update=
> +                       suffix=
>                         case "$update_module" in
>                         rebase)
>                                 command="git rebase"
> +                               suffix=$sha1
>                                 die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
>                                 say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
>                                 must_die_on_failure=yes
>                                 ;;
>                         merge)
>                                 command="git merge"
> +                               suffix=$sha1
>                                 die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
>                                 say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
>                                 must_die_on_failure=yes
>                                 ;;
> +                       checkout)
> +                               if test -n "$attach_module"
> +                               then
> +                                       if test -n "$just_cloned"
> +                                       then
> +                                               command="git checkout $subforce -q"
> +                                               suffix=$branch
> +                                       else
> +                                               # Perform a fast-forward only merge of the origin
> +                                               command="git merge $subforce --ff-only"
> +                                               suffix="origin/$branch"
> +                                       fi
> +                                       die_msg="$(eval_gettext "Unable to checkout banch '\$branch' in submodule path '\$displaypath'")"
> +                                       say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out branch '\$branch'")"
> +                               else
> +                                       command="git checkout $subforce -q"
> +                                       suffix=$sha1
> +                                       die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> +                                       say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
> +                               fi
> +                               ;;
>                         !*)
>                                 command="${update_module#!}"
> +                               suffix=$sha1
>                                 die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'")"
>                                 say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
>                                 must_die_on_failure=yes
> +                               custom_update=yes
>                                 ;;
>                         *)
> -                               command="git checkout $subforce -q"
> -                               die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> -                               say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
> +                               # Valid user configurable update modes are already filtered above
> +                               die "$(eval_gettext "Unexpected update mode in the current flow")"
>                                 ;;
>                         esac
>
> -                       if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
> +                       if (clear_local_git_env; cd "$sm_path" &&
> +                               $command_pre "$suffix_pre" &&
> +                               $command "$suffix")
>                         then
>                                 say "$say_msg"
>                         elif test -n "$must_die_on_failure"

I didn't have time to parse out all these conditional completion
commands in this review, but the feature seems sane to me, as I
understand it.

Phil
