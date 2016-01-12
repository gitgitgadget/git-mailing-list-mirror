From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 11/21] refs: move duplicate check to common code
Date: Mon, 11 Jan 2016 20:22:10 -0500
Message-ID: <1452561740-8668-12-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIng2-0003Vs-7q
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761380AbcALBWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:47 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33568 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761808AbcALBWn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:43 -0500
Received: by mail-qk0-f177.google.com with SMTP id p186so153620678qke.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=USHt9AEvUjgmVzKDluYnqH1YnTp7AWXXfXrtn5z3HKY=;
        b=dlmdaWMca7APcHycaQkPXg0yvEMw6svrOPULIvEQNh6JOJ/y0oUxOGY7px6611Rc9a
         2bGrx5ozQQtJnr1pqnqlFXyuYLFPRLRQu+aaBJgOar9G8PQaWGyntlStwZRO50HVEHxY
         2+Anl2N1xJJbX8uhwOn/QebyJSPzF42iWuZJAmYCU36OCT269ywRetQQKFVHc9KogQH7
         3lvZQm3qzmECqtwELvq2KwgEG0yxlucbuYXK5an5pKjmxQ0Q0gwfnSwqrDS9W5PGMGqt
         8dw9wWQ2ZU1aT+RVjKypuaGVCgX7Xa/+hBhZv4XqHJ7HxSDljqAco4qe7uCW8tPyU8e2
         hMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=USHt9AEvUjgmVzKDluYnqH1YnTp7AWXXfXrtn5z3HKY=;
        b=ma74lai6qNVfip4BL9JejCAxZEaigEpdwnCPB9PGcEgDO8frXm6/uFwNlH6Q8IxZpO
         YaN00R1O2aKnXqNmqHNbfRfBDweBV14dbeLiohUAz7wzjFvq/o9Kj7YTgM3lKYnVV8t9
         q3KY8SGDcwqU/IvwEdNXHT2v+ZIzmxWyx6WXw0cYgNkDz5gKIA9AoTUMG0XBH3pKYjcB
         Jtu0MKMYmtVqFKnKSCWfp5PtdEyTuxMQ/EBzw/X6FdDDhxRMeWeUzAv5AAeI+Ex+YB2d
         u0+h+TBhlGom/kJfq49+WpQdL+CGwxlcZGhaYJI9PQAWzHtPA25jm7/McHf1qcGv/C2J
         a5QA==
X-Gm-Message-State: ALoCoQk/6sgh6lVZ6pqkeO/vQ01MG/CSNfn6vPaaTmQUPa3u5DgAEIcMBOhakcNEV8ftx6q+5LeTgCBLw3Umf2Rc447mn66GdA==
X-Received: by 10.55.76.15 with SMTP id z15mr122692881qka.32.1452561762954;
        Mon, 11 Jan 2016 17:22:42 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:41 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283749>

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
index 0b29b25..87bb1bb 100644
--- a/refs.c
+++ b/refs.c
@@ -1089,6 +1089,36 @@ const char *find_descendant_ref(const char *dirname,
 	return NULL;
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
@@ -1098,7 +1128,29 @@ int refs_init_db(struct strbuf *err, int shared)
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
index 1e5acef..98a9958 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3130,24 +3130,8 @@ static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3155,26 +3139,6 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3193,7 +3157,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
-				&affected_refnames, NULL,
+				affected_refnames, NULL,
 				update->flags,
 				&update->type,
 				err);
@@ -3305,7 +3269,6 @@ cleanup:
 		if (updates[i]->backend_data)
 			unlock_ref(updates[i]->backend_data);
 	string_list_clear(&refs_to_delete, 0);
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
@@ -3318,27 +3281,18 @@ static int ref_present(const char *refname,
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
@@ -3351,7 +3305,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (for_each_rawref(ref_present, &affected_refnames))
+	if (for_each_rawref(ref_present, affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
 	for (i = 0; i < n; i++) {
@@ -3361,7 +3315,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
+					     affected_refnames, NULL,
 					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
@@ -3392,7 +3346,6 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f8ae47b..8f5b412 100644
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
