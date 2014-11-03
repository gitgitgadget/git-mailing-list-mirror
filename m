From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 07/15] refs.c: add a transaction function to append a reflog entry
Date: Mon,  3 Nov 2014 08:55:49 -0800
Message-ID: <1415033757-9539-8-git-send-email-sahlberg@google.com>
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
	id 1XlKxv-0002zG-BI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 17:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbaKCQ6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 11:58:47 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:52662 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbaKCQ4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 11:56:05 -0500
Received: by mail-oi0-f74.google.com with SMTP id u20so1331383oif.5
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=riEC3RStvlPRQjRcZ4olOz0NN5cp2ydbqvk/khJ0q0Y=;
        b=SuQzo2KVd1HV7V/m8ixRhDuSaY+bvft9g7BrcC6v9p5gsMCO8vmyA94zG1d8r7KeAW
         UGd0syR1fBJJ7EE2Z+K7jSagNCj9vjmKzAypx4rGdqKMs9Rs/lP5gHsZDJAJfYmP4zQ5
         nb+DhfXbh2a9NO4CBjdQ6zEjBKCifGorCzVW684bNn4W/ezGgxej6NLHVVnfT3LvcjDY
         Bz/FXaFapvnFIubKzNsIngY6IrtToeLjmzt+ey9QF1Pn5ZPvO0bqWtYGyiSqvXQkbnuX
         +K9qD4GEkWMTSbEElmqX0zx0Yp8yLiBRiUoO+pATQFEtXl+47gzzTyu+ZhTvFrK7E1AI
         whQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=riEC3RStvlPRQjRcZ4olOz0NN5cp2ydbqvk/khJ0q0Y=;
        b=BmZCxaDOJvpkuwbl4b2sNw8dWQrxmc7Y8/ZwDhpa5FUTbStEPz4IYMlMpZZHYLBqI6
         +3mlg78H1OilMfJRzTyRDFIhp2QJTkp3ocqtBQgS+SkVwpG+v+dZWhrHIbDJHE+bPyhK
         R1IIeTtJwdlLvDxwc8Ev/A7cC15FT8zjtOndJmg1j4AfkW/y+J2oqc+R3q3VoKa3xUBS
         ehaYb5L/mFiBKQAYfG+7C0vAjYHWLI+p2diQTi6Tc+JFVcm/gWBxOs93Z1epsTjxuZTW
         gsjBFlw2VwFSzysPtSa5KdFsv34cjh2aS4TG/VGnJTSyHiVMRkjVZHVryNNb7GOuIvyP
         s8Cg==
X-Gm-Message-State: ALoCoQk/hYW0WqfrGOiGM87D9Uw1g6lWlzaOSBKohxOtM95RSKHfO89iyJMKx11NtIF1qjoWpYcb
X-Received: by 10.182.121.170 with SMTP id ll10mr33251418obb.12.1415033763647;
        Mon, 03 Nov 2014 08:56:03 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id 30si477749yhw.1.2014.11.03.08.56.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:03 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id gn2vF0Xp.1; Mon, 03 Nov 2014 08:56:03 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3CAB6E102E; Mon,  3 Nov 2014 08:56:02 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define a new transaction update type, UPDATE_LOG, and a new function
transaction_update_reflog. This function will lock the reflog and append
an entry to it during transaction commit.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs.h |  12 ++++++++
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 0e11b1c..100b3a3 100644
--- a/refs.c
+++ b/refs.c
@@ -3517,7 +3517,8 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 }
 
 enum transaction_update_type {
-	UPDATE_SHA1 = 0
+	UPDATE_SHA1 = 0,
+	UPDATE_LOG = 1
 };
 
 /**
@@ -3535,6 +3536,12 @@ struct ref_update {
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
 
@@ -3581,6 +3588,7 @@ void transaction_free(struct transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free(transaction->updates[i]->committer);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -3601,6 +3609,41 @@ static struct ref_update *add_update(struct transaction *transaction,
 	return update;
 }
 
+int transaction_update_reflog(struct transaction *transaction,
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
+	if (transaction->state != TRANSACTION_OPEN)
+		die("BUG: update_reflog called for transaction that is not open");
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
 int transaction_update_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
@@ -3773,7 +3816,28 @@ int transaction_commit(struct transaction *transaction,
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
+				strbuf_addf(err, str, update->refname,
+					    strerror(errno));
+			goto cleanup;
+		}
+	}
+
+	/* Perform ref updates first so live commits remain referenced */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3809,6 +3873,40 @@ int transaction_commit(struct transaction *transaction,
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
 	if (repack_without_refs(delnames, delnum, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
diff --git a/refs.h b/refs.h
index 556adfd..8220d18 100644
--- a/refs.h
+++ b/refs.h
@@ -328,6 +328,18 @@ int transaction_delete_ref(struct transaction *transaction,
 			   struct strbuf *err);
 
 /*
+ * Append a reflog entry for refname.
+ */
+int transaction_update_reflog(struct transaction *transaction,
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
  * atomically as possible.
  *
-- 
2.1.0.rc2.206.gedb03e5
