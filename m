Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5225EC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKDBDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKDBD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:03:29 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A14C1EC53
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:03:25 -0700 (PDT)
Date:   Fri, 04 Nov 2022 01:03:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667523803; x=1667783003;
        bh=Pql34eLJJuLd6n+4bJD6FcYpLXQ6T6WHV+XjgMfKHME=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dQUo2CbsB57cX0UWFJIsWus7tGagvb76rm0OCvNTYgRb77muhtblry/mUgCDJ4Ydt
         PAwL3oWJYGj/xTxuCmJ8FQDYSDwFfxhGpAY7MTolDK4MVghwZXZFeSo8NXNpsS3rUK
         a9/7/TB96++lP8h6eKMkAacxtcXc2v6jGap5c0dvsXOqUsgVVnXTFZSVIEpyBl/my2
         8HqFRRggganMy0k9iTl5x7qi2zF+K92uSOkoTsLqRHRhBgq/ueow8MrNKDcdOEQRUR
         HGpg+uvqCbqI+AJlSljyB2KKhZP3KesP5gmkBlw9/xwr4MbT/MoxWuygJCy1veyEc2
         fX9PBMcyBhadA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>
Subject: [PATCH 3/4] worktree add: add --orphan flag
Message-ID: <20221104010242.11555-4-jacobabel@nullpo.dev>
In-Reply-To: <20221104010242.11555-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds support for creating an orphan branch when adding a new worktree.
This functionality is equivalent to git checkout's --orphan flag.

The original reason this feature was implemented was to allow a user
to initialise a new repository using solely the worktree oriented
workflow. Example usage included below.

$ GIT_DIR=3D".git" git init --bare
$ git worktree add --orphan master master/

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt | 18 ++++++++-
 builtin/worktree.c             | 68 +++++++++++++++++++++++++---------
 2 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 4dd658012b..92bd75564f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>=
]]
-=09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
+=09=09   [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
@@ -95,6 +95,17 @@ exist, a new branch based on `HEAD` is automatically cre=
ated as if
 `-b <branch>` was given.  If `<branch>` does exist, it will be checked out
 in the new worktree, if it's not checked out anywhere else, otherwise the
 command will refuse to create the worktree (unless `--force` is used).
++
+------------
+$ git worktree add --orphan <branch> <path> [<commit-ish>]
+------------
++
+Create a worktree containing an orphan branch named `<branch>` based
+on `<commit-ish>`. If `<commit-ish>` is not specified, the new orphan bran=
ch
+will be created based on `HEAD`.
++
+Note that unlike with `-b` or `-B`, this operation will succeed even if
+`<commit-ish>` is a branch that is currently checked out somewhere else.

 list::

@@ -222,6 +233,11 @@ This can also be set up as the default behaviour by us=
ing the
 =09With `prune`, do not remove anything; just report what it would
 =09remove.

+--orphan <new-branch>::
+=09With `add`, create a new orphan branch named `<new-branch>` in the new
+=09worktree based on `<commit-ish>`. If `<commit-ish>` is omitted, it
+=09defaults to `HEAD`.
+
 --porcelain::
 =09With `list`, output in an easy-to-parse format for scripts.
 =09This format will remain stable across Git versions and regardless of us=
er
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d40f771848..70f319a6b5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -17,7 +17,7 @@

 #define BUILTIN_WORKTREE_ADD_USAGE                                        =
                \
 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]\n" \
-=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]")
+=09   "                 [[-b | -B | --orphan] <new-branch>] <path> [<commi=
t-ish>]")
 #define BUILTIN_WORKTREE_LIST_USAGE \
 =09N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
@@ -90,6 +90,8 @@ struct add_opts {
 =09int detach;
 =09int quiet;
 =09int checkout;
+=09int implicit;
+=09const char *orphan_branch;
 =09const char *keep_locked;
 };

@@ -360,6 +362,8 @@ static int checkout_worktree(const struct add_opts *opt=
s,
 =09strvec_pushl(&cp.args, "checkout", "--no-recurse-submodules", NULL);
 =09if (opts->quiet)
 =09=09strvec_push(&cp.args, "--quiet");
+=09if (opts->orphan_branch)
+=09=09strvec_pushl(&cp.args, "--orphan", opts->orphan_branch, NULL);
 =09strvec_pushv(&cp.env, child_env->v);
 =09return run_command(&cp);
 }
@@ -393,7 +397,8 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09=09=09die_if_checked_out(symref.buf, 0);
 =09}
 =09commit =3D lookup_commit_reference_by_name(refname);
-=09if (!commit)
+
+=09if (!commit && !opts->implicit)
 =09=09die(_("invalid reference: %s"), refname);

 =09name =3D worktree_basename(path, &len);
@@ -482,10 +487,10 @@ static int add_worktree(const char *path, const char =
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
@@ -516,7 +521,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 =09 * Hook failure does not warrant worktree deletion, so run hook after
 =09 * is_junk is cleared, but do return appropriate code when hook fails.
 =09 */
-=09if (!ret && opts->checkout) {
+=09if (!ret && opts->checkout && !opts->orphan_branch) {
 =09=09struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;

 =09=09strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
@@ -608,33 +613,52 @@ static int add(int ac, const char **av, const char *p=
refix)
 =09const char *opt_track =3D NULL;
 =09const char *lock_reason =3D NULL;
 =09int keep_locked =3D 0;
+
 =09struct option options[] =3D {
-=09=09OPT__FORCE(&opts.force,
-=09=09=09   N_("checkout <branch> even if already checked out in other wor=
ktree"),
-=09=09=09   PARSE_OPT_NOCOMPLETE),
+=09=09OPT__FORCE(
+=09=09=09&opts.force,
+=09=09=09N_("checkout <branch> even if already checked out in other worktr=
ee"),
+=09=09=09PARSE_OPT_NOCOMPLETE),
 =09=09OPT_STRING('b', NULL, &new_branch, N_("branch"),
 =09=09=09   N_("create a new branch")),
 =09=09OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 =09=09=09   N_("create or reset a branch")),
-=09=09OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commi=
t")),
-=09=09OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working=
 tree")),
-=09=09OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree lock=
ed")),
+=09=09OPT_STRING(0, "orphan", &opts.orphan_branch, N_("branch"),
+=09=09=09   N_("create a new unparented branch")),
+=09=09OPT_BOOL('d', "detach", &opts.detach,
+=09=09=09 N_("detach HEAD at named commit")),
+=09=09OPT_BOOL(0, "checkout", &opts.checkout,
+=09=09=09 N_("populate the new working tree")),
+=09=09OPT_BOOL(0, "lock", &keep_locked,
+=09=09=09 N_("keep the new working tree locked")),
 =09=09OPT_STRING(0, "reason", &lock_reason, N_("string"),
 =09=09=09   N_("reason for locking")),
 =09=09OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 =09=09OPT_PASSTHRU(0, "track", &opt_track, NULL,
 =09=09=09     N_("set up tracking mode (see git-branch(1))"),
 =09=09=09     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
-=09=09OPT_BOOL(0, "guess-remote", &guess_remote,
-=09=09=09 N_("try to match the new branch name with a remote-tracking bran=
ch")),
+=09=09OPT_BOOL(
+=09=09=090, "guess-remote", &guess_remote,
+=09=09=09N_("try to match the new branch name with a remote-tracking branc=
h")),
 =09=09OPT_END()
 =09};

 =09memset(&opts, 0, sizeof(opts));
 =09opts.checkout =3D 1;
 =09ac =3D parse_options(ac, av, prefix, options, git_worktree_add_usage, 0=
);
-=09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
-=09=09die(_("options '%s', '%s', and '%s' cannot be used together"), "-b",=
 "-B", "--detach");
+
+=09opts.implicit =3D ac < 2;
+
+=09if (!!opts.detach + !!new_branch + !!new_branch_force +
+=09=09    !!opts.orphan_branch >
+=09    1)
+=09=09die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
+=09=09    "-b", "-B", "--orphan", "--detach");
+=09if (opts.orphan_branch && opt_track)
+=09=09die(_("'%s' cannot be used with '%s'"), "--orphan", "--track");
+=09if (opts.orphan_branch && !opts.checkout)
+=09=09die(_("'%s' cannot be used with '%s'"), "--orphan",
+=09=09    "--no-checkout");
 =09if (lock_reason && !keep_locked)
 =09=09die(_("the option '%s' requires '%s'"), "--reason", "--lock");
 =09if (lock_reason)
@@ -646,11 +670,16 @@ static int add(int ac, const char **av, const char *p=
refix)
 =09=09usage_with_options(git_worktree_add_usage, options);

 =09path =3D prefix_filename(prefix, av[0]);
-=09branch =3D ac < 2 ? "HEAD" : av[1];
+=09branch =3D opts.implicit ? "HEAD" : av[1];

 =09if (!strcmp(branch, "-"))
 =09=09branch =3D "@{-1}";

+=09/*
+=09 * From here on, new_branch will contain the branch to be checked out,
+=09 * and new_branch_force and opts.orphan_branch will tell us which one o=
f
+=09 * -b/-B/--orphan is being used.
+=09 */
 =09if (new_branch_force) {
 =09=09struct strbuf symref =3D STRBUF_INIT;

@@ -663,6 +692,11 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09=09strbuf_release(&symref);
 =09}

+=09if (opts.orphan_branch) {
+=09=09new_branch =3D opts.orphan_branch;
+=09=09opts.force =3D 1;
+=09}
+
 =09if (ac < 2 && !new_branch && !opts.detach) {
 =09=09const char *s =3D dwim_branch(path, &new_branch);
 =09=09if (s)
@@ -686,7 +720,7 @@ static int add(int ac, const char **av, const char *pre=
fix)
 =09if (!opts.quiet)
 =09=09print_preparing_worktree_line(opts.detach, branch, new_branch, !!new=
_branch_force);

-=09if (new_branch) {
+=09if (new_branch && !opts.orphan_branch) {
 =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
 =09=09cp.git_cmd =3D 1;
 =09=09strvec_push(&cp.args, "branch");
--
2.37.4


