From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 16/32] refs: make lock generic
Date: Wed, 24 Feb 2016 17:58:48 -0500
Message-ID: <1456354744-8022-17-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPN-0003fn-PV
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759192AbcBXW7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:41 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33164 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758101AbcBXW7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:37 -0500
Received: by mail-qg0-f48.google.com with SMTP id b35so27011809qge.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4OY+lGwwcXJe9Gg/+y2T0ReOzxu68KDsU8WGCOfBgcw=;
        b=oz+gMwkYYTCsdYMmmvGZW9eUr3Wf9gCttwGUuTGYKi5gCM52bvv1FG5Rcii2vfmwfx
         W3V430JdIyzTYMYx3IdhSvRsskaB09aFSf5i1tAJCFSY6nw001u3vPRPrUIVj0OM+vmz
         tCzC44Q1HmFxdezg871UeF+Mc+u7KEpPriKyJwDAYVbvesSUmyfHk1Er8M2RmG5Lh2Jm
         Nwg8Oe4IZDb7AzNfX3BkcygO0+wy67fQRu8HaX1qb9QGzftdetFqv0lp2TUcukLoqDkM
         4lTvcIT7QA+tHyJtO70mbpOfvH1e5OZ/uw0hu0jnmp+7ZRL7uqT2e03sICHAjyzgnJg4
         /9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4OY+lGwwcXJe9Gg/+y2T0ReOzxu68KDsU8WGCOfBgcw=;
        b=aya5IOJPoI59HqZxjmHZh5MPSSXpSAYivnBr9L5hs8Uv4U85iVebNfqHj4qQc8evad
         fDqwB7aFjLRaGVkrxIBOVtLi4eDad8KgFDgBH11DTYDaC0tmM4mymSVkrKvnw5IDdVb1
         U72Zv0921HH5XJbCJMp6f+k9/KzHeMIe3Nak41nrHocQNrQxvBClIvJyfydTH6LvWOeo
         wl5iotUIEVDpEoiBF5X1MLEKRYhaUkEa9MTryBewAaQs4hW40qVrb1FrIO0z8kiAtdp7
         V+d5/uIGf3PpMQX/SO54ImXUwg3ToRU9ovozsNDsE7NSaeVglzXK0XZ/qa7pQ9ST4LmE
         Y/Iw==
X-Gm-Message-State: AG10YOQ+BitZS1YXbXz4jusQfmHXyGHFT2HExlWqfmcKDR5jJiwpkMMoclB9VGMlTimlhA==
X-Received: by 10.140.85.19 with SMTP id m19mr51907535qgd.106.1456354771310;
        Wed, 24 Feb 2016 14:59:31 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:30 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287253>

Instead of using a files-backend-specific struct ref_lock, the generic
ref_transaction struct should provide a void pointer that backends can use
for their own lock data.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 29 ++++++++++++++++-------------
 refs/refs-internal.h |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4e4b852..9be3158 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3074,11 +3074,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3086,7 +3087,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->flags,
 				&update->type,
 				err);
-		if (!update->lock) {
+		update->backend_data = lock;
+		if (!lock) {
 			char *reason;
 
 			ret = (errno == ENOTDIR)
@@ -3104,12 +3106,12 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3118,7 +3120,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				 * The lock was freed upon failure of
 				 * write_ref_to_lockfile():
 				 */
-				update->lock = NULL;
+				update->backend_data = NULL;
 				strbuf_addf(err,
 					    "cannot update the ref '%s': %s",
 					    update->refname, write_err);
@@ -3134,7 +3136,7 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			 * We didn't have to write anything to the lockfile.
 			 * Close it to free up the file descriptor:
 			 */
-			if (close_ref(update->lock)) {
+			if (close_ref(lock)) {
 				strbuf_addf(err, "Couldn't close %s.lock",
 					    update->refname);
 				goto cleanup;
@@ -3147,16 +3149,16 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3164,16 +3166,17 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3189,8 +3192,8 @@ cleanup:
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
