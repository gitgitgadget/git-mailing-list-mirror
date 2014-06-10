From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 46/48] refs.c: propagate any errno==ENOTDIR from _commit back to the callers
Date: Tue, 10 Jun 2014 15:29:34 -0700
Message-ID: <1402439376-25839-47-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:36:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZF-0005av-Kd
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720AbaFJWav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:51 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:50434 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so132377oac.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ORrtGlcUn8VcNlAc2EX9mQbA8NvOVfbwXpZTCTdULz0=;
        b=Wo6O+bdYJxs0Jd/m/ql6XoOBTLM6mEzYhp9bPtqHDqZfsfJCOsIAPqImNfZChQRpJH
         Q6mazOMjWXp26ER9gA7KbgkBKMrI1Fq/BpZpl6RpAD7IsHn0pI+qNfCqOtKLUIbuJBZk
         kEF0zFRkCwsxFrIqUV0mrBY/V7GaCispYWT3JiuNZT4BUH6Jel0H8ZojylFlOLoCuOFe
         LnzCqb+S++KEPU55Ib7Rw44/fpRD9/ha9Z8aRQLtA3yphB64tEujFh67xUJWPHSRlCdt
         K7XTDsECF69bS/7QmiQpOMZMHmMEDOzpEV2BzBZkudWK6Z9KLZ4Epg20Ta2vx17EIce+
         xIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ORrtGlcUn8VcNlAc2EX9mQbA8NvOVfbwXpZTCTdULz0=;
        b=L/c50Nxb11ThkOFWafsJuG+sOSQHU/UHoK778bGfnpDP7/n5lONNU6O2ni/5/eIyps
         m15k/42BTLYO2Nxe5zS1PKIBL8BjPMGGG4DA1AAP9vdtdBFjHcLVNtB4CvWWbqyD5FeZ
         reSM4Ux2+KWJd7EaK1FuzMxLZq/RQAYaJYcfP07/CRnbF7PfNZe8nkWxxNqphWIgZ0UI
         sOb5X8vrAEK/F3eLxKOlvlUi9DYb5UYz/l1L2Bdcts++myGOrVrwu4X2+fJSY17sL/BA
         LyPui0ettTQGCXN8UwcstKlvWljc073zH22fBkSdswaC8uBBCgwRXPIjHHju750Q8ti5
         WQcw==
X-Gm-Message-State: ALoCoQmyLfrbhXuCl69Rb1KCqwS3B0sAXsUzxXKS/NDAmkbEGz3thK7HeCUOkf+KfP0e0sJL/QDz
X-Received: by 10.182.106.229 with SMTP id gx5mr3171751obb.31.1402439382322;
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si1395568yhj.5.2014.06.10.15.29.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 17C9B5A46F1;
	Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id ECEFBE0BF1; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251273>

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
index 5e1c0fd..4cee9e70 100644
--- a/refs.c
+++ b/refs.c
@@ -3555,7 +3555,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
+	int ret = 0, delnum = 0, i, df_conflict = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -3573,9 +3573,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
@@ -3589,10 +3590,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3610,6 +3613,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 				if (err)
 					strbuf_addf(err, str, update->refname);
+				ret = -1;
 				goto cleanup;
 			}
 		}
@@ -3620,14 +3624,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3640,6 +3646,8 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
+	if (df_conflict)
+		ret = -2;
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index e4780c8..e03ab44 100644
--- a/refs.h
+++ b/refs.h
@@ -329,7 +329,13 @@ int ref_transaction_delete(struct ref_transaction *transaction,
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
2.0.0.574.g30c2c5e
