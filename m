Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73052C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 23:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKJXcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 18:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKJXcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 18:32:46 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8353E4AF21
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 15:32:43 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:32:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1668123159; x=1668382359;
        bh=ZZTC5J6Ew6ujF9lzS/zWPjdkU0NGa+KGpiYFKzcqyJQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=qO82Gh6O4LsBTVWPnb1PeyX8yVhFz4X7ZhXx5aQVHlWa/QX5TpDPAew4Fq0raDjLZ
         5YSHAd3Z594ZHS9RZWaKqDWc1KxGSNbm/fjisrDGmYRmk4jcw79QsLhZZE+hdAN5Bx
         2gAf/KuywmlO0b+g1JR2Ca/acl/F64XKXVjObT4j8YHPy5ozj7+VcPw0K5SQMnmzH/
         VC8Kxam1R6dEJGe246LaySWBRQW5Te8Wui3hn6KQp4Abo4/8xjNdz5fZKAs0HWtwqO
         Vgr3Y+4DD73x0FRaLfYYyG/igY0zmxqlVdTfz+b12sR0pJj953NAUtIOzjoaeTFGEx
         0DmwARU1x+snA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221110233137.10414-1-jacobabel@nullpo.dev>
In-Reply-To: <20221104213401.17393-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev>
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

This patchset has two parts:

  * adding `-B` to the usage docs (noticed during dev and it seemed too sma=
ll
    to justify a separate submission)
  * adding orphan branch functionality (as is present in `git-switch`)
    to `git-worktree-add`

Changes from v2:

  * Changed orphan creation behavior to match `git switch --orphan` instead=
 of
    `git checkout --orphan` [2][3]. As a result `--orphan` no longer accept=
s a
    `<commit-ish>` and creates the orphan branch with a clean working direc=
tory.
  * Removed the `opts.implicit` flag as it is no longer needed and
    `opts.orphan_branch` can be used instead.
  * No longer set `opts.force` when creating an orphan branch (as checkout =
can
    no longer fail in a way that `--force` would prevent).
  * Updated tests to no longer provide a `<commit-ish>`.
  * Removed no longer relevant test.
  * Added additional cleanup to tests.

1. https://stackoverflow.com/a/68717229/15064705/
2. https://lore.kernel.org/git/CAPig+cSVzewXpk+eDSC-W-+Q8X_7ikZXXeSQbmpHBcd=
LCU5svw@mail.gmail.com/
3. https://lore.kernel.org/git/20221110212132.3se4imsksjo3gsso@phi/

Jacob Abel (2):
  worktree add: Include -B in usage docs
  worktree add: add --orphan flag

 Documentation/git-worktree.txt | 14 +++++++-
 builtin/worktree.c             | 64 ++++++++++++++++++++++++++++++----
 t/t2400-worktree-add.sh        | 45 ++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 8 deletions(-)

Range-diff against v2:
1:  f35d78cfb4 =3D 1:  f35d78cfb4 worktree add: Include -B in usage docs
2:  653be67e8a ! 2:  c040c87c6d worktree add: add --orphan flag
    @@ Commit message
         worktree add: add --orphan flag

         Adds support for creating an orphan branch when adding a new workt=
ree.
    -    This functionality is equivalent to git checkout's --orphan flag.
    +    This functionality is equivalent to git switch's --orphan flag.

         The original reason this feature was implemented was to allow a us=
er
         to initialise a new repository using solely the worktree oriented
    @@ Documentation/git-worktree.txt: exist, a new branch based on `HEAD` =
is automatic
      command will refuse to create the worktree (unless `--force` is used)=
.
     ++
     +------------
    -+$ git worktree add --orphan <branch> <path> [<commit-ish>]
    ++$ git worktree add --orphan <branch> <path>
     +------------
     ++
    -+Create a worktree containing an orphan branch named `<branch>` based
    -+on `<commit-ish>`. If `<commit-ish>` is not specified, the new orphan=
 branch
    -+will be created based on `HEAD`.
    -++
    -+Note that unlike with `-b` or `-B`, this operation will succeed even =
if
    -+`<commit-ish>` is a branch that is currently checked out somewhere el=
se.
    ++Create a worktree containing an orphan branch named `<branch>` with a
    ++clean working directory.  See `--orphan` in linkgit:git-switch[1] for
    ++more details.

      list::

    @@ Documentation/git-worktree.txt: This can also be set up as the defau=
lt behaviour

     +--orphan <new-branch>::
     +=09With `add`, create a new orphan branch named `<new-branch>` in the=
 new
    -+=09worktree based on `<commit-ish>`. If `<commit-ish>` is omitted, it
    -+=09defaults to `HEAD`.
    ++=09worktree. See `--orphan` in linkgit:git-switch[1] for details.
     +
      --porcelain::
      =09With `list`, output in an easy-to-parse format for scripts.
    @@ builtin/worktree.c: struct add_opts {
      =09int detach;
      =09int quiet;
      =09int checkout;
    -+=09int implicit;
     +=09const char *orphan_branch;
      =09const char *keep_locked;
      };
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
      =09}
      =09commit =3D lookup_commit_reference_by_name(refname);
     -=09if (!commit)
    -+=09if (!commit && !opts->implicit)
    ++=09if (!commit && !opts->orphan_branch)
      =09=09die(_("invalid reference: %s"), refname);

      =09name =3D worktree_basename(path, &len);
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
      =09if (ret)
      =09=09goto done;

    --=09if (opts->checkout &&
    --=09    (ret =3D checkout_worktree(opts, &child_env)))
    --=09=09goto done;
    -+=09if (opts->checkout) {
    -+=09=09ret =3D checkout_worktree(opts, &child_env);
    -+=09=09if (opts->orphan_branch && !ret)
    -+=09=09=09ret =3D make_worktree_orphan(opts, &child_env);
    -+=09=09if (ret)
    -+=09=09=09goto done;
    -+=09}
    -
    - =09is_junk =3D 0;
    - =09FREE_AND_NULL(junk_work_tree);
    ++=09if (opts->orphan_branch &&
    ++=09    (ret =3D make_worktree_orphan(opts, &child_env)))
    ++=09=09goto done;
    ++
    + =09if (opts->checkout &&
    + =09    (ret =3D checkout_worktree(opts, &child_env)))
    + =09=09goto done;
     @@ builtin/worktree.c: static int add_worktree(const char *path, const=
 char *refname,
      =09 * Hook failure does not warrant worktree deletion, so run hook af=
ter
      =09 * is_junk is cleared, but do return appropriate code when hook fa=
ils.
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09=09OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new wo=
rking tree")),
      =09=09OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree=
 locked")),
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    - =09memset(&opts, 0, sizeof(opts));
    - =09opts.checkout =3D 1;
      =09ac =3D parse_options(ac, av, prefix, options, git_worktree_add_usa=
ge, 0);
    --=09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
    --=09=09die(_("options '%s', '%s', and '%s' cannot be used together"), =
"-b", "-B", "--detach");
    -+=09opts.implicit =3D ac < 2;
    -+
    + =09if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
    + =09=09die(_("options '%s', '%s', and '%s' cannot be used together"), =
"-b", "-B", "--detach");
     +=09if (!!opts.detach + !!new_branch + !!new_branch_force + !!opts.orp=
han_branch > 1)
     +=09=09die(_("options '%s', '%s', '%s', and '%s' cannot be used togeth=
er"),
     +=09=09    "-b", "-B", "--orphan", "--detach");
    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
      =09=09die(_("the option '%s' requires '%s'"), "--reason", "--lock");
      =09if (lock_reason)
     @@ builtin/worktree.c: static int add(int ac, const char **av, const c=
har *prefix)
    - =09=09usage_with_options(git_worktree_add_usage, options);
    -
    - =09path =3D prefix_filename(prefix, av[0]);
    --=09branch =3D ac < 2 ? "HEAD" : av[1];
    -+=09branch =3D opts.implicit ? "HEAD" : av[1];
    -
      =09if (!strcmp(branch, "-"))
      =09=09branch =3D "@{-1}";

    @@ builtin/worktree.c: static int add(int ac, const char **av, const ch=
ar *prefix)
     +=09 * are staged, opts.orphan_branch should be treated as both a bool=
ean
     +=09 * indicating that `--orphan` was selected and as the name of the =
new
     +=09 * orphan branch from this point on.
    -+=09 *
    -+=09 * When creating a new orphan, force checkout regardless of whethe=
r
    -+=09 * the existing branch is already checked out.
     +=09 */
     +=09if (opts.orphan_branch) {
     +=09=09new_branch =3D opts.orphan_branch;
    -+=09=09opts.force =3D 1;
     +=09}
     +
     +=09if (ac < 2 && !new_branch && !opts.detach && !opts.orphan_branch) =
{
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" -B/--detach mutu=
ally exclusi
      '

     +test_expect_success '"add" --orphan/-b mutually exclusive' '
    -+=09test_must_fail git worktree add --orphan poodle -b poodle bamboo m=
ain
    ++=09test_must_fail git worktree add --orphan poodle -b poodle bamboo
     +'
     +
     +test_expect_success '"add" --orphan/-B mutually exclusive' '
    -+=09test_must_fail git worktree add --orphan poodle -B poodle bamboo m=
ain
    ++=09test_must_fail git worktree add --orphan poodle -B poodle bamboo
     +'
     +
     +test_expect_success '"add" --orphan/--detach mutually exclusive' '
    -+=09test_must_fail git worktree add --orphan poodle --detach bamboo ma=
in
    ++=09test_must_fail git worktree add --orphan poodle --detach bamboo
     +'
     +
     +test_expect_success '"add" --orphan/--no-checkout mutually exclusive'=
 '
    -+=09test_must_fail git worktree add --orphan poodle --no-checkout bamb=
oo main
    ++=09test_must_fail git worktree add --orphan poodle --no-checkout bamb=
oo
     +'
     +
     +test_expect_success '"add" -B/--detach mutually exclusive' '
    @@ t/t2400-worktree-add.sh: test_expect_success 'add --quiet' '

     +test_expect_success '"add --orphan"' '
     +=09test_when_finished "git worktree remove -f -f orphandir" &&
    -+=09git worktree add --orphan neworphan orphandir main &&
    ++=09git worktree add --orphan neworphan orphandir &&
     +=09echo refs/heads/neworphan >expected &&
     +=09git -C orphandir symbolic-ref HEAD >actual &&
    -+=09test_cmp expected actual &&
    -+=09git -C orphandir diff main
    ++=09test_cmp expected actual
     +'
     +
     +test_expect_success '"add --orphan" fails if the branch already exist=
s' '
    ++=09test_when_finished "git branch -D existingbranch" &&
     +=09test_when_finished "git worktree remove -f -f orphandir" &&
     +=09git worktree add -b existingbranch orphandir main &&
    -+=09test_must_fail git worktree add --orphan existingbranch orphandir2=
 main &&
    ++=09test_must_fail git worktree add --orphan existingbranch orphandir2=
 &&
     +=09test ! -d orphandir2
     +'
     +
    -+test_expect_success '"add --orphan" fails if the commit-ish doesnt ex=
ist' '
    -+=09test_must_fail git worktree add --orphan badcommitish orphandir ee=
e2222 &&
    -+=09test ! -d orphandir
    -+'
    -+
     +test_expect_success '"add --orphan" with empty repository' '
     +=09test_when_finished "rm -rf empty_repo" &&
     +=09echo refs/heads/newbranch >expected &&
--
2.37.4


