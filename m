Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC9C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7924610FF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbhKHUSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:18:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39531 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238770AbhKHUSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:18:25 -0500
Received: from localhost (SCRUBBING-BUBBLES.MIT.EDU [18.9.64.11])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A8KFRWF003795;
        Mon, 8 Nov 2021 15:15:28 -0500
Date:   Mon, 8 Nov 2021 15:15:27 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: [PATCH v3 1/2] fetch: Protect branches checked out in all
 worktrees
Message-ID: <alpine.DEB.2.21.999.2111081514460.100671@scrubbing-bubbles.mit.edu>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="152177472-591641175-1636402527=:100671"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--152177472-591641175-1636402527=:100671
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Refuse to fetch into the currently checked out branch of any working
tree, not just the current one.

Fixes this previously reported bug:

https://public-inbox.org/git/cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathema.d=
e

As a side effect of using find_shared_symref, we=E2=80=99ll also refuse the
fetch when we=E2=80=99re on a detached HEAD because we=E2=80=99re rebasing =
or bisecting
on the branch in question. This seems like a sensible change.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/fetch.c       | 27 +++++++++++++--------------
 t/t5516-fetch-push.sh | 11 +++++++++++
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff..61c8fc9983 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,6 +28,7 @@
 #include "promisor-remote.h"
 #include "commit-graph.h"
 #include "shallow.h"
+#include "worktree.h"
=20
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
=20
@@ -854,7 +855,7 @@ static int update_local_ref(struct ref *ref,
 =09=09=09    int summary_width)
 {
 =09struct commit *current =3D NULL, *updated;
-=09struct branch *current_branch =3D branch_get(NULL);
+=09const struct worktree *wt;
 =09const char *pretty_ref =3D prettify_refname(ref->name);
 =09int fast_forward =3D 0;
=20
@@ -868,16 +869,17 @@ static int update_local_ref(struct ref *ref,
 =09=09return 0;
 =09}
=20
-=09if (current_branch &&
-=09    !strcmp(ref->name, current_branch->name) &&
-=09    !(update_head_ok || is_bare_repository()) &&
+=09if (!update_head_ok &&
+=09    (wt =3D find_shared_symref("HEAD", ref->name)) &&
 =09    !is_null_oid(&ref->old_oid)) {
 =09=09/*
 =09=09 * If this is the head, and it's not okay to update
 =09=09 * the head, and the old value of the head isn't empty...
 =09=09 */
 =09=09format_display(display, '!', _("[rejected]"),
-=09=09=09       _("can't fetch in current branch"),
+=09=09=09       wt->is_current ?
+=09=09=09       _("can't fetch in current branch") :
+=09=09=09       _("branch checked out in worktree"),
 =09=09=09       remote, pretty_ref, summary_width);
 =09=09return 1;
 =09}
@@ -1387,16 +1389,13 @@ static int prune_refs(struct refspec *rs, struct re=
f *ref_map,
=20
 static void check_not_current_branch(struct ref *ref_map)
 {
-=09struct branch *current_branch =3D branch_get(NULL);
-
-=09if (is_bare_repository() || !current_branch)
-=09=09return;
-
+=09const struct worktree *wt;
 =09for (; ref_map; ref_map =3D ref_map->next)
-=09=09if (ref_map->peer_ref && !strcmp(current_branch->refname,
-=09=09=09=09=09ref_map->peer_ref->name))
-=09=09=09die(_("Refusing to fetch into current branch %s "
-=09=09=09    "of non-bare repository"), current_branch->refname);
+=09=09if (ref_map->peer_ref &&
+=09=09    (wt =3D find_shared_symref("HEAD", ref_map->peer_ref->name)))
+=09=09=09die(_("Refusing to fetch into branch '%s' "
+=09=09=09      "checked out at '%s'"),
+=09=09=09    ref_map->peer_ref->name, wt->path);
 }
=20
 static int truncate_fetch_head(void)
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8212ca56dc..4ef4ecbe71 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1771,4 +1771,15 @@ test_expect_success 'denyCurrentBranch and worktrees=
' '
 =09git -C cloned push origin HEAD:new-wt &&
 =09test_must_fail git -C cloned push --delete origin new-wt
 '
+
+test_expect_success 'refuse fetch to current branch of worktree' '
+=09test_commit -C cloned second &&
+=09test_must_fail git fetch cloned HEAD:new-wt &&
+=09git clone --bare . bare.git &&
+=09git -C bare.git worktree add bare-wt &&
+=09test_must_fail git -C bare.git fetch ../cloned HEAD:bare-wt &&
+=09git fetch -u cloned HEAD:new-wt &&
+=09git -C bare.git fetch -u ../cloned HEAD:bare-wt
+'
+
 test_done
--=20
2.33.1


--152177472-591641175-1636402527=:100671--
