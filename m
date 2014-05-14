From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 09/31] refs.c: allow multiple reflog updates during a single transaction
Date: Wed, 14 May 2014 15:13:08 -0700
Message-ID: <1400105610-21194-10-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhS7-0000IL-Nv
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbaENWNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:37 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:64178 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbaENWNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:36 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so56968obc.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w369WeX1uvJDX62+AyNvZ6ozZZbKoHQcRdPjT8rmTxo=;
        b=BO53s+xtDOaqM7ouzE57xP8yqzI3ttPWktkUPVr0nRVjz6WGBePCGp/EFpeuGwY26G
         Pd4LpwQsDK74hgEwozHoCher1j1p8fFV4fjky8WB1PRmNDrAG/jwZ6sMYhANqHPLbVZc
         wq1pZZTiciA8vyw/mQJioQGWE7QNLnK9+Go1d2Gtn2Pjykf5EtxSzqw6PVDrb20YqITl
         +6QdjbfdrJHvwQrmEYVVYLmchGomsghtiL1Oly+mEcVQUx0Eggra9XF4DIhUFdzxJwHZ
         I3UdEPUYOcVnxwW+XM5P3DXzztV0Cxq0GlKvCxgZAjYBm0eAlr398Vo70nk3TRVI97yJ
         8kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w369WeX1uvJDX62+AyNvZ6ozZZbKoHQcRdPjT8rmTxo=;
        b=mzfUa+Y1tPX98+Ba3MOg/9LSXWv6BjZ/AHpF8WeFU80GPCBBDPgsGhmnDsY+znk+3w
         qljXPiW7qVgvVPljcYNVoPjJy9kvZlIfRnYcOd+nGdiVVeWA0wLj/hjFXgzjdvuf8t6O
         Tmw67aH7t+ssVT1/YcFF21SvmBhXn8E99d+f6pTMO43qUL/eNhnUiyH0bEIc+5XjDW1u
         mH13fm67kPD0Ck0jam9XHxiRlKpsFip/R3NgBpPcXA0QYc3PIWQOiIDI92aUTYkhvNtD
         Va+QZ+yxCCuCiYu9+0inEitI3ATXE0NX6AEDsKu9/B5dv4/nQdNA7hRGauOm3HHrjG6p
         kOBw==
X-Gm-Message-State: ALoCoQkoYLpo8u5lHqKriI+tp7LAoOV45Wee5g60RqRrJ1tEVtTiLHRU0qatcK6ESd2Tl/Dl39dn
X-Received: by 10.50.130.102 with SMTP id od6mr1169546igb.0.1400105615553;
        Wed, 14 May 2014 15:13:35 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si151864yhk.4.2014.05.14.15.13.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 55C7231C1F8;
	Wed, 14 May 2014 15:13:35 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 162D8E038E; Wed, 14 May 2014 15:13:35 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249027>

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
 refs.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index a3f60ad..e7ede03 100644
--- a/refs.c
+++ b/refs.c
@@ -37,6 +37,10 @@ static inline int bad_ref_char(int ch)
  *  need to lock the loose ref during the transaction.
  */
 #define REF_ISPACKONLY	0x0200
+/** Only the first reflog update needs to lock the reflog file. Further updates
+ *  just use the lock taken by the first update.
+ */
+#define UPDATE_REFLOG_NOLOCK 0x0300
 
 /*
  * Try to read one refname component from the front of refname.  Return
@@ -3252,6 +3256,7 @@ enum transaction_update_type {
        UPDATE_LOG = 1,
 };
 
+
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3262,7 +3267,7 @@ struct ref_update {
 	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
+	int flags; /* REF_NODEREF? or private flags */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
@@ -3270,8 +3275,9 @@ struct ref_update {
 
 	/* used by reflog updates */
 	int reflog_fd;
-	struct lock_file reflog_lock;
+	struct lock_file *reflog_lock;
 	const char *committer;
+	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
 
 	const char refname[FLEX_ARRAY];
 };
@@ -3349,8 +3355,23 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      int flags)
 {
 	struct ref_update *update;
+	int i;
 
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
+	  update->reflog_lock = xcalloc(1, sizeof(struct lock_file));
+
 	hashcpy(update->new_sha1, new_sha1);
 	hashcpy(update->old_sha1, old_sha1);
 	update->reflog_fd = -1;
@@ -3366,7 +3387,6 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 	}
 	if (msg)
 		update->msg = xstrdup(msg);
-	update->flags = flags;
 
 	return 0;
 }
@@ -3479,7 +3499,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 					struct strbuf *err)
 {
 	int i;
-	for (i = 1; i < n; i++)
+	for (i = 1; i < n; i++) {
 		if (updates[i]->update_type != UPDATE_SHA1)
 			continue;
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
@@ -3490,6 +3510,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 
 			return 1;
 		}
+	}
 	return 0;
 }
 
@@ -3558,10 +3579,15 @@ int transaction_commit(struct ref_transaction *transaction,
 
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
 			const char *str = "Cannot lock reflog for '%s'.";
 
@@ -3630,20 +3656,22 @@ int transaction_commit(struct ref_transaction *transaction,
 						    update->new_sha1,
 						    update->committer,
 						    update->msg)) {
-			rollback_lock_file(&update->reflog_lock);
+			rollback_lock_file(update->reflog_lock);
 			update->reflog_fd = -1;
 		}
 	}
 
-	/* Unock all reflog files */
+	/* Commit all reflog files */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
 		if (update->update_type != UPDATE_LOG)
 			continue;
+		if (update->flags & UPDATE_REFLOG_NOLOCK)
+			continue;
 		if (update->reflog_fd == -1)
 			continue;
-		if (commit_lock_file(&update->reflog_lock)) {
+		if (commit_lock_file(update->reflog_lock)) {
 			update->reflog_fd = -1;
 		}
 	}
@@ -3654,6 +3682,18 @@ int transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	/* Rollback any reflog files that are still open */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->update_type != UPDATE_LOG)
+			continue;
+		if (update->flags & UPDATE_REFLOG_NOLOCK)
+			continue;
+		if (update->reflog_fd == -1)
+			continue;
+		rollback_lock_file(update->reflog_lock);
+	}
 	transaction->status = ret ? REF_TRANSACTION_ERROR
 	  : REF_TRANSACTION_CLOSED;
 
-- 
2.0.0.rc3.506.g3739a35
