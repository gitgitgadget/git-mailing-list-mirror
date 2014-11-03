From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 10/15] refs.c: allow multiple reflog updates during a single transaction
Date: Mon,  3 Nov 2014 08:55:52 -0800
Message-ID: <1415033757-9539-11-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 17:58:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlKxs-0002zG-6u
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 17:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbaKCQ6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 11:58:35 -0500
Received: from mail-ob0-f201.google.com ([209.85.214.201]:61053 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbaKCQ4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 11:56:05 -0500
Received: by mail-ob0-f201.google.com with SMTP id nt9so1678844obb.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mUvQU2JsBf0KRp3KEc4bymqnWEONryBqyN64BGj9ftE=;
        b=TSw2R2uq0GeQV1SnYhMf6j0GGj2nnGWmZFdpRw+Q/Q8DEhbvbf3wOPcTRbVZO27q0Q
         bqqO8dox39WunEE6TXzu81csQj17oh8E1XHuQOor44ceaHIBdhrWGAVIDXsG8zdijGE2
         qd44+M6Zwlrylr5WBnGJFuzW2hcVgKwYGb3p7Ybu1GQqy1HJN2iuDCn2A91najsSFCYF
         c2vzXOGMU24V25b2E5nwkKnC/LQDg8tlL8ZaFpjyCkVjAl8HadCOYJ2bbeBc9HYdJ4xI
         yg5O2oHo+W0xP1zlrqBncP0tFf+yeJG8q0IfXSgLgYOeTjJcfr+WJk9xQMxNkKDwGsj9
         sBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mUvQU2JsBf0KRp3KEc4bymqnWEONryBqyN64BGj9ftE=;
        b=KudSf/gCYTBuh0ghLCNrr+8TjH6YDTBvVm1eRhHPGg0etDi5cFzbxHtPbK21JpFxix
         0eViEwP6LXjtHS6DYxeFkVGmb4evLgPzJrO3wWZa9/UeOos17TUCyUZgnGSM1yx/3azQ
         EUq77x/ZZhX5M3Jvs0hxjplp0qfcNs/JzypkNt9r09XaBh/gABB0DBdz7ZNKM3NeNtvs
         gfGLLOlLzQAhEU3VLJfZPVkZdcArr19YKfNv+W2FtWMtfOJi/LPUvoD59MlVURKAqy7C
         JczmkADOL6jcF8Om6aIs30v8DTD4hnY/YbjfZAL/c4byqjdhwQ4Q3Ej0+pBfYGldYUtS
         Lh1w==
X-Gm-Message-State: ALoCoQnbZggVwNFVCONHUIILSVWbyy9TxWwPnJhlARs4KwJ3tOME/N6rqITNiazKYis2+uikB57h
X-Received: by 10.50.111.135 with SMTP id ii7mr13437665igb.4.1415033764244;
        Mon, 03 Nov 2014 08:56:04 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id k66si956288yho.7.2014.11.03.08.56.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:04 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 6ANX4hdH.2; Mon, 03 Nov 2014 08:56:04 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5FEF1E0FD8; Mon,  3 Nov 2014 08:56:02 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow to make multiple reflog updates to the same ref during a transaction.
This means we only need to lock the reflog once, during the first update
that touches the reflog, and that all further updates can just write the
reflog entry since the reflog is already locked.

This allows us to write code such as:

t = transaction_begin()
transaction_reflog_update(t, "foo", REFLOG_TRUNCATE, NULL);
loop-over-something...
   transaction_reflog_update(t, "foo", 0, <message>);
transaction_commit(t)

where we first truncate the reflog and then build the new content one line
at a time.

While this technically looks like O(n2) behavior it not that bad.
We only do this loop for transactions that cover a single ref during
reflog expire. This means that the linear search inside
transaction_update_reflog() will find the match on the very first entry
thus making it O(1) and not O(n) or our usecases. Thus the whole expire
becomes O(n) instead of O(n2). If in the future we start doing this for many
refs in one single transaction we might want to optimize this.
But there is no need to complexify the code and optimize for future usecases
that might never materialize at this stage.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index f14b76e..1c3e674 100644
--- a/refs.c
+++ b/refs.c
@@ -31,6 +31,12 @@ static unsigned char refname_disposition[256] = {
  */
 #define REF_ISPRUNING	0x0100
 /*
+ * Only the first reflog update needs to lock the reflog file. Further updates
+ * just use the lock taken by the first update.
+ */
+#define UPDATE_REFLOG_NOLOCK 0x0200
+
+/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -3521,7 +3527,7 @@ enum transaction_update_type {
 	UPDATE_LOG = 1
 };
 
-/**
+/*
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
  * while locking the ref, set have_old to 1 and set old_sha1 to the
@@ -3531,7 +3537,9 @@ struct ref_update {
 	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
+	int flags;  /* The flags to transaction_update_ref[log] are defined
+		     * in refs.h
+		     */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
@@ -3539,8 +3547,9 @@ struct ref_update {
 
 	/* used by reflog updates */
 	int reflog_fd;
-	struct lock_file reflog_lock;
+	struct lock_file *reflog_lock;
 	char *committer;
+	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
 
 	const char refname[FLEX_ARRAY];
 };
@@ -3619,11 +3628,26 @@ int transaction_update_reflog(struct transaction *transaction,
 			      struct strbuf *err)
 {
 	struct ref_update *update;
+	int i;
 
 	if (transaction->state != TRANSACTION_OPEN)
 		die("BUG: update_reflog called for transaction that is not open");
 
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
@@ -3639,7 +3663,6 @@ int transaction_update_reflog(struct transaction *transaction,
 	}
 	if (msg)
 		update->msg = xstrdup(msg);
-	update->flags = flags;
 
 	return 0;
 }
@@ -3822,10 +3845,15 @@ int transaction_commit(struct transaction *transaction,
 
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
+					LOCK_NO_DEREF);
 		if (update->reflog_fd < 0) {
 			const char *str = "Cannot lock reflog for '%s'. %s";
 
@@ -3891,7 +3919,7 @@ int transaction_commit(struct transaction *transaction,
 				ftruncate(update->reflog_fd, 0)) {
 				error("Could not truncate reflog: %s. %s",
 				      update->refname, strerror(errno));
-				rollback_lock_file(&update->reflog_lock);
+				rollback_lock_file(update->reflog_lock);
 				update->reflog_fd = -1;
 				continue;
 			}
@@ -3901,7 +3929,7 @@ int transaction_commit(struct transaction *transaction,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
-			rollback_lock_file(&update->reflog_lock);
+			rollback_lock_file(update->reflog_lock);
 			update->reflog_fd = -1;
 		}
 	}
@@ -3912,9 +3940,11 @@ int transaction_commit(struct transaction *transaction,
 
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
2.1.0.rc2.206.gedb03e5
