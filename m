From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 10/11] refs.c: allow multiple reflog updates during a single transaction
Date: Wed,  4 Jun 2014 11:57:51 -0700
Message-ID: <1401908272-7600-11-git-send-email-sahlberg@google.com>
References: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:58:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGOQ-0008BH-Qb
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbaFDS6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:58:23 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:49308 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbaFDS6I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:58:08 -0400
Received: by mail-qa0-f74.google.com with SMTP id j5so1108214qaq.5
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CyWd2FkF3j14QU2QjILyKUg6w2SF1LApwktm2AZDRo8=;
        b=JIn6XsvpENacOz4ER9TelL5hWgtybmfsTzPML2MzEecF22FRA9pwUsls20qdy7yAhN
         2IGTBUVTEjjF8Sjb7FDXBhTj4ApJT4AFbrkBaodgNRgFTVxDeUEEefDa52TZfa4uQToy
         XOnBuqpUdeCHVdZXTjlEVuymM6Cbo9VvFPnsbH2Hg4L5M0LUzhSk2FtrgyK/rL6OibO5
         +2dg7eHmoi8YdELw2ZVngn+iErHee3ewFxd8EyaMcN3vx+eLkdkavnV3GXuGev8Pa7Bo
         ZTC8kCM2mQOOgRu/sBq8lFoglwxFJ8nR6Th1Uv2NAYeufexRMTch++LTrT7rmI69beTe
         P6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CyWd2FkF3j14QU2QjILyKUg6w2SF1LApwktm2AZDRo8=;
        b=lDme2RDbyNdRS/Occ05sewVQ4IlowxEf1o/IGW+zcQ9dVCat02hiFsPLn0ardC2LyC
         RS3HbHk4cVUx1FzVN3yoXtbHD2JUJUOMuPyAfjvRuLdh0yEGTReu7FZNyb0LRB+LxEqF
         DHe18OkZDFuq5rb7tntNmMXreKngd+ffumG5z3KP5Dls+eCqXkzdsHxwlLW0CBlDnuxs
         vqc0maRiLB3JmY0hhhgqaguE6/H9ENO2xbgL50KwusAzFzL0H8MjK5kq1Y29mDCUfFoQ
         d6BsCcNeD3hVVmA3u6cBiYuC7LYfB5OMi4DcoIedkTGbpeKPgS1zUR9eOxhK/qDY2cov
         H/TQ==
X-Gm-Message-State: ALoCoQkJZsiMk1K4EJKrnQopZqUFSrUzXj2P2rlh/lXZhDC9AdI395ixhZ5yIoDEy7jRMD9dCjMr
X-Received: by 10.58.118.226 with SMTP id kp2mr23296845veb.4.1401908287259;
        Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si331414yhj.5.2014.06.04.11.58.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1076D2F42F6;
	Wed,  4 Jun 2014 11:58:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B0E29E1565; Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
In-Reply-To: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250764>

Allow to make multiple reflog updates to the same ref during a transaction.
This means we only need to lock the reflog once, during the first update that
touches the reflog, and that all further updates can just write the reflog
entry since the reflog is already locked.

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
index 8faf5c1..eb64d8b 100644
--- a/refs.c
+++ b/refs.c
@@ -34,6 +34,11 @@ static inline int bad_ref_char(int ch)
  * pruned.
  */
 #define REF_ISPRUNING	0x0100
+/*
+ * Only the first reflog update needs to lock the reflog file. Further updates
+ * just use the lock taken by the first update.
+ */
+#define UPDATE_REFLOG_NOLOCK 0x0200
 
 /*
  * Try to read one refname component from the front of refname.  Return
@@ -3360,7 +3365,7 @@ enum transaction_update_type {
        UPDATE_LOG = 1,
 };
 
-/**
+/*
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
  * while locking the ref, set have_old to 1 and set old_sha1 to the
@@ -3370,7 +3375,7 @@ struct ref_update {
 	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
+	int flags; /* REF_NODEREF? or private flags */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
@@ -3378,8 +3383,9 @@ struct ref_update {
 
 	/* used by reflog updates */
 	int reflog_fd;
-	struct lock_file reflog_lock;
+	struct lock_file *reflog_lock;
 	char *committer;
+	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
 
 	const char refname[FLEX_ARRAY];
 };
@@ -3461,12 +3467,27 @@ int transaction_update_reflog(struct ref_transaction *transaction,
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
@@ -3482,7 +3503,6 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 	}
 	if (msg)
 		update->msg = xstrdup(msg);
-	update->flags = flags;
 
 	return 0;
 }
@@ -3663,10 +3683,15 @@ int transaction_commit(struct ref_transaction *transaction,
 
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
 
@@ -3732,7 +3757,7 @@ int transaction_commit(struct ref_transaction *transaction,
 				ftruncate(update->reflog_fd, 0)) {
 				error("Could not truncate reflog: %s. %s",
 				      update->refname, strerror(errno));
-				rollback_lock_file(&update->reflog_lock);
+				rollback_lock_file(update->reflog_lock);
 				update->reflog_fd = -1;
 				continue;
 			}
@@ -3742,7 +3767,7 @@ int transaction_commit(struct ref_transaction *transaction,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
-			rollback_lock_file(&update->reflog_lock);
+			rollback_lock_file(update->reflog_lock);
 			update->reflog_fd = -1;
 		}
 	}
@@ -3753,9 +3778,11 @@ int transaction_commit(struct ref_transaction *transaction,
 
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
2.0.0.578.gb9e379f
