Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9150DC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 17:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjAIReg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbjAIReP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 12:34:15 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA40A33D75
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 09:33:54 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:33:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673285631; x=1673544831;
        bh=RE28uzEaVWYpprRv1g6F8VfIgGL745SD29b+KOC43c0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=LGxTQONoGCi3Dy/nnxto6u8DXkRMCEYaPcy84gkgWceLqARJkFRyiLxCTmUYRd0cr
         Y3hdxNKk5lkiHTHMAdu7cPts5vM3iNSA2ksAsA66IWaKEmFiT+XIa0W4+lX2VkwEdJ
         CqyTphGatDj2vP8EQeNubvoj/xzI3gq7P4L+YZ2vBAVCddnDPCgR4Qlp4/uUxImIBU
         zYf+HEcWsHxSZbtQqHJctRjXH6yRD9ijgL6vJpq4yP2+wsTBCH7uwma2jEtYg/MNb3
         LVgxyzgoF2a6E45ueSSLbI8eWcF+eR6CFWtvu5G//i2rhvYEel7ckh/QR+bl1JilOD
         O1T+Zcf86S8Bw==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v8 4/4] worktree add: add hint to direct users towards --orphan
Message-ID: <20230109173227.29264-5-jacobabel@nullpo.dev>
In-Reply-To: <20230109173227.29264-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev> <20230109173227.29264-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds a new advice/hint in `git worktree add` for when the user
tries to create a new worktree from a reference that doesn't exist.

Current Behavior:

% git init --bare foo.git
Initialized empty Git repository in /path/to/foo.git/
% git -C foo.git worktree add main/
Preparing worktree (new branch 'main')
fatal: invalid reference: HEAD
%

New Behavior:

% git init --bare foo.git
Initialized empty Git repository in /path/to/foo.git/
% git -C foo.git worktree add main/
Preparing worktree (new branch 'main')
hint: If you meant to create a worktree containing a new orphan branch
hint: (branch with no commits) for this repository, you can do so
hint: using the --orphan option:
hint:
hint:   git worktree add --orphan main ./main
hint:
hint: Disable this message with "git config advice.worktreeAddOrphan false"
fatal: invalid reference: HEAD
%

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/config/advice.txt |  4 ++++
 advice.c                        |  1 +
 advice.h                        |  1 +
 builtin/worktree.c              |  6 ++++++
 t/t2400-worktree-add.sh         | 18 ++++++++++++++++++
 5 files changed, 30 insertions(+)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.=
txt
index a00d0100a8..3e58521613 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -136,4 +136,8 @@ advice.*::
 =09=09Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
 =09=09is asked to update index entries outside the current sparse
 =09=09checkout.
+=09worktreeAddOrphan::
+=09=09Advice shown when a user tries to create a worktree from an
+=09=09invalid reference, to instruct how to create a new orphan
+=09=09branch instead.
 --
diff --git a/advice.c b/advice.c
index fd18968943..53e91fdb85 100644
--- a/advice.c
+++ b/advice.c
@@ -75,6 +75,7 @@ static struct {
 =09[ADVICE_SUBMODULES_NOT_UPDATED] =09=09=3D { "submodulesNotUpdated", 1 }=
,
 =09[ADVICE_UPDATE_SPARSE_PATH]=09=09=09=3D { "updateSparsePath", 1 },
 =09[ADVICE_WAITING_FOR_EDITOR]=09=09=09=3D { "waitingForEditor", 1 },
+=09[ADVICE_WORKTREE_ADD_ORPHAN]=09=09=09=3D { "worktreeAddOrphan", 1 },
 };

 static const char turn_off_instructions[] =3D
diff --git a/advice.h b/advice.h
index 07e0f76833..919d8c0064 100644
--- a/advice.h
+++ b/advice.h
@@ -50,6 +50,7 @@ struct string_list;
 =09ADVICE_UPDATE_SPARSE_PATH,
 =09ADVICE_WAITING_FOR_EDITOR,
 =09ADVICE_SKIPPED_CHERRY_PICKS,
+=09ADVICE_WORKTREE_ADD_ORPHAN,
 };

 int git_default_advice_config(const char *var, const char *value);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index ac82c5feda..d975628353 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -730,6 +730,12 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09if (opts.orphan) {
 =09=09branch =3D new_branch;
 =09} else if (!lookup_commit_reference_by_name(branch)) {
+=09=09advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
+=09=09=09_("If you meant to create a worktree containing a new orphan bran=
ch\n"
+=09=09=09"(branch with no commits) for this repository, you can do so\n"
+=09=09=09"using the --orphan option:\n"
+=09=09=09"\n"
+=09=09=09"=09git worktree add --orphan %s %s\n"), new_branch, path);
 =09=09die(_("invalid reference: %s"), branch);
 =09} else if (new_branch) {
 =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 45f896dcd0..1bf8d619e2 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -378,6 +378,24 @@ test_expect_success '"add" worktree with orphan branch=
, lock, and reason' '
 =09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
 '

+# Note: Quoted arguments containing spaces are not supported.
+test_wt_add_empty_repo_orphan_hint () {
+=09local context=3D"$1" &&
+=09shift &&
+=09local opts=3D"$*" &&
+=09test_expect_success "'worktree add' show orphan hint in empty repo w/ $=
context" '
+=09=09test_when_finished "rm -rf empty_repo" &&
+=09=09GIT_DIR=3D"empty_repo" git init --bare &&
+=09=09test_must_fail git -C empty_repo worktree add $opts foobar/ 2>actual=
 &&
+=09=09! grep "error: unknown switch" actual &&
+=09=09grep "hint: If you meant to create a worktree containing a new orpha=
n branch" actual
+=09'
+}
+
+test_wt_add_empty_repo_orphan_hint 'DWIM'
+test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch
+test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch
+
 test_expect_success 'local clone from linked checkout' '
 =09git clone --local here here-clone &&
 =09( cd here-clone && git fsck )
--
2.38.2


