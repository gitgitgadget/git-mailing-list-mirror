From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 38/44] refs: move duplicate check to common code
Date: Mon, 12 Oct 2015 17:51:59 -0400
Message-ID: <1444686725-27660-40-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:53:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1k-0004vO-2W
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbbJLVw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:58 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35672 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbbJLVwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:55 -0400
Received: by qgt47 with SMTP id 47so129537447qgt.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6bnWsYj6Mtyuld+Gwzj62557/TJCfEiDIF2pymCAt4Q=;
        b=lgO9QDAO72s1AGYaGZzfZB6li6yeR4dE4uXPsujArL/+j4frgSXB3r30QknC/3kMks
         SycIJ5MBdqQLmpKSO0Q+3t6buyvG5G2ODUXP369veZlyUh5IPwNI/7hMymo+WJERGBX6
         tSnKUQrpbsl/4A8Hxrt0SeyzBueFw1Lu68zUa/sBJ1DgvywBezeAkHs0uUeL8XonxKTj
         Ih4kLAEkZ9jUzRKwIYUyRYppL8O/7lrQqxK8or+XCAm1mOQWTWRwWbAIyqgQWmcCLU8a
         nIjp5nx9troQQATop7NaUopwyTtn+FC7neOMxZPWj49klvia6Iu55Em1aJBXCDGA3ObS
         4Vuw==
X-Gm-Message-State: ALoCoQmEbpNaOS9Hgymci96UJjy4kPkrETTos0GyIJ/p7P0sjfgtx3dyWjYRZ9VDda4C8GLFYsnB
X-Received: by 10.140.19.175 with SMTP id 44mr34645236qgh.50.1444686774989;
        Mon, 12 Oct 2015 14:52:54 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:54 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279438>

The check for duplicate refnames in a transaction is needed for
all backends, so move it to the common code.

ref_transaction_commit_fn gains a new argument, the sorted
string_list of affected refnames.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 57 ++++-----------------------------------------
 refs.c          | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs.h          |  1 +
 3 files changed, 75 insertions(+), 54 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index dd2c42e..b89bd5c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3104,24 +3104,8 @@ static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3129,26 +3113,6 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3167,7 +3131,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
-				&affected_refnames, NULL,
+				affected_refnames, NULL,
 				update->flags,
 				&update->type,
 				err);
@@ -3279,7 +3243,6 @@ cleanup:
 		if (updates[i]->backend_data)
 			unlock_ref(updates[i]->backend_data);
 	string_list_clear(&refs_to_delete, 0);
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
@@ -3297,27 +3260,18 @@ void files_init_backend(void *data)
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
@@ -3330,7 +3284,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (for_each_rawref(ref_present, &affected_refnames))
+	if (for_each_rawref(ref_present, affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
 	for (i = 0; i < n; i++) {
@@ -3340,7 +3294,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
+					     affected_refnames, NULL,
 					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
@@ -3371,7 +3325,6 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
diff --git a/refs.c b/refs.c
index 3ae0274..b00f910 100644
--- a/refs.c
+++ b/refs.c
@@ -1123,6 +1123,37 @@ const char *find_descendant_ref(const char *refname,
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
 int refs_initdb(struct strbuf *err, int shared)
 {
@@ -1132,7 +1163,29 @@ int refs_initdb(struct strbuf *err, int shared)
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
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
@@ -1302,5 +1355,19 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
diff --git a/refs.h b/refs.h
index f8becea..a9fdbf0 100644
--- a/refs.h
+++ b/refs.h
@@ -695,6 +695,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 typedef void ref_backend_init_fn(void *data);
 typedef int ref_backend_initdb_fn(struct strbuf *err, int shared);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
+				      struct string_list *affected_refnames,
 				      struct strbuf *err);
 typedef void ref_transaction_free_fn(struct ref_transaction *transaction);
 
-- 
2.4.2.644.g97b850b-twtrsrc
