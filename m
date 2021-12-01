Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A290C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353482AbhLAWTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:19:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33969 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353476AbhLAWTr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:19:47 -0500
Received: from localhost (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B1MGE6w012614
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Dec 2021 17:16:15 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason=20?= 
        <avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v7 5/8] fetch: protect branches checked out in all worktrees
Date:   Wed,  1 Dec 2021 14:15:44 -0800
Message-Id: <20211201221547.1796213-6-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201221547.1796213-1-andersk@mit.edu>
References: <20211201221547.1796213-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refuse to fetch into the currently checked out branch of any working
tree, not just the current one.

Fixes this previously reported bug:

https://lore.kernel.org/git/cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathema.de/

As a side effect of using find_shared_symref, we’ll also refuse the
fetch when we’re on a detached HEAD because we’re rebasing or bisecting
on the branch in question. This seems like a sensible change.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/fetch.c       | 75 +++++++++++++++++++++++--------------------
 t/t5516-fetch-push.sh | 18 +++++++++++
 2 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 16b98523ce..e45185cf9c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,6 +28,7 @@
 #include "promisor-remote.h"
 #include "commit-graph.h"
 #include "shallow.h"
+#include "worktree.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -848,13 +849,12 @@ static void format_display(struct strbuf *display, char code,
 
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
-			    const char *remote,
-			    const struct ref *remote_ref,
-			    struct strbuf *display,
-			    int summary_width)
+			    const char *remote, const struct ref *remote_ref,
+			    struct strbuf *display, int summary_width,
+			    struct worktree **worktrees)
 {
 	struct commit *current = NULL, *updated;
-	struct branch *current_branch = branch_get(NULL);
+	const struct worktree *wt;
 	const char *pretty_ref = prettify_refname(ref->name);
 	int fast_forward = 0;
 
@@ -868,16 +868,17 @@ static int update_local_ref(struct ref *ref,
 		return 0;
 	}
 
-	if (current_branch &&
-	    !strcmp(ref->name, current_branch->name) &&
-	    !(update_head_ok || is_bare_repository()) &&
-	    !is_null_oid(&ref->old_oid)) {
+	if (!update_head_ok &&
+	    (wt = find_shared_symref(worktrees, "HEAD", ref->name)) &&
+	    !wt->is_bare && !is_null_oid(&ref->old_oid)) {
 		/*
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
 		format_display(display, '!', _("[rejected]"),
-			       _("can't fetch in current branch"),
+			       wt->is_current ?
+				       _("can't fetch in current branch") :
+				       _("checked out in another worktree"),
 			       remote, pretty_ref, summary_width);
 		return 1;
 	}
@@ -1076,7 +1077,8 @@ N_("it took %.2f seconds to check forced updates; you can use\n"
    "to avoid this check\n");
 
 static int store_updated_refs(const char *raw_url, const char *remote_name,
-			      int connectivity_checked, struct ref *ref_map)
+			      int connectivity_checked, struct ref *ref_map,
+			      struct worktree **worktrees)
 {
 	struct fetch_head fetch_head;
 	int url_len, i, rc = 0;
@@ -1205,7 +1207,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			strbuf_reset(&note);
 			if (ref) {
 				rc |= update_local_ref(ref, transaction, what,
-						       rm, &note, summary_width);
+						       rm, &note, summary_width,
+						       worktrees);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
@@ -1298,7 +1301,9 @@ static int check_exist_and_connected(struct ref *ref_map)
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
 
-static int fetch_and_consume_refs(struct transport *transport, struct ref *ref_map)
+static int fetch_and_consume_refs(struct transport *transport,
+				  struct ref *ref_map,
+				  struct worktree **worktrees)
 {
 	int connectivity_checked = 1;
 	int ret;
@@ -1319,10 +1324,8 @@ static int fetch_and_consume_refs(struct transport *transport, struct ref *ref_m
 	}
 
 	trace2_region_enter("fetch", "consume_refs", the_repository);
-	ret = store_updated_refs(transport->url,
-				 transport->remote->name,
-				 connectivity_checked,
-				 ref_map);
+	ret = store_updated_refs(transport->url, transport->remote->name,
+				 connectivity_checked, ref_map, worktrees);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
 
 out:
@@ -1385,19 +1388,18 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,
 	return result;
 }
 
-static void check_not_current_branch(struct ref *ref_map)
+static void check_not_current_branch(struct ref *ref_map,
+				     struct worktree **worktrees)
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
-			die(_("refusing to fetch into current branch %s "
-			      "of non-bare repository"),
-			    current_branch->refname);
+		if (ref_map->peer_ref &&
+		    (wt = find_shared_symref(worktrees, "HEAD",
+					     ref_map->peer_ref->name)) &&
+		    !wt->is_bare)
+			die(_("refusing to fetch into branch '%s' "
+			      "checked out at '%s'"),
+			    ref_map->peer_ref->name, wt->path);
 }
 
 static int truncate_fetch_head(void)
@@ -1495,7 +1497,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 	return transport;
 }
 
-static void backfill_tags(struct transport *transport, struct ref *ref_map)
+static void backfill_tags(struct transport *transport, struct ref *ref_map,
+			  struct worktree **worktrees)
 {
 	int cannot_reuse;
 
@@ -1516,7 +1519,7 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	fetch_and_consume_refs(transport, ref_map);
+	fetch_and_consume_refs(transport, ref_map, worktrees);
 
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1534,6 +1537,7 @@ static int do_fetch(struct transport *transport,
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	int must_list_refs = 1;
+	struct worktree **worktrees = get_worktrees();
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1589,7 +1593,7 @@ static int do_fetch(struct transport *transport,
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
 			      tags, &autotags);
 	if (!update_head_ok)
-		check_not_current_branch(ref_map);
+		check_not_current_branch(ref_map, worktrees);
 
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
@@ -1607,7 +1611,7 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_and_consume_refs(transport, ref_map)) {
+	if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
 		free_refs(ref_map);
 		retcode = 1;
 		goto cleanup;
@@ -1656,7 +1660,7 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
- skip:
+skip:
 	free_refs(ref_map);
 
 	/* if neither --no-tags nor --tags was specified, do automated tag
@@ -1666,11 +1670,12 @@ static int do_fetch(struct transport *transport,
 		ref_map = NULL;
 		find_non_local_tags(remote_refs, &ref_map, &tail);
 		if (ref_map)
-			backfill_tags(transport, ref_map);
+			backfill_tags(transport, ref_map, worktrees);
 		free_refs(ref_map);
 	}
 
- cleanup:
+cleanup:
+	free_worktrees(worktrees);
 	return retcode;
 }
 
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
2.34.1

