From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 10/15] refs.c: allow multiple reflog updates during a single transaction
Date: Wed, 23 Jul 2014 10:03:50 -0700
Message-ID: <1406135035-26441-11-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zyH-0004nO-A2
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbaGWREh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:37 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:34421 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-ig0-f201.google.com with SMTP id h3so200821igd.4
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pllO89FNW19+lXyz0Im30KmDKLdC5FHPcnkqxub2pcY=;
        b=LV4wryIjdSFAG/Tpv7MRVoY1ZIBFNg4iYAbH+9BPF3dmYgSe2gy1B8+CaBZJTbug8i
         qyfPXcF4NypseuzC1Pt82XDIh/ib8qy6SmrxZEPJgrJyRMPHiOwerDV9AZUdAp8+eVjy
         tGhMppEJ1XcbDCA2kkFhxxos5TOjUkR0wxdzEdvjp5ufyPZ05CUCyryooQ17OIIOFWrI
         8faF/JfgzJkaa01NXKkU1o7pD2okLNa0QZl9Wz1lghyjtAO2JiGDvRyeJsYvQuoQNj+A
         WBFiKK1fjGv69GsUNJlWrNzOnzOiQQyNC9tycdjl8qTAhwJ4PwsIrbBthhbN80Kl5LKw
         QLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pllO89FNW19+lXyz0Im30KmDKLdC5FHPcnkqxub2pcY=;
        b=KnU4vYR+rKswJ/vF2xrKBr+SQUaw+SRupQTf3R71gfQCQhtWc03JhIGIybkwQ7mYUx
         7B+Zbolslh3DSLGLrIX9v9mbTtiD8Z91Gnu502gLpR/vbUwLmJ0yMNpafd8NJ7jI0oTl
         0gIjEkF5CrSNyz/KsdLqpb3OnguJSeHE3/FKPsDp3GiG55iUX00dyIRYczYtEjmpwCga
         aJBHTJ2mYOeFxhh3ebqsB18BspIfOv8dxmNvzfSvb//Ssd1H5yVrWCYTJmh4Kh2rJ2xV
         Z1Vie5o/VX3nPNwPX9iCyqyPjxzDKHFdjqgI54pH/dtcuTqHtzlovkce4YGA6k27CRCn
         4BoA==
X-Gm-Message-State: ALoCoQlCP+smbUlpd5HiPstD34HS9yqcY06zkdKrFlJskMkbaTFN38M/X78qYSjDW8E7c05N+g4Q
X-Received: by 10.50.73.5 with SMTP id h5mr1598429igv.2.1406135038826;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si487014yhb.3.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 990A931C354;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 70F5BE0C3A; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254093>

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
index c431088..12ff916 100644
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
@@ -3389,7 +3395,7 @@ enum transaction_update_type {
        UPDATE_LOG = 1
 };
 
-/**
+/*
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
  * while locking the ref, set have_old to 1 and set old_sha1 to the
@@ -3399,7 +3405,7 @@ struct ref_update {
 	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
+	int flags; /* REF_NODEREF? or private flags */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
@@ -3407,8 +3413,9 @@ struct ref_update {
 
 	/* used by reflog updates */
 	int reflog_fd;
-	struct lock_file reflog_lock;
+	struct lock_file *reflog_lock;
 	char *committer;
+	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
 
 	const char refname[FLEX_ARRAY];
 };
@@ -3489,12 +3496,27 @@ int transaction_update_reflog(struct ref_transaction *transaction,
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
@@ -3510,7 +3532,6 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 	}
 	if (msg)
 		update->msg = xstrdup(msg);
-	update->flags = flags;
 
 	return 0;
 }
@@ -3696,10 +3717,15 @@ int transaction_commit(struct ref_transaction *transaction,
 
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
 
@@ -3765,7 +3791,7 @@ int transaction_commit(struct ref_transaction *transaction,
 				ftruncate(update->reflog_fd, 0)) {
 				error("Could not truncate reflog: %s. %s",
 				      update->refname, strerror(errno));
-				rollback_lock_file(&update->reflog_lock);
+				rollback_lock_file(update->reflog_lock);
 				update->reflog_fd = -1;
 				continue;
 			}
@@ -3775,7 +3801,7 @@ int transaction_commit(struct ref_transaction *transaction,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
-			rollback_lock_file(&update->reflog_lock);
+			rollback_lock_file(update->reflog_lock);
 			update->reflog_fd = -1;
 		}
 	}
@@ -3786,9 +3812,11 @@ int transaction_commit(struct ref_transaction *transaction,
 
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
2.0.1.508.g763ab16
