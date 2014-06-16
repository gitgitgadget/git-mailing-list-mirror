From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 46/48] refs.c: propagate any errno==ENOTDIR from _commit back to the callers
Date: Mon, 16 Jun 2014 11:04:17 -0700
Message-ID: <1402941859-29354-47-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:06:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbIj-0005V4-Uo
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbaFPSFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:05:18 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:42311 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932668AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so829626qcz.0
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RIPR0VfepeaGi8gpd3QrQBumTG7Id2NeMugZzqHiQpo=;
        b=hkBDL1V1/uDWehO9To+B+l/bUQO2VjmzLvKTS8DzF5lu6siRbRUQ4JaXOnKiqHAPww
         NIM9Rh+5Rf3s8NusgGRj3vmM0HyIUFh1oJB28vdvolAJJJEW+2amdCiaAblAbdXnSRJy
         0dtaXRRqlDcSSHbQRxK9rb0E0E4v/PsuOVZE2i++JJPdG3dx5hjoHWijsU0+QXiYb5zZ
         7nY3MEmSjlFd3IHZ1IR1QUl3yQczip5sdFk9G29AE1D1YRQaEE7UYEI2f0pacmFx651Q
         n4x2sUxqcyi/imGcyEdw1HXSuRcCjU0Upbp5iXMkWL2xDimWZe+zYWUCiH0VyyepNffx
         T1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RIPR0VfepeaGi8gpd3QrQBumTG7Id2NeMugZzqHiQpo=;
        b=XQ/Ilj9d6Tc+egvq11l06IjbFdzD/ccJ2BcmRw5wV8rDWDI589owF9dBschkx9NHkH
         SSkeVEX5Lk21XLAwsYWf40h3GvK9Xv1yQDfZelKmOTWUQyjNo2kyhSm3ZCkmNoaP6a6x
         afn4feqF6v8VfAUmLeVBMP0GP5FqEVn5wyaEW8HRUxOaI5WvqVgO/ustqxJtjeWCq9Ps
         vCUv9hQfzmm+qvualH61V8+FRFg9Xokhsi1k3l3cpgEj8FQmjIYeXYuY56WvXAM5Oa9W
         /9jGSK15G/yJMerBAdwf7NlAGZMtmCH0slpwpxzzAMHb4XGND+sOiwzBNARVghG4XYSZ
         jAxA==
X-Gm-Message-State: ALoCoQnqENqm/hCWVDKG11YO1qVu3ugsuabIWoPHJkDRCLQVpEFWIMHzPzOjvfQsXWZbmzK08O3M
X-Received: by 10.236.136.231 with SMTP id w67mr2214785yhi.37.1402941864323;
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si997327yhk.4.2014.06.16.11.04.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1B6075A4914;
	Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F2334E0CFF; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251759>

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
index be6b4b6..47575e8 100644
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
2.0.0.282.g3799eda.dirty
