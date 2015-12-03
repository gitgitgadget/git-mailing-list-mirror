From: David Turner <dturner@twopensource.com>
Subject: [PATCH 11/16] refs: move duplicate check to common code
Date: Wed,  2 Dec 2015 19:35:16 -0500
Message-ID: <1449102921-7707-12-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Hso-0007Bh-VM
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967AbbLCAgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:21 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:35257 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563AbbLCAfx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:53 -0500
Received: by ioc74 with SMTP id 74so64530529ioc.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BpA8Iv+o5h2vFGv42zgG+aDgiLSVR0v7fb5vTGT9Ng8=;
        b=g5XxY21C1NJxxRUM7LmKGZhcA+dqazDG3Ir2IKqt4FpID4Pes+yDd2pQW4Wz2YBgWJ
         wMkFkyfXqD2mUd7R1/zad94CHE8vsBKFgmDef/43GPBPuV1oFbcIwWdZ2X6AvCZZfd5x
         Ah+5Gn+CMHamfCO6Xy4ab4FUpzRuZ7F9IC7EGwbK9C6FjNkEfqdF69fiNJOThHZc+Fvl
         B/H7SBdiw0UOF88BhZKeE718W6kwC5uT3/uC+rFhfVGvnFPYwt8Lh5YmeodVqqEruxUX
         xNrIH5Q5QTk3cqPEpXwjRXpdl18bx2jFlidjMT9QPbhJBeChtreXnzrmLdbTV4r/WNvn
         hewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BpA8Iv+o5h2vFGv42zgG+aDgiLSVR0v7fb5vTGT9Ng8=;
        b=DnzczNt9U6xPPHM2HugMz1ZQgLxa7213BJYJEyNv+vJpoiI2eR3gEjpx1KbATJ8yYD
         g6Aapd9ssCVLp9DfxI/2GNW7gIpyvw+Pqv4t9kY1LB+BvTEkmjNFlNl2Wd50ovkKmw7B
         f50W0iQUjJM0dP8zAGhwAuVQ7hsJW/YLe7HP2Of+n2uSqlZZY8OBXQYZlbOze2mnakr2
         gSrIvjFlrTdwvaBksbwCSKRlinV05uNgEQT3k1bsCm+Cukz4+WP3pm8DOmTCmK4moNll
         yKkZ1DgTHCZXTNTrU1PaUeWjxXvu00VO70CuZitsemlKYZRNkUbpnpTKR++o5RWbr6H0
         MwDA==
X-Gm-Message-State: ALoCoQkw6F7bZNcjLuLIBw0v7EOmpXCdcBTs0cVv3DtfunnjgEUvlCBxC5HGonTA2RFtys463a41
X-Received: by 10.107.162.21 with SMTP id l21mr5906840ioe.123.1449102952456;
        Wed, 02 Dec 2015 16:35:52 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:51 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281930>

The check for duplicate refnames in a transaction is needed for
all backends, so move it to the common code.

ref_transaction_commit_fn gains a new argument, the sorted
string_list of affected refnames.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs/files-backend.c | 57 ++++-------------------------------------
 refs/refs-internal.h |  1 +
 3 files changed, 75 insertions(+), 54 deletions(-)

diff --git a/refs.c b/refs.c
index 1b79630..808053f 100644
--- a/refs.c
+++ b/refs.c
@@ -1093,6 +1093,37 @@ const char *find_descendant_ref(const char *dirname,
 	return NULL;
 }
 
+/*
+ * Return 1 if there are any duplicate refnames in the updates in
+ * `transaction`, and fill in err with an appropriate error message.
+ * Fill in `refnames` with the refnames from the transaction.
+ */
+
+static int ref_update_reject_duplicates(struct ref_transaction *transaction,
+					struct string_list *refnames,
+					struct strbuf *err)
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
@@ -1102,7 +1133,29 @@ int refs_init_db(struct strbuf *err, int shared)
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
+	if (ref_update_reject_duplicates(transaction, &affected_refnames, err)) {
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
@@ -1270,5 +1323,19 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	return the_refs_backend->initial_transaction_commit(transaction, err);
+
+	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	int ret;
+
+	if (ref_update_reject_duplicates(transaction,
+					 &affected_refnames, err)) {
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
index 22a6f24..59e2ec1 100644
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
 
@@ -3323,27 +3286,18 @@ void files_init_backend(void *data)
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
@@ -3356,7 +3310,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (for_each_rawref(ref_present, &affected_refnames))
+	if (for_each_rawref(ref_present, affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
 	for (i = 0; i < n; i++) {
@@ -3366,7 +3320,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
+					     affected_refnames, NULL,
 					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
@@ -3397,7 +3351,6 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8322011..9c17fdf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -218,6 +218,7 @@ int rename_ref_available(const char *oldname, const char *newname);
 typedef void ref_backend_init_fn(void *data);
 typedef int ref_backend_init_db_fn(struct strbuf *err, int shared);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
+				      struct string_list *affected_refnames,
 				      struct strbuf *err);
 
 /* reflog functions */
-- 
2.4.2.749.g0ed01d8-twtrsrc
