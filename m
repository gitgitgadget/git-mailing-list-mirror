Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17385C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjDQJgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjDQJgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:36:10 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED92718
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:35:30 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:34:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681724080; x=1681983280;
        bh=JbBUitJyPqj5GuFTQaLxU6Twsk7ImRm/tFpKoiZaAtU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=wVj/W/mFE+FHTuzLGDuhAfJ4fzsrGFqLIBc69z256Fj/AwcqSmoZOvEuwKvlZEgst
         nuNHOyj7QaQQjJD0XAqidm2HsvPdLGU5JP3ddD67kY5a4aRdEFeG3xSqXmor8trgE5
         8X/mrQUPRbQ2nN7Jesx8oK4KWR9rx2IO/elDQSJjccg6doHjq/UH5fbE/HrKVU9Nk5
         NcmoPRUzeLEFYPv5vsq8qYT5KMhMIecQrBJLFEXhxj2qZpsdeXPfPuzSlrdfwZ42lE
         fejVqXLyzeFteIYHIf18NDj/h93NssYwdL+IR3BYNOdY9Y08cUcYEBLdyjYH2cay/H
         FgjNDrfqOqGHA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v9 7/8] worktree add: extend DWIM to infer --orphan
Message-ID: <20230417093255.31079-8-jacobabel@nullpo.dev>
In-Reply-To: <20230417093255.31079-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend DWIM to try to infer `--orphan` when in an empty repository. i.e.
a repository with an invalid/unborn HEAD, no local branches, and if
`--guess-remote` is used then no remote branches.

This behavior is equivalent to `git switch -c` or `git checkout -b` in
an empty repository.

Also warn the user (overriden with `-f`/`--force`) when they likely
intend to checkout a remote branch to the worktree but have not yet
fetched from the remote. i.e. when using `--guess-remote` and there is a
remote but no local or remote refs.

Current Behavior:
% git --no-pager branch --list --remotes
% git remote
origin
% git workree add ../main
hint: If you meant to create a worktree containing a new orphan branch
[...]
hint: Disable this message with "git config advice.worktreeAddOrphan false"
fatal: invalid reference: HEAD
% git workree add --guess-remote ../main
hint: If you meant to create a worktree containing a new orphan branch
[...]
hint: Disable this message with "git config advice.worktreeAddOrphan false"
fatal: invalid reference: HEAD
% git fetch --quiet
% git --no-pager branch --list --remotes
origin/HEAD -> origin/main
origin/main
% git workree add --guess-remote ../main
Preparing worktree (new branch 'main')
branch 'main' set up to track 'origin/main'.
HEAD is now at dadc8e6dac commit message
%

New Behavior:
% git --no-pager branch --list --remotes
% git remote
origin
% git workree add ../main
No possible source branch, inferring '--orphan'
Preparing worktree (new branch 'main')
% git worktree remove ../main
% git workree add --guess-remote ../main
fatal: No local or remote refs exist despite at least one remote
present, stopping; use 'add -f' to overide or fetch a remote first
% git workree add --guess-remote -f ../main
No possible source branch, inferring '--orphan'
Preparing worktree (new branch 'main')
% git worktree remove ../main
% git fetch --quiet
% git --no-pager branch --list --remotes
origin/HEAD -> origin/main
origin/main
% git workree add --guess-remote ../main
Preparing worktree (new branch 'main')
branch 'main' set up to track 'origin/main'.
HEAD is now at dadc8e6dac commit message
%

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt |  10 +
 builtin/worktree.c             | 114 ++++++++++-
 t/t2400-worktree-add.sh        | 332 +++++++++++++++++++++++++++++++++
 3 files changed, 455 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 485d865eb2..a4fbf5e838 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -95,6 +95,16 @@ exist, a new branch based on `HEAD` is automatically cre=
ated as if
 `-b <branch>` was given.  If `<branch>` does exist, it will be checked out
 in the new worktree, if it's not checked out anywhere else, otherwise the
 command will refuse to create the worktree (unless `--force` is used).
++
+If `<commit-ish>` is omitted, neither `--detach`, or `--orphan` is
+used, and there are no valid local branches (or remote branches if
+`--guess-remote` is specified) then, as a convenience, the new worktree is
+associated with a new orphan branch named `<branch>` (after
+`$(basename <path>)` if neither `-b` or `-B` is used) as if `--orphan` was
+passed to the command. In the event the repository has a remote and
+`--guess-remote` is used, but no remote or local branches exist, then the
+command fails with a warning reminding the user to fetch from their remote
+first (or override by using `-f/--force`).

 list::

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 12348d3d16..95b5bbb1d2 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -11,6 +11,7 @@
 #include "strvec.h"
 #include "branch.h"
 #include "refs.h"
+#include "remote.h"
 #include "run-command.h"
 #include "hook.h"
 #include "sigchain.h"
@@ -39,6 +40,9 @@
 #define BUILTIN_WORKTREE_UNLOCK_USAGE \
 =09N_("git worktree unlock <worktree>")

+#define WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT \
+=09_("No possible source branch, inferring '--orphan'")
+
 #define WORKTREE_ADD_ORPHAN_WITH_DASH_B_HINT_TEXT \
 =09_("If you meant to create a worktree containing a new orphan branch\n" =
\
 =09"(branch with no commits) for this repository, you can do so\n" \
@@ -612,6 +616,107 @@ static void print_preparing_worktree_line(int detach,
 =09}
 }

+/**
+ * Callback to short circuit iteration over refs on the first reference
+ * corresponding to a valid oid.
+ *
+ * Returns 0 on failure and non-zero on success.
+ */
+static int first_valid_ref(const char *refname,
+=09=09=09   const struct object_id *oid,
+=09=09=09   int flags,
+=09=09=09   void *cb_data)
+{
+=09return 1;
+}
+
+/**
+ * Verifies HEAD and determines whether there exist any valid local refere=
nces.
+ *
+ * - Checks whether HEAD points to a valid reference.
+ *
+ * - Checks whether any valid local branches exist.
+ *
+ * Returns 1 if any of the previous checks are true, otherwise returns 0.
+ */
+static int can_use_local_refs(const struct add_opts *opts)
+{
+=09if (head_ref(first_valid_ref, NULL)) {
+=09=09return 1;
+=09} else if (for_each_branch_ref(first_valid_ref, NULL)) {
+=09=09return 1;
+=09}
+=09return 0;
+}
+
+/**
+ * Reports whether the necessary flags were set and whether the repository=
 has
+ * remote references to attempt DWIM tracking of upstream branches.
+ *
+ * 1. Checks that `--guess-remote` was used or `worktree.guessRemote =3D t=
rue`.
+ *
+ * 2. Checks whether any valid remote branches exist.
+ *
+ * 3. Checks that there exists at least one remote and emits a warning/err=
or
+ *    if both checks 1. and 2. are false (can be bypassed with `--force`).
+ *
+ * Returns 1 if checks 1. and 2. are true, otherwise 0.
+ */
+static int can_use_remote_refs(const struct add_opts *opts)
+{
+=09if (!guess_remote) {
+=09=09if (!opts->quiet)
+=09=09=09fprintf_ln(stderr, WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT);
+=09=09return 0;
+=09} else if (for_each_remote_ref(first_valid_ref, NULL)) {
+=09=09return 1;
+=09} else if (!opts->force && remote_get(NULL)) {
+=09=09die(_("No local or remote refs exist despite at least one remote\n"
+=09=09      "present, stopping; use 'add -f' to overide or fetch a remote =
first"));
+=09} else if (!opts->quiet) {
+=09=09fprintf_ln(stderr, WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT);
+=09}
+=09return 0;
+}
+
+/**
+ * Determines whether `--orphan` should be inferred in the evaluation of
+ * `worktree add path/` or `worktree add -b branch path/` and emits an err=
or
+ * if the supplied arguments would produce an illegal combination  when th=
e
+ * `--orphan` flag is included.
+ *
+ * `opts` and `opt_track` contain the other options & flags supplied to th=
e
+ * command.
+ *
+ * remote determines whether to check `can_use_remote_refs()` or not. This
+ * is primarily to differentiate between the basic `add` DWIM and `add -b`=
.
+ *
+ * Returns 1 when inferring `--orphan`, 0 otherwise, and emits an error wh=
en
+ * `--orphan` is inferred but doing so produces an illegal combination of
+ * options and flags. Additionally produces an error when remote refs are
+ * checked and the repo is in a state that looks like the user added a rem=
ote
+ * but forgot to fetch (and did not override the warning with -f).
+ */
+static int dwim_orphan(const struct add_opts *opts, int opt_track, int rem=
ote)
+{
+=09if (can_use_local_refs(opts)) {
+=09=09return 0;
+=09} else if (remote && can_use_remote_refs(opts)) {
+=09=09return 0;
+=09} else if (!opts->quiet) {
+=09=09fprintf_ln(stderr, WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT);
+=09}
+
+=09if (opt_track) {
+=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan",
+=09=09    "--track");
+=09} else if (!opts->checkout) {
+=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan",
+=09=09    "--no-checkout");
+=09}
+=09return 1;
+}
+
 static const char *dwim_branch(const char *path, const char **new_branch)
 {
 =09int n;
@@ -722,12 +827,19 @@ static int add(int ac, const char **av, const char *p=
refix)
 =09=09int n;
 =09=09const char *s =3D worktree_basename(path, &n);
 =09=09new_branch =3D xstrndup(s, n);
-=09} else if (new_branch || opts.detach || opts.orphan) {
+=09} else if (opts.orphan || opts.detach) {
 =09=09// No-op
+=09} else if (ac < 2 && new_branch) {
+=09=09// DWIM: Infer --orphan when repo has no refs.
+=09=09opts.orphan =3D dwim_orphan(&opts, !!opt_track, 0);
 =09} else if (ac < 2) {
+=09=09// DWIM: Guess branch name from path.
 =09=09const char *s =3D dwim_branch(path, &new_branch);
 =09=09if (s)
 =09=09=09branch =3D s;
+
+=09=09// DWIM: Infer --orphan when repo has no refs.
+=09=09opts.orphan =3D (!s) && dwim_orphan(&opts, !!opt_track, 1);
 =09} else if (ac =3D=3D 2) {
 =09=09struct object_id oid;
 =09=09struct commit *commit;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 7ea56ef7c1..e5cca1d11b 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -712,6 +712,338 @@ test_expect_success 'git worktree --no-guess-remote o=
ption overrides config' '
 =09)
 '

+test_dwim_orphan () {
+=09local info_text=3D"No possible source branch, inferring '--orphan'" &&
+=09local fetch_error_text=3D"fatal: No local or remote refs exist despite =
at least one remote" &&
+=09local orphan_hint=3D"hint: If you meant to create a worktree containing=
 a new orphan branch" &&
+=09local invalid_ref_regex=3D"^fatal: invalid reference:\s\+.*" &&
+=09local bad_combo_regex=3D"^fatal: '[a-z-]\+' and '[a-z-]\+' cannot be us=
ed together" &&
+
+=09local git_ns=3D"repo" &&
+=09local dashc_args=3D"-C $git_ns" &&
+=09local use_cd=3D0 &&
+
+=09local bad_head=3D0 &&
+=09local empty_repo=3D1 &&
+=09local local_ref=3D0 &&
+=09local use_quiet=3D0 &&
+=09local remote=3D0 &&
+=09local remote_ref=3D0 &&
+=09local use_new_branch=3D0 &&
+
+=09local outcome=3D"$1" &&
+=09local outcome_text &&
+=09local success &&
+=09shift &&
+=09local args=3D"" &&
+=09local context=3D"" &&
+=09case "$outcome" in
+=09"infer")
+=09=09success=3D1 &&
+=09=09outcome_text=3D'"add" DWIM infer --orphan'
+=09=09;;
+=09"no_infer")
+=09=09success=3D1 &&
+=09=09outcome_text=3D'"add" DWIM doesnt infer --orphan'
+=09=09;;
+=09"fetch_error")
+=09=09success=3D0 &&
+=09=09outcome_text=3D'"add" error need fetch'
+=09=09;;
+=09"fatal_orphan_bad_combo")
+=09=09success=3D0 &&
+=09=09outcome_text=3D'"add" error inferred "--orphan" gives illegal opts c=
ombo'
+=09=09;;
+=09*)
+=09=09echo "test_dwim_orphan(): invalid outcome: '$outcome'" >&2 &&
+=09=09return 1
+=09=09;;
+=09esac &&
+=09while [ $# -gt 0 ]
+=09do
+=09=09case "$1" in
+=09=09# How and from where to create the worktree
+=09=09"-C_repo")
+=09=09=09use_cd=3D0 &&
+=09=09=09git_ns=3D"repo" &&
+=09=09=09dashc_args=3D"-C $git_ns" &&
+=09=09=09context=3D"$context, 'git -C repo'"
+=09=09=09;;
+=09=09"-C_wt")
+=09=09=09use_cd=3D0 &&
+=09=09=09git_ns=3D"wt" &&
+=09=09=09dashc_args=3D"-C $git_ns" &&
+=09=09=09context=3D"$context, 'git -C wt'"
+=09=09=09;;
+=09=09"cd_repo")
+=09=09=09use_cd=3D1 &&
+=09=09=09git_ns=3D"repo" &&
+=09=09=09dashc_args=3D"" &&
+=09=09=09context=3D"$context, 'cd repo && git'"
+=09=09=09;;
+=09=09"cd_wt")
+=09=09=09use_cd=3D1 &&
+=09=09=09git_ns=3D"wt" &&
+=09=09=09dashc_args=3D"" &&
+=09=09=09context=3D"$context, 'cd wt && git'"
+=09=09=09;;
+
+=09=09# Bypass the "pull first" warning
+=09=09"force")
+=09=09=09args=3D"$args --force" &&
+=09=09=09context=3D"$context, --force"
+=09=09=09;;
+
+=09=09# Try to use remote refs when DWIM
+=09=09"guess_remote")
+=09=09=09args=3D"$args --guess-remote" &&
+=09=09=09context=3D"$context, --guess-remote"
+=09=09=09;;
+=09=09"no_guess_remote")
+=09=09=09args=3D"$args --no-guess-remote" &&
+=09=09=09context=3D"$context, --no-guess-remote"
+=09=09=09;;
+
+=09=09# Whether there is at least one local branch present
+=09=09"local_ref")
+=09=09=09empty_repo=3D0 &&
+=09=09=09local_ref=3D1 &&
+=09=09=09context=3D"$context, >=3D1 local branches"
+=09=09=09;;
+=09=09"no_local_ref")
+=09=09=09empty_repo=3D0 &&
+=09=09=09context=3D"$context, 0 local branches"
+=09=09=09;;
+
+=09=09# Whether the HEAD points at a valid ref (skip this opt when no refs=
)
+=09=09"good_head")
+=09=09=09# requires: local_ref
+=09=09=09context=3D"$context, valid HEAD"
+=09=09=09;;
+=09=09"bad_head")
+=09=09=09bad_head=3D1 &&
+=09=09=09context=3D"$context, invalid (or orphan) HEAD"
+=09=09=09;;
+
+=09=09# Whether the code path is tested with the base add command or -b
+=09=09"no_-b")
+=09=09=09use_new_branch=3D0 &&
+=09=09=09context=3D"$context, no --branch"
+=09=09=09;;
+=09=09"-b")
+=09=09=09use_new_branch=3D1 &&
+=09=09=09context=3D"$context, --branch"
+=09=09=09;;
+
+=09=09# Whether to check that all output is suppressed (except errors)
+=09=09# or that the output is as expected
+=09=09"quiet")
+=09=09=09use_quiet=3D1 &&
+=09=09=09args=3D"$args --quiet" &&
+=09=09=09context=3D"$context, --quiet"
+=09=09=09;;
+=09=09"no_quiet")
+=09=09=09use_quiet=3D0 &&
+=09=09=09context=3D"$context, no --quiet (expect output)"
+=09=09=09;;
+
+=09=09# Whether there is at least one remote attached to the repo
+=09=09"remote")
+=09=09=09empty_repo=3D0 &&
+=09=09=09remote=3D1 &&
+=09=09=09context=3D"$context, >=3D1 remotes"
+=09=09=09;;
+=09=09"no_remote")
+=09=09=09empty_repo=3D0 &&
+=09=09=09remote=3D0 &&
+=09=09=09context=3D"$context, 0 remotes"
+=09=09=09;;
+
+=09=09# Whether there is at least one valid remote ref
+=09=09"remote_ref")
+=09=09=09# requires: remote
+=09=09=09empty_repo=3D0 &&
+=09=09=09remote_ref=3D1 &&
+=09=09=09context=3D"$context, >=3D1 fetched remote branches"
+=09=09=09;;
+=09=09"no_remote_ref")
+=09=09=09empty_repo=3D0 &&
+=09=09=09remote_ref=3D0 &&
+=09=09=09context=3D"$context, 0 fetched remote branches"
+=09=09=09;;
+
+=09=09# Options or flags that become illegal when --orphan is inferred
+=09=09"no_checkout")
+=09=09=09args=3D"$args --no-checkout" &&
+=09=09=09context=3D"$context, --no-checkout"
+=09=09=09;;
+=09=09"track")
+=09=09=09args=3D"$args --track" &&
+=09=09=09context=3D"$context, --track"
+=09=09=09;;
+
+=09=09# All other options are illegal
+=09=09*)
+=09=09=09echo "test_dwim_orphan(): invalid arg: '$1'" >&2 &&
+=09=09=09return 1
+=09=09=09;;
+=09=09esac &&
+=09=09shift
+=09done &&
+=09context=3D"${context#', '}" &&
+=09if [ $use_new_branch -eq 1 ]
+=09then
+=09=09args=3D"$args -b foo"
+=09else
+=09=09context=3D"DWIM (no --branch), $context"
+=09fi &&
+=09if [ $empty_repo -eq 1 ]
+=09then
+=09=09context=3D"empty repo, $context"
+=09fi &&
+=09args=3D"$args ../foo" &&
+=09context=3D"${context%', '}" &&
+=09test_expect_success "$outcome_text w/ $context" '
+=09=09test_when_finished "rm -rf repo" &&
+=09=09git init repo &&
+=09=09if [ $local_ref -eq 1 ] && [ "$git_ns" =3D "repo" ]
+=09=09then
+=09=09=09(cd repo && test_commit commit) &&
+=09=09=09if [ $bad_head -eq 1 ]
+=09=09=09then
+=09=09=09=09git -C repo symbolic-ref HEAD refs/heads/badbranch
+=09=09=09fi
+=09=09elif [ $local_ref -eq 1 ] && [ "$git_ns" =3D "wt" ]
+=09=09then
+=09=09=09test_when_finished "git -C repo worktree remove -f ../wt" &&
+=09=09=09git -C repo worktree add --orphan -b main ../wt &&
+=09=09=09(cd wt && test_commit commit) &&
+=09=09=09if [ $bad_head -eq 1 ]
+=09=09=09then
+=09=09=09=09git -C wt symbolic-ref HEAD refs/heads/badbranch
+=09=09=09fi
+=09=09elif [ $local_ref -eq 0 ] && [ "$git_ns" =3D "wt" ]
+=09=09then
+=09=09=09test_when_finished "git -C repo worktree remove -f ../wt" &&
+=09=09=09git -C repo worktree add --orphan -b orphanbranch ../wt
+=09=09fi &&
+
+=09=09if [ $remote -eq 1 ]
+=09=09then
+=09=09=09test_when_finished "rm -rf upstream" &&
+=09=09=09git init upstream &&
+=09=09=09(cd upstream && test_commit commit) &&
+=09=09=09git -C upstream switch -c foo &&
+=09=09=09git -C repo remote add upstream ../upstream
+=09=09fi &&
+
+=09=09if [ $remote_ref -eq 1 ]
+=09=09then
+=09=09=09git -C repo fetch
+=09=09fi &&
+=09=09if [ $success -eq 1 ]
+=09=09then
+=09=09=09test_when_finished git -C repo worktree remove ../foo
+=09=09fi &&
+=09=09if [ $use_cd -eq 1 ]
+=09=09then
+=09=09=09test_when_finished cat "$git_ns/actual" >&2
+=09=09else
+=09=09=09test_when_finished cat actual >&2
+=09=09fi &&
+=09=09(
+=09=09=09if [ $use_cd -eq 1 ]
+=09=09=09then
+=09=09=09=09cd $git_ns
+=09=09=09fi &&
+=09=09=09if [ "$outcome" =3D "infer" ]
+=09=09=09then
+=09=09=09=09git $dashc_args worktree add $args 2>actual &&
+=09=09=09=09if [ $use_quiet -eq 1 ]
+=09=09=09=09then
+=09=09=09=09=09test_must_be_empty actual
+=09=09=09=09else
+=09=09=09=09=09grep "$info_text" actual
+=09=09=09=09fi
+=09=09=09elif [ "$outcome" =3D "no_infer" ]
+=09=09=09then
+=09=09=09=09git $dashc_args worktree add $args 2>actual &&
+=09=09=09=09if [ $use_quiet -eq 1 ]
+=09=09=09=09then
+=09=09=09=09=09test_must_be_empty actual
+=09=09=09=09else
+=09=09=09=09=09! grep "$info_text" actual
+=09=09=09=09fi
+=09=09=09elif [ "$outcome" =3D "fetch_error" ]
+=09=09=09then
+=09=09=09=09test_must_fail git $dashc_args worktree add $args 2>actual &&
+=09=09=09=09grep "$fetch_error_text" actual
+=09=09=09elif [ "$outcome" =3D "fatal_orphan_bad_combo" ]
+=09=09=09then
+=09=09=09=09test_must_fail git $dashc_args worktree add $args 2>actual &&
+=09=09=09=09if [ $use_quiet -eq 1 ]
+=09=09=09=09then
+=09=09=09=09=09! grep "$info_text" actual
+=09=09=09=09else
+=09=09=09=09=09grep "$info_text" actual
+=09=09=09=09fi &&
+=09=09=09=09grep "$bad_combo_regex" actual
+=09=09=09elif [ "$outcome" =3D "warn_bad_head" ]
+=09=09=09then
+=09=09=09=09test_must_fail git $dashc_args worktree add $args 2>actual &&
+=09=09=09=09if [ $use_quiet -eq 1 ]
+=09=09=09=09then
+=09=09=09=09=09grep "$invalid_ref_regex" actual &&
+=09=09=09=09=09! grep "$orphan_hint" actual
+=09=09=09=09else
+=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --sq --path-format=
=3Dabsolute --git-path HEAD) &&
+=09=09=09=09=09headcontents=3D$(cat "$headpath") &&
+=09=09=09=09=09grep "HEAD points to an invalid (or orphaned) reference" ac=
tual &&
+=09=09=09=09=09grep "HEAD path:\s*.$headpath." actual &&
+=09=09=09=09=09grep "HEAD contents:\s*.$headcontents." actual &&
+=09=09=09=09=09grep "$orphan_hint" actual &&
+=09=09=09=09=09! grep "$info_text" actual
+=09=09=09=09fi &&
+=09=09=09=09grep "$invalid_ref_regex" actual
+=09=09=09else
+=09=09=09=09# Unreachable
+=09=09=09=09false
+=09=09=09fi
+=09=09) &&
+=09=09if [ $success -ne 1 ]
+=09=09then
+=09=09=09test_path_is_missing foo
+=09=09fi
+=09'
+}
+
+for quiet_mode in "no_quiet" "quiet"
+do
+=09for changedir_type in "cd_repo" "cd_wt" "-C_repo" "-C_wt"
+=09do
+=09=09dwim_test_args=3D"$quiet_mode $changedir_type"
+=09=09test_dwim_orphan 'infer' $dwim_test_args no_-b
+=09=09test_dwim_orphan 'no_infer' $dwim_test_args no_-b local_ref good_hea=
d
+=09=09test_dwim_orphan 'infer' $dwim_test_args no_-b no_local_ref no_remot=
e no_remote_ref no_guess_remote
+=09=09test_dwim_orphan 'infer' $dwim_test_args no_-b no_local_ref remote n=
o_remote_ref no_guess_remote
+=09=09test_dwim_orphan 'fetch_error' $dwim_test_args no_-b no_local_ref re=
mote no_remote_ref guess_remote
+=09=09test_dwim_orphan 'infer' $dwim_test_args no_-b no_local_ref remote n=
o_remote_ref guess_remote force
+=09=09test_dwim_orphan 'no_infer' $dwim_test_args no_-b no_local_ref remot=
e remote_ref guess_remote
+
+=09=09test_dwim_orphan 'infer' $dwim_test_args -b
+=09=09test_dwim_orphan 'no_infer' $dwim_test_args -b local_ref good_head
+=09=09test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref no_remote n=
o_remote_ref no_guess_remote
+=09=09test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref remote no_r=
emote_ref no_guess_remote
+=09=09test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref remote no_r=
emote_ref guess_remote
+=09=09test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref remote remo=
te_ref guess_remote
+=09done
+
+=09test_dwim_orphan 'fatal_orphan_bad_combo' $quiet_mode no_-b no_checkout
+=09test_dwim_orphan 'fatal_orphan_bad_combo' $quiet_mode no_-b track
+=09test_dwim_orphan 'fatal_orphan_bad_combo' $quiet_mode -b no_checkout
+=09test_dwim_orphan 'fatal_orphan_bad_combo' $quiet_mode -b track
+done
+
 post_checkout_hook () {
 =09test_when_finished "rm -rf .git/hooks" &&
 =09mkdir .git/hooks &&
--
2.39.2


