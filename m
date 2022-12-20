Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558F0C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 02:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiLTCic (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 21:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiLTCia (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 21:38:30 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532DB11C04
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 18:38:29 -0800 (PST)
Date:   Tue, 20 Dec 2022 02:38:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1671503907; x=1671763107;
        bh=agsApGEdvZ/sbPT9zs4G25gZiWR215kBggCWoBL+w5o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=H/f84RS+0x9860xR+RjPAfA48KDX3YJD6TRCzPs4DExsH8lrZLyNdLQ/tPiebOsnH
         AfoveZKgJ/YAKrpdm1e3jRhd/5GhenTbVwWzDRdwPfMNAORNYX7wJLMAGxsyrH7BfM
         BPw6iDG3R5Aje5WyCJXxmSnMJZFDniogeanTKdk1vf4j47Lf5YIiME4bE0a9e2/+ac
         EgZ3r6gn8kc9xQhT/C6GQEz/ubGchb3Sp5Ta/mtQSJlhQHroM+fcNcMW9TrxQ0K3HA
         N6BRtVmZPzqS5uw++oZuei8s2K2xYx/5cVcc+3p009vtFKItEwzduV4HMbnSslr3PL
         CGgIwEKbxx42g==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v5 4/4] worktree add: Add hint to use --orphan when bad ref
Message-ID: <20221220023637.29042-5-jacobabel@nullpo.dev>
In-Reply-To: <20221220023637.29042-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev>
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
 builtin/worktree.c              |  6 ++++++
 t/t2400-worktree-add.sh         | 16 ++++++++++++++++
 5 files changed, 28 insertions(+)

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
index 194c3ccabf..1f44978616 100644
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
index 73ad26651e..05539aa03c 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -375,6 +375,22 @@ test_expect_success '"add" worktree with orphan branch=
, lock, and reason' '
 =09test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
 '

+test_wt_add_empty_repo_orphan_hint() {
+=09local context=3D"$1"
+=09shift
+=09local opts=3D"$@"
+=09test_expect_success "'worktree add' show orphan hint in empty repo w/ $=
context" '
+=09=09test_when_finished "rm -rf empty_repo" &&
+=09=09GIT_DIR=3D"empty_repo" git init --bare &&
+=09=09test_must_fail git -C empty_repo worktree add $opts foobar/ 2> actua=
l &&
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


