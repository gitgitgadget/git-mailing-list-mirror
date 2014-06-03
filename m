From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 39/41] refs.c: propagate any errno==ENOTDIR from _commit back to the callers
Date: Tue,  3 Jun 2014 14:37:57 -0700
Message-ID: <1401831479-3388-40-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:40:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwRl-0006vS-C8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbaFCVjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:39:14 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:44875 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934320AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so1534283oah.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vgJXBXxYYAXlhZSKkk7ZWXpwtmSyZhmjMUQGjQBRMNk=;
        b=lbj6dJTIify3dhCvlONoTEhlsRMFjGHGEn/cCLAkxuEx0jIhcaUcuWXsBJMObLgW5r
         1WeZbdoGn3NN9h1g5hZYe2AzFy0GsV6FtBMkWP/Us+GGyjP/JjaI9zq88UxLu4WREjtn
         CWBFtEVicjQE3E8VyyVyxjgCAzqPMUkNzt7nPSIqsy/0uzDqHt/8Z9Pbt1rBVmyVr2LG
         VBoxQdUX8TP6Pivx2FfDR5KzL/NSV5yh+CFKikiSD/ol5cgtkWuY/P02fNMLz8/dJ1B1
         Nze0WpnABl2FwQ77SHY0uJ7m0pECmgPd58EkaxABH26oEQP9um1445DwB4xSE+zUzB7g
         XEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vgJXBXxYYAXlhZSKkk7ZWXpwtmSyZhmjMUQGjQBRMNk=;
        b=l5BFo5YRXLA+CmBS5da30KL77BReWMGj5zQD0N6VSWvYgs7Ubq3C7iBdsp2P5pc+th
         DcP5nkXgPc94oZmBd2+OSemNS1YBrIoqUDdm0tXCF17iOsweYhq6KSxAupXQXkyx132r
         FKOOB+HvoEe6Ae98s7tghcllfmUyuqBKJpDCmF/HGcFIi/WF5UVThuhQCd/gF0Ti71NK
         7z1K8i9AgoOaM0F6CqotyrMEL7MYYQuL4Cbu7mDr4+aa/GmXA7a0E/v7WXyQq5NiYuN4
         Ue9lJshp8SAlu/s0ugJCmtTtk3fRL8lmplEHbFePvZJri0eOao6CuiBsIiluFkv5l2Kd
         JPXA==
X-Gm-Message-State: ALoCoQl7tSP37aKA9X6eLCfb7ZfWRgNL68q6V1+a0CQqC9GmZ+TVnAsIZB2SIrmwscx3Gf7w42I5
X-Received: by 10.183.11.102 with SMTP id eh6mr19011599obd.37.1401831488745;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si30044yhb.3.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 728B95A43CF;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 50F80E043A; Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250664>

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
index f2ca96a..bcf238e 100644
--- a/refs.c
+++ b/refs.c
@@ -3551,7 +3551,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
+	int ret = 0, delnum = 0, i, df_conflict = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -3569,9 +3569,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
@@ -3585,10 +3586,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3606,6 +3609,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 				if (err)
 					strbuf_addf(err, str, update->refname);
+				ret = -1;
 				goto cleanup;
 			}
 		}
@@ -3616,14 +3620,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3636,6 +3642,8 @@ cleanup:
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
2.0.0.567.g64a7adf
