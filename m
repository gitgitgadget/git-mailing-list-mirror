Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903C220A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbdJAWKE (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:10:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751866AbdJAWIt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:08:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8A0AD60D94;
        Sun,  1 Oct 2017 22:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895728;
        bh=qKIYXvHhAfdbXkDYwVmwVZbjmGPN7zZMf050EBVMye4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZhr8ux9PiFFdwvZKKxH5jxJ0hHiPeUqXMNPmrHNdAy4UPKTaBXtXsJaq9XKvR94T
         GPZm65eCgjwvXaEvP1CqDvkQMzoQP31jfIUREbrD+jeBERzQyCv9RiB9gH5a2tkF7m
         22D1eH3gk2w+kbUWYhuGWwfFVF2AMIc3/9QSGjei9lBlMMHO7VAnjL4yjcRUVXGL9O
         4CdYn+I666qo6KtzNDq3UY0hQ0aic9xX8SWgCPNcWAtzXHM9Ok8LypFIYrFG8Z+H2O
         oRb+07t6b9ED9rHtBc+rUh0h8iIbIwUu06fM7Rs0MaJ1bkRtdL+OhOwV2uBBU+mzyS
         St9qjMiScItIEhcE98ATGoMnm79fIkIvUzSX6le5cD1wSlCRxFAyiqoy/bgTEyzxk3
         0ETzfzGbTqQ8UpKmFBXYPHHQy6YZyFnN2BnEbtYkRkDlitZlkh0ue+Dfr3TOH+4j7Y
         CAdqTepsfGkFX1b58eDXyTRkQvQ+7t+DusjyhSqvDcLDp/3F5vx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 04/24] refs: convert update_ref and refs_update_ref to use struct object_id
Date:   Sun,  1 Oct 2017 22:08:11 +0000
Message-Id: <20171001220831.214705-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert update_ref, refs_update_ref, and write_pseudoref to use struct
object_id.  Update the existing callers as well.  Remove update_ref_oid,
as it is no longer needed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c                  |  6 ++++--
 builtin/am.c              | 14 +++++++-------
 builtin/checkout.c        |  3 +--
 builtin/clone.c           | 14 +++++++-------
 builtin/merge.c           | 13 ++++++-------
 builtin/notes.c           | 10 +++++-----
 builtin/pull.c            |  2 +-
 builtin/reset.c           |  4 ++--
 builtin/update-ref.c      |  2 +-
 notes-cache.c             |  3 +--
 notes-utils.c             |  2 +-
 refs.c                    | 39 ++++++++++++++++-----------------------
 refs.h                    |  5 +----
 sequencer.c               |  9 +++------
 t/helper/test-ref-store.c | 10 +++++-----
 transport-helper.c        |  3 ++-
 transport.c               |  4 ++--
 17 files changed, 65 insertions(+), 78 deletions(-)

diff --git a/bisect.c b/bisect.c
index 96beeb5d13..e8470a2e0f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -685,11 +685,13 @@ static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 
 	memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
-	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev->hash, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0,
+		   UPDATE_REFS_DIE_ON_ERR);
 
 	argv_checkout[2] = bisect_rev_hex;
 	if (no_checkout) {
-		update_ref(NULL, "BISECT_HEAD", bisect_rev->hash, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
+			   UPDATE_REFS_DIE_ON_ERR);
 	} else {
 		int res;
 		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
diff --git a/builtin/am.c b/builtin/am.c
index d7513f5375..32120f42df 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1068,8 +1068,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	if (!get_oid("HEAD", &curr_head)) {
 		write_state_text(state, "abort-safety", oid_to_hex(&curr_head));
 		if (!state->rebasing)
-			update_ref_oid("am", "ORIG_HEAD", &curr_head, NULL, 0,
-					UPDATE_REFS_DIE_ON_ERR);
+			update_ref("am", "ORIG_HEAD", &curr_head, NULL, 0,
+				   UPDATE_REFS_DIE_ON_ERR);
 	} else {
 		write_state_text(state, "abort-safety", "");
 		if (!state->rebasing)
@@ -1686,8 +1686,8 @@ static void do_commit(const struct am_state *state)
 	strbuf_addf(&sb, "%s: %.*s", reflog_msg, linelen(state->msg),
 			state->msg);
 
-	update_ref_oid(sb.buf, "HEAD", &commit, old_oid, 0,
-			UPDATE_REFS_DIE_ON_ERR);
+	update_ref(sb.buf, "HEAD", &commit, old_oid, 0,
+		   UPDATE_REFS_DIE_ON_ERR);
 
 	if (state->rebasing) {
 		FILE *fp = xfopen(am_path(state, "rewritten"), "a");
@@ -2147,9 +2147,9 @@ static void am_abort(struct am_state *state)
 	clean_index(&curr_head, &orig_head);
 
 	if (has_orig_head)
-		update_ref_oid("am --abort", "HEAD", &orig_head,
-				has_curr_head ? &curr_head : NULL, 0,
-				UPDATE_REFS_DIE_ON_ERR);
+		update_ref("am --abort", "HEAD", &orig_head,
+			   has_curr_head ? &curr_head : NULL, 0,
+			   UPDATE_REFS_DIE_ON_ERR);
 	else if (curr_branch)
 		delete_ref(NULL, curr_branch, NULL, REF_NODEREF);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3345a0d16f..fd0dec401e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -664,8 +664,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
-		update_ref(msg.buf, "HEAD", new->commit->object.oid.hash, NULL,
-			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+		update_ref(msg.buf, "HEAD", &new->commit->object.oid, NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path &&
 			    advice_detached_head && !opts->force_detach)
diff --git a/builtin/clone.c b/builtin/clone.c
index dbddd98f80..4135621aa3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -610,8 +610,8 @@ static void write_followtags(const struct ref *refs, const char *msg)
 			continue;
 		if (!has_object_file(&ref->old_oid))
 			continue;
-		update_ref(msg, ref->name, ref->old_oid.hash,
-			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+		update_ref(msg, ref->name, &ref->old_oid, NULL, 0,
+			   UPDATE_REFS_DIE_ON_ERR);
 	}
 }
 
@@ -682,23 +682,23 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		if (create_symref("HEAD", our->name, NULL) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare) {
-			update_ref(msg, "HEAD", our->old_oid.hash, NULL, 0,
+			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
 				   UPDATE_REFS_DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(&our->old_oid);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
-		update_ref(msg, "HEAD", c->object.oid.hash,
-			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NODEREF,
+			   UPDATE_REFS_DIE_ON_ERR);
 	} else if (remote) {
 		/*
 		 * We know remote HEAD points to a non-branch, or
 		 * HEAD points to a branch but we don't know which one.
 		 * Detach HEAD in all these cases.
 		 */
-		update_ref(msg, "HEAD", remote->old_oid.hash,
-			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+		update_ref(msg, "HEAD", &remote->old_oid, NULL, REF_NODEREF,
+			   UPDATE_REFS_DIE_ON_ERR);
 	}
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index ab5ffe85e8..99d4b873f0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -405,9 +405,8 @@ static void finish(struct commit *head_commit,
 			printf(_("No merge message -- not updating HEAD\n"));
 		else {
 			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
-			update_ref(reflog_message.buf, "HEAD",
-				new_head->hash, head->hash, 0,
-				UPDATE_REFS_DIE_ON_ERR);
+			update_ref(reflog_message.buf, "HEAD", new_head, head,
+				   0, UPDATE_REFS_DIE_ON_ERR);
 			/*
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
@@ -1261,8 +1260,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die(_("Can merge only exactly one commit into empty head"));
 		remote_head_oid = &remoteheads->item->object.oid;
 		read_empty(remote_head_oid->hash, 0);
-		update_ref("initial pull", "HEAD", remote_head_oid->hash,
-			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
+			   UPDATE_REFS_DIE_ON_ERR);
 		goto done;
 	}
 
@@ -1357,8 +1356,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		free(list);
 	}
 
-	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head_commit->object.oid.hash,
-		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	update_ref("updating ORIG_HEAD", "ORIG_HEAD",
+		   &head_commit->object.oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
 	if (remoteheads && !common) {
 		/* No common ancestors found. */
diff --git a/builtin/notes.c b/builtin/notes.c
index 8e54f2d146..8276af419b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -736,8 +736,8 @@ static int merge_commit(struct notes_merge_options *o)
 	format_commit_message(partial, "%s", &msg, &pretty_ctx);
 	strbuf_trim(&msg);
 	strbuf_insert(&msg, 0, "notes: ", 7);
-	update_ref(msg.buf, o->local_ref, oid.hash,
-		   is_null_oid(&parent_oid) ? NULL : parent_oid.hash,
+	update_ref(msg.buf, o->local_ref, &oid,
+		   is_null_oid(&parent_oid) ? NULL : &parent_oid,
 		   0, UPDATE_REFS_DIE_ON_ERR);
 
 	free_notes(t);
@@ -850,12 +850,12 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	if (result >= 0) /* Merge resulted (trivially) in result_oid */
 		/* Update default notes ref with new commit */
-		update_ref(msg.buf, default_notes_ref(), result_oid.hash, NULL,
-			   0, UPDATE_REFS_DIE_ON_ERR);
+		update_ref(msg.buf, default_notes_ref(), &result_oid, NULL, 0,
+			   UPDATE_REFS_DIE_ON_ERR);
 	else { /* Merge has unresolved conflicts */
 		const struct worktree *wt;
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
-		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_oid.hash, NULL,
+		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", &result_oid, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
 		wt = find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
diff --git a/builtin/pull.c b/builtin/pull.c
index 6f772e8a22..9b2d67fe43 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -544,7 +544,7 @@ static int pull_into_void(const struct object_id *merge_head,
 	if (checkout_fast_forward(&empty_tree_oid, merge_head, 0))
 		return 1;
 
-	if (update_ref("initial pull", "HEAD", merge_head->hash, curr_head->hash, 0, UPDATE_REFS_DIE_ON_ERR))
+	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
 		return 1;
 
 	return 0;
diff --git a/builtin/reset.c b/builtin/reset.c
index 5f3632e05b..d4003f76ab 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -266,12 +266,12 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 	if (!get_oid("HEAD", &oid_orig)) {
 		orig = &oid_orig;
 		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
-		update_ref_oid(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
+		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
 			   UPDATE_REFS_MSG_ON_ERR);
 	} else if (old_orig)
 		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
 	set_reflog_message(&msg, "updating HEAD", rev);
-	update_ref_status = update_ref_oid(msg.buf, "HEAD", oid, orig, 0,
+	update_ref_status = update_ref(msg.buf, "HEAD", oid, orig, 0,
 				       UPDATE_REFS_MSG_ON_ERR);
 	strbuf_release(&msg);
 	return update_ref_status;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index bf0f80ebae..f491cf1a92 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -437,7 +437,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 				  (oldval && !is_null_oid(&oldoid)) ? &oldoid : NULL,
 				  flags);
 	else
-		return update_ref(msg, refname, oid.hash, oldval ? oldoid.hash : NULL,
+		return update_ref(msg, refname, &oid, oldval ? &oldoid : NULL,
 				  flags | create_reflog_flag,
 				  UPDATE_REFS_DIE_ON_ERR);
 }
diff --git a/notes-cache.c b/notes-cache.c
index 29b4cede5f..927b6645db 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -59,8 +59,7 @@ int notes_cache_write(struct notes_cache *c)
 	if (commit_tree(c->validity, strlen(c->validity), tree_oid.hash, NULL,
 			commit_oid.hash, NULL, NULL) < 0)
 		return -1;
-	if (update_ref("update notes cache", c->tree.update_ref, commit_oid.hash,
-		       NULL, 0, UPDATE_REFS_QUIET_ON_ERR) < 0)
+	if (update_ref("update notes cache", c->tree.update_ref, &commit_oid, NULL, 0, UPDATE_REFS_QUIET_ON_ERR) < 0)
 		return -1;
 
 	return 0;
diff --git a/notes-utils.c b/notes-utils.c
index 9765deb41a..3a7008948c 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -49,7 +49,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 
 	create_notes_commit(t, NULL, buf.buf, buf.len, commit_oid.hash);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
-	update_ref(buf.buf, t->update_ref, commit_oid.hash, NULL, 0,
+	update_ref(buf.buf, t->update_ref, &commit_oid, NULL, 0,
 		   UPDATE_REFS_DIE_ON_ERR);
 
 	strbuf_release(&buf);
diff --git a/refs.c b/refs.c
index 0a5b68d6fb..66d66af126 100644
--- a/refs.c
+++ b/refs.c
@@ -574,8 +574,8 @@ long get_files_ref_lock_timeout_ms(void)
 	return timeout_ms;
 }
 
-static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
-			   const unsigned char *old_sha1, struct strbuf *err)
+static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
+			   const struct object_id *old_oid, struct strbuf *err)
 {
 	const char *filename;
 	int fd;
@@ -583,7 +583,7 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 	struct strbuf buf = STRBUF_INIT;
 	int ret = -1;
 
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
+	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 
 	filename = git_path("%s", pseudoref);
 	fd = hold_lock_file_for_update_timeout(&lock, filename,
@@ -595,12 +595,12 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 		goto done;
 	}
 
-	if (old_sha1) {
-		unsigned char actual_old_sha1[20];
+	if (old_oid) {
+		struct object_id actual_old_oid;
 
-		if (read_ref(pseudoref, actual_old_sha1))
+		if (read_ref(pseudoref, actual_old_oid.hash))
 			die("could not read ref '%s'", pseudoref);
-		if (hashcmp(actual_old_sha1, old_sha1)) {
+		if (oidcmp(&actual_old_oid, old_oid)) {
 			strbuf_addf(err, "unexpected sha1 when writing '%s'", pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
@@ -985,17 +985,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      flags, NULL, err);
 }
 
-int update_ref_oid(const char *msg, const char *refname,
-	       const struct object_id *new_oid, const struct object_id *old_oid,
-	       unsigned int flags, enum action_on_err onerr)
-{
-	return update_ref(msg, refname, new_oid ? new_oid->hash : NULL,
-		old_oid ? old_oid->hash : NULL, flags, onerr);
-}
 
 int refs_update_ref(struct ref_store *refs, const char *msg,
-		    const char *refname, const unsigned char *new_sha1,
-		    const unsigned char *old_sha1, unsigned int flags,
+		    const char *refname, const struct object_id *new_oid,
+		    const struct object_id *old_oid, unsigned int flags,
 		    enum action_on_err onerr)
 {
 	struct ref_transaction *t = NULL;
@@ -1003,12 +996,12 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	int ret = 0;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		assert(refs == get_main_ref_store());
-		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
+		ret = write_pseudoref(refname, new_oid, old_oid, &err);
 	} else {
 		t = ref_store_transaction_begin(refs, &err);
 		if (!t ||
-		    ref_transaction_update(t, refname, new_sha1, old_sha1,
+		    ref_transaction_update(t, refname, new_oid ? new_oid->hash : NULL,
+					   old_oid ? old_oid->hash : NULL,
 					   flags, msg, &err) ||
 		    ref_transaction_commit(t, &err)) {
 			ret = 1;
@@ -1038,12 +1031,12 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 }
 
 int update_ref(const char *msg, const char *refname,
-	       const unsigned char *new_sha1,
-	       const unsigned char *old_sha1,
+	       const struct object_id *new_oid,
+	       const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr)
 {
-	return refs_update_ref(get_main_ref_store(), msg, refname, new_sha1,
-			       old_sha1, flags, onerr);
+	return refs_update_ref(get_main_ref_store(), msg, refname, new_oid,
+			       old_oid, flags, onerr);
 }
 
 char *shorten_unambiguous_ref(const char *refname, int strict)
diff --git a/refs.h b/refs.h
index 07e9907b31..369614d392 100644
--- a/refs.h
+++ b/refs.h
@@ -636,12 +636,9 @@ void ref_transaction_free(struct ref_transaction *transaction);
  * argument.
  */
 int refs_update_ref(struct ref_store *refs, const char *msg, const char *refname,
-		    const unsigned char *new_sha1, const unsigned char *old_sha1,
+		    const struct object_id *new_oid, const struct object_id *old_oid,
 		    unsigned int flags, enum action_on_err onerr);
 int update_ref(const char *msg, const char *refname,
-	       const unsigned char *new_sha1, const unsigned char *old_sha1,
-	       unsigned int flags, enum action_on_err onerr);
-int update_ref_oid(const char *msg, const char *refname,
 	       const struct object_id *new_oid, const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr);
 
diff --git a/sequencer.c b/sequencer.c
index 60636ce54b..b349474bd3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1114,12 +1114,10 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	 * write it at all.
 	 */
 	if (command == TODO_PICK && !opts->no_commit && (res == 0 || res == 1) &&
-	    update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.oid.hash, NULL,
-		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+	    update_ref(NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL, REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
 	if (command == TODO_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
-	    update_ref(NULL, "REVERT_HEAD", commit->object.oid.hash, NULL,
-		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+	    update_ref(NULL, "REVERT_HEAD", &commit->object.oid, NULL, REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
 
 	if (res) {
@@ -2123,8 +2121,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			}
 			msg = reflog_message(opts, "finish", "%s onto %s",
 				head_ref.buf, buf.buf);
-			if (update_ref(msg, head_ref.buf, head.hash, orig.hash,
-					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
+			if (update_ref(msg, head_ref.buf, &head, &orig, REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
 				res = error(_("could not update %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 4624238641..af8dba9560 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -233,15 +233,15 @@ static int cmd_update_ref(struct ref_store *refs, const char **argv)
 	const char *new_sha1_buf = notnull(*argv++, "old-sha1");
 	const char *old_sha1_buf = notnull(*argv++, "old-sha1");
 	unsigned int flags = arg_flags(*argv++, "flags");
-	unsigned char old_sha1[20];
-	unsigned char new_sha1[20];
+	struct object_id old_oid;
+	struct object_id new_oid;
 
-	if (get_sha1_hex(old_sha1_buf, old_sha1) ||
-	    get_sha1_hex(new_sha1_buf, new_sha1))
+	if (get_oid_hex(old_sha1_buf, &old_oid) ||
+	    get_oid_hex(new_sha1_buf, &new_oid))
 		die("not sha-1");
 
 	return refs_update_ref(refs, msg, refname,
-			       new_sha1, old_sha1,
+			       &new_oid, &old_oid,
 			       flags, UPDATE_REFS_DIE_ON_ERR);
 }
 
diff --git a/transport-helper.c b/transport-helper.c
index c948d5215c..f183601261 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -795,7 +795,8 @@ static int push_update_refs_status(struct helper_data *data,
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (!private)
 			continue;
-		update_ref("update by helper", private, ref->new_oid.hash, NULL, 0, 0);
+		update_ref("update by helper", private, &ref->new_oid, NULL,
+			   0, 0);
 		free(private);
 	}
 	strbuf_release(&buf);
diff --git a/transport.c b/transport.c
index fb8c01e57a..09bd06e6e5 100644
--- a/transport.c
+++ b/transport.c
@@ -305,8 +305,8 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 		if (ref->deletion) {
 			delete_ref(NULL, rs.dst, NULL, 0);
 		} else
-			update_ref("update by push", rs.dst,
-					ref->new_oid.hash, NULL, 0, 0);
+			update_ref("update by push", rs.dst, &ref->new_oid,
+				   NULL, 0, 0);
 		free(rs.dst);
 	}
 }
-- 
2.14.2.822.g60be5d43e6

