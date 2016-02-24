From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 17/32] refs: move duplicate check to common code
Date: Wed, 24 Feb 2016 17:58:49 -0500
Message-ID: <1456354744-8022-18-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:01:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQc-0004iM-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759046AbcBXXBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:01:03 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34614 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759149AbcBXW7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:33 -0500
Received: by mail-qg0-f44.google.com with SMTP id b67so27012817qgb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i6mfzTFFbewDKyVY2tG5XlrLgyATGL1KuCJSYiFFd7g=;
        b=nCEIHwoL694SzmuBqBR+WSNTlhH++W++c+XciK0qtLucS4lxX736kFr/Pp+nw2nZOI
         pVqKOa331OJRwAFhYwLvz308zSX/kuloqNsdVoBJdNweUfnbTyFLVjXE/HQOjC+Rv3Bu
         UHNy7QGvzWXG6lEb5UcQEmaFYNrjTFSce7xs/DTp9bV48zKIQ5etruOLhbX6Z3pQ9Oih
         H0SRAT73HQKAjsRBdBc0cPTUKnEvo3bCMlRu23UrXBitQv0EZAxrQ1VWoEYj1HgUerOM
         o67TE4WA7LJag7rInZd/QtH8q8tJb4tgxcf2APJqePncYZvKXUy+yF3L/CWS7PRlea1e
         /WOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i6mfzTFFbewDKyVY2tG5XlrLgyATGL1KuCJSYiFFd7g=;
        b=MBZ3eqmImCvyY2345Ev4K6c+Ks/4kYrfH0vmDMOapr52/s/lBLqpM0VLve0lxksyWt
         v1c5nnAXH7yjIttqUclrQcyHC8EH2a3NtgTGATp/p6RwnWAW2IVi1+knzDF2YyFVHjbY
         6X6imqSd/n1s4Dkb/sLAgyFKipt5lbTjYgSqIp95BAlbEXqAgBrzHPstONNfbg4PnLT9
         db+Z9wF/0VV8GrvAkFS3JlHLzB3dS5dYEEY+0krDIfEUXYh302NkcpHMvAvIFJ6OSDzZ
         /erhniVYForD8nVtmcnKbSGuAxVc9fBIfEpgfRgkV54KOLma33xo2OaDHgYE1r2jDRDb
         kkQQ==
X-Gm-Message-State: AG10YOQxML3bz1bO8I2aTb3PL4lr3M76uBQj9q8/BHGURgwiLDGwUtB2wUVbAxuCs50fIg==
X-Received: by 10.140.42.137 with SMTP id c9mr20142589qga.5.1456354772607;
        Wed, 24 Feb 2016 14:59:32 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:31 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287270>

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
index 05b1b2a..daf92ce 100644
--- a/refs.c
+++ b/refs.c
@@ -1140,6 +1140,36 @@ int head_ref(each_ref_fn fn, void *cb_data)
 }
 
 /*
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
+/*
  * The common backend for the for_each_*ref* functions
  */
 static int do_for_each_ref(const char *submodule, const char *base,
@@ -1324,7 +1354,29 @@ int refs_init_db(int shared, struct strbuf *err)
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
 
 int verify_refname_available(const char *refname, struct string_list *extra,
@@ -1405,7 +1457,20 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
 
 int delete_refs(struct string_list *refnames)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9be3158..413db22 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3020,24 +3020,8 @@ static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3045,26 +3029,6 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3083,7 +3047,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
-				&affected_refnames, NULL,
+				affected_refnames, NULL,
 				update->flags,
 				&update->type,
 				err);
@@ -3195,7 +3159,6 @@ cleanup:
 		if (updates[i]->backend_data)
 			unlock_ref(updates[i]->backend_data);
 	string_list_clear(&refs_to_delete, 0);
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
@@ -3208,27 +3171,18 @@ static int ref_present(const char *refname,
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
@@ -3241,7 +3195,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (for_each_rawref(ref_present, &affected_refnames))
+	if (for_each_rawref(ref_present, affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
 	for (i = 0; i < n; i++) {
@@ -3251,7 +3205,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
+					     affected_refnames, NULL,
 					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
@@ -3282,7 +3236,6 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8d091cb..94d162e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -218,6 +218,7 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
 /* refs backends */
 typedef int ref_init_db_fn(int shared, struct strbuf *err);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
+				      struct string_list *affected_refnames,
 				      struct strbuf *err);
 
 /* reflog functions */
-- 
2.4.2.767.g62658d5-twtrsrc
