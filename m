From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] refs.c: add a transaction function to append a reflog entry
Date: Mon,  1 Dec 2014 18:02:31 -0800
Message-ID: <1417485752-10502-3-git-send-email-sbeller@google.com>
References: <1417485752-10502-1-git-send-email-sbeller@google.com>
To: jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 03:02:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvcnZ-0006ue-G5
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 03:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbaLBCCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 21:02:38 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:55265 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbaLBCCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 21:02:36 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so15174535iga.3
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 18:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=SC5vGnx39QC8M+fw5gQ420FowwzoieGc5bGjV5n29AA=;
        b=aNMNoTZeht5eDNSj6xRXJqede+C0uO/RVCRSJiMwAweJE1yQ8PKZFe+5nLUOdK0HWF
         KUPR9KTeEYyhOjUFkcTaZAYKQjwvtOC/UxDtxCIZd/MSO/4WpeQBD8z90RleO4HCkRmP
         kwwkqZ84z7MWdMsQcAVSxsZRHmzevkTWjGGWy3LhYeVY4d7sMZ7XtwdoGC0fnPQenLwm
         RUq/14rcX5tZzApum/RMeJnXXVEUO86DZpro5bxpHIiItl+jfo4TK4NFqfgXtudaaju1
         nKDHjyiO21rnPg3FkWvCl09eSY4Z9zRnc749s/T2Tx38xgTLXj8UT4vSBXIcAfl4kEcw
         08hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=SC5vGnx39QC8M+fw5gQ420FowwzoieGc5bGjV5n29AA=;
        b=HPKbB7L5jCnKNGCvOKfqHEHw9ybulmHQaj/sNRUipcOSk01hlNaubhyHMP5k0Yy1OP
         BjHdwLjWNbHOr4/V88iPb9YMSEz6opOdYgr54FlNBi4dIPq02C+qS7qagUSlsAo9DW7Y
         nB7nXAgLoTtJVrA8hd+TgA5SrdTEqM29/5AH789nQb3/HWwaVctUhvdO+QkLxr0Cjd9Q
         RntwZ4YoZpWIoSTYUfEb34tkKrNg6i1QFrkFLFzECAYSKmkmkxan2B4d1X7i/uGqMjrM
         Bgns6/1c9qE9WW43fWfV4IGvN1XjEAchiByqgoDMBawARnZWP5Jowu3sWMd5hmtX5sX9
         VYfw==
X-Gm-Message-State: ALoCoQm4Qm4L9f2Ic16tQu0gQrSlyadyXIugsCLTB0pQGjTItYeC/CVloPATrwttOMv100TpCjps
X-Received: by 10.107.159.19 with SMTP id i19mr37878402ioe.79.1417485756140;
        Mon, 01 Dec 2014 18:02:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:21e7:446b:f329:a30a])
        by mx.google.com with ESMTPSA id s10sm11200877igr.2.2014.12.01.18.02.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 18:02:35 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417485752-10502-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260519>

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

This allows us to write code such as:

  t = transaction_begin()
  transaction_reflog_update(t, "foo", REFLOG_TRUNCATE, NULL);
  loop-over-something...
     transaction_reflog_update(t, "foo", 0, <message>);
  transaction_commit(t)

where we first truncate the reflog and then build the new content one line
at a time.

Change-Id: I83923b2dcfa29aadb86a942826060180ac6f3d07
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs.h |  21 +++++++++++++
 2 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 58de60c..d0d2be7 100644
--- a/refs.c
+++ b/refs.c
@@ -3557,6 +3557,7 @@ struct transaction {
 	struct ref_update **ref_updates;
 	size_t alloc;
 	size_t nr;
+	struct string_list reflog_updates;
 	enum transaction_state state;
 };
 
@@ -3564,7 +3565,10 @@ struct transaction *transaction_begin(struct strbuf *err)
 {
 	assert(err);
 
-	return xcalloc(1, sizeof(struct transaction));
+	struct transaction *ret = xcalloc(1, sizeof(struct transaction));
+	string_list_init(&ret->reflog_updates, 1);
+
+	return ret;
 }
 
 void transaction_free(struct transaction *transaction)
@@ -3629,6 +3633,102 @@ int transaction_update_ref(struct transaction *transaction,
 	return 0;
 }
 
+/* Returns a non null fd, 0 on error. */
+static int get_reflog_updates_fd(struct transaction *transaction,
+			  const char *refname)
+{
+	char *path;
+	struct lock_file *lock;
+	struct string_list_item *item = string_list_insert(
+						&transaction->reflog_updates,
+						refname);
+	if (!item->util) {
+		item->util = xcalloc(1, sizeof(struct lock_file));
+		lock = item->util;
+		path = git_path("logs/locks/%s", refname);
+		if (safe_create_leading_directories(path) < 0)
+			return 0;
+
+		if (hold_lock_file_for_update(lock, path, 0) < 0)
+			return 0;
+	}
+
+	lock = item->util;
+
+	return lock->fd;
+}
+
+int transaction_update_reflog(struct transaction *transaction,
+			      const char *refname,
+			      const unsigned char *new_sha1,
+			      const unsigned char *old_sha1,
+			      const char *email,
+			      unsigned long timestamp, int tz,
+			      const char *msg, int flags,
+			      struct strbuf *err)
+{
+	/*
+	 * We cannot handle reflogs the same way, we handle refs.
+	 *
+	 * Naming conflicts in the file system
+	 *   If renaming a ref from foo/foo to foo or the other way round,
+	 *   we need to be careful as we need the basic foo/ from being a
+	 *   directory to be a file or vice versa. When handling the refs
+	 *   this can be solved easily by first recording all we want into
+	 *   the packed refs file and then deleting all the loose refs. By
+	 *   doing it that way, we always have a valid state on disk.
+	 *
+	 *   We don't have an equivalent of a packed refs file when dealing
+	 *   with reflog updates, but the API for updating the refs turned
+	 *   out to be conveniant, so let's introduce an intermediate file
+	 *   outside the $GIT_DIR/logs/refs/heads/ directory helping us
+	 *   avoiding this naming conflict for the reflogs. The intermediate
+	 *   lock file, in which we build up the new reflog will live under
+	 *   $GIT_DIR/logs/lock/refs/heads/ so the files
+	 *       $GIT_DIR/logs/lock/refs/heads/foo.lock and
+	 *       $GIT_DIR/logs/lock/refs/heads/foo/foo.lock
+	 *   do not collide.
+	 */
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	if (transaction->state != TRANSACTION_OPEN)
+		die("BUG: update_reflog called for transaction that is not open");
+
+	fd = get_reflog_updates_fd(transaction, refname);
+	if (!fd)
+		goto failure;
+
+	if (flags & REFLOG_TRUNCATE) {
+		if (lseek(fd, 0, SEEK_SET) < 0 ||
+			ftruncate(fd, 0)) {
+			strbuf_addf(err, "Could not truncate reflog: %s. %s",
+				    refname, strerror(errno));
+			goto failure;
+		}
+	}
+	if (email)
+		strbuf_addf(&buf, "%s %lu %+05d", email, timestamp, tz);
+
+	if (msg &&
+	    log_ref_write_fd(fd, old_sha1, new_sha1, buf.buf, msg)) {
+		strbuf_addf(err, "Could not write to reflog: %s. %s",
+			    refname, strerror(errno));
+		goto failure;
+	}
+	strbuf_release(&buf);
+
+	return 0;
+failure:
+	strbuf_release(&buf);
+	/*
+	 * As we are using the lock file API, any stale files left behind will
+	 * be taken care of, no need to do anything here.
+	 */
+
+	transaction->state = TRANSACTION_CLOSED;
+	return 1;
+}
 int transaction_create_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
@@ -3713,13 +3813,14 @@ int transaction_commit(struct transaction *transaction,
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->ref_updates;
+	struct string_list_item *item;
 
 	assert(err);
 
 	if (transaction->state != TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
-	if (!n) {
+	if (!n && !transaction->reflog_updates.nr) {
 		transaction->state = TRANSACTION_CLOSED;
 		return 0;
 	}
@@ -3796,6 +3897,13 @@ int transaction_commit(struct transaction *transaction,
 	}
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
+
+	/* Commit all reflog updates*/
+	for_each_string_list_item(item, &transaction->reflog_updates) {
+		struct lock_file *lock = item->util;
+		commit_lock_file_to(lock, git_path("logs/%s", item->string));
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
2.2.0
