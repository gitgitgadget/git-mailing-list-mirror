From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Sun, 5 Jan 2014 20:55:34 +0100
Message-ID: <CALas-ihrHM-vsqDmJD5VssQKhW-9+3Y5BDNr6pRe6ako=WD0og@mail.gmail.com>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com> <1388890249-3577-2-git-send-email-ceztko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Francesco Pretto <ceztko@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Junio C Hamano <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 05 20:56:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vztns-000625-Ak
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 20:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbaAETz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 14:55:56 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:53680 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbaAETzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 14:55:55 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so17523236obc.15
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 11:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JpLfrhRH/o/KSeYxwTVYrVsQDukBkz9F1FwE8zbnEqw=;
        b=p+SfBwNk9fXS+EH1FDIm68h7ZRvf5wrHZEuvds18I38mzcS0dUOAfBI4uE0+/CgFYQ
         zUgr4ZIU2WBxS1iQa5YQrHFSKks5ufzKN+lZgd5AoKoqaODxdFinXDsSHBeUe5z54bn2
         2YRpAFFtMdyKcZazXTEIEtiYEF8aIzD2XxsoJ8grB7iWDkavrU+gAIAizyIrQ2+quIDS
         H2giPcO80mZi/xLVimwSlIFCh/C+DQK2TbiUl6ZXPG77NO6wEq1GCaDP1pPfrrx7ATkP
         aG+NrI0F9eR86U+LTwn8U4WAYCu49wYYfqmGgypdEViwExx5KhSl8VIsTEPTmDc/GfeI
         /pfQ==
X-Received: by 10.182.102.7 with SMTP id fk7mr68174860obb.28.1388951754593;
 Sun, 05 Jan 2014 11:55:54 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Sun, 5 Jan 2014 11:55:34 -0800 (PST)
In-Reply-To: <1388890249-3577-2-git-send-email-ceztko@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239969>

(Hmmpth, forgot signoff...)

To whom it may interest, added some CC.

2014/1/5 Francesco Pretto <ceztko@gmail.com>:
> At the current state, the following use-case is not supported very
> well in git:
> - a maintainer adds a submodule, checking out a specific branch of
> the repository. He doesn't track the upstream submodule revision sha1;
> - a developer checkout the repository branch decided by the maintainer.
> Subsequent "merge" or "rebase" update operations don't detach the HEAD.
>
> To ease the above use-case this patch:
> - introduces a "submodule.<module>.attached" property that, when set
>   to "true", ensures that the "update" operation will result in
>   the HEAD attached to a branch;
> - introduces "--attach|--dettach" switches to the submodule "update"
>   command: they attach/detach the HEAD, overriding
>   "submodule.<module>.attached" property value;
> - introduces "--attached-update" switch to the "add" operation. It:
>     * sets "submodule.<module>.attached" to true;
>     * sets "submodule.<module>.ignore" to all.
>
> Using the '--attach' switch or operating in a repository with
> 'submodule.<name>.attached' set to 'true' during "update" will:
> - checkout a branch with an attached HEAD if the repository was just
> cloned;
> - perform a fast-forward only merge of changes if it's a 'checkout'
> update operation;
> - reattach the HEAD prior performing a 'merge', 'rebase' or '!command'
> update operation if the HEAD was found detached. Orphaned commits
> will also be merged back in the branch.
>
> '--attach' or 'submodule.<name>.attached' set to true also implies '--remote'.
>
> Using  the '--detach' switch or operating in a repository with
> 'submodule.<name>.attached' set to 'false' during "update" will:
> - checkout a detached HEAD if the repository was just cloned;
> - detach the HEAD prior performing a 'merge', 'rebase' or '!command'
> update operation if the HEAD was found attached.
>
> 'submodule.<name>.attached' works similarly to 'submodule.<name>.update'
> property: git copies the values found in ".gitmodules" in ".git/config" when
> performing an "init" command. "update" looks for values in ".git/config"
> only.
>
> '--attach' and '--detach' switches override an opposite behaviour
> of 'submodule.<name>.attached' properties.
>
> The patch is strongly additive and doesn't break any submodule specific
> test. It also adds some tests specific to the added feature.
> ---
>  Documentation/git-submodule.txt    |  48 +++++--
>  Documentation/gitmodules.txt       |  10 +-
>  git-submodule.sh                   | 154 +++++++++++++++++++--
>  t/t7410-submodule-attached-head.sh | 268 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 457 insertions(+), 23 deletions(-)
>  create mode 100755 t/t7410-submodule-attached-head.sh
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index bfef8a0..b97eefb 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -10,13 +10,14 @@ SYNOPSIS
>  --------
>  [verse]
>  'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
> -             [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
> +             [--reference <repository>] [--attached-update] [--depth <depth>]
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
> @@ -107,6 +108,9 @@ is the superproject and submodule repositories will be kept
>  together in the same relative location, and only the
>  superproject's URL needs to be provided: git-submodule will correctly
>  locate the submodule using the relative URL in .gitmodules.
> ++
> +If `--attached-update` is specified, the property `submodule.<name>.attached`
> +will be set to `true` and `submodule.<name>.ignore` will be set to `all`.
>
>  status::
>         Show the status of the submodules. This will print the SHA-1 of the
> @@ -156,12 +160,15 @@ it contains local modifications.
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
> +       specified or `submodule.$name.attached` is set to `true`. The last setting
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
> @@ -270,6 +277,23 @@ OPTIONS
>         be overridden by setting the `submodule.<name>.branch` option in
>         either `.gitmodules` or `.git/config` (with `.git/config` taking
>         precedence).
> +
> +--attached-update::
> +       This option is only valid for the add command. Causes the add command
> +       also to set the property `submodule.<name>.attached` to `true` and
> +       the property `submodule.<name>.ignore` to `all`.
> +
> +--attach::
> +       This option is only valid for the update commands. Causes the result
> +       of an update operation to be an attached HEAD. In the update operation,
> +       the branch named by 'submodule.<name>.branch' is checked out as the new
> +       HEAD of the submodule repository. If 'submodule.<name>.branch' is not
> +       set, the 'master' branch is checked out as the new HEAD of the
> +       submodule. Note: `--attach` also implies `--remote`.
> +
> +--detach::
> +       This option is only valid for the update command. Forces the result
> +       of the update operation to be a detached HEAD in the submodule.
>  +
>  This works for any of the supported update procedures (`--checkout`,
>  `--rebase`, etc.).  The only change is the source of the target SHA-1.
> @@ -290,8 +314,7 @@ SHA-1.  If you don't want to fetch, you should use `submodule update
>  --merge::
>         This option is only valid for the update command.
>         Merge the commit recorded in the superproject into the current branch
> -       of the submodule. If this option is given, the submodule's HEAD will
> -       not be detached. If a merge failure prevents this process, you will
> +       of the submodule. If a merge failure prevents this process, you will
>         have to resolve the resulting conflicts within the submodule with the
>         usual conflict resolution tools.
>         If the key `submodule.$name.update` is set to `merge`, this option is
> @@ -300,8 +323,7 @@ SHA-1.  If you don't want to fetch, you should use `submodule update
>  --rebase::
>         This option is only valid for the update command.
>         Rebase the current branch onto the commit recorded in the
> -       superproject. If this option is given, the submodule's HEAD will not
> -       be detached. If a merge failure prevents this process, you will have
> +       superproject. If a merge failure prevents this process, you will have
>         to resolve these failures with linkgit:git-rebase[1].
>         If the key `submodule.$name.update` is set to `rebase`, this option is
>         implicit.
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index f7be93f..9c436db 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -38,7 +38,8 @@ submodule.<name>.url::
>  submodule.<name>.update::
>         Defines what to do when the submodule is updated by the superproject.
>         If 'checkout' (the default), the new commit specified in the
> -       superproject will be checked out in the submodule on a detached HEAD.
> +       superproject (or branch, with '--attach') will be checked out in
> +       the submodule.
>         If 'rebase', the current branch of the submodule will be rebased onto
>         the commit specified in the superproject. If 'merge', the commit
>         specified in the superproject will be merged into the current branch
> @@ -54,6 +55,13 @@ submodule.<name>.branch::
>         If the option is not specified, it defaults to 'master'.  See the
>         `--remote` documentation in linkgit:git-submodule[1] for details.
>
> +submodule.<name>.attached::
> +       Determine if the update operation will produce a detached HEAD or not.
> +       Valid values are `true` or `false`. If the property is set to `true`
> +       and `submodule.<name>.branch` is not set, the branch `master` will
> +       be checked out. If `submodule.<name>.branch` is set the branch
> +       specified will be checked out instead.
> +
>  submodule.<name>.fetchRecurseSubmodules::
>         This option can be used to control recursive fetching of this
>         submodule. If this option is also present in the submodules entry in
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 1d041a7..bc6df2b 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -5,11 +5,11 @@
>  # Copyright (c) 2007 Lars Hjemli
>
>  dashless=$(basename "$0" | sed -e 's/-/ /')
> -USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
> +USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--attached-update] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--attach | --detach] [--merge] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
>     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
> @@ -36,6 +36,9 @@ update=
>  prefix=
>  custom_name=
>  depth=
> +attach=
> +detach=
> +attached_update=
>
>  # The function takes at most 2 arguments. The first argument is the
>  # URL that navigates to the submodule origin repo. When relative, this URL
> @@ -352,6 +355,9 @@ cmd_add()
>                         custom_name=$2
>                         shift
>                         ;;
> +               --attached-update)
> +                       attached_update=yes
> +                       ;;
>                 --depth)
>                         case "$2" in '') usage ;; esac
>                         depth="--depth=$2"
> @@ -491,6 +497,12 @@ Use -f if you really want to add it." >&2
>         then
>                 git config -f .gitmodules submodule."$sm_name".branch "$branch"
>         fi &&
> +       if test -n "$attached_update"
> +       then
> +               # We'll stay stick to the HEAD, no need to track revision sha1
> +               git config -f .gitmodules submodule."$sm_name".attached "true"
> +               git config -f .gitmodules submodule."$sm_name".ignore "all"
> +       fi &&
>         git add --force .gitmodules ||
>         die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
>  }
> @@ -632,6 +644,22 @@ cmd_init()
>                         git config submodule."$name".update "$upd" ||
>                         die "$(eval_gettext "Failed to register update mode for submodule path '\$displaypath'")"
>                 fi
> +
> +               # Copy "attached" setting when it is not set yet
> +               if attached="$(git config -f .gitmodules submodule."$name".attached)" &&
> +                  test -n "$attached" &&
> +                  test -z "$(git config submodule."$name".attached)"
> +               then
> +                       case "$attached" in
> +                       true | false)
> +                               ;; # Valid attach flag values
> +                       *)
> +                               echo >&2 "warning: invalid attach flag value for submodule '$name'"
> +                               ;;
> +                       esac
> +                       git config submodule."$name".attached "$attached" ||
> +                       die "$(eval_gettext "Failed to register attach option for submodule path '\$displaypath'")"
> +               fi
>         done
>  }
>
> @@ -750,6 +778,14 @@ cmd_update()
>                 --reference=*)
>                         reference="$1"
>                         ;;
> +               --attach)
> +                       if test -n "$detach" ; then usage ; fi
> +                       attach=1
> +                       ;;
> +               --detach)
> +                       if test -n "$attach" ; then usage ; fi
> +                       detach=1
> +                       ;;
>                 -m|--merge)
>                         update="merge"
>                         ;;
> @@ -800,6 +836,28 @@ cmd_update()
>                 name=$(module_name "$sm_path") || exit
>                 url=$(git config submodule."$name".url)
>                 branch=$(get_submodule_config "$name" branch master)
> +               attach_module=
> +               detach_module=
> +               if test -n "$attach" -o -n "$detach"
> +               then
> +                       attach_module=$attach
> +                       detach_module=$detach
> +               else
> +                       attached=$(git config submodule."$name".attached)
> +                       case "$attached" in
> +                       '')
> +                               ;; # Unset attach flag
> +                       true)
> +                               attach_module=1
> +                               ;;
> +                       false)
> +                               detach_module=1
> +                               ;;
> +                       *)
> +                               echo >&2 "warning: invalid attach flag value for submodule '$name'"
> +                               ;;
> +                       esac
> +               fi
>                 if ! test -z "$update"
>                 then
>                         update_module=$update
> @@ -848,7 +906,16 @@ Maybe you want to use 'update --init'?")"
>                         die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
>                 fi
>
> -               if test -n "$remote"
> +               head_rev_ref=$(clear_local_git_env; cd "$sm_path" && git rev-parse --abbrev-ref HEAD) ||
> +               die "$(eval_gettext "Unable to determine revision ref in submodule path '\$sm_path'")"
> +               head_detached=
> +               if test "$head_rev_ref" = "HEAD"
> +               then
> +                       # Determine if the HEAD is detached
> +                       head_detached="true"
> +               fi
> +
> +               if test -n "$remote" -o -n "$attach_module"
>                 then
>                         if test -z "$nofetch"
>                         then
> @@ -862,7 +929,8 @@ Maybe you want to use 'update --init'?")"
>                         die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
>                 fi
>
> -               if test "$subsha1" != "$sha1" -o -n "$force"
> +               if test "$subsha1" != "$sha1" || test -n "$attach_module" -a -n "$head_detached" ||
> +                       test -n "$detach_module" -a -z "$head_detached" || test -n "$force"
>                 then
>                         subforce=$force
>                         # If we don't already have a -f flag and the submodule has never been checked out
> @@ -882,40 +950,108 @@ Maybe you want to use 'update --init'?")"
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
> +                       command_attach=:
> +                       suffix_attach=
> +                       if test "$update_module" != "checkout"
> +                       then
> +                               if test -n "$attach_module" -a -n "$head_detached"
> +                               then
> +                                       # We need to reattach to the branch
> +                                       command_attach="git checkout $subforce -q"
> +                                       suffix_attach=$branch
> +                               elif test -n "$detach_module" -a -z "$head_detached"
> +                               then
> +                                       # We need to detach from the branch
> +                                       command_attach="git checkout $subforce -q"
> +                                       suffix_attach=$sha1
> +                               fi
> +                       fi
> +
> +                       command_pre=:
> +                       suffix_pre=
> +                       command_post=:
> +                       suffix_pre=
> +                       suffix=
>                         must_die_on_failure=
> +                       custom_update=
>                         case "$update_module" in
>                         rebase)
>                                 command="git rebase"
> +                               suffix=$sha1
>                                 die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
>                                 say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
>                                 must_die_on_failure=yes
> +                               if test -n "$attach_module" -a -n "$head_detached" && test "$subsha1" != "$sha1"
> +                               then
> +                                       # After the rebase, we merge orphaned commits in the branch
> +                                       command_post="git merge"
> +                                       suffix_post=$subsha1
> +                               fi
>                                 ;;
>                         merge)
> +                               if test -n "$attach_module" -a -n "$head_detached" && test "$subsha1" != "$sha1"
> +                               then
> +                                       # Prior the rebase, we merge orphaned commits in in the branch
> +                                       command_pre="git merge"
> +                                       suffix_pre=$subsha1
> +                               fi
>                                 command="git merge"
> +                               suffix=$sha1
>                                 die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
>                                 say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
>                                 must_die_on_failure=yes
>                                 ;;
> +                       checkout)
> +                               if test -n "$attach_module"
> +                               then
> +                                       command="git checkout $subforce -q"
> +                                       suffix=$branch
> +                                       die_msg="$(eval_gettext "Unable to checkout banch '\$branch' in submodule path '\$displaypath'")"
> +                                       say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out branch '\$branch'")"
> +                                       if test -z "$just_cloned" -a && test "$subsha1" != "$sha1"
> +                                       then
> +                                               # Perform a fast-forward only merge of the origin
> +                                               command_post="git merge $subforce --ff-only"
> +                                               suffix_post="origin/$branch"
> +                                       fi
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
> +                       if (clear_local_git_env; cd "$sm_path" && $command_attach "$suffix_attach" &&
> +                               $command_pre "$suffix_pre" && $command "$suffix" && $command_post "$suffix_pro")
>                         then
>                                 say "$say_msg"
>                         elif test -n "$must_die_on_failure"
> diff --git a/t/t7410-submodule-attached-head.sh b/t/t7410-submodule-attached-head.sh
> new file mode 100755
> index 0000000..04b3018
> --- /dev/null
> +++ b/t/t7410-submodule-attached-head.sh
> @@ -0,0 +1,268 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Francesco Pretto
> +#
> +
> +test_description='Support for submodules with attached head
> +
> +This test verifies the sanity of the add and update git submodule commands with
> +or without the --attached-update, --attach, --detach switches or the
> +submoudule.<module>.attach property set
> +'
> +
> +TEST_NO_CREATE_REPO=true
> +. ./test-lib.sh
> +
> +submodurl1=$(pwd -P)/repo1
> +submodurl2=$(pwd -P)/repo2
> +repourl=$(pwd -P)/repo
> +
> +test_expect_success 'setup - create repository "repo1" to be used as submodule' '
> +       mkdir repo1 &&
> +       (
> +               cd repo1 &&
> +               git init &&
> +               git config receive.denyCurrentBranch ignore &&
> +               echo a >a &&
> +               git add a &&
> +               git commit -m "repo1 commit 1"
> +       )
> +'
> +
> +test_expect_success 'setup - reate repository "repo2" to be used as submodule' '
> +       mkdir repo2 &&
> +       (
> +               cd repo2 &&
> +               git init &&
> +               git config receive.denyCurrentBranch ignore &&
> +               echo a >a &&
> +               git add a &&
> +               git commit -m "repo2 commit 1"
> +       )
> +'
> +
> +test_expect_success 'setup - create repository "repo" to be added with sumodules' '
> +       mkdir repo &&
> +       (
> +               cd repo &&
> +               git init &&
> +               git config receive.denyCurrentBranch ignore &&
> +               echo a >a &&
> +               git add a &&
> +               git commit -m "repo commit 1"
> +       )
> +'
> +
> +test_expect_success 'setup - clone repository "repo" in "repoclone"' '
> +       git clone "$repourl" repoclone
> +'
> +
> +test_expect_success 'setup - add "mod1" as regular submodule of "repo"' '
> +       (
> +               cd repo &&
> +               git submodule add "$submodurl1" submod1
> +       )
> +'
> +
> +test_expect_success 'setup - add "mod2" as update attached HEAD submodule of "repo"' '
> +       (
> +               cd repo &&
> +               git submodule add --attached-update "$submodurl2" submod2
> +       )
> +'
> +
> +test_expect_success 'setup - commit submodules in repo' '
> +       (
> +               cd repo &&
> +               git add . &&
> +               git commit -m "Added submodules"
> +       )
> +'
> +
> +test_expect_success 'init submodules in cloned repo' '
> +       (
> +               cd repoclone &&
> +               git pull &&
> +               git submodule init
> +       )
> +'
> +
> +test_expect_success 'update submodules in cloned repo' '
> +       (
> +               cd repoclone &&
> +               git submodule update
> +       )
> +'
> +
> +test_expect_success 'assert submod1 HEAD is detached in cloned repo' '
> +       (
> +               cd repoclone/submod1 &&
> +               test "$(git rev-parse --abbrev-ref HEAD)" = "HEAD"
> +       )
> +'
> +
> +test_expect_success 'assert submod2 HEAD is attached in cloned repo' '
> +       (
> +               cd repoclone/submod2 &&
> +               test "$(git rev-parse --abbrev-ref HEAD)" != "HEAD"
> +       )
> +'
> +
> +test_expect_success 'update submodules with --attach in cloned repo' '
> +       (
> +               cd repoclone &&
> +               git submodule update --attach
> +       )
> +'
> +
> +test_expect_success 'assert submod1 HEAD is attached in cloned repo' '
> +       (
> +               cd repoclone/submod1 &&
> +               test "$(git rev-parse --abbrev-ref HEAD)" != "HEAD"
> +       )
> +'
> +
> +test_expect_success 'update submodules with --detach in cloned repo' '
> +       (
> +               cd repoclone &&
> +               git submodule update --detach
> +       )
> +'
> +
> +test_expect_success 'assert submod1 HEAD is detached in cloned repo' '
> +       (
> +               cd repoclone/submod1 &&
> +               test "$(git rev-parse --abbrev-ref HEAD)" = "HEAD"
> +       )
> +'
> +
> +test_expect_success 'assert submod2 HEAD is detached in cloned repo' '
> +       (
> +               cd repoclone/submod2 &&
> +               test "$(git rev-parse --abbrev-ref HEAD)" = "HEAD"
> +       )
> +'
> +
> +test_expect_success 'update submodules in cloned repo (will restore HEAD states)' '
> +       (
> +               cd repoclone &&
> +               git submodule update
> +       )
> +'
> +
> +test_expect_success 'assert submod1 HEAD is detached in cloned repo' '
> +       (
> +               cd repoclone/submod1 &&
> +               test "$(git rev-parse --abbrev-ref HEAD)" = "HEAD"
> +       )
> +'
> +
> +test_expect_success 'assert submod2 HEAD is attached in cloned repo' '
> +       (
> +               cd repoclone/submod2 &&
> +               test "$(git rev-parse --abbrev-ref HEAD)" != "HEAD"
> +       )
> +'
> +
> +test_expect_success 'setup - add update operation to submodules' '
> +       (
> +               cd repo &&
> +               git config  -f .gitmodules submodule.submod1.update merge &&
> +               git config  -f .gitmodules submodule.submod2.update rebase &&
> +               git add . &&
> +               git commit -m "updated submodules"
> +       )
> +'
> +
> +test_expect_success 'setup - update cloned repo and reinitialize submodules' '
> +       (
> +               cd repoclone &&
> +               git pull &&
> +               git submodule init
> +       )
> +'
> +
> +test_expect_success 'add some content to repo2' '
> +       (
> +               cd repo2 &&
> +               echo b >b &&
> +               git add b &&
> +               git commit -m "repo2 commit 2"
> +       )
> +'
> +
> +test_expect_success 'update sumodules in cloned repo and verify that submod2 matches repo2' '
> +       (
> +               cd repoclone &&
> +               git submodule update &&
> +               test -e submod2/b
> +       )
> +'
> +
> +test_expect_success 'prepend some content to repo1/a' '
> +       (
> +               cd repo1 &&
> +               echo -e "b\na" >a &&
> +               git add a &&
> +               git commit -m "repo1 commit 2"
> +       )
> +'
> +
> +test_expect_success 'append some content in repoclone/submod1 and commit' '
> +       (
> +               cd repoclone/submod1 &&
> +               echo c >>a &&
> +               git add a &&
> +               git commit -m "submod1 commit 1"
> +       )
> +'
> +
> +test_expect_success 'update repoclone submodules with --attach' '
> +       (
> +               cd repoclone &&
> +               git submodule update --attach
> +       )
> +'
> +
> +test_expect_success 'verify repoclone submod1 merge with reattached orphaned commits was correct' '
> +       (
> +               cd repoclone/submod1 &&
> +               test "$(<a)" = "$'b\na\nc'"
> +       )
> +'
> +
> +test_expect_success 'setup - set operation checkout to submodule sumod1 in repo' '
> +       (
> +               cd repo &&
> +               git config  -f .gitmodules submodule.submod1.update checkout &&
> +               git add . &&
> +               git commit -m "updated submodules"
> +       )
> +'
> +
> +test_expect_success 'setup - update cloned repo and reinitialize submodules' '
> +       (
> +               cd repoclone &&
> +               git pull &&
> +               git submodule init
> +       )
> +'
> +
> +test_expect_success 'add some content to repo1' '
> +       (
> +               cd repo1 &&
> +               echo b >b &&
> +               git add b &&
> +               git commit -m "repo1 commit 3"
> +       )
> +'
> +
> +test_expect_success 'update submodule submod2 (merge ff-only) and verify it matches repo2' '
> +       (
> +               cd repoclone &&
> +               git submodule update &&
> +               test -e submod2/b
> +       )
> +'
> +
> +test_done
> --
> 1.8.5.2.230.g032cd47.dirty
>
