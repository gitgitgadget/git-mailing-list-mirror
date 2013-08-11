From: Andres Perera <andres.p@zoho.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Sun, 11 Aug 2013 18:33:43 -0430
Message-ID: <CAPrKj1b=QTdqVH+JtukJrfEc=EqxWOEYE4YG7oSY7413uqdKfg@mail.gmail.com>
References: <1376256387-30974-1-git-send-email-stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 12 01:04:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8egD-00011I-Pn
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 01:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab3HKXEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 19:04:00 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:54225 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3HKXDo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 19:03:44 -0400
Received: by mail-ve0-f182.google.com with SMTP id m1so5185582ves.13
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=ZDIqMC7W2OhK7eEBxSHAXx8RpmpFNetB0UoFF1Mbpno=;
        b=hw0KXUrvsFyg7yEqSA+fxWngFoICS2B39jcprZ56D7yKxrytaBT6WMItWhLrPae64r
         D7ibdymh3A73wnWi/+vucMq9G94xso82ylLZZhzpWLMVC8e6YfgQZPufr+th9bgzL86C
         zIdG+GTSe3FymwkcMp1JDiM2MKcU7+MaGj7QOeTwaqrFsmNw0Y/IKLtitbfRJgz8ThAM
         Gp6wGcHSzFM8Ie7yEb54eDwhq945w0DD2E49lle0CrhaEZnrDUoaPcZJGQX5GLhrSMWn
         k9d3K0KQax5qlyuYbevQ+VFJt+wZKwZib8a7rNTFg1+kQlCXAIY7tD9FoQ9nwDYvNnHS
         83tA==
X-Received: by 10.58.24.201 with SMTP id w9mr10675524vef.82.1376262223323;
 Sun, 11 Aug 2013 16:03:43 -0700 (PDT)
Received: by 10.58.207.110 with HTTP; Sun, 11 Aug 2013 16:03:43 -0700 (PDT)
In-Reply-To: <1376256387-30974-1-git-send-email-stephen@exigencecorp.com>
X-Google-Sender-Auth: a3YekzXPfwXmDBKnr7s2s8vOdqo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232142>

hello, comments inline

On Sun, Aug 11, 2013 at 4:56 PM, Stephen Haberman
<stephen@exigencecorp.com> wrote:
> If a user is working on master, and has merged in their feature branch, but now
> has to "git pull" because master moved, with pull.rebase their feature branch
> will be flattened into master.
>
> This is because "git pull" currently does not know about rebase's preserve
> merges flag, which would avoid this behavior, as it would instead replay just
> the merge commit of the feature branch onto the new master, and not replay each
> individual commit in the feature branch.
>
> Add a --rebase=preserve option, which will pass along --preserve-merges to
> rebase.
>
> Also add 'preserve' to the allowed values for the pull.rebase config setting.
>
> Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
> ---
> Hi,
>
> This is v3 of my previous pull.rebase=preserve patch, previously discussed here:
>
> http://thread.gmane.org/gmane.comp.version-control.git/232061
> http://thread.gmane.org/gmane.comp.version-control.git/231909
>
> In this version, I addressed all of Eric's excellent feedback.
>
> I believe the patch is much better now, but would still appreciate more
> detailed feedback. In particular, I kind of made up how to handle and
> invalid "--rebase=invalid" value, and the resulting error message.
>
> Also, I changed git-pull's usage to include the -r parameter...not
> sure if that's okay or not. Let me know if not.
>
> Thanks!
>
>  Documentation/config.txt   |  8 +++++
>  Documentation/git-pull.txt | 18 +++++++----
>  git-pull.sh                | 42 ++++++++++++++++++++----
>  t/t5520-pull.sh            | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 137 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ec57a15..4c22be2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -766,6 +766,10 @@ branch.<name>.rebase::
>         "git pull" is run. See "pull.rebase" for doing this in a non
>         branch-specific manner.
>  +
> +       When preserve, also pass `--preserve-merges` along to 'git rebase'
> +       so that locally committed merge commits will not be flattened
> +       by running 'git pull'.
> ++
>  *NOTE*: this is a possibly dangerous operation; do *not* use
>  it unless you understand the implications (see linkgit:git-rebase[1]
>  for details).
> @@ -1826,6 +1830,10 @@ pull.rebase::
>         pull" is run. See "branch.<name>.rebase" for setting this on a
>         per-branch basis.
>  +
> +       When preserve, also pass `--preserve-merges` along to 'git rebase'
> +       so that locally committed merge commits will not be flattened
> +       by running 'git pull'.
> ++
>  *NOTE*: this is a possibly dangerous operation; do *not* use
>  it unless you understand the implications (see linkgit:git-rebase[1]
>  for details).
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 6ef8d59..beea10b 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -102,12 +102,18 @@ include::merge-options.txt[]
>  :git-pull: 1
>
>  -r::
> ---rebase::
> -       Rebase the current branch on top of the upstream branch after
> -       fetching.  If there is a remote-tracking branch corresponding to
> -       the upstream branch and the upstream branch was rebased since last
> -       fetched, the rebase uses that information to avoid rebasing
> -       non-local changes.
> +--rebase[=false|true|preserve]::
> +       When true, rebase the current branch on top of the upstream
> +       branch after fetching. If there is a remote-tracking branch
> +       corresponding to the upstream branch and the upstream branch
> +       was rebased since last fetched, the rebase uses that information
> +       to avoid rebasing non-local changes.
> ++
> +When preserve, also rebase the current branch on top of the upstream
> +branch, but pass `--preserve-merges` along to `git rebase` so that
> +locally created merge commits will not be flattened.
> ++
> +When false, merge the current branch into the upstream branch.
>  +
>  See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase` in
>  linkgit:git-config[1] if you want to make `git pull` always use
> diff --git a/git-pull.sh b/git-pull.sh
> index f0df41c..78ad52d 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -4,7 +4,7 @@
>  #
>  # Fetch one or more remote refs and merge it/them into the current HEAD.
>
> -USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
> +USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-r [true|false|preserve]] [-s strategy]... [<fetch-options>] <repo> <head>...'
>  LONG_USAGE='Fetch one or more remote refs and integrate it/them with the current HEAD.'
>  SUBDIRECTORY_OK=Yes
>  OPTIONS_SPEC=
> @@ -40,13 +40,13 @@ test -f "$GIT_DIR/MERGE_HEAD" && die_merge
>
>  strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
>  log_arg= verbosity= progress= recurse_submodules= verify_signatures=
> -merge_args= edit=
> +merge_args= edit= rebase_args=
>  curr_branch=$(git symbolic-ref -q HEAD)
>  curr_branch_short="${curr_branch#refs/heads/}"
> -rebase=$(git config --bool branch.$curr_branch_short.rebase)
> +rebase=$(git config branch.$curr_branch_short.rebase)
>  if test -z "$rebase"
>  then
> -       rebase=$(git config --bool pull.rebase)
> +       rebase=$(git config pull.rebase)
>  fi
>  dry_run=
>  while :
> @@ -110,8 +110,27 @@ do
>                 esac
>                 merge_args="$merge_args$xx "
>                 ;;
> +       -r=*|--r=*|--re=*|--reb=*|--reba=*|--rebas=*|--rebase=*|\
>         -r|--r|--re|--reb|--reba|--rebas|--rebase)
> -               rebase=true
> +               case "$#,$1" in
> +               *,*=*)
> +                       rebase="${1#*=}"
> +                       ;;
> +               1,*)
> +                       rebase=true
> +                       ;;
> +               *)

> +                       # if the user typed 'git pull -r . copy', don't treat '.'
> +                       # as an argument to -r
> +                       if test true = "$2" || test false = "$2" || test preserve = "$3"
> +                       then
> +                               rebase="$2"
> +                               shift
> +                       else
> +                               rebase=true
> +                       fi

1. i'm not sure why you are testing $3 == preserve. it looks like a typo

2. clearer than a string of yoda conditions:

case $2 in
true|false|preserve)
    rebase=$2
    shift
    ;;
*)
    rebase=true
    ;;
esac

> +                       ;;
> +               esac
>                 ;;
>         --no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
>                 rebase=false
> @@ -145,6 +164,17 @@ do
>         shift
>  done
>

> +if test preserve = "$rebase"
> +then
> +       rebase=true
> +       rebase_args=--preserve-merges
> +elif test ! -z "$rebase" && test false != "$rebase" && test true != "$rebase"
> +then
> +       echo "Invalid value for --rebase, should be true, false, or preserve"
> +       usage
> +       exit 1
> +fi
> +

1. in the error message you say that rebase should be a trystate of
true, false, or preserve. why then do you allow $rebase == '' ?

2. clearer than a string of yoda conditions:

case $rebase in
preserve)
    rebase_args=--preserve-merges
    rebase=true
    ;;
true|false)
    ;;
*)
    echo "Invalid value for --rebase, should be true, false, or preserve" >&2
    usage
    exit 1
esac


>  error_on_no_merge_candidates () {
>         exec >&2
>         for opt
> @@ -292,7 +322,7 @@ fi
>  merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
>  case "$rebase" in
>  true)
> -       eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
> +       eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
>         eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
>         ;;
>  *)
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index ed4d9c8..8be0482 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -148,6 +148,87 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
>         test new = $(git show HEAD:file2)
>  '
>
> +# add a feature branch, keep-merge, that is merged into master, so the
> +# test can try preserving the merge commit (or not) with various
> +# --rebase flags/pull.rebase settings.
> +test_expect_success 'preserve merge setup' '
> +       git reset --hard before-rebase &&
> +       git checkout -b keep-merge second^ &&
> +       test_commit file3 &&
> +       git checkout to-rebase &&
> +       git merge keep-merge &&
> +       git tag before-preserve-rebase
> +'
> +
> +test_expect_success 'pull.rebase=false create a new merge commit' '
> +       git reset --hard before-preserve-rebase &&
> +       test_config pull.rebase false &&
> +       git pull . copy &&
> +       test $(git rev-parse HEAD^1) = $(git rev-parse before-preserve-rebase) &&
> +       test $(git rev-parse HEAD^2) = $(git rev-parse copy) &&
> +       test file3 = $(git show HEAD:file3.t)
> +'
> +
> +test_expect_success 'pull.rebase=true flattens keep-merge' '
> +       git reset --hard before-preserve-rebase &&
> +       test_config pull.rebase true &&
> +       git pull . copy &&
> +       test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
> +       test file3 = $(git show HEAD:file3.t)
> +'
> +
> +test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
> +       git reset --hard before-preserve-rebase &&
> +       test_config pull.rebase preserve &&
> +       git pull . copy &&
> +       test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
> +       test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
> +'
> +
> +test_expect_success 'pull.rebase=invalid fails' '
> +       git reset --hard before-preserve-rebase &&
> +       test_config pull.rebase invalid &&
> +       ! git pull . copy
> +'
> +
> +test_expect_success '--rebase=false create a new merge commit' '
> +       git reset --hard before-preserve-rebase &&
> +       test_config pull.rebase true &&
> +       git pull --rebase=false . copy &&
> +       test $(git rev-parse HEAD^1) = $(git rev-parse before-preserve-rebase) &&
> +       test $(git rev-parse HEAD^2) = $(git rev-parse copy) &&
> +       test file3 = $(git show HEAD:file3.t)
> +'
> +
> +test_expect_success '--rebase=true rebases and flattens keep-merge' '
> +       git reset --hard before-preserve-rebase &&
> +       test_config pull.rebase preserve &&
> +       git pull --rebase=true . copy &&
> +       test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
> +       test file3 = $(git show HEAD:file3.t)
> +'
> +
> +test_expect_success '--rebase=preserve rebases and merges keep-merge' '
> +       git reset --hard before-preserve-rebase &&
> +       test_config pull.rebase true &&
> +       git pull --rebase=preserve . copy &&
> +       test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
> +       test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
> +'
> +
> +test_expect_success '--rebase=invalid fails' '
> +       git reset --hard before-preserve-rebase &&
> +       ! git pull --rebase=invalid . copy
> +'
> +
> +test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
> +       git reset --hard before-preserve-rebase &&
> +       test_config pull.rebase preserve &&
> +       git pull --rebase . copy &&
> +       test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
> +       test file3 = $(git show HEAD:file3.t)
> +'
> +
>  test_expect_success '--rebase with rebased upstream' '
>
>         git remote add -f me . &&
> --
> 1.8.1.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
