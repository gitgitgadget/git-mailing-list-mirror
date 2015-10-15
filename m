From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 18/26] refs: move transaction functions into common code
Date: Thu, 15 Oct 2015 15:46:42 -0400
Message-ID: <1444938410-2345-19-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:47:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoUw-0006tn-KE
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbbJOTr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:29 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36145 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbbJOTr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:27 -0400
Received: by qkht68 with SMTP id t68so44761456qkh.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z7khdgcd416+/R1WMwnilmSE3FoIMFU1g97gcslMxqE=;
        b=RRLS/rD3wgCSR3Vfp6hjQeeBBhWhKcl6Jogt8tVyqB1ykW1VhbwpPPTHivbDk6h/rV
         1KOCbp/zTLu6TmqG+5x761wMmnvheds+9m08ZW0n6NSOK0TR0SjIhwfVZnVge25W/nmH
         kkK2fP0OG052q3ICzzbA/yElv2yFcl4wjeyrtgMXldm7AxAMjPhPwTess0TJVwivDoKH
         WURKms4k6qVKnVdSfsSJVDb7VO6pcqayHL5n5hDDTWO9c4xDvmmGyYrvJuVY/0+OSumL
         K3l/Zsg1bgb7oiaD07Ek4bHc2vATmmrPz1wyDplQ/hJoyG+8xmIltjzEvtnkNpxSP7QX
         Cy1g==
X-Gm-Message-State: ALoCoQlgeqPh6soVXjp6lhsrCXstTMieeBKG8awzQ3+z1FGFQHzY/Mn+qh/SCqrApeDIqLf9KUYH
X-Received: by 10.55.16.221 with SMTP id 90mr6094848qkq.81.1444938446577;
        Thu, 15 Oct 2015 12:47:26 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279690>

The common ref code will build up a ref transaction.  Backends will
then commit it.  So the transaction creation and update functions should
be in the common code.  We also need to move the ref structs into
the common code so that alternate backends can access them.

Later, we will modify struct ref_update to support alternate backends.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 198 --------------------------------------------------------
 refs.c          | 108 +++++++++++++++++++++++++++++++
 refs.h          |  91 +++++++++++++++++++++++++-
 3 files changed, 198 insertions(+), 199 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index ffc3813..73eb1e2 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -13,41 +13,6 @@ struct ref_lock {
 	struct object_id old_oid;
 };
 
-/*
- * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
- * refs (i.e., because the reference is about to be deleted anyway).
- */
-#define REF_DELETING	0x02
-
-/*
- * Used as a flag in ref_update::flags when a loose ref is being
- * pruned.
- */
-#define REF_ISPRUNING	0x04
-
-/*
- * Used as a flag in ref_update::flags when the reference should be
- * updated to new_sha1.
- */
-#define REF_HAVE_NEW	0x08
-
-/*
- * Used as a flag in ref_update::flags when old_sha1 should be
- * checked.
- */
-#define REF_HAVE_OLD	0x10
-
-/*
- * Used as a flag in ref_update::flags when the lockfile needs to be
- * committed.
- */
-#define REF_NEEDS_COMMIT 0x20
-
-/*
- * 0x40 is REF_FORCE_CREATE_REFLOG, so skip it if you're adding a
- * value to ref_update::flags
- */
-
 struct ref_entry;
 
 /*
@@ -3289,169 +3254,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-/**
- * Information needed for a single ref update. Set new_sha1 to the new
- * value or to null_sha1 to delete the ref. To check the old value
- * while the ref is locked, set (flags & REF_HAVE_OLD) and set
- * old_sha1 to the old value, or to null_sha1 to ensure the ref does
- * not exist before update.
- */
-struct ref_update {
-	/*
-	 * If (flags & REF_HAVE_NEW), set the reference to this value:
-	 */
-	unsigned char new_sha1[20];
-	/*
-	 * If (flags & REF_HAVE_OLD), check that the reference
-	 * previously had this value:
-	 */
-	unsigned char old_sha1[20];
-	/*
-	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
-	 * REF_DELETING, and REF_ISPRUNING:
-	 */
-	unsigned int flags;
-	struct ref_lock *lock;
-	int type;
-	char *msg;
-	const char refname[FLEX_ARRAY];
-};
-
-/*
- * Transaction states.
- * OPEN:   The transaction is in a valid state and can accept new updates.
- *         An OPEN transaction can be committed.
- * CLOSED: A closed transaction is no longer active and no other operations
- *         than free can be used on it in this state.
- *         A transaction can either become closed by successfully committing
- *         an active transaction or if there is a failure while building
- *         the transaction thus rendering it failed/inactive.
- */
-enum ref_transaction_state {
-	REF_TRANSACTION_OPEN   = 0,
-	REF_TRANSACTION_CLOSED = 1
-};
-
-/*
- * Data structure for holding a reference transaction, which can
- * consist of checks and updates to multiple references, carried out
- * as atomically as possible.  This structure is opaque to callers.
- */
-struct ref_transaction {
-	struct ref_update **updates;
-	size_t alloc;
-	size_t nr;
-	enum ref_transaction_state state;
-};
-
-struct ref_transaction *ref_transaction_begin(struct strbuf *err)
-{
-	assert(err);
-
-	return xcalloc(1, sizeof(struct ref_transaction));
-}
-
-void ref_transaction_free(struct ref_transaction *transaction)
-{
-	int i;
-
-	if (!transaction)
-		return;
-
-	for (i = 0; i < transaction->nr; i++) {
-		free(transaction->updates[i]->msg);
-		free(transaction->updates[i]);
-	}
-	free(transaction->updates);
-	free(transaction);
-}
-
-static struct ref_update *add_update(struct ref_transaction *transaction,
-				     const char *refname)
-{
-	size_t len = strlen(refname) + 1;
-	struct ref_update *update = xcalloc(1, sizeof(*update) + len);
-
-	memcpy((char *)update->refname, refname, len); /* includes NUL */
-	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
-	transaction->updates[transaction->nr++] = update;
-	return update;
-}
-
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   const unsigned char *old_sha1,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
-{
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: update called for transaction that is not open");
-
-	if (new_sha1 && !is_null_sha1(new_sha1) &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "refusing to update ref with bad name %s",
-			    refname);
-		return -1;
-	}
-
-	update = add_update(transaction, refname);
-	if (new_sha1) {
-		hashcpy(update->new_sha1, new_sha1);
-		flags |= REF_HAVE_NEW;
-	}
-	if (old_sha1) {
-		hashcpy(update->old_sha1, old_sha1);
-		flags |= REF_HAVE_OLD;
-	}
-	update->flags = flags;
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
-}
-
-int ref_transaction_create(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
-{
-	if (!new_sha1 || is_null_sha1(new_sha1))
-		die("BUG: create called without valid new_sha1");
-	return ref_transaction_update(transaction, refname, new_sha1,
-				      null_sha1, flags, msg, err);
-}
-
-int ref_transaction_delete(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *old_sha1,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
-{
-	if (old_sha1 && is_null_sha1(old_sha1))
-		die("BUG: delete called with old_sha1 set to zeros");
-	return ref_transaction_update(transaction, refname,
-				      null_sha1, old_sha1,
-				      flags, msg, err);
-}
-
-int ref_transaction_verify(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *old_sha1,
-			   unsigned int flags,
-			   struct strbuf *err)
-{
-	if (!old_sha1)
-		die("BUG: verify called with old_sha1 set to NULL");
-	return ref_transaction_update(transaction, refname,
-				      NULL, old_sha1,
-				      flags, NULL, err);
-}
-
 static int ref_update_reject_duplicates(struct string_list *refnames,
 					struct strbuf *err)
 {
diff --git a/refs.c b/refs.c
index ae518a2..be08787 100644
--- a/refs.c
+++ b/refs.c
@@ -842,3 +842,111 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 
 	return ret;
 }
+
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
+{
+	assert(err);
+
+	return xcalloc(1, sizeof(struct ref_transaction));
+}
+
+void ref_transaction_free(struct ref_transaction *transaction)
+{
+	int i;
+
+	if (!transaction)
+		return;
+
+	for (i = 0; i < transaction->nr; i++) {
+		free(transaction->updates[i]->msg);
+		free(transaction->updates[i]);
+	}
+	free(transaction->updates);
+	free(transaction);
+}
+
+static struct ref_update *add_update(struct ref_transaction *transaction,
+				     const char *refname)
+{
+	size_t len = strlen(refname) + 1;
+	struct ref_update *update = xcalloc(1, sizeof(*update) + len);
+
+	memcpy((char *)update->refname, refname, len); /* includes NUL */
+	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
+	transaction->updates[transaction->nr++] = update;
+	return update;
+}
+
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   unsigned int flags, const char *msg,
+			   struct strbuf *err)
+{
+	struct ref_update *update;
+
+	assert(err);
+
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update called for transaction that is not open");
+
+	if (new_sha1 && !is_null_sha1(new_sha1) &&
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		strbuf_addf(err, "refusing to update ref with bad name %s",
+			    refname);
+		return -1;
+	}
+
+	update = add_update(transaction, refname);
+	if (new_sha1) {
+		hashcpy(update->new_sha1, new_sha1);
+		flags |= REF_HAVE_NEW;
+	}
+	if (old_sha1) {
+		hashcpy(update->old_sha1, old_sha1);
+		flags |= REF_HAVE_OLD;
+	}
+	update->flags = flags;
+	if (msg)
+		update->msg = xstrdup(msg);
+	return 0;
+}
+
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   unsigned int flags, const char *msg,
+			   struct strbuf *err)
+{
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("BUG: create called without valid new_sha1");
+	return ref_transaction_update(transaction, refname, new_sha1,
+				      null_sha1, flags, msg, err);
+}
+
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   unsigned int flags, const char *msg,
+			   struct strbuf *err)
+{
+	if (old_sha1 && is_null_sha1(old_sha1))
+		die("BUG: delete called with old_sha1 set to zeros");
+	return ref_transaction_update(transaction, refname,
+				      null_sha1, old_sha1,
+				      flags, msg, err);
+}
+
+int ref_transaction_verify(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   unsigned int flags,
+			   struct strbuf *err)
+{
+	if (!old_sha1)
+		die("BUG: verify called with old_sha1 set to NULL");
+	return ref_transaction_update(transaction, refname,
+				      NULL, old_sha1,
+				      flags, NULL, err);
+}
diff --git a/refs.h b/refs.h
index 8408bef..3d24c79 100644
--- a/refs.h
+++ b/refs.h
@@ -94,6 +94,84 @@ extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 
 /*
+ * Transaction states.
+ * OPEN:   The transaction is in a valid state and can accept new updates.
+ *         An OPEN transaction can be committed.
+ * CLOSED: A closed transaction is no longer active and no other operations
+ *         than free can be used on it in this state.
+ *         A transaction can either become closed by successfully committing
+ *         an active transaction or if there is a failure while building
+ *         the transaction thus rendering it failed/inactive.
+ */
+enum ref_transaction_state {
+	REF_TRANSACTION_OPEN   = 0,
+	REF_TRANSACTION_CLOSED = 1
+};
+
+/*
+ * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
+ * refs (i.e., because the reference is about to be deleted anyway).
+ */
+#define REF_DELETING	0x02
+
+/*
+ * Used as a flag in ref_update::flags when a loose ref is being
+ * pruned.
+ */
+#define REF_ISPRUNING	0x04
+
+/*
+ * Used as a flag in ref_update::flags when the reference should be
+ * updated to new_sha1.
+ */
+#define REF_HAVE_NEW	0x08
+
+/*
+ * Used as a flag in ref_update::flags when old_sha1 should be
+ * checked.
+ */
+#define REF_HAVE_OLD	0x10
+
+/*
+ * Used as a flag in ref_update::flags when the lockfile needs to be
+ * committed.
+ */
+#define REF_NEEDS_COMMIT 0x20
+
+/*
+ * 0x40 is REF_FORCE_CREATE_REFLOG, so skip it if you're adding a
+ * value to ref_update::flags
+ */
+
+/**
+ * Information needed for a single ref update. Set new_sha1 to the new
+ * value or to null_sha1 to delete the ref. To check the old value
+ * while the ref is locked, set (flags & REF_HAVE_OLD) and set
+ * old_sha1 to the old value, or to null_sha1 to ensure the ref does
+ * not exist before update.
+ */
+struct ref_update {
+	/*
+	 * If (flags & REF_HAVE_NEW), set the reference to this value:
+	 */
+	unsigned char new_sha1[20];
+	/*
+	 * If (flags & REF_HAVE_OLD), check that the reference
+	 * previously had this value:
+	 */
+	unsigned char old_sha1[20];
+	/*
+	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
+	 * REF_DELETING, and REF_ISPRUNING:
+	 */
+	unsigned int flags;
+	struct ref_lock *lock;
+	int type;
+	char *msg;
+	const char refname[FLEX_ARRAY];
+};
+
+/*
  * A ref_transaction represents a collection of ref updates
  * that should succeed or fail together.
  *
@@ -125,7 +203,18 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
  * The message is appended to err without first clearing err.
  * err will not be '\n' terminated.
  */
-struct ref_transaction;
+
+/*
+ * Data structure for holding a reference transaction, which can
+ * consist of checks and updates to multiple references, carried out
+ * as atomically as possible.  This structure is opaque to callers.
+ */
+struct ref_transaction {
+	struct ref_update **updates;
+	size_t alloc;
+	size_t nr;
+	enum ref_transaction_state state;
+};
 
 /*
  * Bit values set in the flags argument passed to each_ref_fn():
-- 
2.4.2.644.g97b850b-twtrsrc
