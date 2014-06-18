From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 10/14] refs.c: allow multiple reflog updates during a single transaction
Date: Wed, 18 Jun 2014 10:09:02 -0700
Message-ID: <1403111346-18466-11-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:10:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJN2-0007XJ-Jc
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbaFRRJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:30 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:55622 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so299963iec.2
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFRx38gx9Z2qDm7SSM3wxCCstg2BmAiyBQTOtcYhze0=;
        b=jxKzYiK7jU+tflnYlQxqiOpeb+lFZmgyDpMAe8AymgaNQPtHhN4lTGexmPnDIf4ntm
         U6pKgKxejRL1T8NmIxhJPIt6EiCZav3zJ/ztWPLE1qjTlfEJPe64E7156j4/jZflOLsy
         uh4bHRV9YUSYVJmWgoBAsmXXVQW/hGG1jlN/ChBcbY6DKsMp7TQT+DcASbZBixjlDLML
         VzbfTzc+9GAtz1e1qf6jziQ/NjUZi2emPtXRFu7Iqjbu3BEhtt54KHjx1JgUw9bJOscL
         OtEjLyIOsWetompT/jXiGIiWF50F0wDa5jgFZ+lpLGKRzVDRtMTUaqvjbV2Oxvsw5vjp
         +LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFRx38gx9Z2qDm7SSM3wxCCstg2BmAiyBQTOtcYhze0=;
        b=F0a5ux6zg2QJG8N5ZK0CrKdjMRerGsU5Lelyxwz9JG8HFXxdLKK4vm30y/1yWjXPqa
         QVYXzwc5dugLGpEoIeORnRJ+kcAn4gUUk4YTpNrW8j65BJYnPASq+y2zTCd2b3mFiJla
         OQPgN9EuDD7kV2xzJ5RBb45X07mHYGsdFeY2gkTrPQb51L9ckCCCpEjH9A0H2A+0to2W
         AwOHslPnuAnOdiiuIVUfQwbdqWeYMYMR48MgSKekNg/ovFcdUhBf5e0oKSAN5hnASZrU
         EF0G0jvVPS/kNbJoiKdOSL4Z+mzE2LUriYY5e787lG5bqULWf1MraOn74hJPjR3POvu+
         xHrw==
X-Gm-Message-State: ALoCoQkVgyu0CixmTFSnK0aseG2MW4sZytBL5fODOvt0iz+mW3FBNbgHhNRNi+1Z6pv+7bZ72LhS
X-Received: by 10.43.156.13 with SMTP id lk13mr1190639icc.29.1403111350261;
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si173684yhb.3.2014.06.18.10.09.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0E69031C80B;
	Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C1CCAE075A; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252004>

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
 refs.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index d6df28d..ad60231 100644
--- a/refs.c
+++ b/refs.c
@@ -30,6 +30,12 @@ static unsigned char refname_disposition[256] = {
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
@@ -3391,7 +3397,7 @@ enum transaction_update_type {
        UPDATE_LOG = 1,
 };
 
-/**
+/*
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
  * while locking the ref, set have_old to 1 and set old_sha1 to the
@@ -3401,7 +3407,7 @@ struct ref_update {
 	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
+	int flags; /* REF_NODEREF? or private flags */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
@@ -3409,8 +3415,9 @@ struct ref_update {
 
 	/* used by reflog updates */
 	int reflog_fd;
-	struct lock_file reflog_lock;
+	struct lock_file *reflog_lock;
 	char *committer;
+	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
 
 	const char refname[FLEX_ARRAY];
 };
@@ -3492,12 +3499,27 @@ int transaction_update_reflog(struct ref_transaction *transaction,
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
@@ -3513,7 +3535,6 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 	}
 	if (msg)
 		update->msg = xstrdup(msg);
-	update->flags = flags;
 
 	return 0;
 }
@@ -3690,10 +3711,15 @@ int transaction_commit(struct ref_transaction *transaction,
 
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
 
@@ -3759,7 +3785,7 @@ int transaction_commit(struct ref_transaction *transaction,
 				ftruncate(update->reflog_fd, 0)) {
 				error("Could not truncate reflog: %s. %s",
 				      update->refname, strerror(errno));
-				rollback_lock_file(&update->reflog_lock);
+				rollback_lock_file(update->reflog_lock);
 				update->reflog_fd = -1;
 				continue;
 			}
@@ -3769,7 +3795,7 @@ int transaction_commit(struct ref_transaction *transaction,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
-			rollback_lock_file(&update->reflog_lock);
+			rollback_lock_file(update->reflog_lock);
 			update->reflog_fd = -1;
 		}
 	}
@@ -3780,9 +3806,11 @@ int transaction_commit(struct ref_transaction *transaction,
 
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
2.0.0.467.g08c0633
