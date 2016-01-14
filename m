From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 10/20] refs: make lock generic
Date: Thu, 14 Jan 2016 11:26:07 -0500
Message-ID: <1452788777-24954-11-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkkP-0002tj-1i
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbcANQ10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:27:26 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34423 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648AbcANQ0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:43 -0500
Received: by mail-qk0-f180.google.com with SMTP id x1so27645069qkc.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mcXxToWX6KQDQXiUzOTieMzVuDqjCsUIhyfKjfO4tYQ=;
        b=SOtwpHvo4GtYq4AZ9ikvUZNdx2dH3M5jCaAa4XeEwHa4p+TOZFRZV8HwGrO4Yj0bO3
         dM2xaMG8iB6h03s9Mau9mWay7AuhrLzESQJdPciyQwE3iRPAqnCJwX4vt4aMQj26W12q
         IhMLD7OGyywA46mvFOD6vgIJ7dSXNTl18BvoTkG6dR1olnaR3+1lAta9FRC5wzHCxcTy
         USx10vYFFl+4GWSB6MrXiG9gbmRxbzc+vZjHe8em21VHlYZm9NSAaNAYIlw9zN1oio+8
         RdV1dibRhR+5ECQgcQ1KbCCylXScCfEhNI2wNcHB8uZOvr7vPTMW7WdY1rI+ZLO7KHJ0
         46Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mcXxToWX6KQDQXiUzOTieMzVuDqjCsUIhyfKjfO4tYQ=;
        b=aiG2Bzu+wM6eXIqtNkBu45B/LZMXfi8anJyINvDFk9VOxpJdxPTCIeYYk70aeCL2h/
         KsT1t/yec2m6tFksOLL9WXygMaroVKdYpbYv7EJdU4vZJbIBNr8Qr0QKrze0IY5V37uP
         AQNT12WtEVGrWj/Q+ZLLbDTcLH9vSN6tIWa/1Uq2WerzWzQU2ffNqHi42ulpJvmYojvp
         Xcsf3C4FxHiEKRoGwyvoefQrbz9pRWMysWzME8+8DcLkfETluSvCZIofnGnpXVHFcIXO
         rnn/a5kovVZYdhzaWaSbz/M+i6RSRwIaXTdaAUb8K2C+GXmySj737bz5uWhV6vFl2pBQ
         kndw==
X-Gm-Message-State: ALoCoQm2sgeRCFQ9qQhZNFyKEJmdMQ5KNkyW51TuxdZkGk7Q+h7tOI4T5FPVopMao7kCEFucfmwwrmsevkwXBYpm9YY72EOaQg==
X-Received: by 10.55.78.70 with SMTP id c67mr6614586qkb.37.1452788802550;
        Thu, 14 Jan 2016 08:26:42 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:41 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284053>

Instead of using a files-backend-specific struct ref_lock, the generic
ref_transaction struct should provide a void pointer that backends can use
for their own lock data.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 29 ++++++++++++++++-------------
 refs/refs-internal.h |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f14b6f9..9ae06a6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3190,11 +3190,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3202,7 +3203,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->flags,
 				&update->type,
 				err);
-		if (!update->lock) {
+		update->backend_data = lock;
+		if (!lock) {
 			char *reason;
 
 			ret = (errno == ENOTDIR)
@@ -3220,12 +3222,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3234,7 +3236,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				 * The lock was freed upon failure of
 				 * write_ref_to_lockfile():
 				 */
-				update->lock = NULL;
+				update->backend_data = NULL;
 				strbuf_addf(err,
 					    "cannot update the ref '%s': %s",
 					    update->refname, write_err);
@@ -3250,7 +3252,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			 * We didn't have to write anything to the lockfile.
 			 * Close it to free up the file descriptor:
 			 */
-			if (close_ref(update->lock)) {
+			if (close_ref(lock)) {
 				strbuf_addf(err, "Couldn't close %s.lock",
 					    update->refname);
 				goto cleanup;
@@ -3263,16 +3265,16 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3280,16 +3282,17 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3305,8 +3308,8 @@ cleanup:
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
index 36a5bf8..7390247 100644
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
