From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 46/48] refs.c: propagate any errno==ENOTDIR from _commit back to the callers
Date: Thu, 12 Jun 2014 10:21:37 -0700
Message-ID: <1402593699-13983-47-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8iJ-0007rj-9Q
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756382AbaFLRWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:17 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:36652 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296AbaFLRVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:46 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so142839vcb.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8f45o2clKCgI9nBrlGI/6Vs+6zqZftu65X9KqmMD7BE=;
        b=AZgNo4gSODEgevbvU8EY+WieNKT431YAnUv5T1CtNgE1SlgKZVMYkXTgrLGR3BMPn9
         2oASxc+gO0qm7ETPe3PGgLY78kycj8hDP8yZUVYjN52CIOv39HO0W33L0PdhOij2+tRd
         zwMBXAAEexrFqDWKw936oL14uP0Zc4Opi1Ibj7eQ5QNLSCJvSZmRLXD7liiR7n76BMmZ
         l4WImIPNjPaaK1us1ap/lUAPPESzS7l+h+Qh6gQ7dnRUzFGe1DSZJLHAqFTSbZjMfm0p
         unMznM4pWFekO2uxjI/OHTX2BsNj58yjz1Aqd2NQlM3F4ggYnDnu2bnr+oCh1bRl2XY1
         UyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8f45o2clKCgI9nBrlGI/6Vs+6zqZftu65X9KqmMD7BE=;
        b=GzhI7Zto+6BAl6OdB1Mm+ylS75krAgU0RLt5xLGT7EsmPLxJ75W+uySVJpog95PbhP
         lK+h+qryQf4FL7LnuiRvmVF+d91E+IfXO9hv9LE/XPXqG2+Pcje7QZjaot+w6ZzpxwCt
         ypDvd6/mob+mUAaq+qZy3Nn8XOEIEV+E3ruMkDFWTKTGuqrhpWTbYkgBwZYUztTm6tVK
         qjN43zVFOmi02VLjgRk6hY0bitKXVhNpWjoIwUrYunm2MbeQD1G4ihNLmMQEgdLBT4Xc
         /Ri/ekg55hVRbWkREBRl8SeprL0jLXB+n8G+4X4dRqkJXLTMJxAQx/quqW/a8MO0pCJu
         21xw==
X-Gm-Message-State: ALoCoQmyMjTUt4cUH8oq92lhnBDKNGaS5q6QjR3ZQE/qL/8PjhlEOQdop+BFqaKget7XA9S2LVp6
X-Received: by 10.58.38.199 with SMTP id i7mr1341664vek.6.1402593705167;
        Thu, 12 Jun 2014 10:21:45 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si112269yhj.5.2014.06.12.10.21.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DA7EC5A4813;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BCEF2E0A7E; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251436>

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
index b1224f3..8917832 100644
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
2.0.0.599.g83ced0e
