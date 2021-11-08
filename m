Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08534C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC276152A
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhKHUTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:19:03 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39651 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236622AbhKHUTC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:19:02 -0500
Received: from localhost (SCRUBBING-BUBBLES.MIT.EDU [18.9.64.11])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A8KGCvb004248;
        Mon, 8 Nov 2021 15:16:13 -0500
Date:   Mon, 8 Nov 2021 15:16:12 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: [PATCH v3 2/2] receive-pack: Protect current branch for bare repository
 worktree
Message-ID: <alpine.DEB.2.21.999.2111081515380.100671@scrubbing-bubbles.mit.edu>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="152177472-543465509-1636402572=:100671"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--152177472-543465509-1636402572=:100671
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

A bare repository won=E2=80=99t have a working tree at .., but it may still=
 have
separate working trees created with git worktree. We should protect the
current branch of such working trees from being updated or deleted,
according to receive.denyCurrentBranch.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/receive-pack.c | 10 +++++-----
 t/t5516-fetch-push.sh  | 11 ++++++++---
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d960..5efc9bc9fa 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1456,11 +1456,11 @@ static const char *update_worktree(unsigned char *s=
ha1, const struct worktree *w
 =09=09work_tree =3D worktree->path;
 =09else if (git_work_tree_cfg)
 =09=09work_tree =3D git_work_tree_cfg;
-=09else
-=09=09work_tree =3D "..";
-
-=09if (is_bare_repository())
+=09else if (is_bare_repository())
 =09=09return "denyCurrentBranch =3D updateInstead needs a worktree";
+=09else
+=09=09work_tree =3D "..";
+
 =09if (worktree)
 =09=09git_dir =3D get_worktree_git_dir(worktree);
 =09if (!git_dir)
@@ -1486,7 +1486,7 @@ static const char *update(struct command *cmd, struct=
 shallow_info *si)
 =09struct object_id *old_oid =3D &cmd->old_oid;
 =09struct object_id *new_oid =3D &cmd->new_oid;
 =09int do_update_worktree =3D 0;
-=09const struct worktree *worktree =3D is_bare_repository() ? NULL : find_=
shared_symref("HEAD", name);
+=09const struct worktree *worktree =3D find_shared_symref("HEAD", name);
=20
 =09/* only refs/... are allowed */
 =09if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4ef4ecbe71..52a4686afe 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1763,20 +1763,25 @@ test_expect_success 'updateInstead with push-to-che=
ckout hook' '
=20
 test_expect_success 'denyCurrentBranch and worktrees' '
 =09git worktree add new-wt &&
+=09git clone --bare . bare.git &&
+=09git -C bare.git worktree add bare-wt &&
 =09git clone . cloned &&
 =09test_commit -C cloned first &&
 =09test_config receive.denyCurrentBranch refuse &&
 =09test_must_fail git -C cloned push origin HEAD:new-wt &&
+=09test_config -C bare.git receive.denyCurrentBranch refuse &&
+=09test_must_fail git -C cloned push ../bare.git HEAD:bare-wt &&
 =09test_config receive.denyCurrentBranch updateInstead &&
 =09git -C cloned push origin HEAD:new-wt &&
-=09test_must_fail git -C cloned push --delete origin new-wt
+=09test_must_fail git -C cloned push --delete origin new-wt &&
+=09test_config -C bare.git receive.denyCurrentBranch updateInstead &&
+=09git -C cloned push ../bare.git HEAD:bare-wt &&
+=09test_must_fail git -C cloned push --delete ../bare.git bare-wt
 '
=20
 test_expect_success 'refuse fetch to current branch of worktree' '
 =09test_commit -C cloned second &&
 =09test_must_fail git fetch cloned HEAD:new-wt &&
-=09git clone --bare . bare.git &&
-=09git -C bare.git worktree add bare-wt &&
 =09test_must_fail git -C bare.git fetch ../cloned HEAD:bare-wt &&
 =09git fetch -u cloned HEAD:new-wt &&
 =09git -C bare.git fetch -u ../cloned HEAD:bare-wt
--=20
2.33.1

--152177472-543465509-1636402572=:100671--
