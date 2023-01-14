Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7AC46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 22:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjANWuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 17:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjANWui (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 17:50:38 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45181E3B3
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 14:50:37 -0800 (PST)
Date:   Sat, 14 Jan 2023 22:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673736635; x=1673995835;
        bh=DK0Zzm0i7NSnV8hbEp/I+6dlkOy6RQi4tItEC/sm/UY=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=N0Hi+Q8DXKlVB3wmMir3vijPhVNvCI0wU8GX6C+NluXsju44ztT4mFsPZHnAb5uGG
         Iu5hiD5nYCEBUBRgBziMyZ1vEZxTGADRqPZ5SW08Rf0gHMHbQ8U8PZzw6Mwdyknrco
         ZgSX47SKqEpVkhMu/1VOxI5Sck21GhVZp/pT/1NUcSAvRhgnC42TzpOdrQeoLiDSkY
         OyvMVPZ5PWinyXib7hSew2AZ8t3D7cPi0c0+xzbMyN5govOqKCrWIJ+Keg9q2Hw4Hp
         IzZdvHBgSmwoPKAdQjmnMnTY5uN+dcS+71WyqcC0dlyaFVu64BpWxUXNk/YdPcwt1r
         v7Z57tKQXegkA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH] worktree add: introduce basic DWYM for --orphan
Message-ID: <20230114224956.24801-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduces a DWYM shorthand of --orphan for when the worktree directory
and the to-be-created branch share the same name.

Current Behavior:
    % git worktree list
    /path/to/git/repo        a38d39a4c5 [main]
    % git worktree add --orphan new_branch ../new_branch/
    Preparing worktree (new branch 'new_branch')
    % git worktree add --orphan ../new_branch2/
    usage: git worktree add [<options>] <path> [<commit-ish>]
       or: git worktree list [<options>]
    [...]
    %

New Behavior:

    % git worktree list
    /path/to/git/repo        a38d39a4c5 [main]
    % git worktree add --orphan new_branch ../new_branch/
    Preparing worktree (new branch 'new_branch')
    % git worktree list
    /path/to/git/repo        a38d39a4c5 [main]
    /path/to/git/new_branch  a38d39a4c5 [new_branch]
    % git worktree add --orphan ../new_branch2/
    Preparing worktree (new branch 'new_branch2')
    % git worktree list
    /path/to/git/repo        a38d39a4c5 [main]
    /path/to/git/new_branch  a38d39a4c5 [new_branch]
    /path/to/git/new_branch2 a38d39a4c5 [new_branch2]
    %

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt | 13 +++++++++----
 builtin/worktree.c             | 21 +++++++++++++++------
 t/t2400-worktree-add.sh        | 10 ++++++++++
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index d78460c29c..a56ddb0185 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>=
]]
 =09=09   [(-b | -B) <new-branch>] <path> [<commit-ish>]
 'git worktree add' [-f] [--lock [--reason <string>]]
-=09=09   --orphan <new-branch> <path>
+=09=09   --orphan [<new-branch>] <path>
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
@@ -99,13 +99,16 @@ in the new worktree, if it's not checked out anywhere e=
lse, otherwise the
 command will refuse to create the worktree (unless `--force` is used).
 +
 ------------
-$ git worktree add --orphan <branch> <path>
+$ git worktree add --orphan [<branch>] <path>
 ------------
 +
 Create a worktree containing no files, with an empty index, and associated
 with a new orphan branch named `<branch>`. The first commit made on this n=
ew
 branch will have no parents and will be the root of a new history disconne=
cted
 from any other branches.
++
+If a branch name `<branch>` is not supplied, the name is derived from the
+supplied path `<path>`.

 list::

@@ -233,9 +236,11 @@ This can also be set up as the default behaviour by us=
ing the
 =09With `prune`, do not remove anything; just report what it would
 =09remove.

---orphan <new-branch>::
+--orphan [<new-branch>]::
 =09With `add`, make the new worktree and index empty, associating
-=09the worktree with a new orphan branch named `<new-branch>`.
+=09the worktree with a new orphan branch named `<new-branch>`. If
+=09`<new-branch>` is not supplied, the new branch name is derived
+=09from `<path>`.

 --porcelain::
 =09With `list`, output in an easy-to-parse format for scripts.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d975628353..481f895075 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -19,7 +19,7 @@
 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]\n" \
 =09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>]"), =
\
 =09N_("git worktree add [-f] [--lock [--reason <string>]]\n" \
-=09   "                 --orphan <new-branch> <path>")
+=09   "                 --orphan [<new-branch>] <path>")

 #define BUILTIN_WORKTREE_LIST_USAGE \
 =09N_("git worktree list [-v | --porcelain [-z]]")
@@ -681,10 +681,13 @@ static int add(int ac, const char **av, const char *p=
refix)
 =09else if (keep_locked)
 =09=09opts.keep_locked =3D _("added with --lock");

-=09if (ac < 1 || ac > 2)
+=09if (ac < 1 && opts.orphan) {
+=09=09path =3D prefix_filename(prefix, orphan_branch);
+=09} else if (ac >=3D 1 && ac <=3D 2) {
+=09=09path =3D prefix_filename(prefix, av[0]);
+=09} else {
 =09=09usage_with_options(git_worktree_add_usage, options);
-
-=09path =3D prefix_filename(prefix, av[0]);
+=09}
 =09branch =3D ac < 2 ? "HEAD" : av[1];

 =09if (!strcmp(branch, "-"))
@@ -702,14 +705,20 @@ static int add(int ac, const char **av, const char *p=
refix)
 =09=09strbuf_release(&symref);
 =09}

-=09if (opts.orphan) {
-=09=09new_branch =3D orphan_branch;
+=09if (ac < 1 && opts.orphan) {
+=09=09const char *s =3D dwim_branch(path, &orphan_branch);
+=09=09if (s)
+=09=09=09orphan_branch =3D s;
 =09} else if (ac < 2 && !new_branch && !opts.detach) {
 =09=09const char *s =3D dwim_branch(path, &new_branch);
 =09=09if (s)
 =09=09=09branch =3D s;
 =09}

+=09if (opts.orphan) {
+=09=09new_branch =3D orphan_branch;
+=09}
+
 =09if (ac =3D=3D 2 && !new_branch && !opts.detach) {
 =09=09struct object_id oid;
 =09=09struct commit *commit;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 1bf8d619e2..c3de277738 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -354,6 +354,16 @@ test_expect_success '"add --orphan" fails if the branc=
h already exists' '
 =09test_path_is_missing orphandir2
 '

+test_expect_success '"add --orphan" with basic DWYM' '
+=09test_when_finished "rm -rf empty_repo" &&
+=09echo refs/heads/worktreedir >expected &&
+=09GIT_DIR=3D"empty_repo" git init --bare &&
+=09# Use non-trivial path to verify it DWYMs properly.
+=09git -C empty_repo worktree add --orphan ../empty_repo/worktreedir &&
+=09git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
+=09test_cmp expected actual
+'
+
 test_expect_success '"add --orphan" with empty repository' '
 =09test_when_finished "rm -rf empty_repo" &&
 =09echo refs/heads/newbranch >expected &&
--
2.38.2


