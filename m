From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 10/21] refs: make lock generic
Date: Mon, 11 Jan 2016 20:22:09 -0500
Message-ID: <1452561740-8668-11-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIngE-0003dS-2a
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761820AbcALBWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:46 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33536 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761133AbcALBWl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:41 -0500
Received: by mail-qg0-f43.google.com with SMTP id b35so287934952qge.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jYX1/zRvpj163zxVB3ynIN4D1+jW63NaWTi3oSh36NI=;
        b=bAvbfAnr7Bk2+aFSbLidMLPT9idWGyEnfRyeU8z4IRGjMiitXZz2lsaAK+/nRF/+a0
         9gVCCbq+/Pj7oxlWdA4zh+NA6tKjO+14ea8NB0t+FQHMx8Fai+d25dF7tErVIsk7GJPA
         Clrs5oMF1vE7UZW0nOniioRXTUrdz6nxKHKutDDTBf+zTLa2W9dmua6+e+/51ox3FSxm
         s7xPVzO4MfKgrHk/NU71mep5umkSe5Pn0lCQGR7JmLhGX/xsLtz5AEaNsRj0ajzZ5l2e
         CmnQdj/OYYVk9bCSj2tV6l4887vQ1ie0FpopiA1AoE7PFqkFOe5Ud2afreqWr0FtVIEH
         5xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jYX1/zRvpj163zxVB3ynIN4D1+jW63NaWTi3oSh36NI=;
        b=fXsovXlOiEi24L6lSW0hnPRopQB15raAE8dvyld8Hv8FukJScex+LUwPxDWgbGCElB
         e8zheAW1cd+k8PbwALQWPVPOW9KvXoDjVtIMgpAq2ULI9Pk1bbK+Kwub2YxxbSPXCjQh
         PREmzxRL1qngL6ne4ULNeUoXbZuzzsokdwzah2zL4OZi0Quckup/4vU0hMDpLTL6KyBf
         dUddqkFmh7GxDJxrkAK9L9fQADOqkTs612qvM/creliyFy6RrrBw/E/0KLdx8qLqApJG
         EsAJdW6ffVgScKO5yljDLyOIHv5pcjp7aAyk4UD+SKHGgehm7WxVRIqPp1kspx+EtahA
         TBMA==
X-Gm-Message-State: ALoCoQkaQXV/Z+t5WiG0Peh/8MUSp6O5sJS5EpAqnBZwVCc94Ooee++5nVcLh50yHl/Aua6FVY5/BBZiRKiNl7AjY1Y8L8c7hw==
X-Received: by 10.140.225.9 with SMTP id v9mr104293267qhb.89.1452561761121;
        Mon, 11 Jan 2016 17:22:41 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:40 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283754>

Instead of using a files-backend-specific struct ref_lock, the generic
ref_transaction struct should provide a void pointer that backends can use
for their own lock data.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 29 ++++++++++++++++-------------
 refs/refs-internal.h |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fd4b530..1e5acef 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3184,11 +3184,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
+		struct ref_lock *lock;
 
 		if ((update->flags & REF_HAVE_NEW) &&
 		    is_null_sha1(update->new_sha1))
 			update->flags |= REF_DELETING;
-		update->lock = lock_ref_sha1_basic(
+		lock = lock_ref_sha1_basic(
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
@@ -3196,7 +3197,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->flags,
 				&update->type,
 				err);
-		if (!update->lock) {
+		update->backend_data = lock;
+		if (!lock) {
 			char *reason;
 
 			ret = (errno == ENOTDIR)
@@ -3214,12 +3216,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 						  (update->flags & REF_NODEREF));
 
 			if (!overwriting_symref &&
-			    !hashcmp(update->lock->old_oid.hash, update->new_sha1)) {
+			    !hashcmp(lock->old_oid.hash, update->new_sha1)) {
 				/*
 				 * The reference already has the desired
 				 * value, so we don't need to write it.
 				 */
-			} else if (write_ref_to_lockfile(update->lock,
+			} else if (write_ref_to_lockfile(lock,
 							 update->new_sha1,
 							 err)) {
 				char *write_err = strbuf_detach(err, NULL);
@@ -3228,7 +3230,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				 * The lock was freed upon failure of
 				 * write_ref_to_lockfile():
 				 */
-				update->lock = NULL;
+				update->backend_data = NULL;
 				strbuf_addf(err,
 					    "cannot update the ref '%s': %s",
 					    update->refname, write_err);
@@ -3244,7 +3246,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			 * We didn't have to write anything to the lockfile.
 			 * Close it to free up the file descriptor:
 			 */
-			if (close_ref(update->lock)) {
+			if (close_ref(lock)) {
 				strbuf_addf(err, "Couldn't close %s.lock",
 					    update->refname);
 				goto cleanup;
@@ -3257,16 +3259,16 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->flags & REF_NEEDS_COMMIT) {
-			if (commit_ref_update(update->lock,
+			if (commit_ref_update(update->backend_data,
 					      update->new_sha1, update->msg,
 					      update->flags, err)) {
 				/* freed by commit_ref_update(): */
-				update->lock = NULL;
+				update->backend_data = NULL;
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			} else {
 				/* freed by commit_ref_update(): */
-				update->lock = NULL;
+				update->backend_data = NULL;
 			}
 		}
 	}
@@ -3274,16 +3276,17 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 	/* Perform deletes now that updates are safely completed */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
+		struct ref_lock *lock = update->backend_data;
 
 		if (update->flags & REF_DELETING) {
-			if (delete_ref_loose(update->lock, update->type, err)) {
+			if (delete_ref_loose(lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
 				string_list_append(&refs_to_delete,
-						   update->lock->ref_name);
+						   lock->ref_name);
 		}
 	}
 
@@ -3299,8 +3302,8 @@ cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
 
 	for (i = 0; i < n; i++)
-		if (updates[i]->lock)
-			unlock_ref(updates[i]->lock);
+		if (updates[i]->backend_data)
+			unlock_ref(updates[i]->backend_data);
 	string_list_clear(&refs_to_delete, 0);
 	string_list_clear(&affected_refnames, 0);
 	return ret;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 64c3092..f8ae47b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -161,7 +161,7 @@ struct ref_update {
 	 * REF_DELETING, and REF_ISPRUNING:
 	 */
 	unsigned int flags;
-	struct ref_lock *lock;
+	void *backend_data;
 	int type;
 	char *msg;
 	const char refname[FLEX_ARRAY];
-- 
2.4.2.749.g730654d-twtrsrc
