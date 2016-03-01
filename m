From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 17/33] refs: make lock generic
Date: Mon, 29 Feb 2016 19:52:50 -0500
Message-ID: <1456793586-22082-18-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZT-00073r-PY
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbcCAAxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:48 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34883 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbcCAAxq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:46 -0500
Received: by mail-qk0-f171.google.com with SMTP id o6so63937710qkc.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sDp5yYryHaRqlv3RNlRzIXY/WuOIqMGbs85BvZjqVwE=;
        b=VCk1sEc4xWqeSb/qpGukuP+MNLTYdbfR3ngRTx8j3OjCv41T362i77455VvdPG3CVA
         WpG39PuufEJlWeRRM0Z0MQGeWtPykV41kCWJcIdB16O7uH9latYh8S989HdnZiZqcp30
         pvI/JRYNXSELnvDxV/3KeGuxzjmS3vF/4I9THyqYrTuCvOsxcZLD0cga82c8EQYIPLNR
         Zmd6SDcFL9y79NYkwp0JFZwY5qx9B8x6Ywg3UAxevCBOHYn4e0yRaoGfw3F/DShUvFr5
         f66hBtENypNoXF/0BE5Tmq50Do226xh1wNHUwhiETa+t+ITu/Xys6+GNtIYhRWZjEhCU
         99mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sDp5yYryHaRqlv3RNlRzIXY/WuOIqMGbs85BvZjqVwE=;
        b=FB1O2mC5dQqZJ6lUtQxk0f50Tt9tKrwT72ZjsXtu/4RbpbBZ46yG4oVYt8IVtx0zdL
         4w6wLX0mbmF53UN2MiQqBosOFYBYOB7G9XsU5RrGTzdRJY7VwSFCGs2WHD5ntCklEinG
         6ONBdF6zP/qEZrtX6J19IoDWvjIsxRkj7x5OOgUQVTJcyiCeVIa3nWvzw2qhXjAzwxRW
         5p542Glvie/XDiKP63wrWpsViFDgXsdEZFov+7IzjBTizJuvzdyi6qY6TIgPa4kjHmtc
         H3X/HxGzRbQthhbN2oQlCwda1gcs9fRKn9cGHHY4QSwnKP1J2kL5w8yC3qAKHoc68Aqj
         SMvg==
X-Gm-Message-State: AD7BkJI5YweG/CpIWV/1M5dq5L8nC/kkid4+St/n0AEEk29iNyllcUaF6Acw50n+bVlgrA==
X-Received: by 10.55.75.144 with SMTP id y138mr23494856qka.96.1456793625663;
        Mon, 29 Feb 2016 16:53:45 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:44 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287952>

Instead of using a files-backend-specific struct ref_lock, the generic
ref_transaction struct should provide a void pointer that backends can use
for their own lock data.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 29 ++++++++++++++++-------------
 refs/refs-internal.h |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 534bbaf..01c85c0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3065,11 +3065,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3077,7 +3078,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->flags,
 				&update->type,
 				err);
-		if (!update->lock) {
+		update->backend_data = lock;
+		if (!lock) {
 			char *reason;
 
 			ret = (errno == ENOTDIR)
@@ -3095,12 +3097,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3109,7 +3111,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				 * The lock was freed upon failure of
 				 * write_ref_to_lockfile():
 				 */
-				update->lock = NULL;
+				update->backend_data = NULL;
 				strbuf_addf(err,
 					    "cannot update the ref '%s': %s",
 					    update->refname, write_err);
@@ -3125,7 +3127,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			 * We didn't have to write anything to the lockfile.
 			 * Close it to free up the file descriptor:
 			 */
-			if (close_ref(update->lock)) {
+			if (close_ref(lock)) {
 				strbuf_addf(err, "Couldn't close %s.lock",
 					    update->refname);
 				goto cleanup;
@@ -3138,16 +3140,16 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3155,16 +3157,17 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3180,8 +3183,8 @@ cleanup:
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
index d6fe199..8d091cb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -144,7 +144,7 @@ struct ref_update {
 	 * REF_DELETING, and REF_ISPRUNING:
 	 */
 	unsigned int flags;
-	struct ref_lock *lock;
+	void *backend_data;
 	int type;
 	char *msg;
 	const char refname[FLEX_ARRAY];
-- 
2.4.2.767.g62658d5-twtrsrc
