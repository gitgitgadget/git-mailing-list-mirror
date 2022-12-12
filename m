Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6656C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 01:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiLLBnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 20:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLBnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 20:43:16 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D17B4A2
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 17:43:15 -0800 (PST)
Date:   Mon, 12 Dec 2022 01:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1670809393; x=1671068593;
        bh=faw1dode0pAcgAI+Mn1lHgyudxSfGTvoH7TMbqisGjs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=vqmwBviNP5e12teq/3BfZ26NziPbszsrCryV3clnOPHEug0HDt+6uJTTGCUevK2zT
         z753PsHYlqOnITZti9nsv2jLmBX3KvEhifG9i03YVki0Qbhw/qG25CbPO0mChFzBaz
         8HNgjPGz6eW7xSQhc7txvw1EnsVAOPhTo5Ab+CN4OwHIi7VGMVNBeCd5CycdZdoIpH
         TkfsG3RzAsMLkHi4HfD+iO5p5mnvMVe4hOcLoT9nEJms9A+/6kWeq/DgwGIJUPow8o
         IVFoSRfdXux73Z+VW6HzBwmnxLCi5FEaTXKeaY425TBYcUmjJHUtGvJsEPMvK72Vlo
         nk5Y+tYROKr8A==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v4 3/3] worktree add: Add hint to use --orphan when bad ref
Message-ID: <20221212014003.20290-4-jacobabel@nullpo.dev>
In-Reply-To: <20221212014003.20290-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds a new advice/hint in `git worktree add` for when the user
tries to create a new worktree from a reference that doesn't exist.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/config/advice.txt |  4 ++++
 advice.c                        |  1 +
 advice.h                        |  1 +
 builtin/worktree.c              |  8 ++++++++
 t/t2400-worktree-add.sh         | 16 ++++++++++++++++
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
index 51b247b2a7..ea306e18de 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -744,6 +744,14 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09=09 * If `branch` does not reference a valid commit, a new
 =09=09 * worktree (and/or branch) cannot be created based off of it.
 =09=09 */
+=09=09advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
+=09=09=09"If you meant to create a worktree containing a new orphan branch=
\n"
+=09=09=09"(branch with no commits) for this repository, e.g. '%s',\n"
+=09=09=09"you can do so using the --orphan option:\n"
+=09=09=09"\n"
+=09=09=09"=09git worktree add --orphan %s %s\n"
+=09=09=09"\n",
+=09=09=09 new_branch, new_branch, path);
 =09=09die(_("invalid reference: %s"), branch);
 =09} else if (new_branch) {
 =09=09struct child_process cp =3D CHILD_PROCESS_INIT;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 6118ace92d..455cddcdd2 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -376,6 +376,22 @@ test_expect_success '"add" worktree with orphan branch=
, lock, and reason' '
 =09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
 '

+# Helper function to test hints for using --orphan in an empty repo.
+test_wt_add_empty_repo_orphan_hint() {
+=09local context=3D"$1" &&
+=09local opts=3D"${@:2}" &&
+=09test_expect_success "'worktree add' show orphan hint in empty repo w/ $=
context" '
+=09=09test_when_finished "rm -rf empty_repo" &&
+=09=09GIT_DIR=3D"empty_repo" git init --bare &&
+=09=09test_must_fail git -C empty_repo worktree add $opts 2> actual &&
+=09=09grep "hint: If you meant to create a worktree containing a new orpha=
n branch" actual
+=09'
+}
+
+test_wt_add_empty_repo_orphan_hint 'DWIM' foobar/
+test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch foobar/
+test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch foobar/
+
 test_expect_success 'local clone from linked checkout' '
 =09git clone --local here here-clone &&
 =09( cd here-clone && git fsck )
--
2.37.4


