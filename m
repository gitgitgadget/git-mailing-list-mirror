From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 39/41] refs.c: propagate any errno==ENOTDIR from _commit back to the callers
Date: Tue, 27 May 2014 13:25:58 -0700
Message-ID: <1401222360-21175-40-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxI-0002RS-7z
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbaE0U0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:32 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:60843 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaE0U0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:06 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so1508354pbc.4
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fSh5b21VYtz0izh24GU5op83FWirDFHPb1ZdcsafMpI=;
        b=F1zqSrjN7pXR5tKnSIh8u6nWG/PDjbRnlkN03uIfQsfga9vMUpZXXLMQEPTYlJOAuA
         b8/lNgyn71e8JMNTfJpuMeRRD/IG/GishLZanGUqmkROKABIvBkmw6S/CGdkjoHhvR6Q
         3cQLUnPMTSuX84E2oLbtBOxiZs4PjZmwTE3Yumn8EvCx7sPx/tmxCu3LcWH7eBPWRcQz
         9HZpg0wHGOyMolTiub5TVwpXKQEtIUPHtTRbnG7J1iVerK0lJQVki5mzqIkn3tYNBT9c
         0Vd6sRWg3GCCJuzyZfb2xpPHYlI2QqZuUn4Qde+cq9YxdXlQ4YK2x1+SLxCEfbRtupLr
         LfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fSh5b21VYtz0izh24GU5op83FWirDFHPb1ZdcsafMpI=;
        b=gmcRkZ+0ZBoURG2zgHUKJiB/5RnHFgVcC/DjI7uZlELt0KFwI68Esdjqn6RLatXRwI
         FVA8W3Dj9/F0Ya3nxXWyEakUA/0VcigYGckfqIB3p83lL2XHbeNS/+m8FhKpWMTtJoO/
         myCmLWMcmfmgsMTrZGGmstYHuVSIuYDIJOyhBfTaJvx3mqvmkPHztzplSd5aRsKIAqVg
         SQ/rtuLvpm7azH0JEAjhSIyA5nNXlF9X+TN0kuoL9aF7id8A3WXL5P4fdijzmIem+LYh
         jrLmWd3fi6FtZ4ByCBifczKD3x3WFASL5+7eKU9+j9/rNIvJ/32QcnesRmruvojtvYRr
         xuBg==
X-Gm-Message-State: ALoCoQnaVh658SAlEuX+xQmKy/a+iBcbIbL3u4Jc6C9Eca6NLZtLqidqerG4gf5oOksp0I2xJdQ1
X-Received: by 10.66.66.35 with SMTP id c3mr14821977pat.7.1401222365656;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si1575173yhq.3.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5672F37053C;
	Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 320F5E1170; Tue, 27 May 2014 13:26:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250203>

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
 refs.c | 23 ++++++++++++++++-------
 refs.h |  4 ++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index d3812b7..c108007 100644
--- a/refs.c
+++ b/refs.c
@@ -3517,7 +3517,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
+	int ret = 0, delnum = 0, i, save_errno = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -3535,9 +3535,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
@@ -3551,10 +3552,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   &update->type,
 						   delnames, delnum);
 		if (!update->lock) {
+			if (errno == ENOTDIR)
+				save_errno = errno;
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
 					    update->refname);
-			ret = 1;
+			ret = -1;
 			goto cleanup;
 		}
 	}
@@ -3572,6 +3575,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 				if (err)
 					strbuf_addf(err, str, update->refname);
+				ret = -1;
 				goto cleanup;
 			}
 		}
@@ -3582,14 +3586,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3602,6 +3608,9 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
+	errno = save_errno;
+	if (save_errno == ENOTDIR)
+		ret = -2;
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 84e12b5..2823b72 100644
--- a/refs.h
+++ b/refs.h
@@ -289,6 +289,10 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
+ * If the transaction is already in failed state this function will return
+ * an error.
+ * Function returns 0 on success, -1 for generic failures and -2 if the
+ * failure was due to a name collision (ENOTDIR).
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
-- 
2.0.0.rc3.474.g0203784
