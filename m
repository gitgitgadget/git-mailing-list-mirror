From: David Turner <dturner@twopensource.com>
Subject: [PATCH 10/16] refs: make lock generic
Date: Wed,  2 Dec 2015 19:35:15 -0500
Message-ID: <1449102921-7707-11-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4HtD-0007rt-BE
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962AbbLCAgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:19 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:33116 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757480AbbLCAfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:51 -0500
Received: by iouu10 with SMTP id u10so66089283iou.0
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E1vJ6wE84zMtV+zWBGWbNdRs0RsYw7iXpxNpjBGlejk=;
        b=1qI1NRtUn1kIx6qklq7bs1RJLzs4CakZShoGz353e8B//K+3utgK2RIxyO48KOsNTm
         3MBasm/PNwmoaVTMLv68EAOMZxleUgb9XHS+vYB0LNSplog6mWscjJYZUvwyg37g5BKr
         EUnUXwmAe8EdFZi/u/gQ3BhaSZmy9bYu7VMsVWD/UPJbVYOr1C6mCPmZYyHKdV/TSMxO
         S0jPXPa/ggoHM3nxlbgFQNrNhWpmI7Gy9z/JVeIL3zoUS0qvF2TBjXYJDBLf5k2jxhMP
         NlMrOze6lwIYQwXm1geVYV6t3utwmBXQjlbYQAUgEs+HiBNvFr6AlQbS8wsLmMOMPMJ1
         wGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E1vJ6wE84zMtV+zWBGWbNdRs0RsYw7iXpxNpjBGlejk=;
        b=OyRWnHvnZ81Gth0yj8oOk3cvMremVnszaw6wJ8oQldVQkzHcec1SM65Or1TdPVfRmV
         QGwLaiCu+4CUpBlp0VahjWNSJ7XYDhH+rSvQCRuTkgv7iEraKvwDk9pIBctxwgtTAGj+
         o2usFUdsWrlC08F+WxH5gmlyXf7HWv47WHMpjXiDVuIsK+6YPwMGFTWaCqB+3blty+wT
         eb/825KGTc/DNy4LCIb9sB9TZLkJQ4BSI51RUAd0xcWWZez+0pKxY19USHEGgvQNlLNE
         v2SjxG2GyQLqC0e9jEaR5D/8Fh3t8tl5FKUD0A3fccOMG37csufT7kcAf3ZrxR0GmpMm
         oyGQ==
X-Gm-Message-State: ALoCoQndswA8+SUv1vZSdoXRo/FJQ7zFRoDA6SijrCNOETkFOLhAFnfS83JA1ZvqBa+Vri5kRFku
X-Received: by 10.107.19.12 with SMTP id b12mr7236937ioj.11.1449102950865;
        Wed, 02 Dec 2015 16:35:50 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:50 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281937>

Instead of using a files-backend-specific struct ref_lock, the generic
ref_transaction struct should provide a void pointer that backends can use
for their own lock data.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 29 ++++++++++++++++-------------
 refs/refs-internal.h |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0af0818..22a6f24 100644
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
index 36a024f..8322011 100644
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
2.4.2.749.g0ed01d8-twtrsrc
