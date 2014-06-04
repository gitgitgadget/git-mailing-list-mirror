From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 07/11] refs.c: add a transaction function to append a reflog entry
Date: Wed,  4 Jun 2014 11:57:48 -0700
Message-ID: <1401908272-7600-8-git-send-email-sahlberg@google.com>
References: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:58:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGOa-0008BH-06
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbaFDS63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:58:29 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:55446 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbaFDS6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:58:07 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so1816098oah.0
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qRSOnAWGvZ/8YOwl+CqYxkcE4/DUtzwtxZRFLEws5Ng=;
        b=K5CsMCCov83MOEdyWNNtIc1FfhNTMMMwLHspAlhKRpCWb1W7t3oYTxtK5/gSJd4Om5
         gtaNX5MgSaw68T5UtkuMgcmy0qF2ofrjHOm6HVih0yqSu9i9rT7taxWx88Y4GJ2iIS07
         ARrIRQjU+Ttad2faWRtAXMGLSThTV6BuBSTsF0N7NBYlHzD90SS18DCArX9vKXvgXJAf
         8RiQC1Z6U6VE0g/PCnT6SHLIlI6YPCP8rHCfIDxFS9ohZFmhAoa72rHd2B7JHclGZMyO
         37Hp5dDmtVTqWakLDbeL0TPdvfi9myZr9etyszEgHvmIbTrVlbkCm57Y4gRFEOkyUiMg
         9xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qRSOnAWGvZ/8YOwl+CqYxkcE4/DUtzwtxZRFLEws5Ng=;
        b=S66W9rdRMmD/g63M+AehgfjWiscph9xWoEh35QTlj5TjBW3WlG1cjexTSTM92jtPuK
         Q+mhGS9px4ElLDoAHo0GLC0P04VOa3YeAWuL7BwSFWkgl9z5qmlHshPMl9x1WES+wT5F
         jUOxerYAAU/+UwDqM7IX9uiRbGcasUD3nk+YDEpP+Sn0AN7NEm1m4T/QMD3WOhSFc6XE
         Dq4tlXrQ9KqIlf4NcacvPVQufVlbtc5z2GA1nIIzpL5y5YF39YGOVdBA+Um/OuwUP612
         6OD0j7B4HcmJOxLSjD3+RWdIe9XTABGb6whk2iJvhQRwf/TmHGtr424YuTc7WPG91a5y
         J51A==
X-Gm-Message-State: ALoCoQnznvdbIqlYRhqu2EaF71KRnQE+AhudrR33+n+trABKxVY4BFkFRD7OJ+FfLbOQPp6KIhCb
X-Received: by 10.182.227.131 with SMTP id sa3mr23503280obc.38.1401908287053;
        Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si331413yhj.5.2014.06.04.11.58.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D26B731DBF7;
	Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8B62DE0887; Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
In-Reply-To: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250767>

Define a new transaction update type, UPDATE_LOG, and a new function
transaction_update_reflog. This function will lock the reflog and append
an entry to it during transaction commit.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 refs.h |  12 ++++++++
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e89a81c..b99fcd9 100644
--- a/refs.c
+++ b/refs.c
@@ -3357,6 +3357,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 
 enum transaction_update_type {
        UPDATE_SHA1 = 0,
+       UPDATE_LOG = 1,
 };
 
 /**
@@ -3374,6 +3375,12 @@ struct ref_update {
 	struct ref_lock *lock;
 	int type;
 	char *msg;
+
+	/* used by reflog updates */
+	int reflog_fd;
+	struct lock_file reflog_lock;
+	char *committer;
+
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3423,6 +3430,7 @@ void transaction_free(struct ref_transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free(transaction->updates[i]->committer);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -3443,6 +3451,42 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
+int transaction_update_reflog(struct ref_transaction *transaction,
+			      const char *refname,
+			      const unsigned char *new_sha1,
+			      const unsigned char *old_sha1,
+			      const unsigned char *email,
+			      unsigned long timestamp, int tz,
+			      const char *msg, int flags,
+			      struct strbuf *err)
+{
+	struct ref_update *update;
+
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update_reflog called for transaction that is not "
+		    "open");
+
+	update = add_update(transaction, refname, UPDATE_LOG);
+	hashcpy(update->new_sha1, new_sha1);
+	hashcpy(update->old_sha1, old_sha1);
+	update->reflog_fd = -1;
+	if (email) {
+		struct strbuf buf = STRBUF_INIT;
+		char sign = (tz < 0) ? '-' : '+';
+		int zone = (tz < 0) ? (-tz) : tz;
+
+		strbuf_addf(&buf, "%s %lu %c%04d", email, timestamp, sign,
+			    zone);
+		update->committer = xstrdup(buf.buf);
+		strbuf_release(&buf);
+	}
+	if (msg)
+		update->msg = xstrdup(msg);
+	update->flags = flags;
+
+	return 0;
+}
+
 int transaction_update_sha1(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
@@ -3613,7 +3657,28 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	/* Perform updates first so live commits remain referenced */
+	/* Lock all reflog files */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->update_type != UPDATE_LOG)
+			continue;
+		update->reflog_fd = hold_lock_file_for_append(
+					&update->reflog_lock,
+					git_path("logs/%s", update->refname),
+					0);
+		if (update->reflog_fd < 0) {
+			const char *str = "Cannot lock reflog for '%s'. %s";
+
+			ret = -1;
+			if (err)
+				  strbuf_addf(err, str, update->refname,
+					      strerror(errno));
+			goto cleanup;
+		}
+	}
+
+	/* Perform ref updates first so live commits remain referenced */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3649,6 +3714,40 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
+	/* Update all reflog files */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->update_type != UPDATE_LOG)
+			continue;
+		if (update->reflog_fd == -1)
+			continue;
+
+		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
+				     update->new_sha1,
+				     update->committer, update->msg)) {
+			error("Could write to reflog: %s. %s",
+			      update->refname, strerror(errno));
+			rollback_lock_file(&update->reflog_lock);
+			update->reflog_fd = -1;
+		}
+	}
+
+	/* Commit all reflog files */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->update_type != UPDATE_LOG)
+			continue;
+		if (update->reflog_fd == -1)
+			continue;
+		if (commit_lock_file(&update->reflog_lock)) {
+			error("Could not commit reflog: %s. %s",
+			      update->refname, strerror(errno));
+			update->reflog_fd = -1;
+		}
+	}
+
 	if (repack_without_refs(delnames, delnum, err))
 		ret = -1;
 	for (i = 0; i < delnum; i++)
diff --git a/refs.h b/refs.h
index c7ba822..ae8a800 100644
--- a/refs.h
+++ b/refs.h
@@ -318,6 +318,18 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 			    struct strbuf *err);
 
 /*
+ * Append a reflog entry for refname.
+ */
+int transaction_update_reflog(struct ref_transaction *transaction,
+			      const char *refname,
+			      const unsigned char *new_sha1,
+			      const unsigned char *old_sha1,
+			      const unsigned char *email,
+			      unsigned long timestamp, int tz,
+			      const char *msg, int flags,
+			      struct strbuf *err);
+
+/*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
-- 
2.0.0.578.gb9e379f
