From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 07/15] refs.c: add a transaction function to append a reflog entry
Date: Tue, 21 Oct 2014 12:24:14 -0700
Message-ID: <1413919462-3458-8-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:24:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf2x-0000LV-F2
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbaJUTYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:24:40 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:64208 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbaJUTYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:24:36 -0400
Received: by mail-ob0-f202.google.com with SMTP id wp4so281718obc.5
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HlaBEl5vB1Dd/7nUtrf3pK6ZTFMElLXZPQUYUsGevQ0=;
        b=JGygis75DLCkUJ87BSlDgOMjM9B2zCABSq/Qozl77Hs0bWacUlZGjDcv65/vIchjXL
         hNsbQ35CxcrDJTYXczIw29jhr4X9ige/65liETi3DeME1OCgBfdA08qJVAblXxhWRIK+
         asf3TUW/FmmBV9vNlTj7DzHYNvb03TPbTNUYi8aiKEjcxOzsECOJsnB+9XLZyPHcqgyM
         TlcFtFj9KSFpsummLBAU0JApJ0xGX5Yw5Jlq7Cn/6qFAlZrYqtD7XtGjoDxkR4m0KfRf
         NAHu+tqnhKQT1CJEyKsMO/sqLPDA6OKBWR3DfCiyZ/gKV94eKxzX1GCoJdvuuHXkEORj
         X2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HlaBEl5vB1Dd/7nUtrf3pK6ZTFMElLXZPQUYUsGevQ0=;
        b=Q8ErhMx+gy8ef0ozrY+jqbw1H4oz36khIX5oyDhBIjz6yMtvyHft3KUeUobcnqKPsM
         iK/L3GT924EaeLIYC74yEyJJ7AGPvLRlBzBEDmGrCMlvPJFOrXW9ispKvWk8r2P2Fc7L
         DOAWpkID9W/xdlhD2AWQMP5noBDEvV+Cavx7g+N2c8Nvp554vrp8MAUmew8H4p76yyXv
         eickS4wfWQeC77fzKprRqtRB/GfgwD2PltYIW1FSGDPs9hCflkx5XY4GbdR3h0pWrh3K
         6TRKCjIOHDnUKao797akLyiNyExjiYRocdWEwBjscY5GibVgHiqaDGDNAEwGJBXBucQM
         ZgQg==
X-Gm-Message-State: ALoCoQn1iZTTmtCb0SK+Tl2mNk3560H7LRe8NCemaEq03GAZhxxMYFbxKzDDKfC18QTk9nW6s2r9
X-Received: by 10.42.101.144 with SMTP id e16mr152652ico.15.1413919475478;
        Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id l45si585595yha.2.2014.10.21.12.24.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id ABxSNHy7.1; Tue, 21 Oct 2014 12:24:35 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5047FE0CC5; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit de045215a52a6a9591b0e786488de2293d79d245 upstream.

Define a new transaction update type, UPDATE_LOG, and a new function
transaction_update_reflog. This function will lock the reflog and append
an entry to it during transaction commit.

Change-Id: I8cc935ef311688d561d447fa51b44ac98492693b
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
