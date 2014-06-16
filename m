From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 10/14] refs.c: allow multiple reflog updates during a single transaction
Date: Mon, 16 Jun 2014 09:51:41 -0700
Message-ID: <1402937505-6091-11-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa8a-0002QJ-GS
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbaFPQv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:51:57 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:48300 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242AbaFPQvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:52 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so851794veb.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AresMXgtc6xlmVIbd6EPcAMr6ax/rIMTBpVIp+EkGMw=;
        b=fcw4D26g/FvxGzKv3LLjb2tBNGBlxHF1HrI+KBdPsLzMND3nkrdD1W6tpU2Nkwnfui
         T+Ue/NZemnTlGe2rLz46eYziIEbw9rd+1JkXLn0qTM0idzhMHFhYDZD5CPdFY721+Rsq
         1yEtxZX5ay5LmDKAXUj5R/VsLkC7choR1QIVPLDJxWTLxhYMKf1Dm0SftfLpr5xnHr9L
         DKGDoYVwiJhVybGueRFlPlmvYsFD/zvDfpXVsM84Ng0ev2iWjchobKLYr9ff7QStybFb
         FWvw//L3zEBPnaDeja6F0yvvkeB8SX1U13qCqzO33+a5FdA1zqB6tUyiZPq4m8+cfqxD
         unWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AresMXgtc6xlmVIbd6EPcAMr6ax/rIMTBpVIp+EkGMw=;
        b=aYBT7uSz+ZW7CXxNLYMer/65E1aQlg5O79Pi32nWolsc/DcRAMNbi2JTsJTnbab6as
         wCoNX/eo6f/uyKfGPkfcxLw9km3m77OUGBOSW47MSFWnH4qghsCNA0/fAbsg24Y8sqNB
         JPTuOGA4cMextN/oxfwrpuGOve88t1IJNy1/MU63EQj4xSssd2SweGCeKJ8qgKgC8wpC
         TyOSEhrYHE1cYO5GxUpqXNE9hIQSIAAXS2Q1OXLl6gRPSHwXkqtgRVx/NS72kkmOZNtQ
         CFuq1v/y7Qf+ooQ7LMnl4xob3C4oNd8B9F2UWWGc72VXZeXtIhp7lpafXcFx53pIgP9G
         Ukyg==
X-Gm-Message-State: ALoCoQnI/L8tC6QubJftdDaXykYqYAQEP7+Sw2IhYM5TvSW8K66y8iP+aVwshGYRyuAhIgYe0B3f
X-Received: by 10.224.64.198 with SMTP id f6mr3776324qai.3.1402937509979;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si982153yhl.7.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C043331C64B;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 58A82E14EA; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251720>

Allow to make multiple reflog updates to the same ref during a transaction.
This means we only need to lock the reflog once, during the first update
that touches the reflog, and that all further updates can just write the
reflog entry since the reflog is already locked.

This allows us to write code such as:

t = transaction_begin()
transaction_reflog_update(t, "foo", REFLOG_TRUNCATE, NULL);
loop-over-somehting...
   transaction_reflog_update(t, "foo", 0, <message>);
transaction_commit(t)

where we first truncate the reflog and then build the new content one line at a
time.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 2163c90..3b90457 100644
--- a/refs.c
+++ b/refs.c
@@ -2407,6 +2407,11 @@ static void try_remove_empty_parents(char *name)
  * pruned.
  */
 #define REF_ISPRUNING	0x0100
+/*
+ * Only the first reflog update needs to lock the reflog file. Further updates
+ * just use the lock taken by the first update.
+ */
+#define UPDATE_REFLOG_NOLOCK 0x0200
 
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
@@ -3413,7 +3418,7 @@ enum transaction_update_type {
        UPDATE_LOG = 1,
 };
 
-/**
+/*
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
  * while locking the ref, set have_old to 1 and set old_sha1 to the
@@ -3423,7 +3428,7 @@ struct ref_update {
 	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
+	int flags; /* REF_NODEREF? or private flags */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
@@ -3431,8 +3436,9 @@ struct ref_update {
 
 	/* used by reflog updates */
 	int reflog_fd;
-	struct lock_file reflog_lock;
+	struct lock_file *reflog_lock;
 	char *committer;
+	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
 
 	const char refname[FLEX_ARRAY];
 };
@@ -3514,12 +3520,27 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      struct strbuf *err)
 {
 	struct ref_update *update;
+	int i;
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update_reflog called for transaction that is not "
 		    "open");
 
 	update = add_update(transaction, refname, UPDATE_LOG);
+	update->flags = flags;
+	for (i = 0; i < transaction->nr - 1; i++) {
+		if (transaction->updates[i]->update_type != UPDATE_LOG)
+			continue;
+		if (!strcmp(transaction->updates[i]->refname,
+			    update->refname)) {
+			update->flags |= UPDATE_REFLOG_NOLOCK;
+			update->orig_update = transaction->updates[i];
+			break;
+		}
+	}
+	if (!(update->flags & UPDATE_REFLOG_NOLOCK))
+		update->reflog_lock = xcalloc(1, sizeof(struct lock_file));
+
 	hashcpy(update->new_sha1, new_sha1);
 	hashcpy(update->old_sha1, old_sha1);
 	update->reflog_fd = -1;
@@ -3535,7 +3556,6 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 	}
 	if (msg)
 		update->msg = xstrdup(msg);
-	update->flags = flags;
 
 	return 0;
 }
@@ -3712,10 +3732,15 @@ int transaction_commit(struct ref_transaction *transaction,
 
 		if (update->update_type != UPDATE_LOG)
 			continue;
+		if (update->flags & UPDATE_REFLOG_NOLOCK) {
+			update->reflog_fd = update->orig_update->reflog_fd;
+			update->reflog_lock = update->orig_update->reflog_lock;
+			continue;
+		}
 		update->reflog_fd = hold_lock_file_for_append(
-					&update->reflog_lock,
+					update->reflog_lock,
 					git_path("logs/%s", update->refname),
-					0);
+					LOCK_NODEREF);
 		if (update->reflog_fd < 0) {
 			const char *str = "Cannot lock reflog for '%s'. %s";
 
@@ -3781,7 +3806,7 @@ int transaction_commit(struct ref_transaction *transaction,
 				ftruncate(update->reflog_fd, 0)) {
 				error("Could not truncate reflog: %s. %s",
 				      update->refname, strerror(errno));
-				rollback_lock_file(&update->reflog_lock);
+				rollback_lock_file(update->reflog_lock);
 				update->reflog_fd = -1;
 				continue;
 			}
@@ -3791,7 +3816,7 @@ int transaction_commit(struct ref_transaction *transaction,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
-			rollback_lock_file(&update->reflog_lock);
+			rollback_lock_file(update->reflog_lock);
 			update->reflog_fd = -1;
 		}
 	}
@@ -3802,9 +3827,11 @@ int transaction_commit(struct ref_transaction *transaction,
 
 		if (update->update_type != UPDATE_LOG)
 			continue;
+		if (update->flags & UPDATE_REFLOG_NOLOCK)
+			continue;
 		if (update->reflog_fd == -1)
 			continue;
-		if (commit_lock_file(&update->reflog_lock)) {
+		if (commit_lock_file(update->reflog_lock)) {
 			error("Could not commit reflog: %s. %s",
 			      update->refname, strerror(errno));
 			update->reflog_fd = -1;
-- 
2.0.0.770.gd892650.dirty
