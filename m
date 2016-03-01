From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 18/33] refs: move duplicate check to common code
Date: Mon, 29 Feb 2016 19:52:51 -0500
Message-ID: <1456793586-22082-19-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZb-00078C-2O
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbcCAAxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:52 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33230 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcCAAxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:47 -0500
Received: by mail-qk0-f178.google.com with SMTP id s5so63749813qkd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7bWSMAbEYW2QjeJEc8XrgATgPYgu3lfe7oR9ifQ2Zbk=;
        b=W+Xzva2uUeMD7SZsQ0dgtTz5Mpc8Uran+AePBy8HJ9WUeQWrOkveiulAylmPt5wvsv
         T72dxwDQmy7kvlvvOlsIH+tRgSXlZhnrfr6xaXXbTqh+HTFUTWm3x17USepKFUwiK3Jb
         SwjGL6txuVByeLBZmgyDoMMAUPI14PzxzZ472RRWYzV7LVeMbFivrxJ2a2TBCM7eob5f
         42L1KunCibK1CLogWILDVQodoCiS11qrfgmEtWGzqonmWxk9bkT5WmaqUadnhJ9plfWT
         YQUljvdLy2kBeYi2K58bx0WX9uhrjsEEEtAbqB3ZNEHVo1XpIv3T367YkCxHjbNtNybL
         huZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7bWSMAbEYW2QjeJEc8XrgATgPYgu3lfe7oR9ifQ2Zbk=;
        b=ApY3j+M2VXZcGI78mqax/NvEgp4uWmD4Xs/WlRznfDUUdPGnhrd0lMYxW4B/mv6gDU
         +CYbZ9JNgKSd42y0c2N+0Q5wBYJ9Sp1len/t08A7k9Wctb4L0/L/zbzKLMwkdAYUWPsB
         GuuFIwy/Vbc5GU2EDryw2Lxef+fOCGJnLNq0q87HQEtXol7GSIU6aicA/1UFajxzHi1u
         YV1l3Q+MACj/g0BVA1Nn6rIX5AA/c6Y6kONrja3VlZee3gM0xUD0LaYNZMf5QE3731Ex
         9akhfVMy857KvdMusnP//Ptn8uDIjGGiy+Ccp4SybuvFcuti72abA/5UFbNsmCPVEHq2
         ancQ==
X-Gm-Message-State: AD7BkJJKIkJNwJvj87R8TwLT0UqzJ9OpiHdE+lclcux/wTfcRHwloIyVc9lSwelE9Ax5xA==
X-Received: by 10.55.79.134 with SMTP id d128mr22842508qkb.73.1456793626741;
        Mon, 29 Feb 2016 16:53:46 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:45 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287956>

The check for duplicate refnames in a transaction is needed for
all backends, so move it to the common code.

ref_transaction_commit_fn gains a new argument, the sorted
string_list of affected refnames.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs/files-backend.c | 57 ++++---------------------------------------
 refs/refs-internal.h |  1 +
 3 files changed, 73 insertions(+), 54 deletions(-)

diff --git a/refs.c b/refs.c
index 4610a44..9f695cd 100644
--- a/refs.c
+++ b/refs.c
@@ -1143,6 +1143,36 @@ int head_ref(each_ref_fn fn, void *cb_data)
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
@@ -1327,7 +1357,29 @@ int refs_init_db(int shared, struct strbuf *err)
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
@@ -1408,7 +1460,20 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index 01c85c0..1f565cb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3011,24 +3011,8 @@ static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3036,26 +3020,6 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3074,7 +3038,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
-				&affected_refnames, NULL,
+				affected_refnames, NULL,
 				update->flags,
 				&update->type,
 				err);
@@ -3186,7 +3150,6 @@ cleanup:
 		if (updates[i]->backend_data)
 			unlock_ref(updates[i]->backend_data);
 	string_list_clear(&refs_to_delete, 0);
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
@@ -3199,27 +3162,18 @@ static int ref_present(const char *refname,
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
@@ -3232,7 +3186,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (for_each_rawref(ref_present, &affected_refnames))
+	if (for_each_rawref(ref_present, affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
 	for (i = 0; i < n; i++) {
@@ -3242,7 +3196,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
+					     affected_refnames, NULL,
 					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
@@ -3273,7 +3227,6 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 
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
