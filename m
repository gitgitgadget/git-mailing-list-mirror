Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85869C77B70
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjDQJgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDQJf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:35:59 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A56192
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:35:21 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681724064; x=1681983264;
        bh=kUNuR7Ky1YOtdKTE2BNyvfMKVcILyKgWzDpanSaQovw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=IQKmzapLRRVVz9/DqGkBNEb0fW9ucjHFDJpvvwntM2uA/aLOlDE+2QZNsiq3P9Hbr
         749qMpgFde8vFwZZWc5eBObsQgPsni40AUD97TJvab1rI/Rh9Qzk3ar+CRKNx9A2Ig
         quVFWQ2p1EB6GZAFmMeC8jFBdZF5YeknC0zatC2FMzuT8W4jgIBJGWcMXqPQlbgCJV
         WDhF6S5K41DC9Ot7IPqUbAMpVHxMXhxvW4ABXPr1tV+UIfZmHGWFxHVJqLX9fFiPLu
         1sePk0JQ7pynaBF7BHnPCJsCnmxM9ebQV4xhBAs/pIndzg25UXAMMLTRnduhStAiFQ
         I6SdQr25Mt5oA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v9 5/8] worktree add: add --orphan flag
Message-ID: <20230417093255.31079-6-jacobabel@nullpo.dev>
In-Reply-To: <20230417093255.31079-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for creating an orphan branch when adding a new worktree.
The functionality of this flag is equivalent to git switch's --orphan
option.

Current Behavior:
% git -C foo.git --no-pager branch -l
+ main
% git -C foo.git worktree add main/
Preparing worktree (new branch 'main')
HEAD is now at 6c93a75 a commit
%

% git init bar.git
Initialized empty Git repository in /path/to/bar.git/
% git -C bar.git --no-pager branch -l

% git -C bar.git worktree add main/
Preparing worktree (new branch 'main')
fatal: not a valid object name: 'HEAD'
%

New Behavior:

% git -C foo.git --no-pager branch -l
+ main
% git -C foo.git worktree add main/
Preparing worktree (new branch 'main')
HEAD is now at 6c93a75 a commit
%

% git init --bare bar.git
Initialized empty Git repository in /path/to/bar.git/
% git -C bar.git --no-pager branch -l

% git -C bar.git worktree add main/
Preparing worktree (new branch 'main')
fatal: invalid reference: HEAD
% git -C bar.git worktree add --orphan -b main/
Preparing worktree (new branch 'main')
% git -C bar.git worktree add --orphan -b newbranch worktreedir/
Preparing worktree (new branch 'newbranch')
%

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt |  6 ++-
 builtin/worktree.c             | 67 +++++++++++++++++++++++++++------
 t/t2400-worktree-add.sh        | 69 ++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index b9c12779f1..485d865eb2 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>=
]]
-=09=09   [(-b | -B) <new-branch>] <path> [<commit-ish>]
+=09=09   [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
@@ -222,6 +222,10 @@ This can also be set up as the default behaviour by us=
ing the
 =09With `prune`, do not remove anything; just report what it would
 =09remove.

+--orphan::
+=09With `add`, make the new worktree and index empty, associating
+=09the worktree with a new orphan/unborn branch named `<new-branch>`.
+
 --porcelain::
 =09With `list`, output in an easy-to-parse format for scripts.
 =09This format will remain stable across Git versions and regardless of us=
er
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d1b4b53f2c..48de7fc3b0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -22,7 +22,8 @@

 #define BUILTIN_WORKTREE_ADD_USAGE \
 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]\n" \
-=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>]")
+=09   "                 [--orphan] [(-b | -B) <new-branch>] <path> [<commi=
t-ish>]")
+
 #define BUILTIN_WORKTREE_LIST_USAGE \
 =09N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
@@ -95,6 +96,7 @@ struct add_opts {
 =09int detach;
 =09int quiet;
 =09int checkout;
+=09int orphan;
 =09const char *keep_locked;
 };

@@ -368,6 +370,22 @@ static int checkout_worktree(const struct add_opts *op=
ts,
 =09return run_command(&cp);
 }

+static int make_worktree_orphan(const char * ref, const struct add_opts *o=
pts,
+=09=09=09=09struct strvec *child_env)
+{
+=09struct strbuf symref =3D STRBUF_INIT;
+=09struct child_process cp =3D CHILD_PROCESS_INIT;
+
+=09validate_new_branchname(ref, &symref, 0);
+=09strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
+=09if (opts->quiet)
+=09=09strvec_push(&cp.args, "--quiet");
+=09strvec_pushv(&cp.env, child_env->v);
+=09strbuf_release(&symref);
+=09cp.git_cmd =3D 1;
+=09return run_command(&cp);
+}
+
 static int add_worktree(const char *path, const char *refname,
 =09=09=09const struct add_opts *opts)
 {
@@ -397,7 +415,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09=09=09die_if_checked_out(symref.buf, 0);
 =09}
 =09commit =3D lookup_commit_reference_by_name(refname);
-=09if (!commit)
+=09if (!commit && !opts->orphan)
 =09=09die(_("invalid reference: %s"), refname);

 =09name =3D worktree_basename(path, &len);
@@ -486,10 +504,10 @@ static int add_worktree(const char *path, const char =
*refname,
 =09strvec_pushf(&child_env, "%s=3D%s", GIT_WORK_TREE_ENVIRONMENT, path);
 =09cp.git_cmd =3D 1;

-=09if (!is_branch)
+=09if (!is_branch && commit) {
 =09=09strvec_pushl(&cp.args, "update-ref", "HEAD",
 =09=09=09     oid_to_hex(&commit->object.oid), NULL);
-=09else {
+=09} else {
 =09=09strvec_pushl(&cp.args, "symbolic-ref", "HEAD",
 =09=09=09     symref.buf, NULL);
 =09=09if (opts->quiet)
@@ -501,6 +519,10 @@ static int add_worktree(const char *path, const char *=
refname,
 =09if (ret)
 =09=09goto done;

+=09if (opts->orphan &&
+=09    (ret =3D make_worktree_orphan(refname, opts, &child_env)))
+=09=09goto done;
+
 =09if (opts->checkout &&
 =09    (ret =3D checkout_worktree(opts, &child_env)))
 =09=09goto done;
@@ -520,7 +542,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09 * Hook failure does not warrant worktree deletion, so run hook after
 =09 * is_junk is cleared, but do return appropriate code when hook fails.
 =09 */
-=09if (!ret && opts->checkout) {
+=09if (!ret && opts->checkout && !opts->orphan) {
 =09=09struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;

 =09=09strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
@@ -568,7 +590,7 @@ static void print_preparing_worktree_line(int detach,
 =09=09else {
 =09=09=09struct commit *commit =3D lookup_commit_reference_by_name(branch)=
;
 =09=09=09if (!commit)
-=09=09=09=09die(_("invalid reference: %s"), branch);
+=09=09=09=09BUG(_("unreachable: invalid reference: %s"), branch);
 =09=09=09fprintf_ln(stderr, _("Preparing worktree (detached HEAD %s)"),
 =09=09=09=09  repo_find_unique_abbrev(the_repository, &commit->object.oid,=
 DEFAULT_ABBREV));
 =09=09}
@@ -620,6 +642,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 =09=09=09   N_("create a new branch")),
 =09=09OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 =09=09=09   N_("create or reset a branch")),
+=09=09OPT_BOOL(0, "orphan", &opts.orphan, N_("create unborn/orphaned branc=
h")),
 =09=09OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commi=
t")),
 =09=09OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working=
 tree")),
 =09=09OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree lock=
ed")),
@@ -640,6 +663,17 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09ac =3D parse_options(ac, av, prefix, options, git_worktree_add_usage, 0=
);
 =09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 =09=09die(_("options '%s', '%s', and '%s' cannot be used together"), "-b",=
 "-B", "--detach");
+=09if (opts.detach && opts.orphan)
+=09=09die(_("options '%s', and '%s' cannot be used together"),
+=09=09    "--orphan", "--detach");
+=09if (opts.orphan && opt_track)
+=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan", "--track=
");
+=09if (opts.orphan && !opts.checkout)
+=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan",
+=09=09    "--no-checkout");
+=09if (opts.orphan && ac =3D=3D 2)
+=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan",
+=09=09    _("<commit-ish>"));
 =09if (lock_reason && !keep_locked)
 =09=09die(_("the option '%s' requires '%s'"), "--reason", "--lock");
 =09if (lock_reason)
@@ -668,13 +702,17 @@ static int add(int ac, const char **av, const char *p=
refix)
 =09=09strbuf_release(&symref);
 =09}

-=09if (ac < 2 && !new_branch && !opts.detach) {
+=09if (opts.orphan && !new_branch) {
+=09=09int n;
+=09=09const char *s =3D worktree_basename(path, &n);
+=09=09new_branch =3D xstrndup(s, n);
+=09} else if (new_branch || opts.detach || opts.orphan) {
+=09=09// No-op
+=09} else if (ac < 2) {
 =09=09const char *s =3D dwim_branch(path, &new_branch);
 =09=09if (s)
 =09=09=09branch =3D s;
-=09}
-
-=09if (ac =3D=3D 2 && !new_branch && !opts.detach) {
+=09} else if (ac =3D=3D 2) {
 =09=09struct object_id oid;
 =09=09struct commit *commit;
 =09=09const char *remote;
@@ -688,10 +726,17 @@ static int add(int ac, const char **av, const char *p=
refix)
 =09=09=09}
 =09=09}
 =09}
+
+=09if (!opts.orphan && !lookup_commit_reference_by_name(branch)) {
+=09=09die(_("invalid reference: %s"), branch);
+=09}
+
 =09if (!opts.quiet)
 =09=09print_preparing_worktree_line(opts.detach, branch, new_branch, !!new=
_branch_force);

-=09if (new_branch) {
+=09if (opts.orphan) {
+=09=09branch =3D new_branch;
+=09} else if (new_branch) {
 =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
 =09=09cp.git_cmd =3D 1;
 =09=09strvec_push(&cp.args, "branch");
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 18831c4d93..2ea4342867 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -313,6 +313,10 @@ test_wt_add_excl () {
 test_wt_add_excl -b poodle -B poodle bamboo main
 test_wt_add_excl -b poodle --detach bamboo main
 test_wt_add_excl -B poodle --detach bamboo main
+test_wt_add_excl --orphan --detach bamboo
+test_wt_add_excl --orphan --no-checkout bamboo
+test_wt_add_excl --orphan bamboo main
+test_wt_add_excl --orphan -b bamboo wtdir/ main

 test_expect_success '"add -B" fails if the branch is checked out' '
 =09git rev-parse newmain >before &&
@@ -344,6 +348,63 @@ test_expect_success 'add --quiet -b' '
 =09test_must_be_empty actual
 '

+test_expect_success '"add --orphan"' '
+=09test_when_finished "git worktree remove -f -f orphandir" &&
+=09git worktree add --orphan -b neworphan orphandir &&
+=09echo refs/heads/neworphan >expected &&
+=09git -C orphandir symbolic-ref HEAD >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success '"add --orphan (no -b)"' '
+=09test_when_finished "git worktree remove -f -f neworphan" &&
+=09git worktree add --orphan neworphan &&
+=09echo refs/heads/neworphan >expected &&
+=09git -C neworphan symbolic-ref HEAD >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success '"add --orphan --quiet"' '
+=09test_when_finished "git worktree remove -f -f orphandir" &&
+=09test_when_finished cat log.actual >&2 &&
+=09git worktree add --quiet --orphan -b neworphan orphandir 2>log.actual &=
&
+=09test_must_be_empty log.actual &&
+=09echo refs/heads/neworphan >expected &&
+=09git -C orphandir symbolic-ref HEAD >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success '"add --orphan" fails if the branch already exists' '
+=09test_when_finished "git branch -D existingbranch" &&
+=09git worktree add -b existingbranch orphandir main &&
+=09git worktree remove orphandir &&
+=09test_must_fail git worktree add --orphan -b existingbranch orphandir
+'
+
+test_expect_success '"add --orphan" with empty repository' '
+=09test_when_finished "rm -rf empty_repo" &&
+=09echo refs/heads/newbranch >expected &&
+=09GIT_DIR=3D"empty_repo" git init --bare &&
+=09git -C empty_repo  worktree add --orphan -b newbranch worktreedir &&
+=09git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success '"add" worktree with orphan branch and lock' '
+=09git worktree add --lock --orphan -b orphanbr orphan-with-lock &&
+=09test_when_finished "git worktree unlock orphan-with-lock || :" &&
+=09test -f .git/worktrees/orphan-with-lock/locked
+'
+
+test_expect_success '"add" worktree with orphan branch, lock, and reason' =
'
+=09lock_reason=3D"why not" &&
+=09git worktree add --detach --lock --reason "$lock_reason" orphan-with-lo=
ck-reason main &&
+=09test_when_finished "git worktree unlock orphan-with-lock-reason || :" &=
&
+=09test -f .git/worktrees/orphan-with-lock-reason/locked &&
+=09echo "$lock_reason" >expect &&
+=09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
+'
+
 test_expect_success 'local clone from linked checkout' '
 =09git clone --local here here-clone &&
 =09( cd here-clone && git fsck )
@@ -460,6 +521,14 @@ setup_remote_repo () {
 =09)
 }

+test_expect_success '"add" <path> <remote/branch> w/ no HEAD' '
+=09test_when_finished rm -rf repo_upstream repo_local foo &&
+=09setup_remote_repo repo_upstream repo_local &&
+=09git -C repo_local config --bool core.bare true &&
+=09git -C repo_local branch -D main &&
+=09git -C repo_local worktree add ./foo repo_upstream/foo
+'
+
 test_expect_success '--no-track avoids setting up tracking' '
 =09test_when_finished rm -rf repo_upstream repo_local foo &&
 =09setup_remote_repo repo_upstream repo_local &&
--
2.39.2


