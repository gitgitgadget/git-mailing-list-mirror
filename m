From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 09/12] refs.c: propagate any errno==ENOTDIR from _commit back to the callers
Date: Wed, 16 Jul 2014 15:23:09 -0700
Message-ID: <1405549392-27306-10-git-send-email-sahlberg@google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:32:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Xka-0007l6-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbaGPWcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:32:33 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:47974 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbaGPWcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:32:32 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so420937pde.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NPbaa1fkQRUicQkwS3TcXC1a5eU0KUkoPS5HF6Z6Yo8=;
        b=YbEOEjQvw7NYeVAwxpA/o28s47fkc+4QBHDXIgQs4Zzu354ytx8C03ktifYiUtlBJW
         xUn0ImE1/c8PtLQBTk2PD75GenFB9/zyjloZnS8eSWC5AP99wOjWZvKgpM/ivo9oUJU8
         53tMas7+i9YaNHZ0RJp2IYyordjpUniX47lei3V3caR2zKs69vjhi2S7kWlhUiynggE6
         cOj15zpvabiHF56jU3cardYVFig3Gc9zOm568fdL6EwCccTZVE50SROBR7R0AS5VKKEj
         ZpZ879ZlkHDZ2PP4r06HzF3a5wU3/7v76SNBa9ncyU8/3sMdzOpTFestBT9E0/Y6roYp
         4BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NPbaa1fkQRUicQkwS3TcXC1a5eU0KUkoPS5HF6Z6Yo8=;
        b=JRFO/VYBgF9o7ITIpBQzciAFKZkOJcgu5UZqtIs/1hv+csNV9pt5vMXIcKMNmiP5B0
         s3dIw5Ipx2/6fqzdU2NVXpKpiRCVfVSLG/J5X31r3iHGfoi03pOIDDXfNZLtloPEb6rP
         8wVk8uCIkPurljK2obCq6YRuiPUTLaJIpLtkIbopUZsjPiGp9/EjIudwxNL2WQbilkXn
         Z1QoowlKy22WLmSp2O6Z28X7VhHHvXmnonSEFRkojBvHeV0d2rEkICWAZlhxmdpnL3Gp
         gu4t68Tc/VCRFKc+eyGWyJjC0Rer39tSM8FGsF701GFyiaY31qP+TbC5LwDuJ2jCZiau
         GMpQ==
X-Gm-Message-State: ALoCoQlAxZK4jV4HtfSJcEhyeRQsjgROaZTPB9u2KbJfjVaxrUrcBO3LgNfOefI7kve/AotqcaAZ
X-Received: by 10.70.24.163 with SMTP id v3mr9908806pdf.8.1405549951646;
        Wed, 16 Jul 2014 15:32:31 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l23si77784yhg.1.2014.07.16.15.32.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:32:31 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 216C65A41E6;
	Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D7CDFE0855; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
In-Reply-To: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253712>

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
index a115478..69cbca5 100644
--- a/refs.c
+++ b/refs.c
@@ -3559,7 +3559,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
+	int ret = 0, delnum = 0, i, df_conflict = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -3577,9 +3577,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
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
@@ -3593,10 +3594,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3614,6 +3617,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 				if (err)
 					strbuf_addf(err, str, update->refname);
+				ret = -1;
 				goto cleanup;
 			}
 		}
@@ -3624,14 +3628,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3644,6 +3650,8 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
+	if (df_conflict)
+		ret = -2;
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 6a4d1a7..fc7942c 100644
--- a/refs.h
+++ b/refs.h
@@ -326,7 +326,13 @@ int ref_transaction_delete(struct ref_transaction *transaction,
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
2.0.1.527.gc6b782e
