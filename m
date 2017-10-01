Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D347820A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdJAWIw (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:08:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54098 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751895AbdJAWIu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:08:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 19CC660D97;
        Sun,  1 Oct 2017 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895729;
        bh=4RehEJLta1UvdUqMUNdEQz2a6MoXgXJuAZnJk4iJXVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LI/o/HXXi7xqw35NHI34HyDbO7L73pmfKO+2j0hWPtP0MRFm3N+p4PkFFmBV1vVbE
         AXfnLQYanAZM9taN/w/AWA9xrj8FXVfYX6Y5VbZ5NhJoDxanTOQBWr18QYzKUQ6n73
         /Dt8vChPyO3ZmqKPvsIapsRhK81jDjSvS4AKK0eZ3UCiU8iGil7kg4r7dz6Hj7qVn1
         rIiEpb3wZUj7QIyiw+chUWXj1ChQkcqo3lR253rqMHKeCJgExu/3RY4nvXJ2vmryhu
         8zEewRVUKo2UwuKrojUlk2UuD8rFkYigFzzYm2UVrVx3QcTeATGqbyo0tvZccUbNKX
         ZACNlvI8iI2nle5295s9M8Ig6z0/BR/OvaKEMmzDl8G/eOJ2/iBpJBswQoL6INaSgu
         K5BsqDXuaMe6N4dfwEslNNogcom7g9shzTm8hnbma+1VhwtAY8Y3R/DosCzdnDLGUP
         HrDlC9gteyZYoGhFQ7hBt6OSv9/fUQ0+ste0pgjrjHxvI/X3VTk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 05/24] refs: update ref transactions to use struct object_id
Date:   Sun,  1 Oct 2017 22:08:12 +0000
Message-Id: <20171001220831.214705-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the ref transaction code to use struct object_id.  Remove one
NULL pointer check which was previously inserted around a dereference;
since we now pass a pointer to struct object_id directly through, the
code we're calling handles this for us.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 branch.c               |  2 +-
 builtin/clone.c        |  2 +-
 builtin/commit.c       |  4 ++--
 builtin/fetch.c        |  4 ++--
 builtin/receive-pack.c |  4 ++--
 builtin/replace.c      |  2 +-
 builtin/tag.c          |  2 +-
 builtin/update-ref.c   |  8 ++++----
 fast-import.c          |  4 ++--
 refs.c                 | 44 +++++++++++++++++++++-----------------------
 refs.h                 | 24 ++++++++++++------------
 refs/files-backend.c   | 12 ++++++------
 refs/refs-internal.h   |  4 ++--
 sequencer.c            |  2 +-
 walker.c               |  2 +-
 15 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/branch.c b/branch.c
index 4377ce2fb1..45029ea142 100644
--- a/branch.c
+++ b/branch.c
@@ -305,7 +305,7 @@ void create_branch(const char *name, const char *start_name,
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, ref.buf,
-					   oid.hash, forcing ? NULL : null_sha1,
+					   &oid, forcing ? NULL : &null_oid,
 					   0, msg, &err) ||
 		    ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
diff --git a/builtin/clone.c b/builtin/clone.c
index 4135621aa3..665a0e2673 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -588,7 +588,7 @@ static void write_remote_refs(const struct ref *local_refs)
 	for (r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
 			continue;
-		if (ref_transaction_create(t, r->peer_ref->name, r->old_oid.hash,
+		if (ref_transaction_create(t, r->peer_ref->name, &r->old_oid,
 					   0, NULL, &err))
 			die("%s", err.buf);
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 0f8ddb6866..d5fbf404f4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1785,9 +1785,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, "HEAD", oid.hash,
+	    ref_transaction_update(transaction, "HEAD", &oid,
 				   current_head
-				   ? current_head->object.oid.hash : null_sha1,
+				   ? &current_head->object.oid : &null_oid,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 225c734924..859be91d6c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -457,8 +457,8 @@ static int s_update_ref(const char *action,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref->name,
-				   ref->new_oid.hash,
-				   check_old ? ref->old_oid.hash : NULL,
+				   &ref->new_oid,
+				   check_old ? &ref->old_oid : NULL,
 				   0, msg, &err))
 		goto fail;
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 29a0f3b75f..39defd4e3c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1139,7 +1139,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 		if (ref_transaction_delete(transaction,
 					   namespaced_name,
-					   old_oid ? old_oid->hash : NULL,
+					   old_oid,
 					   0, "push", &err)) {
 			rp_error("%s", err.buf);
 			strbuf_release(&err);
@@ -1156,7 +1156,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 		if (ref_transaction_update(transaction,
 					   namespaced_name,
-					   new_oid->hash, old_oid->hash,
+					   new_oid, old_oid,
 					   0, "push",
 					   &err)) {
 			rp_error("%s", err.buf);
diff --git a/builtin/replace.c b/builtin/replace.c
index 2854eaa0f3..3099e55307 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -175,7 +175,7 @@ static int replace_object_oid(const char *object_ref,
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref.buf, repl->hash, prev.hash,
+	    ref_transaction_update(transaction, ref.buf, repl, &prev,
 				   0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
diff --git a/builtin/tag.c b/builtin/tag.c
index 46ff4ca736..2ededc3fb1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -543,7 +543,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref.buf, object.hash, prev.hash,
+	    ref_transaction_update(transaction, ref.buf, &object, &prev,
 				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
 				   reflog_msg.buf, &err) ||
 	    ref_transaction_commit(transaction, &err))
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index f491cf1a92..cf1552b478 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -200,7 +200,7 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
 		die("update %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname,
-				   new_oid.hash, have_old ? old_oid.hash : NULL,
+				   &new_oid, have_old ? &old_oid : NULL,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
@@ -232,7 +232,7 @@ static const char *parse_cmd_create(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, new_oid.hash,
+	if (ref_transaction_create(transaction, refname, &new_oid,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
@@ -269,7 +269,7 @@ static const char *parse_cmd_delete(struct ref_transaction *transaction,
 		die("delete %s: extra input: %s", refname, next);
 
 	if (ref_transaction_delete(transaction, refname,
-				   have_old ? old_oid.hash : NULL,
+				   have_old ? &old_oid : NULL,
 				   update_flags, msg, &err))
 		die("%s", err.buf);
 
@@ -298,7 +298,7 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	if (ref_transaction_verify(transaction, refname, old_oid.hash,
+	if (ref_transaction_verify(transaction, refname, &old_oid,
 				   update_flags, &err))
 		die("%s", err.buf);
 
diff --git a/fast-import.c b/fast-import.c
index 35bf671f12..2d2d0d98f0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1778,7 +1778,7 @@ static int update_branch(struct branch *b)
 	}
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, b->name, b->oid.hash, old_oid.hash,
+	    ref_transaction_update(transaction, b->name, &b->oid, &old_oid,
 				   0, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1820,7 +1820,7 @@ static void dump_tags(void)
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
 		if (ref_transaction_update(transaction, ref_name.buf,
-					   t->oid.hash, NULL, 0, msg, &err)) {
+					   &t->oid, NULL, 0, msg, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
 		}
diff --git a/refs.c b/refs.c
index 66d66af126..90c2f9ccca 100644
--- a/refs.c
+++ b/refs.c
@@ -668,8 +668,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname,
-				   old_oid ? old_oid->hash : NULL,
+	    ref_transaction_delete(transaction, refname, old_oid,
 				   flags, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
@@ -895,8 +894,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 struct ref_update *ref_transaction_add_update(
 		struct ref_transaction *transaction,
 		const char *refname, unsigned int flags,
-		const unsigned char *new_sha1,
-		const unsigned char *old_sha1,
+		const struct object_id *new_oid,
+		const struct object_id *old_oid,
 		const char *msg)
 {
 	struct ref_update *update;
@@ -914,23 +913,23 @@ struct ref_update *ref_transaction_add_update(
 	update->flags = flags;
 
 	if (flags & REF_HAVE_NEW)
-		hashcpy(update->new_oid.hash, new_sha1);
+		oidcpy(&update->new_oid, new_oid);
 	if (flags & REF_HAVE_OLD)
-		hashcpy(update->old_oid.hash, old_sha1);
+		oidcpy(&update->old_oid, old_oid);
 	update->msg = xstrdup_or_null(msg);
 	return update;
 }
 
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
-			   const unsigned char *new_sha1,
-			   const unsigned char *old_sha1,
+			   const struct object_id *new_oid,
+			   const struct object_id *old_oid,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
 	assert(err);
 
-	if ((new_sha1 && !is_null_sha1(new_sha1)) ?
+	if ((new_oid && !is_null_oid(new_oid)) ?
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
 	    !refname_is_safe(refname)) {
 		strbuf_addf(err, "refusing to update ref with bad name '%s'",
@@ -940,48 +939,48 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
 
-	flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
+	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
-				   new_sha1, old_sha1, msg);
+				   new_oid, old_oid, msg);
 	return 0;
 }
 
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
-			   const unsigned char *new_sha1,
+			   const struct object_id *new_oid,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
-	if (!new_sha1 || is_null_sha1(new_sha1))
+	if (!new_oid || is_null_oid(new_oid))
 		die("BUG: create called without valid new_sha1");
-	return ref_transaction_update(transaction, refname, new_sha1,
-				      null_sha1, flags, msg, err);
+	return ref_transaction_update(transaction, refname, new_oid,
+				      &null_oid, flags, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
-			   const unsigned char *old_sha1,
+			   const struct object_id *old_oid,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
-	if (old_sha1 && is_null_sha1(old_sha1))
+	if (old_oid && is_null_oid(old_oid))
 		die("BUG: delete called with old_sha1 set to zeros");
 	return ref_transaction_update(transaction, refname,
-				      null_sha1, old_sha1,
+				      &null_oid, old_oid,
 				      flags, msg, err);
 }
 
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
-			   const unsigned char *old_sha1,
+			   const struct object_id *old_oid,
 			   unsigned int flags,
 			   struct strbuf *err)
 {
-	if (!old_sha1)
+	if (!old_oid)
 		die("BUG: verify called with old_sha1 set to NULL");
 	return ref_transaction_update(transaction, refname,
-				      NULL, old_sha1,
+				      NULL, old_oid,
 				      flags, NULL, err);
 }
 
@@ -1000,8 +999,7 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	} else {
 		t = ref_store_transaction_begin(refs, &err);
 		if (!t ||
-		    ref_transaction_update(t, refname, new_oid ? new_oid->hash : NULL,
-					   old_oid ? old_oid->hash : NULL,
+		    ref_transaction_update(t, refname, new_oid, old_oid,
 					   flags, msg, &err) ||
 		    ref_transaction_commit(t, &err)) {
 			ret = 1;
diff --git a/refs.h b/refs.h
index 369614d392..543dcc5956 100644
--- a/refs.h
+++ b/refs.h
@@ -519,15 +519,15 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
-			   const unsigned char *new_sha1,
-			   const unsigned char *old_sha1,
+			   const struct object_id *new_oid,
+			   const struct object_id *old_oid,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
- * Add a reference creation to transaction. new_sha1 is the value that
+ * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be
- * null_sha1. It is verified that the reference does not exist
+ * null_oid. It is verified that the reference does not exist
  * already.
  *
  * See the above comment "Reference transaction updates" for more
@@ -535,35 +535,35 @@ int ref_transaction_update(struct ref_transaction *transaction,
  */
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
-			   const unsigned char *new_sha1,
+			   const struct object_id *new_oid,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
- * Add a reference deletion to transaction. If old_sha1 is non-NULL,
+ * Add a reference deletion to transaction. If old_oid is non-NULL,
  * then it holds the value that the reference should have had before
- * the update (which must not be null_sha1).
+ * the update (which must not be null_oid).
  *
  * See the above comment "Reference transaction updates" for more
  * information.
  */
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
-			   const unsigned char *old_sha1,
+			   const struct object_id *old_oid,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
- * Verify, within a transaction, that refname has the value old_sha1,
- * or, if old_sha1 is null_sha1, then verify that the reference
- * doesn't exist. old_sha1 must be non-NULL.
+ * Verify, within a transaction, that refname has the value old_oid,
+ * or, if old_oid is null_oid, then verify that the reference
+ * doesn't exist. old_oid must be non-NULL.
  *
  * See the above comment "Reference transaction updates" for more
  * information.
  */
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
-			   const unsigned char *old_sha1,
+			   const struct object_id *old_oid,
 			   unsigned int flags,
 			   struct strbuf *err);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0c641f0ad0..46dbcda6a6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1029,7 +1029,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 
 	transaction = ref_store_transaction_begin(&refs->base, &err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, r->name, r->oid.hash,
+	    ref_transaction_delete(transaction, r->name, &r->oid,
 				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1114,7 +1114,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * packed-refs transaction:
 		 */
 		if (ref_transaction_update(transaction, iter->refname,
-					   iter->oid->hash, NULL,
+					   iter->oid, NULL,
 					   REF_NODEREF, NULL, &err))
 			die("failure preparing to create packed reference %s: %s",
 			    iter->refname, err.buf);
@@ -2153,7 +2153,7 @@ static int split_head_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NODEREF,
-			update->new_oid.hash, update->old_oid.hash,
+			&update->new_oid, &update->old_oid,
 			update->msg);
 
 	/*
@@ -2217,7 +2217,7 @@ static int split_symref_update(struct files_ref_store *refs,
 
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
-			update->new_oid.hash, update->old_oid.hash,
+			&update->new_oid, &update->old_oid,
 			update->msg);
 
 	new_update->parent_update = update;
@@ -2600,7 +2600,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			ref_transaction_add_update(
 					packed_transaction, update->refname,
 					update->flags & ~REF_HAVE_OLD,
-					update->new_oid.hash, update->old_oid.hash,
+					&update->new_oid, &update->old_oid,
 					NULL);
 		}
 	}
@@ -2853,7 +2853,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		 */
 		ref_transaction_add_update(packed_transaction, update->refname,
 					   update->flags & ~REF_HAVE_OLD,
-					   update->new_oid.hash, update->old_oid.hash,
+					   &update->new_oid, &update->old_oid,
 					   NULL);
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d7d344de73..6636a13a62 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -202,8 +202,8 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 struct ref_update *ref_transaction_add_update(
 		struct ref_transaction *transaction,
 		const char *refname, unsigned int flags,
-		const unsigned char *new_sha1,
-		const unsigned char *old_sha1,
+		const struct object_id *new_oid,
+		const struct object_id *old_oid,
 		const char *msg);
 
 /*
diff --git a/sequencer.c b/sequencer.c
index b349474bd3..43a6f14eb3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -392,7 +392,7 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
-				   to->hash, unborn ? null_sha1 : from->hash,
+				   to, unborn ? &null_oid : from,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
diff --git a/walker.c b/walker.c
index 2d83254bc0..5d4d3733f7 100644
--- a/walker.c
+++ b/walker.c
@@ -304,7 +304,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "refs/%s", write_ref[i]);
 		if (ref_transaction_update(transaction, refname.buf,
-					   oids[i].hash, NULL, 0,
+					   oids + i, NULL, 0,
 					   msg ? msg : "fetch (unknown)",
 					   &err)) {
 			error("%s", err.buf);
-- 
2.14.2.822.g60be5d43e6

