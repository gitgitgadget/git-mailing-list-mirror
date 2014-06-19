From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 46/48] refs.c: propagate any errno==ENOTDIR from _commit back to the callers
Date: Thu, 19 Jun 2014 08:53:28 -0700
Message-ID: <1403193210-6028-47-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxefO-0006qp-SW
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933096AbaFSPyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:18 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:39833 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758085AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so694268iec.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E4hQl5shA27T+XSwktV8V2ERs5ZrocaamOSeKcXbSQk=;
        b=E5XbowOtSPxijORA7qt+3sdePTLCQoHPaV2zf68wturaYIeXmfqpr6QiCHMPK8Ra3l
         W4M9os+jPWjM4WSi8caE81qqFWnWgf5TfsCeNhOZ8vkVrXv1KAdNmCIkV0em6HtNL6qJ
         22T/+1FY0GURLr6wmMfnGA3+2z5MVhcSGklN7nL1VtDp454OPFBzckux0WE005y3NB00
         OKIsxJYx5eHL5MIbPsNVKgffD+yGzEmDJuIJVtPYeLrBBvpk6gIlXwf2uEi0Gvhftrh6
         9kxtopdsCSOcYsDOplt4Nj/2mjtG8sfb453CFjOry8qusrdLTEMDXMmJi+/HMFV6YTGQ
         zOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E4hQl5shA27T+XSwktV8V2ERs5ZrocaamOSeKcXbSQk=;
        b=Lbp9vsFBhx/WQQMSm+JaeyI1AuRSZ3ZZWZiAYb5ocMCvfkrDMllQrYA4/OSkEB3tFU
         LzFziSlbtDKb4tFAt1UTI5PIFY7ogM8/xAmpGkHDhfXDSjFKo4HzPmVWE+ZsLb9OXNHr
         /meHt34CCqOpTQCgI8maz5YQ2+lYVEBT9Lgz4qZN7V9CWbkZojBOn3QTbt3xcFzcIPCI
         6qV3VV0AfIvn9eulWr5s3ezbsiOWcUs4zlyKoAf82QeQvgnXEiZUE3gfxz5vEnjsUkDB
         D96QkX1VvKf3EubT8nLdD4bQYvjEuk2ZQ9HR7QWF1Is7LMwsZSWfRGXa32gaL3TIkwvi
         xawg==
X-Gm-Message-State: ALoCoQkTmKMiOyJA2yavTe/Y1tkHNtY3dNRlRmNZUUHJiDVoap1NsB/fp3orS/B43mN3KvMxieD8
X-Received: by 10.182.70.74 with SMTP id k10mr2728797obu.34.1403193214801;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si421022yhm.0.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8183E31C3F5;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6039CE115F; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252128>

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
index 6b5fc09..f4234b9 100644
--- a/refs.c
+++ b/refs.c
@@ -3579,7 +3579,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
+	int ret = 0, delnum = 0, i, df_conflict = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -3597,9 +3597,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
@@ -3613,10 +3614,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3634,6 +3637,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 				if (err)
 					strbuf_addf(err, str, update->refname);
+				ret = -1;
 				goto cleanup;
 			}
 		}
@@ -3644,14 +3648,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3664,6 +3670,8 @@ cleanup:
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
2.0.0.438.g337c581
