From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 18/26] refs: move transaction functions into common code
Date: Tue, 27 Oct 2015 22:14:19 -0400
Message-ID: <1445998467-11511-19-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGv-0001Nm-Gf
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbbJ1CPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:20 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37849 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252AbbJ1CPM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:12 -0400
Received: by igbhv6 with SMTP id hv6so92970106igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hmjMX8iuKkmotaCnmdO/S6vUyYmTZa4h81kfHfjJ27w=;
        b=tKLEp+zntPuzytLDLz0KzM8D4qy6ttqj6hNL+IDW2I57H58FSCvmrKJ2CNJuyXHBSJ
         MB8HtXs+XPfV2HrF+ohzF9BTJ+41n3xBEKSLbvNGDzbpPOTm2helD842FoNKLLS+sYf2
         rrXWSkjRXQynli/QIhRarbIGlDF1l57nz7RZzg9h9tT7SxTdnoioy9hu81qti2XX6opQ
         5cSXvtFfQrjl7CQd0/gSigWtcI1zCFWsqtvodypz7RbSOwGtfDyRcOgX2kD6dpyo1bvh
         xxgZjyksZ0/R4WgkMnK0+5Jx/ATqoV3zY3P4yDBX/qp4mOMd6DU4jMdurmdRd0s+vxnh
         q0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hmjMX8iuKkmotaCnmdO/S6vUyYmTZa4h81kfHfjJ27w=;
        b=SuRtlSMTIewgYkoywSkp1mMCLSEDJC7Y2pwg+smsvuZIvlBslPhzbR6xson44Hp0w0
         NhyN9NX8KxpZLHuiSEx9RsKNjkJkBQ829SNTT83Wk5qtRUeiJkGs4iQLml2b2uZG9e03
         ZvmJz6wP1y0wD++bj+HQZ83Q8bOzQ4kyJsUjF2n/9KhLFMV6ODr2WHEwy0sbNiegCbjV
         12mjq2gxMztXDVX5fxhMhkQAyrV5ds+NX0jUxudDedGTanEVUvv9NTx8Ii1AUaKEvLoV
         jcW9gvqSp6udjjBCVP0JLmbrsXkgAMcCM8G8wRbl4q57m1CWORH7uCqo4avPv7Py6E2v
         yYOw==
X-Gm-Message-State: ALoCoQkm+Y9RUE2w8ONf8SRU3lBdsEDHJA5k6dD+iDMZmiABR4TetQGCmwHxL73we26wUWd6fKuZ
X-Received: by 10.50.66.202 with SMTP id h10mr309498igt.67.1445998511998;
        Tue, 27 Oct 2015 19:15:11 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:11 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280338>

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
index 18c849c..156ab4f 100644
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
@@ -3288,169 +3253,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
index 61d71d5..9cafcc9 100644
--- a/refs.c
+++ b/refs.c
@@ -841,3 +841,111 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 
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
2.4.2.658.g6d8523e-twtrsrc
