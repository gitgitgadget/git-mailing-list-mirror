Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F27F201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 01:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdBUBKv (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 20:10:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59068 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750923AbdBUBKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 20:10:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBC12696C0;
        Mon, 20 Feb 2017 20:10:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=bATp
        v4rQFhutIJelNasbr90TZuA=; b=bRDu0dw6atiNwGpG6X+02xuDFzEb7jz/Nm+g
        bK0FHYWabw08UJWds1g/qSxyHPeC+q94E5RnXWW3smLmeDflVBfW/ZyqPDiWu99N
        J05ooCp+JjezMfel5+KvlUARjbaNu+XuzMzjiUiRPx1fBOgcnKOW15QFwYpcJL3f
        QETLtlU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8006696BF;
        Mon, 20 Feb 2017 20:10:48 -0500 (EST)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D639B696BA;
        Mon, 20 Feb 2017 20:10:46 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH v2 1/4] delete_ref: accept a reflog message argument
Date:   Mon, 20 Feb 2017 20:10:32 -0500
Message-Id: <20170221011035.847-2-kyle@kyleam.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170221011035.847-1-kyle@kyleam.com>
References: <20170217035800.13214-1-kyle@kyleam.com>
 <20170221011035.847-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 9408890E-F7D2-11E6-921A-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=bATpv4rQFhutIJelNasbr90TZuA=;
 b=DpcbCniX9cjM3IDmxzDLt6I+ilS2UQnLEkjz5a2ysCTZBF7DAtuCxIWsnbNEJ77MdiSDqGnwFB2f2lZxZZZePPfKZ7HfDdbc6oMSsKvQ2savnBNWjaepQzVTrmfpSGzshel+wwV2bFJ0YnFDP1Q42fPdznLJP87ovZKe67rrYvo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the current branch is renamed with 'git branch -m/-M' or deleted
with 'git update-ref -m<msg> -d', the event is recorded in HEAD's log
with an empty message.  In preparation for adding a more meaningful
message to HEAD's log in these cases, update delete_ref() to take a
message argument and pass it along to ref_transaction_delete().
Modify all callers to pass NULL for the new message argument; no
change in behavior is intended.

Note that this is relevant for HEAD's log but not for the deleted
ref's log, which is currently deleted along with the ref.  Even if it
were not, an entry for the deletion wouldn't be present in the deleted
ref's log.  files_transaction_commit() writes to the log if
REF_NEEDS_COMMIT or REF_LOG_ONLY are set, but lock_ref_for_update()
doesn't set REF_NEEDS_COMMIT for the deleted ref because REF_DELETING
is set.  In contrast, the update for HEAD has REF_LOG_ONLY set by
split_head_update(), resulting in the deletion being logged.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 builtin/am.c           | 4 ++--
 builtin/branch.c       | 2 +-
 builtin/notes.c        | 4 ++--
 builtin/remote.c       | 4 ++--
 builtin/replace.c      | 2 +-
 builtin/reset.c        | 2 +-
 builtin/symbolic-ref.c | 2 +-
 builtin/tag.c          | 2 +-
 builtin/update-ref.c   | 2 +-
 fast-import.c          | 2 +-
 refs.c                 | 6 +++---
 refs.h                 | 4 ++--
 refs/files-backend.c   | 6 +++---
 transport.c            | 2 +-
 14 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 31fb60578..f7a7a971f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1049,7 +1049,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	} else {
 		write_state_text(state, "abort-safety", "");
 		if (!state->rebasing)
-			delete_ref("ORIG_HEAD", NULL, 0);
+			delete_ref(NULL, "ORIG_HEAD", NULL, 0);
 	}
 
 	/*
@@ -2172,7 +2172,7 @@ static void am_abort(struct am_state *state)
 				has_curr_head ? &curr_head : NULL, 0,
 				UPDATE_REFS_DIE_ON_ERR);
 	else if (curr_branch)
-		delete_ref(curr_branch, NULL, REF_NODEREF);
+		delete_ref(NULL, curr_branch, NULL, REF_NODEREF);
 
 	free(curr_branch);
 	am_destroy(state);
diff --git a/builtin/branch.c b/builtin/branch.c
index 9d30f55b0..8f8242e07 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -251,7 +251,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			goto next;
 		}
 
-		if (delete_ref(name, is_null_sha1(sha1) ? NULL : sha1,
+		if (delete_ref(NULL, name, is_null_sha1(sha1) ? NULL : sha1,
 			       REF_NODEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote-tracking branch '%s'")
diff --git a/builtin/notes.c b/builtin/notes.c
index 5248a9bad..4b492abd4 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -681,9 +681,9 @@ static int merge_abort(struct notes_merge_options *o)
 	 * notes_merge_abort() to remove .git/NOTES_MERGE_WORKTREE.
 	 */
 
-	if (delete_ref("NOTES_MERGE_PARTIAL", NULL, 0))
+	if (delete_ref(NULL, "NOTES_MERGE_PARTIAL", NULL, 0))
 		ret += error(_("failed to delete ref NOTES_MERGE_PARTIAL"));
-	if (delete_ref("NOTES_MERGE_REF", NULL, REF_NODEREF))
+	if (delete_ref(NULL, "NOTES_MERGE_REF", NULL, REF_NODEREF))
 		ret += error(_("failed to delete ref NOTES_MERGE_REF"));
 	if (notes_merge_abort(o))
 		ret += error(_("failed to remove 'git notes merge' worktree"));
diff --git a/builtin/remote.c b/builtin/remote.c
index 5339ed6ad..2b415911b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -691,7 +691,7 @@ static int mv(int argc, const char **argv)
 		read_ref_full(item->string, RESOLVE_REF_READING, oid.hash, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
-		if (delete_ref(item->string, NULL, REF_NODEREF))
+		if (delete_ref(NULL, item->string, NULL, REF_NODEREF))
 			die(_("deleting '%s' failed"), item->string);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
@@ -1248,7 +1248,7 @@ static int set_head(int argc, const char **argv)
 			head_name = xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
-		if (delete_ref(buf.buf, NULL, REF_NODEREF))
+		if (delete_ref(NULL, buf.buf, NULL, REF_NODEREF))
 			result |= error(_("Could not delete %s"), buf.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
diff --git a/builtin/replace.c b/builtin/replace.c
index b58c714cb..226d0f952 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -121,7 +121,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 static int delete_replace_ref(const char *name, const char *ref,
 			      const unsigned char *sha1)
 {
-	if (delete_ref(ref, sha1, 0))
+	if (delete_ref(NULL, ref, sha1, 0))
 		return 1;
 	printf("Deleted replace ref '%s'\n", name);
 	return 0;
diff --git a/builtin/reset.c b/builtin/reset.c
index 8ab915bfc..fc3b906c4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -256,7 +256,7 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 		update_ref_oid(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
 			   UPDATE_REFS_MSG_ON_ERR);
 	} else if (old_orig)
-		delete_ref("ORIG_HEAD", old_orig->hash, 0);
+		delete_ref(NULL, "ORIG_HEAD", old_orig->hash, 0);
 	set_reflog_message(&msg, "updating HEAD", rev);
 	update_ref_status = update_ref_oid(msg.buf, "HEAD", oid, orig, 0,
 				       UPDATE_REFS_MSG_ON_ERR);
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 96eed9446..70addef15 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -58,7 +58,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 			die("Cannot delete %s, not a symbolic ref", argv[0]);
 		if (!strcmp(argv[0], "HEAD"))
 			die("deleting '%s' is not allowed", argv[0]);
-		return delete_ref(argv[0], NULL, REF_NODEREF);
+		return delete_ref(NULL, argv[0], NULL, REF_NODEREF);
 	}
 
 	switch (argc) {
diff --git a/builtin/tag.c b/builtin/tag.c
index e40c4a967..c23d6d4bc 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -97,7 +97,7 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 static int delete_tag(const char *name, const char *ref,
 		      const unsigned char *sha1, const void *cb_data)
 {
-	if (delete_ref(ref, sha1, 0))
+	if (delete_ref(NULL, ref, sha1, 0))
 		return 1;
 	printf(_("Deleted tag '%s' (was %s)\n"), name, find_unique_abbrev(sha1, DEFAULT_ABBREV));
 	return 0;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7f30d3a76..86d006d36 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -433,7 +433,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		 * For purposes of backwards compatibility, we treat
 		 * NULL_SHA1 as "don't care" here:
 		 */
-		return delete_ref(refname,
+		return delete_ref(NULL, refname,
 				  (oldval && !is_null_sha1(oldsha1)) ? oldsha1 : NULL,
 				  flags);
 	else
diff --git a/fast-import.c b/fast-import.c
index 64fe602f0..6c13472c4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1752,7 +1752,7 @@ static int update_branch(struct branch *b)
 
 	if (is_null_sha1(b->sha1)) {
 		if (b->delete)
-			delete_ref(b->name, NULL, 0);
+			delete_ref(NULL, b->name, NULL, 0);
 		return 0;
 	}
 	if (read_ref(b->name, old_sha1))
diff --git a/refs.c b/refs.c
index cd36b64ed..053d23a90 100644
--- a/refs.c
+++ b/refs.c
@@ -591,8 +591,8 @@ static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1
 	return 0;
 }
 
-int delete_ref(const char *refname, const unsigned char *old_sha1,
-	       unsigned int flags)
+int delete_ref(const char *msg, const char *refname,
+	       const unsigned char *old_sha1, unsigned int flags)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -603,7 +603,7 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_sha1,
-				   flags, NULL, &err) ||
+				   flags, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ref_transaction_free(transaction);
diff --git a/refs.h b/refs.h
index 9fbff90e7..5880886a7 100644
--- a/refs.h
+++ b/refs.h
@@ -276,8 +276,8 @@ int reflog_exists(const char *refname);
  * exists, regardless of its old value. It is an error for old_sha1 to
  * be NULL_SHA1. flags is passed through to ref_transaction_delete().
  */
-int delete_ref(const char *refname, const unsigned char *old_sha1,
-	       unsigned int flags);
+int delete_ref(const char *msg, const char *refname,
+	       const unsigned char *old_sha1, unsigned int flags);
 
 /*
  * Delete the specified references. If there are any problems, emit
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c041d4ba2..299eb4d8a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2489,7 +2489,7 @@ static int files_delete_refs(struct ref_store *ref_store,
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 
-		if (delete_ref(refname, NULL, flags))
+		if (delete_ref(NULL, refname, NULL, flags))
 			result |= error(_("could not remove reference %s"), refname);
 	}
 
@@ -2616,7 +2616,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
-	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
+	if (delete_ref(NULL, oldrefname, orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
@@ -2630,7 +2630,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	 */
 	if (!read_ref_full(newrefname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 			   sha1, NULL) &&
-	    delete_ref(newrefname, NULL, REF_NODEREF)) {
+	    delete_ref(NULL, newrefname, NULL, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
diff --git a/transport.c b/transport.c
index d72e08948..269352b22 100644
--- a/transport.c
+++ b/transport.c
@@ -299,7 +299,7 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 		if (verbose)
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
 		if (ref->deletion) {
-			delete_ref(rs.dst, NULL, 0);
+			delete_ref(NULL, rs.dst, NULL, 0);
 		} else
 			update_ref("update by push", rs.dst,
 					ref->new_oid.hash, NULL, 0, 0);
-- 
2.11.1

