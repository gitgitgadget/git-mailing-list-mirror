From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 07/15] refs.c: add a transaction function to append a reflog entry
Date: Wed, 23 Jul 2014 10:03:47 -0700
Message-ID: <1406135035-26441-8-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zyH-0004nO-QL
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbaGWREi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:38 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:43403 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932466AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-ie0-f202.google.com with SMTP id rl12so415804iec.5
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q2hY80ksLLFiEqwHH+MEN5AnCPllCjkjegqGnfDF+yI=;
        b=ietZv6Gr2U1pO7ZWT1RrQFWeHfoq11irq+Cvg37rmqce/DH99W4rsUeAMZtfC8OWwm
         YVVyocztZiJhyHT1dfkNnJ9DFJZRrrPmazbKDvjvwjTwy/0spT3ksd8wEwZkgj9awyPq
         vZ7qw6oLSdzgsI5plbSfeKegVlKkacnVb5EV/DrSTAkkUPQUOQ+sFq+RXg+y+jEMTotq
         WdkAt+Koi40TRJlR6N+UN8rnLI1kYyZxQwKup/knHPrviwrG/TnMbN1mlgO1tAEVeK7t
         r2532ySHcHVFvgZAMDIGxU4Gk2W+TPO+1OWXF/e4bV3kQ7PpzIIPAqmqIakTBJ5xpuVD
         OQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q2hY80ksLLFiEqwHH+MEN5AnCPllCjkjegqGnfDF+yI=;
        b=Vn9EE+sbE9LmtR8aHYqy3V4/zq/c3f2QBiqL2ZX0Ib5v1DlcGVuPXbEEFmgZQ4K7Wd
         1GG/ArN3bsTSmVm4G3yeNvv5nYwXUEGd18A/uOUJsCxw3FmcuMYneDf19EXh6NJv1eKn
         TchmPyK41xoq+bqvnBxTxzSB7fHQXCbqpEVfBcEFOr1nZnpg1tYDBx49FjLHJUETs/qz
         zjbwqxNis7Qt+OGsjXDP2y+dOuWy9E/Ch7EV5VbaQkGKypVpcpp65PAwJXLmlWQ7+tf7
         /NoJ7/Tbc21jeeLIgaPzWmCqcfCvQid5l+fBVPWSF/6kosSZtH80DBu4h19ELgbbuUQ0
         hWMQ==
X-Gm-Message-State: ALoCoQluFR2rmn7cL4omg5J2FdeNzVl4nv2hUggSrOZMWGmHXtUBdbssBGg0EcpZS6BwzeEe75CN
X-Received: by 10.50.33.18 with SMTP id n18mr9238365igi.8.1406135038896;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si486950yhh.5.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AA8DA5A4478;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 60725E0BB8; Wed, 23 Jul 2014 10:03:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254091>

Define a new transaction update type, UPDATE_LOG, and a new function
transaction_update_reflog. This function will lock the reflog and append
an entry to it during transaction commit.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs.h |  12 ++++++++
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index a479ddd..b010d6d 100644
--- a/refs.c
+++ b/refs.c
@@ -3385,7 +3385,8 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 }
 
 enum transaction_update_type {
-       UPDATE_SHA1 = 0
+       UPDATE_SHA1 = 0,
+       UPDATE_LOG = 1
 };
 
 /**
@@ -3403,6 +3404,12 @@ struct ref_update {
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
 
@@ -3451,6 +3458,7 @@ void transaction_free(struct ref_transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free(transaction->updates[i]->committer);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -3471,6 +3479,42 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
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
@@ -3646,7 +3690,28 @@ int transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3682,6 +3747,40 @@ int transaction_commit(struct ref_transaction *transaction,
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
index e03eff4..32bc4ae 100644
--- a/refs.h
+++ b/refs.h
@@ -321,6 +321,18 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
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
2.0.1.508.g763ab16
