From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 10/21] refs: make lock generic
Date: Fri,  5 Feb 2016 14:44:11 -0500
Message-ID: <1454701462-3817-11-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:46:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmKQ-0002FF-Fd
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbcBETps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:45:48 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35807 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbcBEToz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:55 -0500
Received: by mail-qg0-f45.google.com with SMTP id y89so2346980qge.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WcLyrN9wA8xTfsfYlbk5PcSBPlgLZFVWufoNeLEOAOs=;
        b=GrUK76fdjPr8sX1Jh3p6gSWiXaL7DJ6RY7AwN6whq2mYL81k5qOVJbQOKg9aauM2o5
         Fsw072gm2vS5rtwDqkSoc+TxSR9yRwmAuwuRx0aijAMdeOYfJCUrHDhjGlD8jeaVypgI
         CwWAgpBge0c+mbEbbJEHkiS4yCYaPsUZ3woCGYbBVjmQtkh9S1U+0ONJ1tygkVpq7fUe
         OkS6sRwjV9TlvjYNDWRC25h6ZEMeKOJ+CJIQwtXIsLJzTseCzoSBScJ/VzfHACDiBTGM
         kVF8jfJMwNhwOo9QAbQqkPTJEZ2HCmPE8QDOpsMLKTzW3Fz03zHQdIqKE9xi3mVl4c5q
         5Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WcLyrN9wA8xTfsfYlbk5PcSBPlgLZFVWufoNeLEOAOs=;
        b=M8uyhmz4oyTk1I2h2DzGqa9bdY1wnUpgsYfBSrmh/nKsWRnPiGL/tsl2YlLBkL/HU7
         moct4TDto+Ws3i70eRDu7B5Cu5sCM5sR4HFJ4pM9HzCJ7WpBMMOyfI2F7c8aj+VPpefM
         5OyLhPfGYNoiJlTF6MRjDJ8HYvb0uiKev69EkCikx1PN3eYgwcEtcOAZTV6lV4o1rki4
         eyhTgt2z4qE0KVMbMI78aC86csXUPuymEwCdXoQkyCDf93zWdyzP0DcII7bNGFc1hBFI
         0CocPas/F9bF05Z+3Ny+NsHGNlKSB47oXh9EXq6xibsQT4tewvsWL9veib0EYUZO11VX
         lSfQ==
X-Gm-Message-State: AG10YOQaSuDJ0KeflmZcnxoO40ovSTHaGK+/ZPnVtf5ShNAhISBQxO42tOMdsF5IOfDXtA==
X-Received: by 10.140.98.100 with SMTP id n91mr18885863qge.56.1454701494328;
        Fri, 05 Feb 2016 11:44:54 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:53 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285619>

Instead of using a files-backend-specific struct ref_lock, the generic
ref_transaction struct should provide a void pointer that backends can use
for their own lock data.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 29 ++++++++++++++++-------------
 refs/refs-internal.h |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 685fc6f..aa11ba2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3208,11 +3208,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3220,7 +3221,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->flags,
 				&update->type,
 				err);
-		if (!update->lock) {
+		update->backend_data = lock;
+		if (!lock) {
 			char *reason;
 
 			ret = (errno == ENOTDIR)
@@ -3238,12 +3240,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3252,7 +3254,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				 * The lock was freed upon failure of
 				 * write_ref_to_lockfile():
 				 */
-				update->lock = NULL;
+				update->backend_data = NULL;
 				strbuf_addf(err,
 					    "cannot update the ref '%s': %s",
 					    update->refname, write_err);
@@ -3268,7 +3270,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			 * We didn't have to write anything to the lockfile.
 			 * Close it to free up the file descriptor:
 			 */
-			if (close_ref(update->lock)) {
+			if (close_ref(lock)) {
 				strbuf_addf(err, "Couldn't close %s.lock",
 					    update->refname);
 				goto cleanup;
@@ -3281,16 +3283,16 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3298,16 +3300,17 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3323,8 +3326,8 @@ cleanup:
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
index 15fa99c..3dec075 100644
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
