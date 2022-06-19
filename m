Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2A3C43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 03:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiFSDxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 23:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiFSDxW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 23:53:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC009588
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:53:20 -0700 (PDT)
Received: (qmail 23640 invoked by uid 109); 19 Jun 2022 03:53:20 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jun 2022 03:53:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Sat, 18 Jun 2022 23:53:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 1/2] fetch: stop passing around unused worktrees variable
Message-ID: <Yq6dr6HaILpqJBdM@coredump.intra.peff.net>
References: <Yq6deQf96g8M5wdg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yq6deQf96g8M5wdg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 12d47e3b1f (fetch: use new branch_checked_out() and add tests,
2022-06-14), fetch's update_local_ref() function stopped using its
"worktrees" parameter. It doesn't need it, since the
branch_checked_out() function examines the global worktrees under the
hood.

So we can not only drop the unused parameter from that function, but
also from its entire call chain. And as we do so all the way up to
do_fetch(), we can see that nobody uses it at all, and we can drop the
local variable there entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fa473fc394..51d9c33f1e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -881,8 +881,7 @@ static void format_display(struct strbuf *display, char code,
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
 			    const char *remote, const struct ref *remote_ref,
-			    struct strbuf *display, int summary_width,
-			    struct worktree **worktrees)
+			    struct strbuf *display, int summary_width)
 {
 	struct commit *current = NULL, *updated;
 	const char *pretty_ref = prettify_refname(ref->name);
@@ -1107,7 +1106,7 @@ N_("it took %.2f seconds to check forced updates; you can use\n"
 static int store_updated_refs(const char *raw_url, const char *remote_name,
 			      int connectivity_checked,
 			      struct ref_transaction *transaction, struct ref *ref_map,
-			      struct fetch_head *fetch_head, struct worktree **worktrees)
+			      struct fetch_head *fetch_head)
 {
 	int url_len, i, rc = 0;
 	struct strbuf note = STRBUF_INIT, err = STRBUF_INIT;
@@ -1237,8 +1236,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			strbuf_reset(&note);
 			if (ref) {
 				rc |= update_local_ref(ref, transaction, what,
-						       rm, &note, summary_width,
-						       worktrees);
+						       rm, &note, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
@@ -1329,8 +1327,7 @@ static int check_exist_and_connected(struct ref *ref_map)
 static int fetch_and_consume_refs(struct transport *transport,
 				  struct ref_transaction *transaction,
 				  struct ref *ref_map,
-				  struct fetch_head *fetch_head,
-				  struct worktree **worktrees)
+				  struct fetch_head *fetch_head)
 {
 	int connectivity_checked = 1;
 	int ret;
@@ -1353,7 +1350,7 @@ static int fetch_and_consume_refs(struct transport *transport,
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret = store_updated_refs(transport->url, transport->remote->name,
 				 connectivity_checked, transaction, ref_map,
-				 fetch_head, worktrees);
+				 fetch_head);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
 
 out:
@@ -1543,8 +1540,7 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 static int backfill_tags(struct transport *transport,
 			 struct ref_transaction *transaction,
 			 struct ref *ref_map,
-			 struct fetch_head *fetch_head,
-			 struct worktree **worktrees)
+			 struct fetch_head *fetch_head)
 {
 	int retcode, cannot_reuse;
 
@@ -1565,7 +1561,7 @@ static int backfill_tags(struct transport *transport,
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	retcode = fetch_and_consume_refs(transport, transaction, ref_map, fetch_head, worktrees);
+	retcode = fetch_and_consume_refs(transport, transaction, ref_map, fetch_head);
 
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1586,7 +1582,6 @@ static int do_fetch(struct transport *transport,
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	int must_list_refs = 1;
-	struct worktree **worktrees = get_worktrees();
 	struct fetch_head fetch_head = { 0 };
 	struct strbuf err = STRBUF_INIT;
 
@@ -1677,7 +1672,7 @@ static int do_fetch(struct transport *transport,
 			retcode = 1;
 	}
 
-	if (fetch_and_consume_refs(transport, transaction, ref_map, &fetch_head, worktrees)) {
+	if (fetch_and_consume_refs(transport, transaction, ref_map, &fetch_head)) {
 		retcode = 1;
 		goto cleanup;
 	}
@@ -1700,7 +1695,7 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(transport, transaction, tags_ref_map,
-					  &fetch_head, worktrees))
+					  &fetch_head))
 				retcode = 1;
 		}
 
@@ -1785,7 +1780,6 @@ static int do_fetch(struct transport *transport,
 	close_fetch_head(&fetch_head);
 	strbuf_release(&err);
 	free_refs(ref_map);
-	free_worktrees(worktrees);
 	return retcode;
 }
 
-- 
2.37.0.rc1.385.g5f9aa3aa78

