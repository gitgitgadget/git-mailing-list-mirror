From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 11/21] refs: move duplicate check to common code
Date: Fri,  5 Feb 2016 14:44:12 -0500
Message-ID: <1454701462-3817-12-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:46:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmKP-0002FF-Cc
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbcBETpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:45:46 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35822 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbcBETo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:56 -0500
Received: by mail-qg0-f45.google.com with SMTP id y89so2347450qge.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ETxymlp9Pbx3esj7OnrFKjkFW7/ZuwgdbPcwtkF2ti4=;
        b=JNH3K+r4H76h+SsC6D01WkIpI3tioLfpnIEl8cJpbjAD1RwKUVn/XOqF6I+yhtUARI
         ldZLGPE5URvzLBOpgWi9kIoY8VDZd6VCNj6aI6AqdEgF11iBg+a8n5Q073Kxal4mInYT
         AVkMqU6KYmxtjnhsa4hJKgVzpaNTRb3lP9ZU8x3FpMugJhWLIt/Tf4kP3xOcafaCyJxg
         yNYNNd3MqUA0FmNDsF1QTuBqjudFrLCRkf/L6D+/QqY+zwVVVPgwxp4rEOKOSfNWXF0U
         rooDz4kk7wnIiF4jT11fDd1CGwi1gA3zEJtfHIQXv03IeJVyM6gOm2vK8uzKRxs29xwF
         fZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ETxymlp9Pbx3esj7OnrFKjkFW7/ZuwgdbPcwtkF2ti4=;
        b=WSN5zBgPyEmQmGEvxghgHEhmXaORzxB/YbFtYxrv4RJLKX5Kr+0FY2iiKRZ4KSWJxp
         l1oE4kfoBODQDm4UmWZ5N73Gf/8a4KYMbtHlxqQ2P6sTl8ZslFbBdJ3q+p55auhlgv/z
         8XBCvdCSbQubvHurQqs1NwxucZg+T4zVioX2e2cpsRYUJgtjpDmJtPc16ocjtLAykgGM
         EghPWXshirBJOqq5bqI9DORkFLacc3wzcD1wmGgAHtL58Lz3c6nvvTENv3UJbVQWXrl+
         uqX3Bg5eWRuDqhVeEJP7nc/Ou+DM2Cxhll0LXtIUKZ0/l467nQXNCGqcbt81vLHzStsb
         87Dg==
X-Gm-Message-State: AG10YOTKMrIu8RIvaIcVxb7c8N+JQPUSEvTszE4efzjRPtNXP4kdpyqW3ZwJloyz1UGwCA==
X-Received: by 10.140.40.134 with SMTP id x6mr18761691qgx.8.1454701495642;
        Fri, 05 Feb 2016 11:44:55 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:54 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285618>

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
index e04fddc..283a5ec 100644
--- a/refs.c
+++ b/refs.c
@@ -1116,6 +1116,36 @@ int rename_ref_available(const char *oldname, const char *newname)
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
@@ -1125,7 +1155,29 @@ int refs_init_db(struct strbuf *err, int shared)
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
@@ -1277,5 +1329,18 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index aa11ba2..0ad60bc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3154,24 +3154,8 @@ static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3179,26 +3163,6 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3217,7 +3181,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
-				&affected_refnames, NULL,
+				affected_refnames, NULL,
 				update->flags,
 				&update->type,
 				err);
@@ -3329,7 +3293,6 @@ cleanup:
 		if (updates[i]->backend_data)
 			unlock_ref(updates[i]->backend_data);
 	string_list_clear(&refs_to_delete, 0);
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
@@ -3342,27 +3305,18 @@ static int ref_present(const char *refname,
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
@@ -3375,7 +3329,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (for_each_rawref(ref_present, &affected_refnames))
+	if (for_each_rawref(ref_present, affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
 	for (i = 0; i < n; i++) {
@@ -3385,7 +3339,7 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
+					     affected_refnames, NULL,
 					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
@@ -3416,7 +3370,6 @@ static int files_initial_transaction_commit(struct ref_transaction *transaction,
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
-	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3dec075..fc5d1db 100644
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
