From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 10/15] refs.c: allow multiple reflog updates during a single transaction
Date: Tue, 21 Oct 2014 12:24:17 -0700
Message-ID: <1413919462-3458-11-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:25:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf3N-0000Yv-5x
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbaJUTYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:24:46 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:61435 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932705AbaJUTYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:24:36 -0400
Received: by mail-qg0-f73.google.com with SMTP id i50so186283qgf.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7JKy14x40jkmVgeolAcptSEoMte5n0cffTYpF6Keico=;
        b=OJoyu9n/fRbKjqZe4x7efy2qN4xt4T9O0YJHODnwJ/eIqqxqpNVM6b+Cpx1wJexoZV
         OJOrKoi8oFPG9B+RHvfnxa6eijc4nTII9gJT4X0thvlxCm2WxykiMqRNNc/xcF9nbA1D
         cv2MPr3LzQm4GoS5JBKO9he+4FIItghvDKrLBHoMgumlZhr1o7Gtx7N0A2DLasgkQ5I2
         N1dRqJtOPFBKXBzKMFA2LKE4H4KGLcrB75V9qvS3jRY32hSnInZAoSfG0GVHDLYjnZIj
         e5srqpBjYYaHLeh8yWuzrR9/yYbnGHfknJo4kBE5pU3PGsgFlIPgBydwIrXOCI7UjQ0F
         MKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7JKy14x40jkmVgeolAcptSEoMte5n0cffTYpF6Keico=;
        b=CS5Ba7yt3PG9CxYrDBrSIuW8gvuwFaSAOsv0/Gmdd8SiKDT/3fQwFEfYiWCp1EOObn
         rNFtJwchYErQvYUpeJAA1mRINapHbNn2u7bUa+7zG/nHyRFyo7v6xfbbJZqf+SAiHvpT
         CTQEMSpaD9IVTducdMHb6THZsN2WZYObqXoLr+frxheynPzztk0woK0i0xplVYZaVcsy
         lTIspEvzWV4R2wWSEusxJAjfP4p1ml078u/0/CB5axf+iPCl/hYUJb0tz0rdIDoVBP5g
         3EVKXEsGIp5e2/Ehk6Xrnk90MU3cgA1JSPDi51/TKMsrk5T+z5pXNnu1hw3UxI0hUKO0
         FWBA==
X-Gm-Message-State: ALoCoQkIGOcqhI9GLYtc1UwEZbYdE+v0vGSiSAil6uLBvAte96hubPuek+tbOqO/G5i66NNvH9E3
X-Received: by 10.236.201.74 with SMTP id a50mr24065065yho.20.1413919475508;
        Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t28si583891yhb.4.2014.10.21.12.24.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id O0W9ZsRF.1; Tue, 21 Oct 2014 12:24:35 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5CF28E1109; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 5fd1fa7d8520cf03e94fa7d0e9aa8685de0ef63f upstream.

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

Change-Id: Ibe703310e33a4db07e5bcc704310211268b788fc
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index f14b76e..f7e947f 100644
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
@@ -3531,7 +3537,7 @@ struct ref_update {
 	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
+	int flags; /* REF_NODEREF? or private flags */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
@@ -3539,8 +3545,9 @@ struct ref_update {
 
 	/* used by reflog updates */
 	int reflog_fd;
-	struct lock_file reflog_lock;
+	struct lock_file *reflog_lock;
 	char *committer;
+	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
 
 	const char refname[FLEX_ARRAY];
 };
@@ -3619,11 +3626,26 @@ int transaction_update_reflog(struct transaction *transaction,
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
@@ -3639,7 +3661,6 @@ int transaction_update_reflog(struct transaction *transaction,
 	}
 	if (msg)
 		update->msg = xstrdup(msg);
-	update->flags = flags;
 
 	return 0;
 }
@@ -3822,10 +3843,15 @@ int transaction_commit(struct transaction *transaction,
 
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
 
@@ -3891,7 +3917,7 @@ int transaction_commit(struct transaction *transaction,
 				ftruncate(update->reflog_fd, 0)) {
 				error("Could not truncate reflog: %s. %s",
 				      update->refname, strerror(errno));
-				rollback_lock_file(&update->reflog_lock);
+				rollback_lock_file(update->reflog_lock);
 				update->reflog_fd = -1;
 				continue;
 			}
@@ -3901,7 +3927,7 @@ int transaction_commit(struct transaction *transaction,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
-			rollback_lock_file(&update->reflog_lock);
+			rollback_lock_file(update->reflog_lock);
 			update->reflog_fd = -1;
 		}
 	}
@@ -3912,9 +3938,11 @@ int transaction_commit(struct transaction *transaction,
 
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
