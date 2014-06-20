From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 46/48] refs.c: propagate any errno==ENOTDIR from _commit back to the callers
Date: Fri, 20 Jun 2014 07:43:27 -0700
Message-ID: <1403275409-28173-47-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:45:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy040-0002Sc-20
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbaFTOoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:44:10 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:55844 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbaFTOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:35 -0400
Received: by mail-ob0-f202.google.com with SMTP id va2so193382obc.3
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=achO6kQDlB0DBxSviHSY1s9I4rdHxz2vjJbnUQye15o=;
        b=c5563H7Esj6eb0OowXqrXX8L9nXz3z74ovFHenPJqt0rPikTadON6KjMxpr2Dlw6Gr
         zHavI7F/+Y/Y7f+XWeMyoPDw5svgjh+cYX/w2AqkFokOgiQHUFahl0n5rajzjKT7l66U
         va0EPnVcpXjbbpnMmGK+OJfFisPg+iq95iK0CvtLId9bDR5MYO8WeshBDIhaU4X38DWp
         IA3amdwEwOQaqIvGBBThWj6rEjAc/Mw55d8bG0PaZCvKhnZ58Z2oPF6A3EHvkE9RM39b
         5gpR+QG0Ihopbagr2C8IHFyhKNqfYXCuD+Mj9wlj02uEB+BLC1mMGz4GipR/38busRT8
         5BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=achO6kQDlB0DBxSviHSY1s9I4rdHxz2vjJbnUQye15o=;
        b=CuoepgadcMNznurJ0O3v+mFpi+oCRs+VwUdfdRT4ybJ+O7bJGjd2q36OpQj5IYP//6
         nneOAT2qPI/3vWIT2sXUFsi8zrMuYAv8NxC7yNSaR7k1ueJxvWfysC+uupPZ2wTMlueZ
         w0mM75u2miMc730DnEXEdjPuOgKK48AxWNv01FYn0IxoXZ5iR3K6v0Dy1iD7EJBQQOFn
         LZthKCeGh93MgSDvnxvIxyQP18M7r38j2Z2s66fVHuShfZVUektS10JcA71Y+RWH8lof
         J4T1nWwTqqQdRhYjcE6rP9qVvGUrqNW3PoXsPmAevOqqYEM2KKMEZI3l32XbUnYSGR1R
         tOlw==
X-Gm-Message-State: ALoCoQlHTgqZYF3txYEb2aTBqdtW/xNXqTPO2BK6SXyGp3aeaz9x/iaSgENdeJkZaXUqWp9j35gf
X-Received: by 10.50.12.7 with SMTP id u7mr1531369igb.5.1403275414176;
        Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id b39si187841yhj.0.2014.06.20.07.43.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id EB54431C6B6;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C4999E0873; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252245>

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
index c6990d0..74a55b5 100644
--- a/refs.c
+++ b/refs.c
@@ -3582,7 +3582,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
+	int ret = 0, delnum = 0, i, df_conflict = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -3600,9 +3600,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
@@ -3616,10 +3617,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3637,6 +3640,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 				if (err)
 					strbuf_addf(err, str, update->refname);
+				ret = -1;
 				goto cleanup;
 			}
 		}
@@ -3647,14 +3651,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3667,6 +3673,8 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
+	if (df_conflict)
+		ret = -2;
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index f24b2c1..5c0543d 100644
--- a/refs.h
+++ b/refs.h
@@ -333,7 +333,13 @@ int ref_transaction_delete(struct ref_transaction *transaction,
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
2.0.0.420.g181e020.dirty
