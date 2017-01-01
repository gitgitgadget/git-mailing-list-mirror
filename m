Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE751FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 19:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbdAATT7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 14:19:59 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53902 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932412AbdAATTt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jan 2017 14:19:49 -0500
Received: from genre.crustytoothpaste.net (unknown [173.243.43.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AFC41280B1;
        Sun,  1 Jan 2017 19:19:47 +0000 (UTC)
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/17] wt-status: convert to struct object_id
Date:   Sun,  1 Jan 2017 19:18:47 +0000
Message-Id: <20170101191847.564741-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170101191847.564741-1-sandals@crustytoothpaste.net>
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining uses of unsigned char [20] to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 wt-status.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 08a4d0bd3..e07a46d21 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1115,16 +1115,16 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 
 	split = strbuf_split_max(line, ' ', 3);
 	if (split[0] && split[1]) {
-		unsigned char sha1[20];
+		struct object_id oid;
 
 		/*
 		 * strbuf_split_max left a space. Trim it and re-add
 		 * it after abbreviation.
 		 */
 		strbuf_trim(split[1]);
-		if (!get_sha1(split[1]->buf, sha1)) {
+		if (!get_oid(split[1]->buf, &oid)) {
 			strbuf_reset(split[1]);
-			strbuf_add_unique_abbrev(split[1], sha1,
+			strbuf_add_unique_abbrev(split[1], oid.hash,
 						 DEFAULT_ABBREV);
 			strbuf_addch(split[1], ' ');
 			strbuf_reset(line);
@@ -1334,7 +1334,7 @@ static void show_bisect_in_progress(struct wt_status *s,
 static char *get_branch(const struct worktree *wt, const char *path)
 {
 	struct strbuf sb = STRBUF_INIT;
-	unsigned char sha1[20];
+	struct object_id oid;
 	const char *branch_name;
 
 	if (strbuf_read_file(&sb, worktree_git_path(wt, "%s", path), 0) <= 0)
@@ -1348,9 +1348,9 @@ static char *get_branch(const struct worktree *wt, const char *path)
 		strbuf_remove(&sb, 0, branch_name - sb.buf);
 	else if (starts_with(sb.buf, "refs/"))
 		;
-	else if (!get_sha1_hex(sb.buf, sha1)) {
+	else if (!get_oid_hex(sb.buf, &oid)) {
 		strbuf_reset(&sb);
-		strbuf_add_unique_abbrev(&sb, sha1, DEFAULT_ABBREV);
+		strbuf_add_unique_abbrev(&sb, oid.hash, DEFAULT_ABBREV);
 	} else if (!strcmp(sb.buf, "detached HEAD")) /* rebase */
 		goto got_nothing;
 	else			/* bisect */
@@ -1364,7 +1364,7 @@ static char *get_branch(const struct worktree *wt, const char *path)
 
 struct grab_1st_switch_cbdata {
 	struct strbuf buf;
-	unsigned char nsha1[20];
+	struct object_id noid;
 };
 
 static int grab_1st_switch(struct object_id *ooid, struct object_id *noid,
@@ -1381,7 +1381,7 @@ static int grab_1st_switch(struct object_id *ooid, struct object_id *noid,
 		return 0;
 	target += strlen(" to ");
 	strbuf_reset(&cb->buf);
-	hashcpy(cb->nsha1, noid->hash);
+	oidcpy(&cb->noid, noid);
 	end = strchrnul(target, '\n');
 	strbuf_add(&cb->buf, target, end - target);
 	if (!strcmp(cb->buf.buf, "HEAD")) {
@@ -1396,7 +1396,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 {
 	struct grab_1st_switch_cbdata cb;
 	struct commit *commit;
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *ref = NULL;
 
 	strbuf_init(&cb.buf, 0);
@@ -1405,22 +1405,22 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 		return;
 	}
 
-	if (dwim_ref(cb.buf.buf, cb.buf.len, sha1, &ref) == 1 &&
+	if (dwim_ref(cb.buf.buf, cb.buf.len, oid.hash, &ref) == 1 &&
 	    /* sha1 is a commit? match without further lookup */
-	    (!hashcmp(cb.nsha1, sha1) ||
+	    (!oidcmp(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-	     ((commit = lookup_commit_reference_gently(sha1, 1)) != NULL &&
-	      !hashcmp(cb.nsha1, commit->object.oid.hash)))) {
+	     ((commit = lookup_commit_reference_gently(oid.hash, 1)) != NULL &&
+	      !oidcmp(&cb.noid, &commit->object.oid)))) {
 		const char *from = ref;
 		if (!skip_prefix(from, "refs/tags/", &from))
 			skip_prefix(from, "refs/remotes/", &from);
 		state->detached_from = xstrdup(from);
 	} else
 		state->detached_from =
-			xstrdup(find_unique_abbrev(cb.nsha1, DEFAULT_ABBREV));
-	hashcpy(state->detached_sha1, cb.nsha1);
-	state->detached_at = !get_sha1("HEAD", sha1) &&
-			     !hashcmp(sha1, state->detached_sha1);
+			xstrdup(find_unique_abbrev(cb.noid.hash, DEFAULT_ABBREV));
+	hashcpy(state->detached_sha1, cb.noid.hash);
+	state->detached_at = !get_oid("HEAD", &oid) &&
+			     !hashcmp(oid.hash, state->detached_sha1);
 
 	free(ref);
 	strbuf_release(&cb.buf);
@@ -1470,22 +1470,22 @@ void wt_status_get_state(struct wt_status_state *state,
 			 int get_detached_from)
 {
 	struct stat st;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (!stat(git_path_merge_head(), &st)) {
 		state->merge_in_progress = 1;
 	} else if (wt_status_check_rebase(NULL, state)) {
 		;		/* all set */
 	} else if (!stat(git_path_cherry_pick_head(), &st) &&
-			!get_sha1("CHERRY_PICK_HEAD", sha1)) {
+			!get_oid("CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
-		hashcpy(state->cherry_pick_head_sha1, sha1);
+		hashcpy(state->cherry_pick_head_sha1, oid.hash);
 	}
 	wt_status_check_bisect(NULL, state);
 	if (!stat(git_path_revert_head(), &st) &&
-	    !get_sha1("REVERT_HEAD", sha1)) {
+	    !get_oid("REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
-		hashcpy(state->revert_head_sha1, sha1);
+		hashcpy(state->revert_head_sha1, oid.hash);
 	}
 
 	if (get_detached_from)
-- 
2.11.0

