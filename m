Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38255C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 02:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiLTChd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 21:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTCh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 21:37:29 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A50F11835
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 18:37:27 -0800 (PST)
Date:   Tue, 20 Dec 2022 02:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1671503844; x=1671763044;
        bh=v4RFosWqicOHbWEAQT7i3kQ2/QWGuAI95QRf2Wxbx3g=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=L5tGQptvlFNqjwLrSbZ3BtWOoEV/87TUEXO32wK8bn3BrL5o7/Q2gUuESaa4XkxDq
         jw3CxNNci8jveTAXfzhMlDj41QIOBPN36SF2RutYqdRD8tVv8t56A6eVeu9Bw71FfF
         Fn2PzH906MEnhesI9UlnFCQ/mbyJmz/hw0eW366VJ4EJweXTxcar9GiC56CjyOBQpo
         YCbVU8qv4Q/tgbXm4KvfAwrc5RSDypAPWMSjXpBgaAp52N+Bi/wKHDq33f/MA1S8gK
         boTkerH/zdpQRVOgKFNJddEcI2R9IvqF//a1+TqHOj97mldItpFp6NhMXUgdnq9MR5
         Tn1Vvg1nX+B2Q==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v5 0/4] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221220023637.29042-1-jacobabel@nullpo.dev>
In-Reply-To: <20221212014003.20290-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working with the worktree based git workflow, I realised that setting
up a new git repository required switching between the traditional and
worktree based workflows. Searching online I found a SO answer [1] which
seemed to support this and which indicated that adding support for this sho=
uld
not be technically difficult.

This patchset has four parts:
  * adding `-B` to the usage docs (noticed during dev and it seemed too sma=
ll
    to justify a separate submission)
  * adding a helper fn to simplify testing for mutual exclusion of options
    in `t/t2400-worktree-add.sh`
  * adding orphan branch functionality (as is present in `git-switch`)
    to `git-worktree-add`
  * adding an advise for using --orphan when `git worktree add` fails due t=
o
    a bad ref.

Changes from v4:

  * Removed redundant var `ret` from `make_worktree_orphan()` [2].
  * Separate vars and decls in `make_worktree_orphan()` [2].
  * Remove accidental `if () {}` diff-noise [2].
  * Remove redundant comment regarding `new_branch_force` [2].
  * Remove redundant comment when `branch` is a bad ref [2].
  * Simplify mutual-exclusion-of-opts testing in t2400 w/
    `test_wt_add_empty_repo_orphan_hint()` helper fn [2].
  * Remove duplicate `-B --detach` exclusion test [3].
  * Remove redundant comment in `test_wt_add_empty_repo_orphan_hint()`
    in t2400 [4].
  * Move test path into `test_wt_add_empty_repo_orphan_hint()` to simplify
    commands [4].
  * Replace added bash-ism with shell syntax [4].
  * Remove confusing `e.g. %s` from advise [4].
  * Reflow advise text [5].
  * Add translation macro `_()` to advise text [5].

1. https://stackoverflow.com/a/68717229/15064705/
2. https://lore.kernel.org/git/221212.86tu2158bz.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/20221212145515.pohzoyllo3bgz7eb@phi/
4. https://lore.kernel.org/git/221212.86pmcp57w4.gmgdl@evledraar.gmail.com/
5. https://lore.kernel.org/git/221212.86zgbs4h9f.gmgdl@evledraar.gmail.com/

Jacob Abel (4):
  worktree add: Include -B in usage docs
  worktree add: refactor opt exclusion tests
  worktree add: add --orphan flag
  worktree add: Add hint to use --orphan when bad ref

 Documentation/config/advice.txt |  4 ++
 Documentation/git-worktree.txt  | 17 ++++++-
 advice.c                        |  1 +
 advice.h                        |  1 +
 builtin/worktree.c              | 65 +++++++++++++++++++++---
 t/t2400-worktree-add.sh         | 89 +++++++++++++++++++++++++++++----
 6 files changed, 159 insertions(+), 18 deletions(-)

Range-diff against v4:
1:  f35d78cfb4 =3D 1:  05371640ad worktree add: Include -B in usage docs
-:  ---------- > 2:  3d8b26f9d6 worktree add: refactor opt exclusion tests
2:  8b1cdf1322 ! 3:  ccae9cec2e worktree add: add --orphan flag
    @@ builtin/worktree.c: static int checkout_worktree(const struct add_op=
ts *opts,
     +static int make_worktree_orphan(const char * ref, const struct add_op=
ts *opts,
     +=09=09=09=09struct strvec *child_env)
     +{
    -+=09int ret;
     +=09struct strbuf symref =3D STRBUF_INIT;
     +=09struct child_process cp =3D CHILD_PROCESS_INIT;
    -+=09cp.git_cmd =3D 1;
     +
     +=09validate_new_branchname(ref, &symref, 0);
     +=09strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
     +=09if (opts->quiet)
     +=09=09strvec_push(&cp.args, "--quiet");
     +=09strvec_pushv(&cp.env, child_env->v);
    -+=09ret =3D run_command(&cp);
     +=09strbuf_release(&symref);
    -+=09return ret;
    ++=09cp.git_cmd =3D 1;
    ++=09return run_command(&cp);
     +}
     +
      static int add_worktree(const char *path, const char *refname,
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
      =09}
      =09commit =3D lookup_commit_reference_by_name(refname);
     -=09if (!commit)
    -+=09if (!commit && !opts->orphan) {
    ++=09if (!commit && !opts->orphan)
      =09=09die(_("invalid reference: %s"), refname);
    -+=09}

      =09name =3D worktree_basename(path, &len);
    - =09strbuf_add(&sb, name, path + len - name);
     @@ builtin/worktree.c: static int add_worktree(const char *path, const=
 char *refname,
      =09strvec_pushf(&child_env, "%s=3D%s", GIT_WORK_TREE_ENVIRONMENT, pat=
h);
      =09cp.git_cmd =3D 1;
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09if (lock_reason && !keep_locked)
      =09=09die(_("the option '%s' requires '%s'"), "--reason", "--lock");
      =09if (lock_reason)
    -@@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    - =09if (!strcmp(branch, "-"))
    - =09=09branch =3D "@{-1}";
    -
    -+=09/*
    -+=09 * When creating a new branch, new_branch now contains the branch =
to
    -+=09 * create.
    -+=09 *
    -+=09 * Past this point, new_branch_force can be treated solely as a
    -+=09 * boolean flag to indicate whether `-B` was selected.
    -+=09 */
    - =09if (new_branch_force) {
    - =09=09struct strbuf symref =3D STRBUF_INIT;
    -
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
      =09=09strbuf_release(&symref);
      =09}
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
     +=09if (opts.orphan) {
     +=09=09branch =3D new_branch;
     +=09} else if (!lookup_commit_reference_by_name(branch)) {
    -+=09=09/*
    -+=09=09 * If `branch` does not reference a valid commit, a new
    -+=09=09 * worktree (and/or branch) cannot be created based off of it.
    -+=09=09 */
     +=09=09die(_("invalid reference: %s"), branch);
     +=09} else if (new_branch) {
      =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09=09strvec_push(&cp.args, "branch");

      ## t/t2400-worktree-add.sh ##
    -@@ t/t2400-worktree-add.sh: test_expect_success '"add" no auto-vivify =
with --detach and <branch> omitted' '
    - =09test_must_fail git -C mish/mash symbolic-ref HEAD
    - '
    -
    --test_expect_success '"add" -b/-B mutually exclusive' '
    --=09test_must_fail git worktree add -b poodle -B poodle bamboo main
    --'
    --
    --test_expect_success '"add" -b/--detach mutually exclusive' '
    --=09test_must_fail git worktree add -b poodle --detach bamboo main
    --'
    -+# Helper function to test mutually exclusive options.
    -+test_wt_add_excl() {
    -+=09local opts=3D"$@" &&
    -+=09test_expect_success "'worktree add' with '$opts' has mutually excl=
usive options" '
    -+=09=09test_must_fail git worktree add $opts
    -+=09'
    -+}
    -
    --test_expect_success '"add" -B/--detach mutually exclusive' '
    --=09test_must_fail git worktree add -B poodle --detach bamboo main
    --'
    -+test_wt_add_excl -b poodle -B poodle bamboo main
    -+test_wt_add_excl -b poodle --orphan poodle bamboo
    -+test_wt_add_excl -b poodle --detach bamboo main
    -+test_wt_add_excl -B poodle --detach bamboo main
    -+test_wt_add_excl -B poodle --detach bamboo main
    +@@ t/t2400-worktree-add.sh: test_wt_add_excl() {
    + test_wt_add_excl -b poodle -B poodle bamboo main
    + test_wt_add_excl -b poodle --detach bamboo main
    + test_wt_add_excl -B poodle --detach bamboo main
     +test_wt_add_excl -B poodle --orphan poodle bamboo
    ++test_wt_add_excl -b poodle --orphan poodle bamboo
     +test_wt_add_excl --orphan poodle --detach bamboo
     +test_wt_add_excl --orphan poodle --no-checkout bamboo
     +test_wt_add_excl --orphan poodle bamboo main
3:  74cb091bb3 ! 4:  df4c1fa469 worktree add: Add hint to use --orphan when=
 bad ref
    @@ advice.h: struct string_list;

      ## builtin/worktree.c ##
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    - =09=09 * If `branch` does not reference a valid commit, a new
    - =09=09 * worktree (and/or branch) cannot be created based off of it.
    - =09=09 */
    + =09if (opts.orphan) {
    + =09=09branch =3D new_branch;
    + =09} else if (!lookup_commit_reference_by_name(branch)) {
     +=09=09advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
    -+=09=09=09"If you meant to create a worktree containing a new orphan b=
ranch\n"
    -+=09=09=09"(branch with no commits) for this repository, e.g. '%s',\n"
    -+=09=09=09"you can do so using the --orphan option:\n"
    ++=09=09=09_("If you meant to create a worktree containing a new orphan=
 branch\n"
    ++=09=09=09"(branch with no commits) for this repository, you can do so=
\n"
    ++=09=09=09"using the --orphan option:\n"
     +=09=09=09"\n"
    -+=09=09=09"=09git worktree add --orphan %s %s\n"
    -+=09=09=09"\n",
    -+=09=09=09 new_branch, new_branch, path);
    ++=09=09=09"=09git worktree add --orphan %s %s\n"), new_branch, path);
      =09=09die(_("invalid reference: %s"), branch);
      =09} else if (new_branch) {
      =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree with or=
phan branch,
      =09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
      '

    -+# Helper function to test hints for using --orphan in an empty repo.
     +test_wt_add_empty_repo_orphan_hint() {
    -+=09local context=3D"$1" &&
    -+=09local opts=3D"${@:2}" &&
    ++=09local context=3D"$1"
    ++=09shift
    ++=09local opts=3D"$@"
     +=09test_expect_success "'worktree add' show orphan hint in empty repo=
 w/ $context" '
     +=09=09test_when_finished "rm -rf empty_repo" &&
     +=09=09GIT_DIR=3D"empty_repo" git init --bare &&
    -+=09=09test_must_fail git -C empty_repo worktree add $opts 2> actual &=
&
    ++=09=09test_must_fail git -C empty_repo worktree add $opts foobar/ 2> =
actual &&
     +=09=09grep "hint: If you meant to create a worktree containing a new =
orphan branch" actual
     +=09'
     +}
     +
    -+test_wt_add_empty_repo_orphan_hint 'DWIM' foobar/
    -+test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch foobar/
    -+test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch foobar/
    ++test_wt_add_empty_repo_orphan_hint 'DWIM'
    ++test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch
    ++test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch
     +
      test_expect_success 'local clone from linked checkout' '
      =09git clone --local here here-clone &&
--
2.38.2


