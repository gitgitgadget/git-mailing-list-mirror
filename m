From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 11/20] refs: move duplicate check to common code
Date: Thu, 14 Jan 2016 11:26:08 -0500
Message-ID: <1452788777-24954-12-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkkF-0002fi-GP
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbcANQ1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:27:24 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34445 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbcANQ0o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:44 -0500
Received: by mail-qk0-f176.google.com with SMTP id x1so27645856qkc.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ekdEWVp6gA0lH9dJh+SjOD1J1S1y3EAOOqu4PRFkxZE=;
        b=cHD0vlbutGKK5VEUsrNOXyRPc4OvngdZz2TDpDI4bfGFvv1efkEf2x5qvSELn+SA7T
         QCB2YR8rCA9wRLyzRkoNEbInZooAMmZL1HILf9vHgqmN4L765/0PKrOUbW8Q3BiGV6qM
         WF6VG5udTMDctEHD9M7HbXkCHtERNc6GXuPspdovjH9j0I9HNGzzXA0v370UiJXcOOjE
         I6ZifGZlLAIMDXDcK0IGMqhqfaURjMqYR0c6vOQYGw66cDplMUTwiDfGPLI87HM9LIAv
         z5jaB6I7fFtduZP5+8Mv+crfpqunbuYStUSm1OfcYrwnIxSoZPOPZzSlVBt02k7Dtqyd
         Tfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ekdEWVp6gA0lH9dJh+SjOD1J1S1y3EAOOqu4PRFkxZE=;
        b=Tct6iEDdQvtH5nd51Kn//X7juIXByN7B6DF76CM0BWzharYVnyplQ4e9VoyDQ0YVGW
         9hTuwL5owa8huXrNkCBoxlkNBCwbUy+lXA5uVH5J5YxCesWivBCGM9H9Hj8xcnhUv6Nd
         Qt30T3G+1jFDkRkfkZfXYS0Nm2/gpVhtY0xiMNEGj4MhRklOVOwJaTRDyyJCrH1TFJ3Z
         5hdGLk+sXT/8jP/c1WMrbNdjj+aZeQo/h5sgXMmlAn+xP2aSvDAN8O3EO49ZskcrzBvG
         Xh4bxpuW+8jaOJ3M5Y0gxUaFKz1pP5OBI524Hus69RS+SMW8oWvJLSpGVrCQGsNazcYN
         oNsQ==
X-Gm-Message-State: ALoCoQn0RoeIaarGHkkNZzAvI9nUU9YFpIcAwwll0fsqRhcB43AF2CyvnfmXHeApVvQODufXBI6RkKQlnvQv8pbNtk07DsDKCQ==
X-Received: by 10.55.53.208 with SMTP id c199mr6721954qka.109.1452788803593;
        Thu, 14 Jan 2016 08:26:43 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:42 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284049>

The check for duplicate refnames in a transaction is needed for
all backends, so move it to the common code.

ref_transaction_commit_fn gains a new argument, the sorted
string_list of affected refnames.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs/files-backend.c | 57 ++++---------------------------------------
 refs/refs-internal.h |  1 +
 3 files changed, 73 insertions(+), 54 deletions(-)

diff --git a/refs.c b/refs.c
index deeb7cf..d9cdacf 100644
--- a/refs.c
+++ b/refs.c
@@ -1105,6 +1105,36 @@ int rename_ref_available(const char *oldname, const char *newname)
 	return ret;
 }
 
+/*
+ * Return 1 if there are any duplicate refnames in the updates in
+ * `transaction`, and fill in err with an appropriate error message.
+ * Fill in `refnames` with the refnames from the transaction.
+ */
+static int get_affected_refnames(struct ref_transaction *transaction,
+				 struct string_list *refnames,
+				 struct strbuf *err)
+{
+	int i, n = transaction->nr;
+	struct ref_update **updates;
+
+	assert(err);
+
+	updates = transaction->updates;
+	/* Fail if a refname appears more than once in the transaction: */
+	for (i = 0; i < n; i++)
+		string_list_append(refnames, updates[i]->refname);
+	string_list_sort(refnames);
+
+	for (i = 1; i < n; i++)
+		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
+			strbuf_addf(err,
+				    "Multiple updates for ref '%s' not allowed.",
+				    refnames->items[i].string);
+			return 1;
+		}
+	return 0;
+}
+
 /* backend functions */
 int refs_init_db(struct strbuf *err, int shared)
 {
@@ -1114,7 +1144,29 @@ int refs_init_db(struct strbuf *err, int shared)
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	return the_refs_backend->transaction_commit(transaction, err);
+	int ret = -1;
+	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+
+	assert(err);
+
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: commit called for transaction that is not open");
+
+	if (!transaction->nr) {
+		transaction->state = REF_TRANSACTION_CLOSED;
+		return 0;
+	}
+
+	if (get_affected_refnames(transaction, &affected_refnames, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto done;
+	}
+
+	ret = the_refs_backend->transaction_commit(transaction,
+						   &affected_refnames, err);
+done:
+	string_list_clear(&affected_refnames, 0);
+	return ret;
 }
 
 int delete_refs(struct string_list *refnames)
@@ -1266,5 +1318,18 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	return the_refs_backend->initial_transaction_commit(transaction, err);
+	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	int ret;
+
+	if (get_affected_refnames(transaction,
+				  &affected_refnames, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto done;
+	}
+	ret = the_refs_backend->initial_transaction_commit(transaction,
+							   &affected_refnames,
+							   err);
+done:
+	string_list_clear(&affected_refnames, 0);
+	return ret;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9ae06a6..6dc9257 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3136,24 +3136,8 @@ static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static int ref_update_reject_duplicates(struct string_list *refnames,
-					struct strbuf *err)
-{
-	int i, n = refnames->nr;
-
-	assert(err);
-
-	for (i = 1; i < n; i++)
-		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
-			strbuf_addf(err,
-				    "Multiple updates for ref '%s' not allowed.",
-				    refnames->items[i].string);
-			return 1;
-		}
-	return 0;
-}
-
 static int files_transaction_commit(struct ref_transaction *transaction,
+				    struct string_list *affected_refnames,
 				    struct strbuf *err)
 {
 	int ret = 0, i;
@@ -3161,26 +3145,6 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
-	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: commit called for transaction that is not open");
-
-	if (!n) {
-		transaction->state = REF_TRANSACTION_CLOSED;
-		return 0;
-	}
-
-	/* Fail if a refname appears more than once in the transaction: */
-	for (i = 0; i < n; i++)
-		string_list_append(&affected_refnames, updates[i]->refname);
-	string_list_sort(&affected_refnames);
-	if (ref_update_reject_duplicates(&affected_refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
 
 	/*
 	 * Acquire all locks, verify old values if provided, check
@@ -3199,7 +3163,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
-				&affected_refnames, NULL,
+				affected_refnames, NULL,
 				update->flags,
 				&update->type,
 				err);
@@ -3311,7 +3275,6 @@ cleanup:
 		if (updates[i]->backend_data)
 			unlock_ref(updates[i]->backend_data);
 	string_list_clear(&refs_to_delete, 0);
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
@@ -3324,27 +3287,18 @@ static int ref_present(const char *refname,
 }
 
 static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct string_list *affected_refnames,
 					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
-	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
 	assert(err);
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
-	/* Fail if a refname appears more than once in the transaction: */
-	for (i = 0; i < n; i++)
-		string_list_append(&affected_refnames, updates[i]->refname);
-	string_list_sort(&affected_refnames);
-	if (ref_update_reject_duplicates(&affected_refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
 	/*
 	 * It's really undefined to call this function in an active
 	 * repository or when there are existing references: we are
@@ -3357,7 +3311,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (for_each_rawref(ref_present, &affected_refnames))
+	if (for_each_rawref(ref_present, affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
 	for (i = 0; i < n; i++) {
@@ -3367,7 +3321,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
+					     affected_refnames, NULL,
 					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
@@ -3398,7 +3352,6 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 7390247..0dbb13d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -217,6 +217,7 @@ int rename_ref_available(const char *oldname, const char *newname);
 /* refs backends */
 typedef int ref_init_db_fn(struct strbuf *err, int shared);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
+				      struct string_list *affected_refnames,
 				      struct strbuf *err);
 
 /* reflog functions */
-- 
2.4.2.749.g730654d-twtrsrc
