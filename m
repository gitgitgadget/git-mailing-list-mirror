From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 17/25] refs: move transaction functions to the common code
Date: Tue,  3 Nov 2015 08:40:01 +0100
Message-ID: <69658d718bd300009c5ae17388b548937b9751fb.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:48:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWKQ-000631-W2
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbbKCHsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:48:22 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44590 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752078AbbKCHsV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:48:21 -0500
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 02:48:21 EST
X-AuditID: 12074414-f794f6d000007852-bd-563864f4c55d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2A.2D.30802.4F468365; Tue,  3 Nov 2015 02:40:36 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdE016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:35 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqPslxSLM4MQUIYv5m04wWnRd6Way
	aOi9wmxxe8V8ZgcWj7/vPzB5XLyk7LHg+X12j8+b5AJYorhtkhJLyoIz0/P07RK4M679LyzY
	kVsx+2kzcwPj2rAuRk4OCQETie7WU2wQtpjEhXvrgWwuDiGBy4wS349OZYdwjjFJtO/dwQJS
	xSagK7Gop5kJxBYRUJOY2HYIKM7BwSxQJHGnXwckLCzgK9E94RsjSJhFQFVi8k8PkDCvQJTE
	q8m3WCB2yUlMud8ONoVTwELiwd0/7CC2kIC5xKZ7y9gmMPIuYGRYxSiXmFOaq5ubmJlTnJqs
	W5ycmJeXWqRroZebWaKXmlK6iRESOiI7GI+clDvEKMDBqMTDu2CJeZgQa2JZcWXuIUZJDiYl
	Ud51MRZhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4CwKBcrwpiZVVqUX5MClpDhYlcd5vi9X9
	hATSE0tSs1NTC1KLYLIyHBxKEryXkoEaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy
	4kFREV8MjAuQFA/Q3oQUkL3FBYm5QFGI1lOMilLivBdB5gqAJDJK8+DGwhLCK0ZxoC+FeSeC
	VPEAkwlc9yugwUxAg8O3mYIMLklESEk1MKa5py7L+5T+rtiCLbXPYu+l/28WnuVY4S5hIHc6
	UOulbIyn4eL35g/8PXlWH67lufpMeXu8VYBz2te4Omuzg31fs79dfBTaOM9UevJX1Vk79H6/
	dCngjuhycr81+ePvjJ2Jh3J04s6zdsvP/b71y/enYVkvb69mi1mUcjWvY+3ssqfv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280777>

From: David Turner <dturner@twopensource.com>

The common ref code will build up a ref transaction. Backends will
then commit it. So the transaction creation and update functions
should be in the common code.

The backends will also need access to some constants and structs that,
until now, were defined within refs.c and treated as private. So move
those into a new header file, refs/refs-internal.h, that is intended
for internal use only within the refs module.

Later, we will modify struct ref_update to support alternate backends.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 200 +--------------------------------------------------
 refs/refs-internal.h | 102 ++++++++++++++++++++++++++
 refs/refs.c          | 110 +++++++++++++++++++++++++++-
 3 files changed, 212 insertions(+), 200 deletions(-)
 create mode 100644 refs/refs-internal.h

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 728e646..1719720 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,5 +1,5 @@
 #include "../cache.h"
-#include "../refs.h"
+#include "refs-internal.h"
 #include "../lockfile.h"
 #include "../object.h"
 #include "../tag.h"
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
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
new file mode 100644
index 0000000..94f5dde
--- /dev/null
+++ b/refs/refs-internal.h
@@ -0,0 +1,102 @@
+#ifndef REFS_REFS_INTERNAL_H
+#define REFS_REFS_INTERNAL_H
+
+/*
+ * Data structures and functions for the internal use of the refs
+ * module. Code outside of the refs module should use only the public
+ * functions defined in "refs.h", and should *not* include this file.
+ */
+
+#include "../refs.h"
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
+
+#endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/refs.c b/refs/refs.c
index 6af5fd6..0d0579f 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -2,7 +2,7 @@
  * Common refs code for all backends.
  */
 #include "../cache.h"
-#include "../refs.h"
+#include "refs-internal.h"
 #include "../lockfile.h"
 
 static int is_per_worktree_ref(const char *refname)
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
-- 
2.6.2
