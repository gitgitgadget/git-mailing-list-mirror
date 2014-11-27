From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] refs.c: add a transaction function to append a reflog entry
Date: Wed, 26 Nov 2014 21:34:44 -0800
Message-ID: <1417066485-24921-4-git-send-email-sbeller@google.com>
References: <20141120181701.GB15945@google.com>
 <1417066485-24921-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, gitster@pobox.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 06:35:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtrji-0005LE-BS
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 06:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbaK0FfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 00:35:00 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:50608 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbaK0Few (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 00:34:52 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so3949689ier.4
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 21:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/tSYLyFGofylFtAyz8Kjp5/tKICt87X0G9Np9s+/NSE=;
        b=JqVWsKA+r0eeH6u93TPah0lTnqdPvb5BRssPnMVC12JRyBI4go3RtJc4/6xMaO10JN
         B7WNbGzsSHbZLJY5Y9Bi39jBIYeY6gh/0jZeQJ0YfxvKXD0o2M51KxH85hVP0fm8LYzZ
         6IwHaSDqW2G2WXLFKUmqE1lfsbNJm/NFBVMPeN6e2wThOKsU9R2BVOyiWWY2500FN+N6
         uC9rLRAXnXQfoBJwF2MR9RG0XW7NKDule9yXvqBhRemOlFUR4uBTYwv/3hOJ1xyi2VYX
         t9iMPsHMKw4Hk7exjYw39ojnZifnFDPZ5WUg3ujdla3u1L5c2hnucFR2hREqMbgZuhuA
         KhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/tSYLyFGofylFtAyz8Kjp5/tKICt87X0G9Np9s+/NSE=;
        b=iNzjItkM8EFxQMsjorvA5E+QlP5MUn6A8w+BcnZRF6oea7TmSoCC4aFXxHjRbWjsGr
         ALIuAdVmpQ1d1Q+CySO9ZV+gkQHBTaQRm2by08J8keaRncmLpk39SlbPZuXzgE43bFZA
         6eJluBHAlA/JnR7bO3cevElc3iCImYmWSWENNooUg86zr6OxDSmTS+CED9KyGdcKNbh/
         Lu1eELytc4ny/nK+UP3nxUirVzfOwLiCL+HSKVrO2OEQzXE4H0fx0OJcW1TCZTr3hG/h
         K2Zs9xWN2504yveOgcseS7fLQOVIWJ+M0j/5Z5O01ZvSyFusWXoPMn+pL6Sfic7NvdUD
         9xYw==
X-Gm-Message-State: ALoCoQnTCZzv0J4hTV548ryZH5eHDpgj1Wy7ByQgWLJvKpOL/jn6JNR/BWTLoDV6K5EdCZ7TAtQA
X-Received: by 10.107.130.197 with SMTP id m66mr33592101ioi.10.1417066491914;
        Wed, 26 Nov 2014 21:34:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:3190:a053:325e:48b2])
        by mx.google.com with ESMTPSA id 3sm3104346ion.37.2014.11.26.21.34.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 21:34:51 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1417066485-24921-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260339>

From: Ronnie Sahlberg <sahlberg@google.com>

Define a new transaction update type, UPDATE_LOG, and a new function
transaction_update_reflog. This function will lock the reflog and append
an entry to it during transaction commit. We can pass a flag to this
function, which can truncate the the reflog file before we write the
update.

When performing a reflog transaction update, only write to the reflog iff
msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
an update that only truncates but does not write. This change only affects
whether or not a reflog entry should be generated and written. If msg == NULL
then no such entry will be written.

Orthogonal to this we have a boolean flag REFLOG_TRUNCATE which is used to
tell the transaction system to "truncate the reflog and thus discard all
previous users".

At the current time the only place where we use msg == NULL is also the
place, where we use REFLOG_TRUNCATE. Even though these two settings are
currently only ever used together it still makes sense to have them through
two separate knobs.

This allows future consumers of this API that may want to do things
differently. For example someone can do:
  msg="Reflog truncated by Bob because ..." + REFLOG_TRUNCATE
and have it truncate the log and have it start fresh with an initial message
that explains the log was truncated. This API allows that.

During one transaction we allow to make multiple reflog updates to the
same ref. This means we only need to lock the reflog once, during the first
update that touches the reflog, and that all further updates can just write the
reflog entry since the reflog is already locked.

This allows us to write code (internally in refs.c) such as:

t = transaction_begin()
transaction_reflog_update(t, "foo", REFLOG_TRUNCATE, NULL);
loop-over-something...
   transaction_reflog_update(t, "foo", 0, <message>);
transaction_commit(t)

where we first truncate the reflog and then build the new content one line
at a time.

While this technically looks like O(n2) behavior it is not that bad.
We only do this loop for transactions that cover a single ref during
reflog expire. This means that the linear search inside
transaction_update_reflog() will find the match on the very first entry
thus making it O(1) and not O(n) or our usecases. Thus the whole expire
becomes O(n) instead of O(n2). If in the future we start doing this for many
refs in one single transaction we might want to optimize this.
But there is no need to complexify the code and optimize for future usecases
that might never materialize at this stage.

Instead of recording the line by line reflog updates in memory, use a
tempfile: .git/tmp_reflog_XXXXXX which we write the entries to as the
transaction is built. Then just rename this file onto the destination
reflog file when the transaction is committed.

todo:
This patch needs to add an atexit() thingy as well to ensure that
any remaining files are unlinked on exit, just like the lock_file() thing does.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is a complete rewrite from previous series. Sorry no diff to previous versions.

 refs.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 refs.h |  21 ++++++++++
 2 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 84e086f..a1af703 100644
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
@@ -3530,11 +3531,18 @@ struct ref_update {
 	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
+	int flags;  /* The flags to transaction_update_ref[log] are defined
+		     * in refs.h
+		     */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
 	char *msg;
+
+	/* used by reflog updates */
+	char *tmp_reflog;
+	int reflog_fd;
+
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3580,6 +3588,7 @@ void transaction_free(struct transaction *transaction)
 		return;
 
 	for (i = 0; i < transaction->nr; i++) {
+		free(transaction->updates[i]->tmp_reflog);
 		free(transaction->updates[i]->msg);
 		free(transaction->updates[i]);
 	}
@@ -3601,6 +3610,116 @@ static struct ref_update *add_update(struct transaction *transaction,
 	return update;
 }
 
+int transaction_update_reflog(struct transaction *transaction,
+			      const char *refname,
+			      const unsigned char *new_sha1,
+			      const unsigned char *old_sha1,
+			      const char *email,
+			      unsigned long timestamp, int tz,
+			      const char *msg, int flags,
+			      struct strbuf *err)
+{
+	struct ref_update *update;
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+
+	if (transaction->state != TRANSACTION_OPEN)
+		die("BUG: update_reflog called for transaction that is not open");
+
+	/* Check if there is another reflog update for this ref already. */
+	for (i = 0; transaction->nr > 0 && i < transaction->nr; i++) {
+		if (transaction->updates[i]->update_type != UPDATE_LOG)
+			continue;
+		if (!strcmp(transaction->updates[i]->refname,
+			    refname)) {
+			break;
+		}
+	}
+	/* When starting the transaction or when we did not find the ref,
+	 * we will need to create a new temporary file. */
+	if (transaction->nr == 0 || i == transaction->nr) {
+		int orig_fd;
+		update = add_update(transaction, refname, UPDATE_LOG);
+
+		orig_fd = open(git_path("logs/%s", refname), O_RDONLY);
+		if (orig_fd < 0) {
+			const char *str = "Cannot open reflog for '%s'. %s";
+
+			strbuf_addf(err, str, refname, strerror(errno));
+			transaction->state = TRANSACTION_CLOSED;
+			return 1;
+		}
+
+		update->tmp_reflog = xstrdup(git_path(".tmp_reflog_XXXXXX"));
+		update->reflog_fd = mkstemp(update->tmp_reflog);
+		if (update->reflog_fd == -1) {
+			const char *str = "Could not create temporary "
+			  "reflog for '%s'. %s";
+
+			close(orig_fd);
+			strbuf_addf(err, str, refname, strerror(errno));
+			transaction->state = TRANSACTION_CLOSED;
+			return 1;
+		}
+		if (adjust_shared_perm(update->tmp_reflog)) {
+			strbuf_addf(err, "Could not fix permission bits for "
+				    "reflog: %s. %s",
+				    update->tmp_reflog, strerror(errno));
+			close(orig_fd);
+			unlink_or_warn(update->tmp_reflog);
+			close(update->reflog_fd);
+			update->reflog_fd = -1;
+			transaction->state = TRANSACTION_CLOSED;
+			return 1;
+		}
+		if (copy_fd(orig_fd, update->reflog_fd)) {
+			strbuf_addf(err, "Could not copy reflog: %s. %s",
+				    refname, strerror(errno));
+			close(orig_fd);
+			unlink_or_warn(update->tmp_reflog);
+			close(update->reflog_fd);
+			update->reflog_fd = -1;
+			transaction->state = TRANSACTION_CLOSED;
+			return 1;
+		}
+		close(orig_fd);
+	} else {
+		update = transaction->updates[i];
+	}
+
+	if (flags & REFLOG_TRUNCATE) {
+		if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
+			ftruncate(update->reflog_fd, 0)) {
+			strbuf_addf(err, "Could not truncate reflog: %s. %s",
+				    refname, strerror(errno));
+			unlink_or_warn(update->tmp_reflog);
+			close(update->reflog_fd);
+			update->reflog_fd = -1;
+			transaction->state = TRANSACTION_CLOSED;
+			return 1;
+		}
+	}
+	if (email)
+		strbuf_addf(&buf, "%s %lu %+05d", email, timestamp, tz);
+
+	if (msg &&
+	    log_ref_write_fd(update->reflog_fd,
+			     old_sha1, new_sha1,
+			     buf.buf, msg)) {
+		strbuf_addf(err, "Could not write to reflog: %s. %s",
+			    refname, strerror(errno));
+		unlink_or_warn(update->tmp_reflog);
+		close(update->reflog_fd);
+		update->reflog_fd = -1;
+		transaction->state = TRANSACTION_CLOSED;
+		strbuf_release(&buf);
+		return 1;
+	}
+	strbuf_release(&buf);
+
+	return 0;
+}
+
 int transaction_update_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
@@ -3815,6 +3934,31 @@ int transaction_commit(struct transaction *transaction,
 	}
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
+
+	/* Commit all reflog files */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->update_type != UPDATE_LOG)
+			continue;
+		if (update->reflog_fd == -1)
+			continue;
+		if (close(update->reflog_fd) == -1) {
+			error("Could not commit temporary reflog: %s. %s",
+			      update->refname, strerror(errno));
+			update->reflog_fd = -1;
+			continue;
+		}
+		update->reflog_fd = -1;
+		if (rename(update->tmp_reflog,
+			   git_path("logs/%s", update->refname))) {
+			error("Could not commit reflog: %s. %s",
+			      update->refname, strerror(errno));
+			update->reflog_fd = -1;
+			continue;
+		}
+	}
+
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
diff --git a/refs.h b/refs.h
index 556adfd..9f70b89 100644
--- a/refs.h
+++ b/refs.h
@@ -328,6 +328,27 @@ int transaction_delete_ref(struct transaction *transaction,
 			   struct strbuf *err);
 
 /*
+ * Flags controlling transaction_update_reflog().
+ * REFLOG_TRUNCATE: Truncate the reflog.
+ *
+ * Flags >= 0x100 are reserved for internal use.
+ */
+#define REFLOG_TRUNCATE 0x01
+/*
+ * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
+ * this update will first truncate the reflog before writing the entry.
+ * If msg is NULL no update will be written to the log.
+ */
+int transaction_update_reflog(struct transaction *transaction,
+			      const char *refname,
+			      const unsigned char *new_sha1,
+			      const unsigned char *old_sha1,
+			      const char *email,
+			      unsigned long timestamp, int tz,
+			      const char *msg, int flags,
+			      struct strbuf *err);
+
+/*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.
  *
-- 
2.2.0.rc3
