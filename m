From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 11/14] pull: teach git pull about --rebase
Date: Mon, 18 May 2015 16:36:15 -0700
Message-ID: <CAGZ79kaY6vr6EqRs7DzZnSBDVhB0oW4=LRg8+cGqKzm45aVypg@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-12-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 01:36:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuUa6-0000bZ-2i
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 01:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbbERXgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 19:36:17 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35479 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045AbbERXgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 19:36:15 -0400
Received: by iesa3 with SMTP id a3so1321319ies.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CB1G6dA0n1ljM6goecadWa4Juk/HG3B55pn9rtLr9y0=;
        b=GaOqRrNs/I30u6ruZ4UcHTZB/vCgMWF5sSVC3OAL100z6K0lyh6K/Uopu0qEupVv3v
         YG7vEr5tzISNubD9D+3R7Ngb+JvJU8LkicMi27IsJ3nz3olW4SszDgAdn2n9pLvxI80z
         gAVkMyrt5/ZUyjpGH8jjzhPqaOzFasN238KmgOEk9LtFbAzS5+sRjmvtteiPV+1sdxPd
         T4oa932XAPvlW2smtymGLiph5soLKs2yTaF3VkHvhwHoNX/nxIPH363g+Ifgg6xA+RhE
         SGifDgFK09EmgI9YYtzsGQZ6u9WvtN5io8iTPSkq93BD9xI9OwwJdwz9H/MByLkr2iGR
         r9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CB1G6dA0n1ljM6goecadWa4Juk/HG3B55pn9rtLr9y0=;
        b=FMoW9LEMoiQUZI7PiiXFjMM5iiDN1eVF3JM6OqOIEEj65kQx1h28MeD1r2yA1juqO1
         Qp5UvGbkxtKBNRnBt0n9I1wdbS2pbO1WDfZyRKd9ylSUYCA/C2t36rg0y3IRTnePWQt9
         BFIOoAf+ZTFax//YbJdVRnqkdKDJdr1maGACBVXuoATK5UEEajRUdSGAZj4jfu28I1PX
         zOzrEvt8gWC/jZhbBjqxq4YAq7COh7Vjb0JQdWxrproYHd6wfYVk+9Dseig4Vee+NnaO
         EmL8JbaFJwHCXHsNgk+0WeMV5RocASDEtE7M8eSIsDP3kR4F2poY3Rd4shWbXclIJfBD
         LJoA==
X-Gm-Message-State: ALoCoQl2TLSquBjfQPaD3lfmKnEDMvVm8KOorOFm3y604l28oon/BTETL4G48Uxv76WLd4Iy5q22
X-Received: by 10.42.240.82 with SMTP id kz18mr24421317icb.92.1431992175283;
 Mon, 18 May 2015 16:36:15 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 18 May 2015 16:36:15 -0700 (PDT)
In-Reply-To: <1431961571-20370-12-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269331>

On Mon, May 18, 2015 at 8:06 AM, Paul Tan <pyokagan@gmail.com> wrote:

> +enum rebase_type {
> +       REBASE_FALSE,
> +       REBASE_TRUE,
> +       REBASE_PRESERVE
> +};
> +
> +/**
> + * Parses the value of --rebase, branch.*.rebase or pull.rebase. If value is a
> + * false value, returns REBASE_FALSE. If value is a true value, returns
> + * REBASE_TRUE. If value is "preserve", returns REBASE_PRESERVE. Otherwise,
> + * returns -1 to signify an invalid value.
> + */
> +static int parse_config_rebase(const char *value)
> +{
> +       int v = git_config_maybe_bool("pull.rebase", value);
> +       if (v >= 0)
> +               return v;
> +       if (!strcmp(value, "preserve"))
> +               return REBASE_PRESERVE;
> +       return -1;

There is no REBASE_FALSE nor REBASE_TRUE in this function,
how do you make sure it returns the correct value then?

Currently this is probably in sync with what git_config_maybe_bool
returns, but think of a future refactoring/change. Then it will be hard
to have the connection between what the code in git_config_maybe_bool
does, what the code here does and the comment here.

You could get rid of the enum all together, as you're using integer as a
return type anyway. (so you lose type safety, a future change may introduce
a "return 42" which is not part of the enum)

Or you could convert the code to use the enum more strictly and having it
as the return type:

enum rebase_type parse_config_rebase(const char *value) {
    int v = git_config_maybe_bool("pull.rebase", value);
    switch (v) {
        case 0:
            return REBASE_FALSE;
        case 1:
            return REBASE_TRUE;
        default:
             if (!strcmp(value, "preserve"))
                return  REBASE_PRESERVE;
             else {
                die("value pull.rebase must be one of {false, true, preserve}");
                // or if you're more tolerant:
                return REBASE_VALUE_UNINTERPRETABLE;
       }
   }


> +}
> +
> +/**
> + * Callback for --rebase, which parses arg with parse_config_rebase().
> + */
> +static int parse_opt_rebase(const struct option *opt, const char *arg, int unset)
> +{
> +       int *value = (int*) opt->value;
> +
> +       if (arg)
> +               *value = parse_config_rebase(arg);
> +       else
> +               *value = unset ? REBASE_FALSE : REBASE_TRUE;
> +       return *value >= 0 ? 0 : -1;

This is repeating the check from above. If you'd go the way of using
stricter enums,
you'd just check for the REBASE_VALUE_UNINTERPRETABLE
value here.

> +}
> +
>  static const char * const pull_usage[] = {
>         N_("git pull [options] [<repo> [<refspec>...]]"),
>         NULL
> @@ -48,7 +84,8 @@ static const char * const pull_usage[] = {
>  static int opt_verbosity;
>  static char *opt_progress;
>
> -/* Options passed to git-merge */
> +/* Options passed to git-merge or git-rebase */
> +static int opt_rebase;
>  static char *opt_diffstat;
>  static char *opt_log;
>  static char *opt_squash;
> @@ -82,8 +119,12 @@ static struct option pull_options[] = {
>           N_("force progress reporting"),
>           PARSE_OPT_NOARG, parse_opt_passthru},
>
> -       /* Options passed to git-merge */
> +       /* Options passed to git-merge or git-rebase */
>         OPT_GROUP(N_("Options related to merging")),
> +       { OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
> +         N_("false|true|preserve"),
> +         N_("incorporate changes by rebasing rather than merging"),
> +         PARSE_OPT_OPTARG, parse_opt_rebase, 0},
>         { OPTION_CALLBACK, 'n', NULL, &opt_diffstat, NULL,
>           N_("do not show a diffstat at the end of the merge"),
>           PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_passthru, (intptr_t) "no-stat" },
> @@ -506,11 +547,185 @@ static int run_merge(void)
>         return ret;
>  }
>
> +/**
> + * Returns the merge branch for the current branch. Returns NULL if repo is not
> + * a valid remote, HEAD does not point to a branch, repo is not the branch's
> + * configured remote or the branch does not have any configured merge branch.
> + */
> +static char *get_merge_branch_1(const char *repo)
> +{
> +       struct remote *rm;
> +       struct branch *curr_branch;
> +
> +       if (repo && !(rm = remote_get(repo)))
> +               return NULL;
> +       if (!(curr_branch = branch_get("HEAD")))
> +               return NULL;
> +       if (repo && curr_branch->remote != rm)
> +               return NULL;
> +       if (!curr_branch->merge_nr)
> +               return NULL;
> +       return xstrdup(curr_branch->merge[0]->dst);
> +}

This feels a bit tangled because of the repetition of checking
for repo and curr_branch. Also we do not do assignments inside
of conditions (if, while, for), so maybe start with a

    if (!repo)
        return NULL;

and then do the assignments and test on the assigned value.

> +
> +/**
> + * Given a refspec, returns the merge branch. Returns NULL if the refspec src
> + * does not refer to a branch.
> + *
> + * FIXME: It should return the tracking branch. Currently only works with the
> + * default mapping.
> + */
> +static char *get_merge_branch_2(const char *repo, const char *refspec)
> +{
> +       struct refspec *spec;
> +       const char *remote;
> +       char *merge_branch;
> +
> +       spec = parse_fetch_refspec(1, &refspec);
> +       remote = spec->src;
> +       if (!*remote || !strcmp(remote, "HEAD"))
> +               remote = "HEAD";
> +       else if (skip_prefix(remote, "heads/", &remote))
> +               ;
> +       else if (skip_prefix(remote, "refs/heads/", &remote))
> +               ;
> +       else if (starts_with(remote, "refs/") ||
> +               starts_with(remote, "tags/") ||
> +               starts_with(remote, "remotes/"))
> +               remote = "";
> +
> +       if (*remote) {
> +               if (!strcmp(repo, "."))
> +                       merge_branch = mkpathdup("refs/heads/%s", remote);
> +               else
> +                       merge_branch = mkpathdup("refs/remotes/%s/%s", repo, remote);
> +       } else
> +               merge_branch = NULL;
> +
> +       free_refspec(1, spec);
> +       return merge_branch;
> +}
> +
> +/**
> + * Sets fork_point to the point at which the current branch forked from its
> + * remote merge branch. Returns 0 on success, -1 on failure.
> + */
> +static int get_rebase_fork_point(unsigned char fork_point[GIT_SHA1_RAWSZ],
> +               const char *repo, const char *refspec)
> +{
> +       int ret;
> +       struct branch *curr_branch;
> +       char *remote_merge_branch;
> +       struct argv_array args = ARGV_ARRAY_INIT;
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       if (!(curr_branch = branch_get("HEAD")))
> +               return -1;
> +
> +       if (refspec)
> +               remote_merge_branch = get_merge_branch_2(repo, refspec);
> +       else
> +               remote_merge_branch = get_merge_branch_1(repo);
> +
> +       if (!remote_merge_branch)
> +               return -1;
> +
> +       argv_array_pushl(&args, "merge-base", "--fork-point",
> +                       remote_merge_branch, curr_branch->name, NULL);
> +       cp.argv = args.argv;
> +       cp.no_stdin = 1;
> +       cp.no_stderr = 1;
> +       cp.git_cmd = 1;
> +
> +       if ((ret = capture_command(&cp, &sb, GIT_SHA1_HEXSZ)))
> +               goto cleanup;
> +
> +       if ((ret = get_sha1_hex(sb.buf, fork_point)))
> +               goto cleanup;
> +
> +cleanup:
> +       free(remote_merge_branch);
> +       strbuf_release(&sb);
> +       return ret ? -1 : 0;
> +}
> +
> +/**
> + * Sets merge_base to the octopus merge base of curr_head, merge_head and
> + * fork_point. Returns 0 if a merge base is found, 1 otherwise.
> + */
> +static int get_octopus_merge_base(unsigned char merge_base[GIT_SHA1_HEXSZ],
> +               unsigned char curr_head[GIT_SHA1_RAWSZ],
> +               unsigned char merge_head[GIT_SHA1_RAWSZ],
> +               unsigned char fork_point[GIT_SHA1_RAWSZ])
> +{
> +       struct commit_list *revs = NULL, *result;
> +
> +       commit_list_insert(lookup_commit_reference(curr_head), &revs);
> +       commit_list_insert(lookup_commit_reference(merge_head), &revs);
> +       if (!is_null_sha1(fork_point))
> +               commit_list_insert(lookup_commit_reference(fork_point), &revs);
> +
> +       result = reduce_heads(get_octopus_merge_bases(revs));
> +       free_commit_list(revs);
> +       if (!result)
> +               return 1;
> +
> +       hashcpy(merge_base, result->item->object.sha1);
> +       return 0;
> +}
> +
> +/**
> + * Given the current HEAD SHA1, the merge head returned from git-fetch and the
> + * fork point calculated by get_rebase_fork_point(), runs git-rebase with the
> + * appropriate arguments and returns its exit status.
> + */
> +static int run_rebase(unsigned char curr_head[GIT_SHA1_RAWSZ],
> +               unsigned char merge_head[GIT_SHA1_RAWSZ],
> +               unsigned char fork_point[GIT_SHA1_RAWSZ])
> +{
> +       int ret;
> +       unsigned char oct_merge_base[GIT_SHA1_RAWSZ];
> +       struct argv_array args = ARGV_ARRAY_INIT;
> +
> +       if (!get_octopus_merge_base(oct_merge_base, curr_head, merge_head, fork_point))
> +               if (!is_null_sha1(fork_point) && !hashcmp(oct_merge_base, fork_point))
> +                       hashclr(fork_point);
> +
> +       argv_array_push(&args, "rebase");
> +
> +       /* Shared options */
> +       argv_push_verbosity(&args);
> +
> +       /* Options passed to git-rebase */
> +       if (opt_rebase == REBASE_PRESERVE)
> +               argv_array_push(&args, "--preserve-merges");
> +       if (opt_diffstat)
> +               argv_array_push(&args, opt_diffstat);
> +       argv_push_strategies(&args);
> +       argv_push_strategy_opts(&args);
> +       if (opt_gpg_sign)
> +               argv_array_push(&args, opt_gpg_sign);
> +
> +       argv_array_push(&args, "--onto");
> +       argv_array_push(&args, sha1_to_hex(merge_head));
> +
> +       if (!is_null_sha1(fork_point))
> +               argv_array_push(&args, sha1_to_hex(fork_point));
> +       else
> +               argv_array_push(&args, sha1_to_hex(merge_head));
> +
> +       ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
> +       argv_array_clear(&args);
> +       return ret;
> +}
> +
>  int cmd_pull(int argc, const char **argv, const char *prefix)
>  {
>         const char *repo, **refspecs;
>         struct sha1_array merge_heads = SHA1_ARRAY_INIT;
>         unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
> +       unsigned char rebase_fork_point[GIT_SHA1_RAWSZ];
>
>         if (!getenv("GIT_REFLOG_ACTION"))
>                 set_reflog_message(argc, argv);
> @@ -532,6 +747,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>         if (get_sha1("HEAD", orig_head))
>                 hashclr(orig_head);
>
> +       if (opt_rebase)
> +               if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
> +                       hashclr(rebase_fork_point);
> +
>         if (run_fetch(repo, refspecs))
>                 return 1;
>
> @@ -573,6 +792,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                 if (merge_heads.nr > 1)
>                         die(_("Cannot merge multiple branches into empty head."));
>                 return pull_into_void(*merge_heads.sha1, curr_head);
> +       } else if (opt_rebase) {
> +               if (merge_heads.nr > 1)
> +                       die(_("Cannot rebase onto multiple branches."));
> +               return run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
>         } else
>                 return run_merge();
>  }
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 9414cc1..3798b96 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -212,7 +212,7 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
>         test "$(git rev-parse third)" = "$(git rev-parse second)"
>  '
>
> -test_expect_failure '--rebase' '
> +test_expect_success '--rebase' '
>         git branch to-rebase &&
>         echo modified again > file &&
>         git commit -m file file &&
> @@ -226,7 +226,7 @@ test_expect_failure '--rebase' '
>         test new = "$(git show HEAD:file2)"
>  '
>
> -test_expect_failure '--rebase fails with multiple branches' '
> +test_expect_success '--rebase fails with multiple branches' '
>         git reset --hard before-rebase &&
>         test_must_fail git pull --rebase . copy master 2>err &&
>         test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
> @@ -310,7 +310,7 @@ test_expect_failure 'pull.rebase=invalid fails' '
>         ! git pull . copy
>  '
>
> -test_expect_failure '--rebase=false create a new merge commit' '
> +test_expect_success '--rebase=false create a new merge commit' '
>         git reset --hard before-preserve-rebase &&
>         test_config pull.rebase true &&
>         git pull --rebase=false . copy &&
> @@ -319,7 +319,7 @@ test_expect_failure '--rebase=false create a new merge commit' '
>         test file3 = "$(git show HEAD:file3.t)"
>  '
>
> -test_expect_failure '--rebase=true rebases and flattens keep-merge' '
> +test_expect_success '--rebase=true rebases and flattens keep-merge' '
>         git reset --hard before-preserve-rebase &&
>         test_config pull.rebase preserve &&
>         git pull --rebase=true . copy &&
> @@ -327,7 +327,7 @@ test_expect_failure '--rebase=true rebases and flattens keep-merge' '
>         test file3 = "$(git show HEAD:file3.t)"
>  '
>
> -test_expect_failure '--rebase=preserve rebases and merges keep-merge' '
> +test_expect_success '--rebase=preserve rebases and merges keep-merge' '
>         git reset --hard before-preserve-rebase &&
>         test_config pull.rebase true &&
>         git pull --rebase=preserve . copy &&
> @@ -340,7 +340,7 @@ test_expect_success '--rebase=invalid fails' '
>         ! git pull --rebase=invalid . copy
>  '
>
> -test_expect_failure '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
> +test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
>         git reset --hard before-preserve-rebase &&
>         test_config pull.rebase preserve &&
>         git pull --rebase . copy &&
> @@ -348,7 +348,7 @@ test_expect_failure '--rebase overrides pull.rebase=preserve and flattens keep-m
>         test file3 = "$(git show HEAD:file3.t)"
>  '
>
> -test_expect_failure '--rebase with rebased upstream' '
> +test_expect_success '--rebase with rebased upstream' '
>
>         git remote add -f me . &&
>         git checkout copy &&
> @@ -366,7 +366,7 @@ test_expect_failure '--rebase with rebased upstream' '
>
>  '
>
> -test_expect_failure '--rebase with rebased default upstream' '
> +test_expect_success '--rebase with rebased default upstream' '
>
>         git update-ref refs/remotes/me/copy copy-orig &&
>         git checkout --track -b to-rebase2 me/copy &&
> @@ -377,7 +377,7 @@ test_expect_failure '--rebase with rebased default upstream' '
>
>  '
>
> -test_expect_failure 'rebased upstream + fetch + pull --rebase' '
> +test_expect_success 'rebased upstream + fetch + pull --rebase' '
>
>         git update-ref refs/remotes/me/copy copy-orig &&
>         git reset --hard to-rebase-orig &&
> @@ -409,7 +409,7 @@ test_expect_failure 'pull --rebase dies early with dirty working directory' '
>
>  '
>
> -test_expect_failure 'pull --rebase works on branch yet to be born' '
> +test_expect_success 'pull --rebase works on branch yet to be born' '
>         git rev-parse master >expect &&
>         mkdir empty_repo &&
>         (cd empty_repo &&
> @@ -456,14 +456,14 @@ test_expect_success 'setup for detecting upstreamed changes' '
>         )
>  '
>
> -test_expect_failure 'git pull --rebase detects upstreamed changes' '
> +test_expect_success 'git pull --rebase detects upstreamed changes' '
>         (cd dst &&
>          git pull --rebase &&
>          test -z "$(git ls-files -u)"
>         )
>  '
>
> -test_expect_failure 'setup for avoiding reapplying old patches' '
> +test_expect_success 'setup for avoiding reapplying old patches' '
>         (cd dst &&
>          test_might_fail git rebase --abort &&
>          git reset --hard origin/master
> @@ -485,7 +485,7 @@ test_expect_failure 'setup for avoiding reapplying old patches' '
>         )
>  '
>
> -test_expect_failure 'git pull --rebase does not reapply old patches' '
> +test_expect_success 'git pull --rebase does not reapply old patches' '
>         (cd dst &&
>          test_must_fail git pull --rebase &&
>          test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 4176e11..56e7377 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -19,7 +19,7 @@ test_expect_success 'git pull -q' '
>         test_must_be_empty out)
>  '
>
> -test_expect_failure 'git pull -q --rebase' '
> +test_expect_success 'git pull -q --rebase' '
>         mkdir clonedqrb &&
>         (cd clonedqrb && git init &&
>         git pull -q --rebase "../parent" >out 2>err &&
> @@ -38,7 +38,7 @@ test_expect_success 'git pull' '
>         test_must_be_empty out)
>  '
>
> -test_expect_failure 'git pull --rebase' '
> +test_expect_success 'git pull --rebase' '
>         mkdir clonedrb &&
>         (cd clonedrb && git init &&
>         git pull --rebase "../parent" >out 2>err &&
> @@ -54,7 +54,7 @@ test_expect_success 'git pull -v' '
>         test_must_be_empty out)
>  '
>
> -test_expect_failure 'git pull -v --rebase' '
> +test_expect_success 'git pull -v --rebase' '
>         mkdir clonedvrb &&
>         (cd clonedvrb && git init &&
>         git pull -v --rebase "../parent" >out 2>err &&
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 1ffd837..dda3929 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -11,8 +11,6 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
>
>  . ./test-lib.sh
>
> -skip_all='skipping submodule update tests, requires git pull --rebase'
> -test_done
>
>  compare_head()
>  {
> --
> 2.1.4
>
