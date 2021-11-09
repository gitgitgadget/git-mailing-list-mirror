Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B447CC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FDC61131
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbhKIXMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:12:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52866 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232159AbhKIXMp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:12:45 -0500
Received: from localhost (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A9N9mKq014709
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Nov 2021 18:09:50 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v5 1/4] fetch: Protect branches checked out in all worktrees
Date:   Tue,  9 Nov 2021 15:09:38 -0800
Message-Id: <20211109230941.2518143-1-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refuse to fetch into the currently checked out branch of any working
tree, not just the current one.

Fixes this previously reported bug:

https://public-inbox.org/git/cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathema.de

As a side effect of using find_shared_symref, we’ll also refuse the
fetch when we’re on a detached HEAD because we’re rebasing or bisecting
on the branch in question. This seems like a sensible change.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/fetch.c       | 29 +++++++++++++++--------------
 t/t5516-fetch-push.sh | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff..ed8a906717 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,6 +28,7 @@
 #include "promisor-remote.h"
 #include "commit-graph.h"
 #include "shallow.h"
+#include "worktree.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -854,7 +855,7 @@ static int update_local_ref(struct ref *ref,
 			    int summary_width)
 {
 	struct commit *current = NULL, *updated;
-	struct branch *current_branch = branch_get(NULL);
+	const struct worktree *wt;
 	const char *pretty_ref = prettify_refname(ref->name);
 	int fast_forward = 0;
 
@@ -868,16 +869,18 @@ static int update_local_ref(struct ref *ref,
 		return 0;
 	}
 
-	if (current_branch &&
-	    !strcmp(ref->name, current_branch->name) &&
-	    !(update_head_ok || is_bare_repository()) &&
+	if (!update_head_ok &&
+	    (wt = find_shared_symref("HEAD", ref->name)) &&
+	    !wt->is_bare &&
 	    !is_null_oid(&ref->old_oid)) {
 		/*
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
 		format_display(display, '!', _("[rejected]"),
-			       _("can't fetch in current branch"),
+			       wt->is_current ?
+			       _("can't fetch in current branch") :
+			       _("checked out in another worktree"),
 			       remote, pretty_ref, summary_width);
 		return 1;
 	}
@@ -1387,16 +1390,14 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,
 
 static void check_not_current_branch(struct ref *ref_map)
 {
-	struct branch *current_branch = branch_get(NULL);
-
-	if (is_bare_repository() || !current_branch)
-		return;
-
+	const struct worktree *wt;
 	for (; ref_map; ref_map = ref_map->next)
-		if (ref_map->peer_ref && !strcmp(current_branch->refname,
-					ref_map->peer_ref->name))
-			die(_("Refusing to fetch into current branch %s "
-			    "of non-bare repository"), current_branch->refname);
+		if (ref_map->peer_ref &&
+		    (wt = find_shared_symref("HEAD", ref_map->peer_ref->name)) &&
+		    !wt->is_bare)
+			die(_("Refusing to fetch into branch '%s' "
+			      "checked out at '%s'"),
+			    ref_map->peer_ref->name, wt->path);
 }
 
 static int truncate_fetch_head(void)
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8212ca56dc..f07e32126f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1771,4 +1771,22 @@ test_expect_success 'denyCurrentBranch and worktrees' '
 	git -C cloned push origin HEAD:new-wt &&
 	test_must_fail git -C cloned push --delete origin new-wt
 '
+
+test_expect_success 'refuse fetch to current branch of worktree' '
+	test_when_finished "git worktree remove --force wt && git branch -D wt" &&
+	git worktree add wt &&
+	test_commit apple &&
+	test_must_fail git fetch . HEAD:wt &&
+	git fetch -u . HEAD:wt
+'
+
+test_expect_success 'refuse fetch to current branch of bare repository worktree' '
+	test_when_finished "rm -fr bare.git" &&
+	git clone --bare . bare.git &&
+	git -C bare.git worktree add wt &&
+	test_commit banana &&
+	test_must_fail git -C bare.git fetch .. HEAD:wt &&
+	git -C bare.git fetch -u .. HEAD:wt
+'
+
 test_done
-- 
2.33.1

