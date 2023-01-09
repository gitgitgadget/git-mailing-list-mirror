Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E0FC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 17:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjAIRdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbjAIRdf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 12:33:35 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDFD6171
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 09:33:33 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673285611; x=1673544811;
        bh=Bsg1wSBjW6zA5m4zbYJv6ykhJSDvX+1vga1nA6s4oss=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=V6/IMaFBShAyXACidpgvRhnv+zO54IGBV7glxzkJbn91K8naDh2wrgXRGSmGqyw8v
         dUVjZbtXpV/+mSDjsXCqw3VBjHtRlGY3rvWYP52qjjrPLmLI1CbFpT/4nOceudm91k
         LQsaaDXr0DvrnpQJNzclh8PRc0uFEEd3oDOg+T8aP5EOIPu8zWWDQOrbwHiEwzySMl
         AzUyL42cj8Zfgw9kbqTrcGXMWt0yU+gwHdjgdYE0GPyiHuktJhvzeTxsXeakL7ryJj
         qnDLIRu4yzx4SbvJKHfaLJaxmFabjFeFmH9FRfCrUMemZwhB2/HXK6t6WMDISAYyVv
         e61SUKToi1BtQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v8 3/4] worktree add: add --orphan flag
Message-ID: <20230109173227.29264-4-jacobabel@nullpo.dev>
In-Reply-To: <20230109173227.29264-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev> <20230109173227.29264-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds support for creating an orphan branch when adding a new worktree.
This functionality is equivalent to git switch's --orphan flag.

The original reason this feature was implemented was to allow a user
to initialise a new repository using solely the worktree oriented
workflow.

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
% git -C bar.git worktree add --orphan main main/
Preparing worktree (new branch 'main')
%

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt | 15 +++++++++
 builtin/worktree.c             | 59 ++++++++++++++++++++++++++++++----
 t/t2400-worktree-add.sh        | 53 ++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index b9c12779f1..d78460c29c 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,8 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>=
]]
 =09=09   [(-b | -B) <new-branch>] <path> [<commit-ish>]
+'git worktree add' [-f] [--lock [--reason <string>]]
+=09=09   --orphan <new-branch> <path>
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
@@ -95,6 +97,15 @@ exist, a new branch based on `HEAD` is automatically cre=
ated as if
 `-b <branch>` was given.  If `<branch>` does exist, it will be checked out
 in the new worktree, if it's not checked out anywhere else, otherwise the
 command will refuse to create the worktree (unless `--force` is used).
++
+------------
+$ git worktree add --orphan <branch> <path>
+------------
++
+Create a worktree containing no files, with an empty index, and associated
+with a new orphan branch named `<branch>`. The first commit made on this n=
ew
+branch will have no parents and will be the root of a new history disconne=
cted
+from any other branches.

 list::

@@ -222,6 +233,10 @@ This can also be set up as the default behaviour by us=
ing the
 =09With `prune`, do not remove anything; just report what it would
 =09remove.

+--orphan <new-branch>::
+=09With `add`, make the new worktree and index empty, associating
+=09the worktree with a new orphan branch named `<new-branch>`.
+
 --porcelain::
 =09With `list`, output in an easy-to-parse format for scripts.
 =09This format will remain stable across Git versions and regardless of us=
er
diff --git a/builtin/worktree.c b/builtin/worktree.c
index ddb33f48a0..ac82c5feda 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -17,7 +17,10 @@

 #define BUILTIN_WORKTREE_ADD_USAGE \
 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]\n" \
-=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>]")
+=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>]"), =
\
+=09N_("git worktree add [-f] [--lock [--reason <string>]]\n" \
+=09   "                 --orphan <new-branch> <path>")
+
 #define BUILTIN_WORKTREE_LIST_USAGE \
 =09N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
@@ -90,6 +93,7 @@ struct add_opts {
 =09int detach;
 =09int quiet;
 =09int checkout;
+=09int orphan;
 =09const char *keep_locked;
 };

@@ -364,6 +368,22 @@ static int checkout_worktree(const struct add_opts *op=
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
@@ -393,7 +413,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09=09=09die_if_checked_out(symref.buf, 0);
 =09}
 =09commit =3D lookup_commit_reference_by_name(refname);
-=09if (!commit)
+=09if (!commit && !opts->orphan)
 =09=09die(_("invalid reference: %s"), refname);

 =09name =3D worktree_basename(path, &len);
@@ -482,10 +502,10 @@ static int add_worktree(const char *path, const char =
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
@@ -497,6 +517,10 @@ static int add_worktree(const char *path, const char *=
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
@@ -516,7 +540,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09 * Hook failure does not warrant worktree deletion, so run hook after
 =09 * is_junk is cleared, but do return appropriate code when hook fails.
 =09 */
-=09if (!ret && opts->checkout) {
+=09if (!ret && opts->checkout && !opts->orphan) {
 =09=09struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;

 =09=09strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
@@ -605,6 +629,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 =09char *path;
 =09const char *branch;
 =09const char *new_branch =3D NULL;
+=09const char *orphan_branch =3D NULL;
 =09const char *opt_track =3D NULL;
 =09const char *lock_reason =3D NULL;
 =09int keep_locked =3D 0;
@@ -616,6 +641,8 @@ static int add(int ac, const char **av, const char *pre=
fix)
 =09=09=09   N_("create a new branch")),
 =09=09OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 =09=09=09   N_("create or reset a branch")),
+=09=09OPT_STRING(0, "orphan", &orphan_branch, N_("branch"),
+=09=09=09   N_("new unparented branch")),
 =09=09OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commi=
t")),
 =09=09OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working=
 tree")),
 =09=09OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree lock=
ed")),
@@ -633,8 +660,20 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09memset(&opts, 0, sizeof(opts));
 =09opts.checkout =3D 1;
 =09ac =3D parse_options(ac, av, prefix, options, git_worktree_add_usage, 0=
);
+=09opts.orphan =3D !!orphan_branch;
 =09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 =09=09die(_("options '%s', '%s', and '%s' cannot be used together"), "-b",=
 "-B", "--detach");
+=09if (!!opts.detach + !!opts.orphan + !!new_branch + !!new_branch_force >=
 1)
+=09=09die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
+=09=09    "-b", "-B", "--orphan", "--detach");
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
@@ -663,7 +702,9 @@ static int add(int ac, const char **av, const char *pre=
fix)
 =09=09strbuf_release(&symref);
 =09}

-=09if (ac < 2 && !new_branch && !opts.detach) {
+=09if (opts.orphan) {
+=09=09new_branch =3D orphan_branch;
+=09} else if (ac < 2 && !new_branch && !opts.detach) {
 =09=09const char *s =3D dwim_branch(path, &new_branch);
 =09=09if (s)
 =09=09=09branch =3D s;
@@ -686,7 +727,11 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09if (!opts.quiet)
 =09=09print_preparing_worktree_line(opts.detach, branch, new_branch, !!new=
_branch_force);

-=09if (new_branch) {
+=09if (opts.orphan) {
+=09=09branch =3D new_branch;
+=09} else if (!lookup_commit_reference_by_name(branch)) {
+=09=09die(_("invalid reference: %s"), branch);
+=09} else if (new_branch) {
 =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
 =09=09cp.git_cmd =3D 1;
 =09=09strvec_push(&cp.args, "branch");
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index dd729a00d8..45f896dcd0 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -312,6 +312,11 @@ test_wt_add_excl () {
 test_wt_add_excl -b poodle -B poodle bamboo main
 test_wt_add_excl -b poodle --detach bamboo main
 test_wt_add_excl -B poodle --detach bamboo main
+test_wt_add_excl -B poodle --orphan poodle bamboo
+test_wt_add_excl -b poodle --orphan poodle bamboo
+test_wt_add_excl --orphan poodle --detach bamboo
+test_wt_add_excl --orphan poodle --no-checkout bamboo
+test_wt_add_excl --orphan poodle bamboo main

 test_expect_success '"add -B" fails if the branch is checked out' '
 =09git rev-parse newmain >before &&
@@ -333,6 +338,46 @@ test_expect_success 'add --quiet' '
 =09test_must_be_empty actual
 '

+test_expect_success '"add --orphan"' '
+=09test_when_finished "git worktree remove -f -f orphandir" &&
+=09git worktree add --orphan neworphan orphandir &&
+=09echo refs/heads/neworphan >expected &&
+=09git -C orphandir symbolic-ref HEAD >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success '"add --orphan" fails if the branch already exists' '
+=09test_when_finished "git branch -D existingbranch" &&
+=09test_when_finished "git worktree remove -f -f orphandir" &&
+=09git worktree add -b existingbranch orphandir main &&
+=09test_must_fail git worktree add --orphan existingbranch orphandir2 &&
+=09test_path_is_missing orphandir2
+'
+
+test_expect_success '"add --orphan" with empty repository' '
+=09test_when_finished "rm -rf empty_repo" &&
+=09echo refs/heads/newbranch >expected &&
+=09GIT_DIR=3D"empty_repo" git init --bare &&
+=09git -C empty_repo  worktree add --orphan newbranch worktreedir &&
+=09git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
+=09test_cmp expected actual
+'
+
+test_expect_success '"add" worktree with orphan branch and lock' '
+=09git worktree add --lock --orphan orphanbr orphan-with-lock &&
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
@@ -449,6 +494,14 @@ setup_remote_repo () {
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
2.38.2


