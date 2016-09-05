Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F35620705
	for <e@80x24.org>; Mon,  5 Sep 2016 20:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964942AbcIEUKE (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:10:04 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:43028 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964895AbcIEUI3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1E6A5280B0;
        Mon,  5 Sep 2016 20:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106108;
        bh=eHzx22xZkExo+dAESsvn5r/ALdHbUj9heePpdYVJHAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3bttIC8gaJgjoUgGbnQ3T3kQQIFd2dQgQMd7ne9SY44tHfZnHdHQqms4ERXIKxNO
         WAxAbbSlVwM6H8HMRNSsskcfZIHUUpckkSUBoq/i/l8xnlZ+BnEwI9Yui0Ay8PzSyv
         E/bvVoy3Itmey25PkGfX7geLhFwXsL4kk1FlHRddIfTS8bSV5aN6eSsnP92Ab2TKJ0
         62zhYJ5914IUZ6jSSSfHQAk1mW37RiQj5OkezXk7VpNNXgLUWMysJCXaJttNHCO9q1
         CevJXdKVbzjQLrgEqT9P1ndcSabUpW4elUg1cGVRqK1tPKltGmkLjnp+vpwvuRBZ4z
         VGRLzFk9hA5cZEfYXYsbAC4TIcXExy4zE5CuT4QPY6OTIfrs9kMg5IW7xT1C2TXy/G
         MxzIiMlpMia42YWJ376khCjbUyb271/igpsdQwkYBpvQm51u6kxDKc/PC5X7z4yZKU
         ly/lxHxjihkIUqO5EKTYTw080t1tDh0Utw0UCpGsd9PgcGOczEn
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 10/20] notes-merge: convert struct notes_merge_pair to struct object_id
Date:   Mon,  5 Sep 2016 20:08:01 +0000
Message-Id: <20160905200811.697889-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert each of this structure's members from an unsigned char array to
a struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 notes-merge.c | 127 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 65 insertions(+), 62 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 97fc42f6..cb36b43c 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -12,7 +12,7 @@
 #include "notes-utils.h"
 
 struct notes_merge_pair {
-	unsigned char obj[20], base[20], local[20], remote[20];
+	struct object_id obj, base, local, remote;
 };
 
 void init_notes_merge_options(struct notes_merge_options *o)
@@ -75,7 +75,7 @@ static struct notes_merge_pair *find_notes_merge_pair_pos(
 	int i = last_index < len ? last_index : len - 1;
 	int prev_cmp = 0, cmp = -1;
 	while (i >= 0 && i < len) {
-		cmp = hashcmp(obj, list[i].obj);
+		cmp = hashcmp(obj, list[i].obj.hash);
 		if (!cmp) /* obj belongs @ i */
 			break;
 		else if (cmp < 0 && prev_cmp <= 0) /* obj belongs < i */
@@ -108,9 +108,10 @@ static struct notes_merge_pair *find_notes_merge_pair_pos(
 	return list + i;
 }
 
-static unsigned char uninitialized[20] =
+static struct object_id uninitialized = {
 	"\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff" \
-	"\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff";
+	"\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"
+};
 
 static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 						 const unsigned char *base,
@@ -149,25 +150,25 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 		mp = find_notes_merge_pair_pos(changes, len, obj, 1, &occupied);
 		if (occupied) {
 			/* We've found an addition/deletion pair */
-			assert(!hashcmp(mp->obj, obj));
+			assert(!hashcmp(mp->obj.hash, obj));
 			if (is_null_oid(&p->one->oid)) { /* addition */
-				assert(is_null_sha1(mp->remote));
-				hashcpy(mp->remote, p->two->oid.hash);
+				assert(is_null_oid(&mp->remote));
+				oidcpy(&mp->remote, &p->two->oid);
 			} else if (is_null_oid(&p->two->oid)) { /* deletion */
-				assert(is_null_sha1(mp->base));
-				hashcpy(mp->base, p->one->oid.hash);
+				assert(is_null_oid(&mp->base));
+				oidcpy(&mp->base, &p->one->oid);
 			} else
 				assert(!"Invalid existing change recorded");
 		} else {
-			hashcpy(mp->obj, obj);
-			hashcpy(mp->base, p->one->oid.hash);
-			hashcpy(mp->local, uninitialized);
-			hashcpy(mp->remote, p->two->oid.hash);
+			hashcpy(mp->obj.hash, obj);
+			oidcpy(&mp->base, &p->one->oid);
+			oidcpy(&mp->local, &uninitialized);
+			oidcpy(&mp->remote, &p->two->oid);
 			len++;
 		}
 		trace_printf("\t\tStored remote change for %s: %.7s -> %.7s\n",
-		       sha1_to_hex(mp->obj), sha1_to_hex(mp->base),
-		       sha1_to_hex(mp->remote));
+		       oid_to_hex(&mp->obj), oid_to_hex(&mp->base),
+		       oid_to_hex(&mp->remote));
 	}
 	diff_flush(&opt);
 	clear_pathspec(&opt.pathspec);
@@ -216,7 +217,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 			continue;
 		}
 
-		assert(!hashcmp(mp->obj, obj));
+		assert(!hashcmp(mp->obj.hash, obj));
 		if (is_null_oid(&p->two->oid)) { /* deletion */
 			/*
 			 * Either this is a true deletion (1), or it is part
@@ -227,8 +228,8 @@ static void diff_tree_local(struct notes_merge_options *o,
 			 * (3) mp->local is uninitialized; set it to null_sha1
 			 *     (will be overwritten by following addition)
 			 */
-			if (!hashcmp(mp->local, uninitialized))
-				hashclr(mp->local);
+			if (!oidcmp(&mp->local, &uninitialized))
+				oidclr(&mp->local);
 		} else if (is_null_oid(&p->one->oid)) { /* addition */
 			/*
 			 * Either this is a true addition (1), or it is part
@@ -238,22 +239,22 @@ static void diff_tree_local(struct notes_merge_options *o,
 			 * (2) mp->local is uninitialized; set to p->two->sha1
 			 * (3) mp->local is null_sha1;     set to p->two->sha1
 			 */
-			assert(is_null_sha1(mp->local) ||
-			       !hashcmp(mp->local, uninitialized));
-			hashcpy(mp->local, p->two->oid.hash);
+			assert(is_null_oid(&mp->local) ||
+			       !oidcmp(&mp->local, &uninitialized));
+			oidcpy(&mp->local, &p->two->oid);
 		} else { /* modification */
 			/*
 			 * This is a true modification. p->one->sha1 shall
 			 * match mp->base, and mp->local shall be uninitialized.
 			 * Set mp->local to p->two->sha1.
 			 */
-			assert(!hashcmp(p->one->oid.hash, mp->base));
-			assert(!hashcmp(mp->local, uninitialized));
-			hashcpy(mp->local, p->two->oid.hash);
+			assert(!oidcmp(&p->one->oid, &mp->base));
+			assert(!oidcmp(&mp->local, &uninitialized));
+			oidcpy(&mp->local, &p->two->oid);
 		}
 		trace_printf("\t\tStored local change for %s: %.7s -> %.7s\n",
-		       sha1_to_hex(mp->obj), sha1_to_hex(mp->base),
-		       sha1_to_hex(mp->local));
+		       oid_to_hex(&mp->obj), oid_to_hex(&mp->base),
+		       oid_to_hex(&mp->local));
 	}
 	diff_flush(&opt);
 	clear_pathspec(&opt.pathspec);
@@ -343,11 +344,11 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 	mmfile_t base, local, remote;
 	int status;
 
-	read_mmblob(&base, p->base);
-	read_mmblob(&local, p->local);
-	read_mmblob(&remote, p->remote);
+	read_mmblob(&base, p->base.hash);
+	read_mmblob(&local, p->local.hash);
+	read_mmblob(&remote, p->remote.hash);
 
-	status = ll_merge(&result_buf, sha1_to_hex(p->obj), &base, NULL,
+	status = ll_merge(&result_buf, oid_to_hex(&p->obj), &base, NULL,
 			  &local, o->local_ref, &remote, o->remote_ref, NULL);
 
 	free(base.ptr);
@@ -357,7 +358,7 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 	if ((status < 0) || !result_buf.ptr)
 		die("Failed to execute internal merge");
 
-	write_buf_to_worktree(p->obj, result_buf.ptr, result_buf.size);
+	write_buf_to_worktree(p->obj.hash, result_buf.ptr, result_buf.size);
 	free(result_buf.ptr);
 
 	return status;
@@ -372,51 +373,52 @@ static int merge_one_change_manual(struct notes_merge_options *o,
 
 	trace_printf("\t\t\tmerge_one_change_manual(obj = %.7s, base = %.7s, "
 	       "local = %.7s, remote = %.7s)\n",
-	       sha1_to_hex(p->obj), sha1_to_hex(p->base),
-	       sha1_to_hex(p->local), sha1_to_hex(p->remote));
+	       oid_to_hex(&p->obj), oid_to_hex(&p->base),
+	       oid_to_hex(&p->local), oid_to_hex(&p->remote));
 
 	/* add "Conflicts:" section to commit message first time through */
 	if (!o->has_worktree)
 		strbuf_addstr(&(o->commit_msg), "\n\nConflicts:\n");
 
-	strbuf_addf(&(o->commit_msg), "\t%s\n", sha1_to_hex(p->obj));
+	strbuf_addf(&(o->commit_msg), "\t%s\n", oid_to_hex(&p->obj));
 
 	if (o->verbosity >= 2)
-		printf("Auto-merging notes for %s\n", sha1_to_hex(p->obj));
+		printf("Auto-merging notes for %s\n", oid_to_hex(&p->obj));
 	check_notes_merge_worktree(o);
-	if (is_null_sha1(p->local)) {
+	if (is_null_oid(&p->local)) {
 		/* D/F conflict, checkout p->remote */
-		assert(!is_null_sha1(p->remote));
+		assert(!is_null_oid(&p->remote));
 		if (o->verbosity >= 1)
 			printf("CONFLICT (delete/modify): Notes for object %s "
 				"deleted in %s and modified in %s. Version from %s "
 				"left in tree.\n",
-				sha1_to_hex(p->obj), lref, rref, rref);
-		write_note_to_worktree(p->obj, p->remote);
-	} else if (is_null_sha1(p->remote)) {
+				oid_to_hex(&p->obj), lref, rref, rref);
+		write_note_to_worktree(p->obj.hash, p->remote.hash);
+	} else if (is_null_oid(&p->remote)) {
 		/* D/F conflict, checkout p->local */
-		assert(!is_null_sha1(p->local));
+		assert(!is_null_oid(&p->local));
 		if (o->verbosity >= 1)
 			printf("CONFLICT (delete/modify): Notes for object %s "
 				"deleted in %s and modified in %s. Version from %s "
 				"left in tree.\n",
-				sha1_to_hex(p->obj), rref, lref, lref);
-		write_note_to_worktree(p->obj, p->local);
+				oid_to_hex(&p->obj), rref, lref, lref);
+		write_note_to_worktree(p->obj.hash, p->local.hash);
 	} else {
 		/* "regular" conflict, checkout result of ll_merge() */
 		const char *reason = "content";
-		if (is_null_sha1(p->base))
+		if (is_null_oid(&p->base))
 			reason = "add/add";
-		assert(!is_null_sha1(p->local));
-		assert(!is_null_sha1(p->remote));
+		assert(!is_null_oid(&p->local));
+		assert(!is_null_oid(&p->remote));
 		if (o->verbosity >= 1)
 			printf("CONFLICT (%s): Merge conflict in notes for "
-				"object %s\n", reason, sha1_to_hex(p->obj));
+				"object %s\n", reason,
+				oid_to_hex(&p->obj));
 		ll_merge_in_worktree(o, p);
 	}
 
 	trace_printf("\t\t\tremoving from partial merge result\n");
-	remove_note(t, p->obj);
+	remove_note(t, p->obj.hash);
 
 	return 1;
 }
@@ -435,29 +437,29 @@ static int merge_one_change(struct notes_merge_options *o,
 	case NOTES_MERGE_RESOLVE_OURS:
 		if (o->verbosity >= 2)
 			printf("Using local notes for %s\n",
-						sha1_to_hex(p->obj));
+						oid_to_hex(&p->obj));
 		/* nothing to do */
 		return 0;
 	case NOTES_MERGE_RESOLVE_THEIRS:
 		if (o->verbosity >= 2)
 			printf("Using remote notes for %s\n",
-						sha1_to_hex(p->obj));
-		if (add_note(t, p->obj, p->remote, combine_notes_overwrite))
+						oid_to_hex(&p->obj));
+		if (add_note(t, p->obj.hash, p->remote.hash, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
 		return 0;
 	case NOTES_MERGE_RESOLVE_UNION:
 		if (o->verbosity >= 2)
 			printf("Concatenating local and remote notes for %s\n",
-							sha1_to_hex(p->obj));
-		if (add_note(t, p->obj, p->remote, combine_notes_concatenate))
+							oid_to_hex(&p->obj));
+		if (add_note(t, p->obj.hash, p->remote.hash, combine_notes_concatenate))
 			die("failed to concatenate notes "
 			    "(combine_notes_concatenate)");
 		return 0;
 	case NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ:
 		if (o->verbosity >= 2)
 			printf("Concatenating unique lines in local and remote "
-				"notes for %s\n", sha1_to_hex(p->obj));
-		if (add_note(t, p->obj, p->remote, combine_notes_cat_sort_uniq))
+				"notes for %s\n", oid_to_hex(&p->obj));
+		if (add_note(t, p->obj.hash, p->remote.hash, combine_notes_cat_sort_uniq))
 			die("failed to concatenate notes "
 			    "(combine_notes_cat_sort_uniq)");
 		return 0;
@@ -475,20 +477,21 @@ static int merge_changes(struct notes_merge_options *o,
 	for (i = 0; i < *num_changes; i++) {
 		struct notes_merge_pair *p = changes + i;
 		trace_printf("\t\t%.7s: %.7s -> %.7s/%.7s\n",
-		       sha1_to_hex(p->obj), sha1_to_hex(p->base),
-		       sha1_to_hex(p->local), sha1_to_hex(p->remote));
+		       oid_to_hex(&p->obj), oid_to_hex(&p->base),
+		       oid_to_hex(&p->local),
+		       oid_to_hex(&p->remote));
 
-		if (!hashcmp(p->base, p->remote)) {
+		if (!oidcmp(&p->base, &p->remote)) {
 			/* no remote change; nothing to do */
 			trace_printf("\t\t\tskipping (no remote change)\n");
-		} else if (!hashcmp(p->local, p->remote)) {
+		} else if (!oidcmp(&p->local, &p->remote)) {
 			/* same change in local and remote; nothing to do */
 			trace_printf("\t\t\tskipping (local == remote)\n");
-		} else if (!hashcmp(p->local, uninitialized) ||
-			   !hashcmp(p->local, p->base)) {
+		} else if (!oidcmp(&p->local, &uninitialized) ||
+			   !oidcmp(&p->local, &p->base)) {
 			/* no local change; adopt remote change */
 			trace_printf("\t\t\tno local change, adopted remote\n");
-			if (add_note(t, p->obj, p->remote,
+			if (add_note(t, p->obj.hash, p->remote.hash,
 				     combine_notes_overwrite))
 				die("BUG: combine_notes_overwrite failed");
 		} else {
