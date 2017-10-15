Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F9F20372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbdJOWHo (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:07:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55038 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751479AbdJOWHm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:42 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 141C86044E;
        Sun, 15 Oct 2017 22:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105261;
        bh=j4YccqOQHDqm5KY4DLHjuhDVM0g9YsAcTjoZthlXdp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=RecATD1yCsyUmjim+lSRhdLFE5rjBAGBMxl0MbecE+LN1fC4xiaQOcTkBQ5b6euNc
         GqLx548jXgqizdO99+AcFpFwSIukshtjnWtnRqskM/0YWZzeVpi7/LHF7Ulsujp4V9
         N11aW+c37l1FmSLgjC2mQZ3evdiGd4yhQw1offQpqLP+EexmhOQA/6C3lLrxOfNMNw
         xRcyExtJxW/UpFG6ltEwhVU9nlij8xPkPugwwgEiSA/KZ2+6gVbKi8HM0s0kynPc/k
         vEJFhgdVzFRo+sIshI2dWc/mxsOABDa59XsmYXZPjE0qCQqmHhj3NJDE3fuPnkUcoZ
         qThB9JR0licpmJzm4R8rLchTVsuL1EBxLsFqHBhNQ/lsAp0VsCgKm61/cP7TspFwrp
         T0pRgwz5vk95u2U7Ih1xecpxr/CdQX9x9SesdGdgi2DJ6iqIi3ddx0OHVYP8/dI1n8
         +2fmaW2/F5nMi8t9a0xMj5YzOQe3ebQJwPkOcJC+Mx2NRPA4MmT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 06/25] refs: update ref transactions to use struct object_id
Date:   Sun, 15 Oct 2017 22:06:53 +0000
Message-Id: <20171015220712.97308-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
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
 refs.c                 | 50 ++++++++++++++++++++++++--------------------------
 refs.h                 | 38 +++++++++++++++++++-------------------
 refs/files-backend.c   | 12 ++++++------
 refs/refs-internal.h   |  4 ++--
 sequencer.c            |  2 +-
 walker.c               |  2 +-
 15 files changed, 69 insertions(+), 71 deletions(-)

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
index d75b3805ea..f9c9676a3f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1788,9 +1788,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
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
index cc48767405..2da3c4cd5c 100644
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
index 272f0d3103..43c07ddeb3 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -544,7 +544,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
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
index d5e4cf0bad..32951b0d4a 100644
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
index 91c2af78b6..db4988ab3c 100644
--- a/refs.c
+++ b/refs.c
@@ -671,8 +671,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname,
-				   old_oid ? old_oid->hash : NULL,
+	    ref_transaction_delete(transaction, refname, old_oid,
 				   flags, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
@@ -898,8 +897,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
@@ -917,23 +916,23 @@ struct ref_update *ref_transaction_add_update(
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
@@ -943,48 +942,48 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
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
-		die("BUG: create called without valid new_sha1");
-	return ref_transaction_update(transaction, refname, new_sha1,
-				      null_sha1, flags, msg, err);
+	if (!new_oid || is_null_oid(new_oid))
+		die("BUG: create called without valid new_oid");
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
-		die("BUG: delete called with old_sha1 set to zeros");
+	if (old_oid && is_null_oid(old_oid))
+		die("BUG: delete called with old_oid set to zeros");
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
-		die("BUG: verify called with old_sha1 set to NULL");
+	if (!old_oid)
+		die("BUG: verify called with old_oid set to NULL");
 	return ref_transaction_update(transaction, refname,
-				      NULL, old_sha1,
+				      NULL, old_oid,
 				      flags, NULL, err);
 }
 
@@ -1003,8 +1002,7 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
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
index 8932109a11..1fee56d132 100644
--- a/refs.h
+++ b/refs.h
@@ -511,14 +511,14 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 
 /*
- * Add a reference update to transaction. new_sha1 is the value that
- * the reference should have after the update, or null_sha1 if it
- * should be deleted. If new_sha1 is NULL, then the reference is not
- * changed at all. old_sha1 is the value that the reference must have
- * before the update, or null_sha1 if it must not have existed
+ * Add a reference update to transaction. new_oid is the value that
+ * the reference should have after the update, or null_oid if it
+ * should be deleted. If new_oid is NULL, then the reference is not
+ * changed at all. old_oid is the value that the reference must have
+ * before the update, or null_oid if it must not have existed
  * beforehand. The old value is checked after the lock is taken to
- * prevent races. If the old value doesn't agree with old_sha1, the
- * whole transaction fails. If old_sha1 is NULL, then the previous
+ * prevent races. If the old value doesn't agree with old_oid, the
+ * whole transaction fails. If old_oid is NULL, then the previous
  * value is not checked.
  *
  * See the above comment "Reference transaction updates" for more
@@ -526,15 +526,15 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
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
@@ -542,35 +542,35 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
index 9c4766aa57..8ab0a7ae04 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -994,7 +994,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 
 	transaction = ref_store_transaction_begin(&refs->base, &err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, r->name, r->oid.hash,
+	    ref_transaction_delete(transaction, r->name, &r->oid,
 				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1079,7 +1079,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * packed-refs transaction:
 		 */
 		if (ref_transaction_update(transaction, iter->refname,
-					   iter->oid->hash, NULL,
+					   iter->oid, NULL,
 					   REF_NODEREF, NULL, &err))
 			die("failure preparing to create packed reference %s: %s",
 			    iter->refname, err.buf);
@@ -2148,7 +2148,7 @@ static int split_head_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NODEREF,
-			update->new_oid.hash, update->old_oid.hash,
+			&update->new_oid, &update->old_oid,
 			update->msg);
 
 	/*
@@ -2212,7 +2212,7 @@ static int split_symref_update(struct files_ref_store *refs,
 
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
-			update->new_oid.hash, update->old_oid.hash,
+			&update->new_oid, &update->old_oid,
 			update->msg);
 
 	new_update->parent_update = update;
@@ -2594,7 +2594,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			ref_transaction_add_update(
 					packed_transaction, update->refname,
 					update->flags & ~REF_HAVE_OLD,
-					update->new_oid.hash, update->old_oid.hash,
+					&update->new_oid, &update->old_oid,
 					NULL);
 		}
 	}
@@ -2847,7 +2847,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		 */
 		ref_transaction_add_update(packed_transaction, update->refname,
 					   update->flags & ~REF_HAVE_OLD,
-					   update->new_oid.hash, update->old_oid.hash,
+					   &update->new_oid, &update->old_oid,
 					   NULL);
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 448de4bccb..951bd340c8 100644
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
index cc3c0da3a5..d26985a6ed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -393,7 +393,7 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
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
2.15.0.rc0.271.g36b669edcc

