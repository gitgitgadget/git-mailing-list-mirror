From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/13] refs.c: add a transaction function to truncate or append a reflog entry
Date: Thu,  4 Dec 2014 00:29:16 -0800
Message-ID: <1417681763-32334-7-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:30:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRoB-0006BS-HR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbaLDIaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:30:10 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:48280 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbaLDI3l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:41 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so9996645ier.6
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c63VuU2d/W6bl0R4ShM//MTW6s+oNXCCNfEKEZiMYEY=;
        b=aXHvmDZc1MYUyelazx223uOrdtkYu996EgTQeZg0HtD6bA6HCojXx1M0WFaS6fzkQ5
         Yxd6RCkMjoc6EyhocnqDwn1mXSlww37phR2suWxdpKmNBIEUdXqRHMMHNAntttp6FgL1
         4wA416DX/2tRZ0GugQU7mUNchqEFbZhqtZW4vpSZbHdKOLlGdtV2ZAP8A6UPaESK61z4
         Bgl8puVR8Qn3WXcq/JHcm2ldj5P25k1y4NEb0sNB7UP2Cwwb9Yl6bmsFPwkrBoXtGrOr
         FkL82rxcFjKhL+ORJYUIamizRooMUiWTvf2UborMz9AoofmD1n3Fg6GLaTPdZj6uWVRL
         6i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c63VuU2d/W6bl0R4ShM//MTW6s+oNXCCNfEKEZiMYEY=;
        b=ckVZ3ji/ofYQHGPajvanhKPFe/vSftdA5wZwMJnctmEOYLK3weLx3KzZvN631Nnh/w
         JGNz/MTYngN4YfhEvMSaRBTzRvYzUgnmPC9HD7fpRnPktm6KSHwXCUzsy1S7IENwRzz/
         d8wE7UqBaQBMCO5fXGw+ZyToqMtkFAfkCbQLPn94clZgYQ24CfrF1zqcbz005G/jBpdh
         hdldgPmpVUygnd3WAuYVH4F841k75+/TznZYC5lYP80GjIVa3CDG6Bl++mlSJ5QqbIXx
         ct3IwM6aInyUkcvut9LOTMqhg9xpBj6HIRtp3bN3NG/oHjTd9M2zIrtuwK3gE2BKHYtk
         H4HQ==
X-Gm-Message-State: ALoCoQm4/91B6tgEKUuyzgRWl8esfLGHfIgQgQQ5viMnfWvkqLV1T8IT0TUMAxO4nFUCRlhsdZVS
X-Received: by 10.50.12.97 with SMTP id x1mr2910442igb.48.1417681780349;
        Thu, 04 Dec 2014 00:29:40 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id c139sm6170367ioc.28.2014.12.04.00.29.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:39 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260744>

This patch introduces two transaction functions for dealing with reflog
changes. The first function transaction_truncate_reflog can be used,
when a rebuilding of the reflog is desired, e.g. on reflog expire.
The transaction_update_reflog function can be used to amend a line to the
reflog.

We cannot handle reflogs the same way we handle refs because
of naming conflicts in the file system.
If renaming a ref from foo/foo to foo or the other way round,
we need to be careful as we need the basic foo/ from being a
directory to be a file or vice versa. When handling the refs
this can be solved easily by first recording all we want into
the packed refs file and then deleting all the loose refs. By
doing it that way, we always have a valid state on disk.

We don't have an equivalent of a packed refs file when dealing
with reflog updates, but the API for updating the refs turned
out to be conveniant, so let's introduce an intermediate file
outside the $GIT_DIR/logs/refs/heads/ directory helping us
avoiding this naming conflict for the reflogs. The intermediate
lock file, in which we build up the new reflog will live under
$GIT_DIR/logs/lock/refs/heads/ so the files
        $GIT_DIR/logs/lock/refs/heads/foo.lock and
        $GIT_DIR/logs/lock/refs/heads/foo/foo.lock
do not collide.

When using transaction_update_reflog, only write to the reflog iff
msg is non-NULL.

During one transaction we allow to make multiple reflog updates to the
same ref. This means we only need to lock the reflog once, during the first
update that touches the reflog, and that all further updates can just write the
reflog entry since the reflog is already locked.

This allows us to write code such as:

  t = transaction_begin()
  transaction_truncate_reflog(t, "foo");
  loop-over-something...
     if (want_reflog_entry(...))
         transaction_reflog_update(t, "foo", 0, <message>);
  transaction_commit(t)

where we first truncate the reflog and then build the new content one line
at a time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    This is a complete rewrite of this patch, lots of design ideas
    have been born in fruitful discussions with Jonathan.
    
    Personally I am not yet happy about the file copying in
    transaction_update_reflog.

 refs.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs.h |  20 +++++++++++
 2 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 58de60c..c411af9 100644
--- a/refs.c
+++ b/refs.c
@@ -3557,6 +3557,12 @@ struct transaction {
 	struct ref_update **ref_updates;
 	size_t alloc;
 	size_t nr;
+
+	/*
+	 * Sorted list of reflogs to be committed,
+	 * the util points to the lock_file.
+	 */
+	struct string_list reflog_updates;
 	enum transaction_state state;
 };
 
@@ -3564,7 +3570,10 @@ struct transaction *transaction_begin(struct strbuf *err)
 {
 	assert(err);
 
-	return xcalloc(1, sizeof(struct transaction));
+	struct transaction *ret = xcalloc(1, sizeof(struct transaction));
+	ret->reflog_updates.strdup_strings = 1;
+
+	return ret;
 }
 
 void transaction_free(struct transaction *transaction)
@@ -3629,6 +3638,113 @@ int transaction_update_ref(struct transaction *transaction,
 	return 0;
 }
 
+int transaction_truncate_reflog(struct transaction *transaction,
+				const char *refname,
+				struct strbuf *err)
+{
+	struct lock_file *lock;
+	struct string_list_item *item;
+
+	if (transaction->state != TRANSACTION_OPEN)
+		die("BUG: update_reflog called for transaction that is not open");
+
+	item = string_list_insert(&transaction->reflog_updates, refname);
+	if (item->util) {
+		lock = item->util;
+		if (lseek(lock->fd, 0, SEEK_SET) < 0 ||
+			ftruncate(lock->fd, 0)) {
+			strbuf_addf(err, "cannot truncate reflog '%s': %s",
+				    refname, strerror(errno));
+			goto failure;
+		}
+
+	} else {
+		char *path = git_path("logs/locks/%s", refname);
+		item->util = xcalloc(1, sizeof(struct lock_file));
+		lock = item->util;
+		if (safe_create_leading_directories(path)) {
+			strbuf_addf(err, "could not create leading directories of '%s': %s",
+				    path, strerror(errno));
+			goto failure;
+		}
+
+		if (hold_lock_file_for_update(lock, path, 0) < 0) {
+			unable_to_lock_message(path, errno, err);
+			goto failure;
+		}
+		/* The file is empty, no need to truncate. */
+	}
+	return 0;
+failure:
+	transaction->state = TRANSACTION_CLOSED;
+	return -1;
+}
+
+
+int transaction_update_reflog(struct transaction *transaction,
+			      const char *refname,
+			      const unsigned char *new_sha1,
+			      const unsigned char *old_sha1,
+			      const char *email,
+			      unsigned long timestamp, int tz,
+			      const char *msg,
+			      struct strbuf *err)
+{
+	struct lock_file *lock;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+
+	if (transaction->state != TRANSACTION_OPEN)
+		die("BUG: update_reflog called for transaction that is not open");
+
+	item = string_list_insert(&transaction->reflog_updates, refname);
+	if (!item->util) {
+		char buf[1024];
+		int infd, nread;
+		char *path = git_path("logs/locks/%s", refname);
+		item->util = xcalloc(1, sizeof(struct lock_file));
+		lock = item->util;
+		if (safe_create_leading_directories(path)) {
+			strbuf_addf(err, "could not create leading directories of '%s': %s",
+				    path, strerror(errno));
+			goto failure;
+		}
+
+		if (hold_lock_file_for_update(lock, path, 0) < 0) {
+			unable_to_lock_message(path, errno, err);
+			goto failure;
+		}
+
+		/* copy existing reflog over */
+		infd = open(git_path("logs/%s", refname), O_RDONLY);
+		while ((nread = read(infd, buf, 1024)) > 0)
+			write_in_full(lock->fd, buf, nread);
+		if (nread < 0) {
+			strbuf_addf(err, "could not read reflog '%s': %s", refname, strerror(errno));
+			goto failure;
+		}
+		close(infd);
+	}
+	lock = item->util;
+
+	if (email)
+		strbuf_addf(&buf, "%s %lu %+05d", email, timestamp, tz);
+
+	if (msg &&
+	    log_ref_write_fd(lock->fd, old_sha1, new_sha1, buf.buf, msg)) {
+		strbuf_addf(err, "Could not write to reflog: %s. %s",
+			    refname, strerror(errno));
+		goto failure;
+	}
+	strbuf_release(&buf);
+
+	return 0;
+failure:
+	strbuf_release(&buf);
+	transaction->state = TRANSACTION_CLOSED;
+	return -1;
+}
+
 int transaction_create_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
@@ -3713,13 +3829,14 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3796,6 +3913,13 @@ int transaction_commit(struct transaction *transaction,
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
index 556adfd..1afc72c 100644
--- a/refs.h
+++ b/refs.h
@@ -328,6 +328,26 @@ int transaction_delete_ref(struct transaction *transaction,
 			   struct strbuf *err);
 
 /*
+ * Truncate the reflog for the given refname.
+ */
+int transaction_truncate_reflog(struct transaction *transaction,
+				const char *refname,
+				struct strbuf *err);
+
+/*
+ * Append a reflog entry for refname. If msg is NULL no update will be
+ * written to the log.
+ */
+int transaction_update_reflog(struct transaction *transaction,
+			      const char *refname,
+			      const unsigned char *new_sha1,
+			      const unsigned char *old_sha1,
+			      const char *email,
+			      unsigned long timestamp, int tz,
+			      const char *msg,
+			      struct strbuf *err);
+
+/*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.
  *
-- 
2.2.0
