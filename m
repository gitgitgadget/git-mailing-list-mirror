From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] refs.c: add a transaction function to append a reflog entry
Date: Mon,  1 Dec 2014 23:46:41 -0800
Message-ID: <1417506402-24257-4-git-send-email-sbeller@google.com>
References: <1417506402-24257-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: gitster@pobox.com, git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 02 08:47:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XviAl-0006Tp-DX
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 08:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105AbaLBHqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 02:46:54 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:61518 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932947AbaLBHqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 02:46:51 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so14527855igi.0
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 23:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mkVqio0lWVhWEEv47ZKhN6tNtE1xpopWbL6kFmuli3g=;
        b=Zv8GBYMe1xt9tNUSeqiB64UFenNjC/7n1zDVj/8RlOah8LWRB9ascg7a5tYGJbdoFU
         o6wOrtiktdlfC54/iq91rPSC88Y3dmU3V0tws5SzrZnGUPzVAKDmvYMynyOxEb5ZlUAj
         J5BdLE11F8GHvrEogJa+OLWaET/DrF6oiuLNdMa+O+ptMHwfpDP483lljVJlNExfzZaj
         YBAlpnrlMojjs/GDdPehWXxIROFonTvfRa7h4Chx0dOvX2LjEOJ1e/HtYi/OsUsLX/th
         AwhR9/yyrAIRcIoz4BrJSnUDTfjk7Ao09/sDn+4UtxvqVNTJD5sLxNo9qYoEgIOKV9Gx
         ENPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mkVqio0lWVhWEEv47ZKhN6tNtE1xpopWbL6kFmuli3g=;
        b=kenqqQN1dX3dLkyOmHVqufwCbLNu7fT+Oejbbq7tGTMnEKGsXXzs81ZtkO9aTZI/Y5
         CJRy/cOyi7Yw5HbaLkIsvA+1KfaurdYLdbbmMt0JBzrkOfkvCdzDkZpVaGAJTHfMZPfz
         Go74Vp1B1/sFCPwjzy8fg/g3gIvaCrbDZTYSffTcN8257lWa5Hgggsz9afi5T5yTKjeF
         iEvVquYtsdWGYdA6pcxqnZKBezpy3lNjOqPGgn7nb0REtOggciPPQYj5n89UqxRnKKLp
         EUBGBRtEFKBUYCuQKGzDFR1Expj+PByJPvy5J0AqTEc36i8Tl9cO41N2jpnpi1W57X0E
         brEw==
X-Gm-Message-State: ALoCoQmuq/l+4Z3EFLNrqzPFJKrUpw9+BYaT2Aopq7ruqUKMTpuJ+b8ADzsJetMFXk8pRHSkgtDB
X-Received: by 10.50.41.103 with SMTP id e7mr11542524igl.20.1417506409876;
        Mon, 01 Dec 2014 23:46:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:21e7:446b:f329:a30a])
        by mx.google.com with ESMTPSA id y2sm11549184igl.8.2014.12.01.23.46.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 23:46:49 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417506402-24257-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260546>

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

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>

---
This is a complete rewrite of the patch you would have found earlier on
the list. The approach was changed to deal with the reflogs differently
and not toss them into the array containing all the ref_updates, but
keep them in a separate string list.

As I am borrowing some text for the commit message and some ideas how to approach
the problem, I still added Ronnies sign off.

 refs.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs.h |  21 +++++++++++
 2 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 58de60c..2861486 100644
--- a/refs.c
+++ b/refs.c
@@ -3557,6 +3557,12 @@ struct transaction {
 	struct ref_update **ref_updates;
 	size_t alloc;
 	size_t nr;
+
+	/*
+	 * Sorted list of reflogs to be committed,
+	 * the util points to the lock_file
+	 */
+	struct string_list reflog_updates;
 	enum transaction_state state;
 };
 
@@ -3564,7 +3570,10 @@ struct transaction *transaction_begin(struct strbuf *err)
 {
 	assert(err);
 
-	return xcalloc(1, sizeof(struct transaction));
+	struct transaction *ret = xcalloc(1, sizeof(struct transaction));
+	string_list_init(&ret->reflog_updates, 1);
+
+	return ret;
 }
 
 void transaction_free(struct transaction *transaction)
@@ -3629,6 +3638,112 @@ int transaction_update_ref(struct transaction *transaction,
 	return 0;
 }
 
+/* Returns a fd, -1 on error. */
+static int get_reflog_updates_fd(struct transaction *transaction,
+				 const char *refname,
+				 struct strbuf *err)
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
+		if (safe_create_leading_directories(path)) {
+			strbuf_addf(err,
+				    "creating temporary directories %s failed.",
+				    path);
+			return -1;
+		}
+
+		if (hold_lock_file_for_update(lock, path, 0) < 0) {
+			strbuf_addf(err,
+				    "creating temporary file %s failed.",
+				    path);
+			return -1;
+		}
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
+	 * We cannot handle reflogs the same way we handle refs because of
+	 * naming conflicts in the file system.
+	 *
+	 * If renaming a ref from foo/foo to foo or the other way round,
+	 * we need to be careful as we need the basic foo/ from being a
+	 * directory to be a file or vice versa. When handling the refs
+	 * this can be solved easily by first recording all we want into
+	 * the packed refs file and then deleting all the loose refs. By
+	 * doing it that way, we always have a valid state on disk.
+	 *
+	 * We don't have an equivalent of a packed refs file when dealing
+	 * with reflog updates, but the API for updating the refs turned
+	 * out to be conveniant, so let's introduce an intermediate file
+	 * outside the $GIT_DIR/logs/refs/heads/ directory helping us
+	 * avoiding this naming conflict for the reflogs. The intermediate
+	 * lock file, in which we build up the new reflog will live under
+	 * $GIT_DIR/logs/lock/refs/heads/ so the files
+	 *       $GIT_DIR/logs/lock/refs/heads/foo.lock and
+	 *       $GIT_DIR/logs/lock/refs/heads/foo/foo.lock
+	 * do not collide.
+	 */
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	if (transaction->state != TRANSACTION_OPEN)
+		die("BUG: update_reflog called for transaction that is not open");
+
+	fd = get_reflog_updates_fd(transaction, refname, err);
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
+
 int transaction_create_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
@@ -3713,13 +3828,14 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3796,6 +3912,13 @@ int transaction_commit(struct transaction *transaction,
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
