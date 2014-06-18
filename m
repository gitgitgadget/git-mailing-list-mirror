From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 07/14] refs.c: add a transaction function to append a reflog entry
Date: Wed, 18 Jun 2014 10:08:59 -0700
Message-ID: <1403111346-18466-8-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:10:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJN3-0007XJ-9d
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbaFRRJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:31 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:39149 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so299961iec.2
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=07+Dp1TCAvOsGYLSzSE1LlNWHfOoklmvsJmrAMzIDKU=;
        b=EhUa3wWOQM/9qYeH1rsEmXI6BHpXbDtxZtu3vOz6BfellBRzPtv28euytls4pawGWV
         MevnQvNyHmaSiUsQ507WKBHjkjT2dU3NvNlGBBvHik3nnLKStMKeeCqO8O9E+zN+qyOA
         32kSzhtH5PB4VmMCYIuH7baygIQ9m0PsQYgLmwGIM8SZVJTp6cjIpVpfVOeJerIPAvBf
         fLeS7NmcUZUI0Shp+1T2dewCMT+gWJoaqawCrYi4aoSKo0c/5GIo0Xh3cTeTPfJZPJNE
         hVDyP+m/6pphpV9joxtylsvDyjskYnlnffsftF4cXru3dKXcdrDUII2ZMhOOVlJNfiN8
         s5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=07+Dp1TCAvOsGYLSzSE1LlNWHfOoklmvsJmrAMzIDKU=;
        b=L6kS8ojRos+HovUgBk8PLbeSx9TIqL+5rK6G6jpd9nsJNT4xILff7TALMPX5G7YGGC
         IFmwYZYt5Cfua+3nnNoPQiVIp+Bz5+HrBAocJWdW3dsjExkxgdOxUPhqklAdjAmA9XY2
         xKK3aYSS0vqf9SGai7GHxvWIQJlteaHPu76XYG7IBz5oQRcw2nSzR1kj5KgKxO7nNq9s
         5H+9DJC+E1MhQobteYbfB3Oc7TNSlmVL0YVJ13tinHC8a8ZYGuPGF568FxR2YGUB+LK5
         hk2YOaaGcQXU91dioSAXsUul/nkCWoiOz8/PXTHzewS2porUpMVxiJW/hex0QCH6CCgZ
         aXJQ==
X-Gm-Message-State: ALoCoQkjehfnGGa9PJAoaXebImhe73bLNJ86BxP4rEgg95mcl+MfIN7kd3pdCPgS5MH2HbFtGb6N
X-Received: by 10.42.195.66 with SMTP id eb2mr1224916icb.9.1403111350149;
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si174768yhm.0.2014.06.18.10.09.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E6B3131C80C;
	Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 965D1E0424; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252005>

Define a new transaction update type, UPDATE_LOG, and a new function
transaction_update_reflog. This function will lock the reflog and append
an entry to it during transaction commit.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 refs.h |  12 ++++++++
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f203285..d673a0f 100644
--- a/refs.c
+++ b/refs.c
@@ -3388,6 +3388,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 
 enum transaction_update_type {
        UPDATE_SHA1 = 0,
+       UPDATE_LOG = 1,
 };
 
 /**
@@ -3405,6 +3406,12 @@ struct ref_update {
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
 
@@ -3454,6 +3461,7 @@ void transaction_free(struct ref_transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free(transaction->updates[i]->committer);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -3474,6 +3482,42 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
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
@@ -3640,7 +3684,28 @@ int transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3676,6 +3741,40 @@ int transaction_commit(struct ref_transaction *transaction,
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
index cf48351..bf52068 100644
--- a/refs.h
+++ b/refs.h
@@ -328,6 +328,18 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
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
2.0.0.467.g08c0633
