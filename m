From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/12] ref_transaction_verify(): new function to check a reference's value
Date: Thu, 12 Feb 2015 12:12:21 +0100
Message-ID: <1423739543-1025-11-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:13:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLrhe-0004Bo-IL
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625AbbBLLMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:12:49 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:53854 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755609AbbBLLMr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:12:47 -0500
X-AuditID: 1207440d-f79976d000005643-78-54dc8aae446e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B5.B7.22083.EAA8CD45; Thu, 12 Feb 2015 06:12:46 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7d003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:45 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLuu606IwcbjuhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgz5n04wVhw276i6+Z9tgbG7UZdjJwcEgImEhveHWeFsMUkLtxbz9bF
	yMUhJHCZUWLZ239MIAkhgRNMErMmZIPYbAK6Eot6msHiIgJqEhPbDrGA2MwCq5kktt5lA7GF
	BWIl3hxuYwSxWQRUJd79ugK2gFfARWLnqyYmiGVyEueP/2QGsTmB4u8uNTBC7HKW2NW2hXUC
	I+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpGermZJXqpKaWbGCFBxruD8f86mUOMAhyM
	Sjy8AcZ3QoRYE8uKK3MPMUpyMCmJ8nK1AoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8Po2AeV4
	UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK85Z1AjYJFqempFWmZOSUI
	aSYOTpDhXFIixal5KalFiaUlGfGgyIgvBsYGSIoHaK8YSDtvcUFiLlAUovUUo6KUOG8mSEIA
	JJFRmgc3FpY6XjGKA30pzDsPpIoHmHbgul8BDWYCGjxxxm2QwSWJCCmpBka5x+7PdRuPJb4x
	9di6qkDiQ+KWPU68IbPbZWoWfRfbFbndeaOybXLAxcmqJh17H/AemTMlSCD2d5a5y/boS7c/
	Ci7wKHt35vxvzy9MPnV3LE9Wb570fpvHge26Dy8YJP+I0gsVCdv2X8VOb8mfmZGJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263719>

If NULL is passed to ref_transaction_update()'s new_sha1 parameter,
then just verify old_sha1 (under lock) without trying to change the
new value of the reference.

Use this functionality to add a new function ref_transaction_verify(),
which checks the current value of the reference under lock but doesn't
change it.

Use ref_transaction_verify() in the implementation of "git update-ref
--stdin"'s "verify" command to avoid the awkward need to "update" the
reference to its existing value.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c |  7 ++-----
 refs.c               | 47 +++++++++++++++++++++++++++++++++++++++--------
 refs.h               | 34 ++++++++++++++++++++++++++--------
 3 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index e9632d5..a75a098 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -282,7 +282,6 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
-	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 
 	refname = parse_refname(input, &next);
@@ -293,13 +292,11 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 			    PARSE_SHA1_OLD))
 		hashclr(old_sha1);
 
-	hashcpy(new_sha1, old_sha1);
-
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, msg, &err))
+	if (ref_transaction_verify(transaction, refname, old_sha1,
+				   update_flags, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
diff --git a/refs.c b/refs.c
index 9dd7932..489eec9 100644
--- a/refs.c
+++ b/refs.c
@@ -47,10 +47,16 @@ static unsigned char refname_disposition[256] = {
 #define REF_ISPRUNING	0x04
 
 /*
+ * Used as a flag in ref_update::flags when the reference should be
+ * updated to new_sha1.
+ */
+#define REF_HAVE_NEW	0x08
+
+/*
  * Used as a flag in ref_update::flags when old_sha1 should be
  * checked.
  */
-#define REF_HAVE_OLD	0x08
+#define REF_HAVE_OLD	0x10
 
 /*
  * Try to read one refname component from the front of refname.
@@ -3577,10 +3583,17 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
  * not exist before update.
  */
 struct ref_update {
+	/*
+	 * If (flags & REF_HAVE_NEW), set the reference to this value:
+	 */
 	unsigned char new_sha1[20];
+	/*
+	 * If (flags & REF_HAVE_OLD), check that the reference
+	 * previously had this value:
+	 */
 	unsigned char old_sha1[20];
 	/*
-	 * One or more of REF_HAVE_OLD, REF_NODEREF,
+	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
 	 * REF_DELETING, and REF_IS_PRUNING:
 	 */
 	int flags;
@@ -3665,7 +3678,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
-	if (!is_null_sha1(new_sha1) &&
+	if (new_sha1 && !is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		strbuf_addf(err, "refusing to update ref with bad name %s",
 			    refname);
@@ -3673,7 +3686,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	}
 
 	update = add_update(transaction, refname);
-	hashcpy(update->new_sha1, new_sha1);
+	if (new_sha1) {
+		hashcpy(update->new_sha1, new_sha1);
+		flags |= REF_HAVE_NEW;
+	}
 	if (old_sha1) {
 		hashcpy(update->old_sha1, old_sha1);
 		flags |= REF_HAVE_OLD;
@@ -3709,6 +3725,19 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 				      flags, msg, err);
 }
 
+int ref_transaction_verify(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags,
+			   struct strbuf *err)
+{
+	if (!old_sha1)
+		die("BUG: verify called with old_sha1 set to NULL");
+	return ref_transaction_update(transaction, refname,
+				      NULL, old_sha1,
+				      flags, NULL, err);
+}
+
 int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
@@ -3797,7 +3826,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 		int flags = update->flags;
 
-		if (is_null_sha1(update->new_sha1))
+		if ((flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1))
 			flags |= REF_DELETING;
 		update->lock = lock_ref_sha1_basic(
 				update->refname,
@@ -3819,8 +3848,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
+		int flags = update->flags;
 
-		if (!is_null_sha1(update->new_sha1)) {
+		if ((flags & REF_HAVE_NEW) && !is_null_sha1(update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
 					   update->msg)) {
 				update->lock = NULL; /* freed by write_ref_sha1 */
@@ -3836,14 +3866,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Perform deletes now that updates are safely completed */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
+		int flags = update->flags;
 
-		if (update->lock) {
+		if ((flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1)) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
 
-			if (!(update->flags & REF_ISPRUNING))
+			if (!(flags & REF_ISPRUNING))
 				string_list_append(&refs_to_delete,
 						   update->lock->ref_name);
 		}
diff --git a/refs.h b/refs.h
index ee612da..02d6e39 100644
--- a/refs.h
+++ b/refs.h
@@ -263,14 +263,19 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 
 /*
- * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or null_sha1 if it should
- * be deleted.  If old_sha1 is non-NULL, then it the value
- * that the reference should have had before the update, or null_sha1 if
- * it must not have existed beforehand.
- * Function returns 0 on success and non-zero on failure. A failure to update
- * means that the transaction as a whole has failed and will need to be
- * rolled back.
+ * Add a reference update to transaction. new_sha1 is the value that
+ * the reference should have after the update, or null_sha1 if it
+ * should be deleted. If new_sha1 is NULL, then the reference is not
+ * changed at all. old_sha1 is the value that the reference must have
+ * before the update, or null_sha1 if it must not have existed
+ * beforehand. The old value is checked after the lock is taken to
+ * prevent races. If the old value doesn't agree with old_sha1, the
+ * whole transaction fails. If old_sha1 is NULL, then the previous
+ * value is not checked.
+ *
+ * Return 0 on success and non-zero on failure. Any failure in the
+ * transaction means that the transaction as a whole has failed and
+ * will need to be rolled back.
  */
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
@@ -309,6 +314,19 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
 /*
+ * Verify, within a transaction, that refname has the value old_sha1,
+ * or, if old_sha1 is null_sha1, then verify that the reference
+ * doesn't exist. old_sha1 must be non-NULL. Function returns 0 on
+ * success and non-zero on failure. A failure to verify means that the
+ * transaction as a whole has failed and will need to be rolled back.
+ */
+int ref_transaction_verify(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags,
+			   struct strbuf *err);
+
+/*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.
  *
-- 
2.1.4
