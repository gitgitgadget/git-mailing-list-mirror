From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 13/27] refs: make lock generic
Date: Thu, 18 Feb 2016 00:17:36 -0500
Message-ID: <1455772670-21142-14-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzL-0001Hk-9E
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424905AbcBRFSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:47 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32891 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424882AbcBRFSp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:45 -0500
Received: by mail-qk0-f180.google.com with SMTP id s5so14809922qkd.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4sBdEx5FxZhCg94VPYLz1TLrsKukFQpBkdo87y2VUbM=;
        b=nBUJO3DfHdcNSQZbUrSNk6ygEQxEwu4hkDijoOTf+kdvRiAGXeo56GMKBSel5O2s/F
         /+dw4EgrGN+NHOeHhfhLp235BZbZ3Qcbmg9zFV5MfYBqzX2QIO4VmVjwX2rzjLjcWg4X
         iIyFoJXGe+tJsKxHpypYgqBNfN5PrR/JthxnHj4kkNBjL4AmkfsbsY1Um79TZVu96OiS
         Ku3mne+Ze6qVr3TECM984ulH0h4SctUZ4cnuD3WmzCbydRawnRg87XPDHiMtcewN1/3W
         BsDzMVlSni9xOPHg2liXfqUYsmnYahQgpfALUp79Cwv29V6d5/03twRy5JX0kum6GLk/
         N72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4sBdEx5FxZhCg94VPYLz1TLrsKukFQpBkdo87y2VUbM=;
        b=LHQrJTryWkr8EiCv5PQAlviSZDDmsqcaXdZHXU7bGhGLeFSP8wwoGkbt64K1lJPQG5
         ma0cEDIgAjyoJH9VNMYPeo/Drrl02e2pmxKhLhun1rdBReG+ub7jTLM6sILSpMryeXMj
         +OXm+fG6642qVGfdJdxJQtKBIKyjTYi54+K7uZajzhCjQyibwImW9ceTV7CtIUpOcxN7
         AiKUsTyq8kZoGRxPQCewEjeyPOYim/b5LZV3bQ8Je8L9Uf+UbyvuPREm+hQFe38EQOl2
         w5kmVbQyMNz8Aj8kxNHFzbMeBkRsbuZuNQAxC4uBf/sHNCqeBpJaZlHoT0hDlPT5Ll9U
         QlNQ==
X-Gm-Message-State: AG10YOS1FPdh1o+HRz5m30VvY0OSYIkyxbsOb2jpxg8dtoS7/bojzjUokmIaDBAR7WMZHw==
X-Received: by 10.55.27.149 with SMTP id m21mr6681099qkh.51.1455772724603;
        Wed, 17 Feb 2016 21:18:44 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:43 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286577>

Instead of using a files-backend-specific struct ref_lock, the generic
ref_transaction struct should provide a void pointer that backends can use
for their own lock data.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 29 ++++++++++++++++-------------
 refs/refs-internal.h |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d38acd6..9011b7c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3130,11 +3130,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3142,7 +3143,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->flags,
 				&update->type,
 				err);
-		if (!update->lock) {
+		update->backend_data = lock;
+		if (!lock) {
 			char *reason;
 
 			ret = (errno == ENOTDIR)
@@ -3160,12 +3162,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3174,7 +3176,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				 * The lock was freed upon failure of
 				 * write_ref_to_lockfile():
 				 */
-				update->lock = NULL;
+				update->backend_data = NULL;
 				strbuf_addf(err,
 					    "cannot update the ref '%s': %s",
 					    update->refname, write_err);
@@ -3190,7 +3192,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			 * We didn't have to write anything to the lockfile.
 			 * Close it to free up the file descriptor:
 			 */
-			if (close_ref(update->lock)) {
+			if (close_ref(lock)) {
 				strbuf_addf(err, "Couldn't close %s.lock",
 					    update->refname);
 				goto cleanup;
@@ -3203,16 +3205,16 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3220,16 +3222,17 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3245,8 +3248,8 @@ cleanup:
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
index 10a4e4d..546183d 100644
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
