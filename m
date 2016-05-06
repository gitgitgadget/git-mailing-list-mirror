From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 26/33] lock_ref_for_update(): new function
Date: Fri,  6 May 2016 18:14:07 +0200
Message-ID: <bfba3b42460c75064ce0538cbd6ad820a7ddc537.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPO-0008Qc-20
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758712AbcEFQPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:11 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58921 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758709AbcEFQPI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:15:08 -0400
X-AuditID: 1207440f-8a7ff700000008e4-15-572cc30bf4d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 45.D5.02276.B03CC275; Fri,  6 May 2016 12:15:07 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHV8031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:15:06 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqMt9WCfc4M08DYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd0bfqTdsBTu1Kl72GDcwLlXoYuTkkBAwkVi+5hZr
	FyMXh5DAVkaJIyeWQTnHmSQmH5nLClLFJqArsainmQnEFhGIkGh41cLYxcjBwSzwmVFiJTeI
	KSxgK/HgAzdIBYuAqsSOxsvMIDavQJREe18vI8QuOYnL0x+wgdicAhYSh3qPg00UEjCX6Fh7
	g30CI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCHBxb+DsWu9zCFG
	AQ5GJR7ejJPa4UKsiWXFlbmHGCU5mJREeb8X6IQL8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuG9
	sg8ox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4D10EKhRsCg1PbUi
	LTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhT88cXA8AdJ8QDtlQdp5y0uSMwFikK0nmLU5Tiy
	/95aJiGWvPy8VClx3rkgRQIgRRmleXArYKnkFaM40MfCvNyHgKp4gGkIbtIroCVMQEvez9UE
	WVKSiJCSamBcpD715o5tHHcyPY+t+v9Wd0FBXcLfmy6nL2krz9hyTnDhx7+6df49nxmMDJR5
	n35YZW2zUzstQNVOy1xxVkZh0Yfe9OzTv+tVRD7PvL7irem1W1riT1eGztx5rkH7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293811>

Extract a new function, lock_ref_for_update(), from
ref_transaction_commit().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 152 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 85 insertions(+), 67 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f0eef9e..1c20af5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3051,6 +3051,88 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
+/*
+ * Acquire all locks, verify old values if provided, check
+ * that new values are valid, and write new values to the
+ * lockfiles, ready to be activated. Only keep one lockfile
+ * open at a time to avoid running out of file descriptors.
+ */
+static int lock_ref_for_update(struct ref_update *update,
+			       struct ref_transaction *transaction,
+			       struct string_list *affected_refnames,
+			       struct strbuf *err)
+{
+	int ret;
+
+	if ((update->flags & REF_HAVE_NEW) &&
+	    is_null_sha1(update->new_sha1))
+		update->flags |= REF_DELETING;
+	update->lock = lock_ref_sha1_basic(
+			update->refname,
+			((update->flags & REF_HAVE_OLD) ?
+			 update->old_sha1 : NULL),
+			affected_refnames, NULL,
+			update->flags,
+			&update->type,
+			err);
+	if (!update->lock) {
+		char *reason;
+
+		ret = (errno == ENOTDIR)
+			? TRANSACTION_NAME_CONFLICT
+			: TRANSACTION_GENERIC_ERROR;
+		reason = strbuf_detach(err, NULL);
+		strbuf_addf(err, "cannot lock ref '%s': %s",
+			    update->refname, reason);
+		free(reason);
+		return ret;
+	}
+	if ((update->flags & REF_HAVE_NEW) &&
+	    !(update->flags & REF_DELETING) &&
+	    !(update->flags & REF_LOG_ONLY)) {
+		int overwriting_symref = ((update->type & REF_ISSYMREF) &&
+					  (update->flags & REF_NODEREF));
+
+		if (!overwriting_symref &&
+		    !hashcmp(update->lock->old_oid.hash, update->new_sha1)) {
+			/*
+			 * The reference already has the desired
+			 * value, so we don't need to write it.
+			 */
+		} else if (write_ref_to_lockfile(update->lock,
+						 update->new_sha1,
+						 err)) {
+			char *write_err = strbuf_detach(err, NULL);
+
+			/*
+			 * The lock was freed upon failure of
+			 * write_ref_to_lockfile():
+			 */
+			update->lock = NULL;
+			strbuf_addf(err,
+				    "cannot update the ref '%s': %s",
+				    update->refname, write_err);
+			free(write_err);
+			return TRANSACTION_GENERIC_ERROR;
+		} else {
+			update->flags |= REF_NEEDS_COMMIT;
+		}
+	}
+	if (!(update->flags & REF_NEEDS_COMMIT)) {
+		/*
+		 * We didn't call write_ref_to_lockfile(), so
+		 * the lockfile is still open. Close it to
+		 * free up the file descriptor:
+		 */
+		if (close_ref(update->lock)) {
+			strbuf_addf(err, "couldn't close '%s.lock'",
+				    update->refname);
+			return TRANSACTION_GENERIC_ERROR;
+		}
+	}
+	return 0;
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
@@ -3088,74 +3170,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
-		if ((update->flags & REF_HAVE_NEW) &&
-		    is_null_sha1(update->new_sha1))
-			update->flags |= REF_DELETING;
-		update->lock = lock_ref_sha1_basic(
-				update->refname,
-				((update->flags & REF_HAVE_OLD) ?
-				 update->old_sha1 : NULL),
-				&affected_refnames, NULL,
-				update->flags,
-				&update->type,
-				err);
-		if (!update->lock) {
-			char *reason;
-
-			ret = (errno == ENOTDIR)
-				? TRANSACTION_NAME_CONFLICT
-				: TRANSACTION_GENERIC_ERROR;
-			reason = strbuf_detach(err, NULL);
-			strbuf_addf(err, "cannot lock ref '%s': %s",
-				    update->refname, reason);
-			free(reason);
+		ret = lock_ref_for_update(update, transaction,
+					  &affected_refnames, err);
+		if (ret)
 			goto cleanup;
-		}
-		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING) &&
-		    !(update->flags & REF_LOG_ONLY)) {
-			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
-						  (update->flags & REF_NODEREF));
-
-			if (!overwriting_symref &&
-			    !hashcmp(update->lock->old_oid.hash, update->new_sha1)) {
-				/*
-				 * The reference already has the desired
-				 * value, so we don't need to write it.
-				 */
-			} else if (write_ref_to_lockfile(update->lock,
-							 update->new_sha1,
-							 err)) {
-				char *write_err = strbuf_detach(err, NULL);
-
-				/*
-				 * The lock was freed upon failure of
-				 * write_ref_to_lockfile():
-				 */
-				update->lock = NULL;
-				strbuf_addf(err,
-					    "cannot update the ref '%s': %s",
-					    update->refname, write_err);
-				free(write_err);
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto cleanup;
-			} else {
-				update->flags |= REF_NEEDS_COMMIT;
-			}
-		}
-		if (!(update->flags & REF_NEEDS_COMMIT)) {
-			/*
-			 * We didn't call write_ref_to_lockfile(), so
-			 * the lockfile is still open. Close it to
-			 * free up the file descriptor:
-			 */
-			if (close_ref(update->lock)) {
-				strbuf_addf(err, "couldn't close '%s.lock'",
-					    update->refname);
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto cleanup;
-			}
-		}
 	}
 
 	/* Perform updates first so live commits remain referenced */
-- 
2.8.1
