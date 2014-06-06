From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 38/40] refs.c: propagate any errno==ENOTDIR from _commit back to the callers
Date: Fri,  6 Jun 2014 15:29:16 -0700
Message-ID: <1402093758-3162-39-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2e7-0002R3-EF
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbaFFW3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:54 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:44202 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbaFFW3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:24 -0400
Received: by mail-ie0-f202.google.com with SMTP id rd18so741007iec.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pVwxo6dQBLvbpSKYihPDdFGzV9N4HVp7wA/Lgacnl+o=;
        b=REilmgIeZWepckqGgXUr4QQyakqFwV+2/D4v3f8ELuWo4/6P+ZwCf/Zf9ssc4KPSnD
         NJR8ErycWGf/H8IcV1mU8wlsUYKaaDjNyrXuIWfp/KxqFPd+fo0oeBChLw6KJso9qp8p
         0Mr2atHe5tqYZsVohKOBnR9xPARuIP94yD8a+U3XNTfpGbd/9LvFWkWmHmtB5wmy5MVb
         ehjwPjRu/rHri/uPiU0bPCGok/z7822vUmlrOujmnkpeCN6CdoUPeFIJ/eclzQKDFZfh
         arAz4YWzqgnue/rof6N72QXke/Z3HSbTH46pncG1jI9G89D6pixP5/QOSjkcrIzaeXok
         Nbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pVwxo6dQBLvbpSKYihPDdFGzV9N4HVp7wA/Lgacnl+o=;
        b=MRDaBFo77c2j7bpjY/iOVSShVmsdeVcgXOdIxqJklXLD4z4xlw2ApxNKIj3LXu1ZdM
         2pyifDwFkbNIZeWKQjRCivX6IeB9poY7IAgKVDPJrvUMAstfoB0arwvNkrn/JMPfHgED
         U73MPs1spOvCiKDy5JouWYiwWoFFCC+8TqbEvxnbxNy4G9ea0jupktsgwIoSh53rmJpW
         577uVdJdFP4REP+pT0HHgiucpRDsg6qBD6+68MPgvOVtaUH2IUSQkoXpThVbZPKM49DO
         z5CAKDOdKp3DZkqw5MjO07JgIGD1wk0e3C7FABtsircKxedSYlhKaYDGs7huCcBhnJe8
         J0IA==
X-Gm-Message-State: ALoCoQmGTZ1bojTNSkiylVNnrICR7AiqvKcw0fN9Yxn8uuWh/g4p/FQMm1vqsMyk+W2KEII713bD
X-Received: by 10.42.249.207 with SMTP id ml15mr4769700icb.21.1402093763619;
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l7si751226vda.3.2014.06.06.15.29.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3A5B15A450E;
	Fri,  6 Jun 2014 15:29:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1AAB4E0878; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250982>

In _commit, ENOTDIR can happen in the call to lock_ref_sha1_basic, either when
we lstat the new refname and it returns ENOTDIR or if the name checking
function reports that the same type of conflict happened. In both cases it
means that we can not create the new ref due to a name conflict.

For these cases, save the errno value and abort and make sure that the caller
can see errno==ENOTDIR.

Also start defining specific return codes for _commit, assign -1 as a generic
error and -2 as the error that refers to a name conflict. Callers can (and
should) use that return value inspecting errno directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 22 +++++++++++++++-------
 refs.h |  6 ++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index a5fd943..9a3a501 100644
--- a/refs.c
+++ b/refs.c
@@ -3548,7 +3548,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
+	int ret = 0, delnum = 0, i, df_conflict = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -3566,9 +3566,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err);
-	if (ret)
+	if (ref_update_reject_duplicates(updates, n, err)) {
+		ret = -1;
 		goto cleanup;
+	}
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
@@ -3582,10 +3583,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   &update->type,
 						   delnames, delnum);
 		if (!update->lock) {
+			if (errno == ENOTDIR)
+				df_conflict = 1;
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
 					    update->refname);
-			ret = 1;
+			ret = -1;
 			goto cleanup;
 		}
 	}
@@ -3603,6 +3606,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 				if (err)
 					strbuf_addf(err, str, update->refname);
+				ret = -1;
 				goto cleanup;
 			}
 		}
@@ -3613,14 +3617,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			ret |= delete_ref_loose(update->lock, update->type,
-						err);
+			if (delete_ref_loose(update->lock, update->type, err))
+				ret = -1;
+
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum, err);
+	if (repack_without_refs(delnames, delnum, err))
+		ret = -1;
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
@@ -3633,6 +3639,8 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
+	if (df_conflict)
+		ret = -2;
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 5c6c20f..1583097 100644
--- a/refs.h
+++ b/refs.h
@@ -323,7 +323,13 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
+ * If the transaction is already in failed state this function will return
+ * an error.
+ * Function returns 0 on success, -1 for generic failures and
+ * UPDATE_REFS_NAME_CONFLICT (-2) if the failure was due to a name
+ * collision (ENOTDIR).
  */
+#define UPDATE_REFS_NAME_CONFLICT -2
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
-- 
2.0.0.582.ge25c160
