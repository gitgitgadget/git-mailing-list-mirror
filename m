From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/25] refs.c: ref_transaction_commit: distinguish name
 conflicts from other errors
Date: Tue, 14 Oct 2014 17:50:46 -0700
Message-ID: <20141015005045.GO32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:50:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCnl-0001zr-6x
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808AbaJOAut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:50:49 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:53268 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594AbaJOAut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:50:49 -0400
Received: by mail-pd0-f170.google.com with SMTP id p10so223849pdj.15
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BYdT1OiuULfojKrX8yGgsAUyXJ0CXP37cpTvX42gW+c=;
        b=TfVRKp75frDKFmQ6vra75tYgLlcSMaeOamHv/KmAR5pmElxTx+pcRo651PpzGu5YFV
         P3yzdD9f12nJeohP4zwMMjPyeNs6ErAF5SI/HneJh5bTcK+hqC0J4pfJpG2hh/+DLEU6
         quOFtM85qeJtO8N7CRDtRIaBTPsz5dgPgEk/GtAmQB90d474kdulqMymDQ0wPMycvG7k
         hEVmI9kzUW52oSSrdXzgw2XAYNUSiEJyKV8SLpxtGdzzorgtk72r1xONS6vPQHKxiBLj
         yp3xOa3Uc0gyKbQjJ7YDBXpGZ+2ij7Vtq45qH54wvddGj0N9FyQUlh9a6g8sc2a0/w8z
         FxmA==
X-Received: by 10.70.118.138 with SMTP id km10mr9017422pdb.65.1413334248638;
        Tue, 14 Oct 2014 17:50:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id od12sm15296829pdb.96.2014.10.14.17.50.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:50:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Fri, 16 May 2014 14:14:38 -0700

In _commit, ENOTDIR can happen in the call to lock_ref_sha1_basic, either
when we lstat the new refname or if the name checking function reports that
the same type of conflict happened.  In both cases, it means that we can not
create the new ref due to a name conflict.

Start defining specific return codes for _commit.  TRANSACTION_NAME_CONFLICT
refers to a failure to create a ref due to a name conflict with another ref.
TRANSACTION_GENERIC_ERROR is for all other errors.

When "git fetch" is creating refs, name conflicts differ from other errors in
that they are likely to be resolved by running "git remote prune <remote>".
"git fetch" currently inspects errno to decide whether to give that advice.
Once it switches to the transaction API, it can check for
TRANSACTION_NAME_CONFLICT instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 26 ++++++++++++++++----------
 refs.h |  9 +++++++--
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index a007cf3..9d9bbeb 100644
--- a/refs.c
+++ b/refs.c
@@ -3637,9 +3637,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err);
-	if (ret)
+	if (ref_update_reject_duplicates(updates, n, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
+	}
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
@@ -3653,10 +3654,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   update->flags,
 						   &update->type);
 		if (!update->lock) {
+			ret = (errno == ENOTDIR)
+				? TRANSACTION_NAME_CONFLICT
+				: TRANSACTION_GENERIC_ERROR;
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
 					    update->refname);
-			ret = 1;
 			goto cleanup;
 		}
 	}
@@ -3666,15 +3669,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			ret = write_ref_sha1(update->lock, update->new_sha1,
-					     update->msg);
-			update->lock = NULL; /* freed by write_ref_sha1 */
-			if (ret) {
+			if (write_ref_sha1(update->lock, update->new_sha1,
+					   update->msg)) {
+				update->lock = NULL; /* freed by write_ref_sha1 */
 				if (err)
 					strbuf_addf(err, "Cannot update the ref '%s'.",
 						    update->refname);
+				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
+			update->lock = NULL; /* freed by write_ref_sha1 */
 		}
 	}
 
@@ -3683,14 +3687,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			ret |= delete_ref_loose(update->lock, update->type,
-						err);
+			if (delete_ref_loose(update->lock, update->type, err))
+				ret = TRANSACTION_GENERIC_ERROR;
+
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum, err);
+	if (repack_without_refs(delnames, delnum, err))
+		ret = TRANSACTION_GENERIC_ERROR;
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index 1a55cab..50b115a 100644
--- a/refs.h
+++ b/refs.h
@@ -326,9 +326,14 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 
 /*
  * Commit all of the changes that have been queued in transaction, as
- * atomically as possible.  Return a nonzero value if there is a
- * problem.
+ * atomically as possible.
+ *
+ * Returns 0 for success, or one of the below error codes for errors.
  */
+/* Naming conflict (for example, the ref names A and A/B conflict). */
+#define TRANSACTION_NAME_CONFLICT -1
+/* All other errors. */
+#define TRANSACTION_GENERIC_ERROR -2
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
-- 
2.1.0.rc2.206.gedb03e5
