From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/8] refs.c: add transaction function to append to the reflog
Date: Fri,  5 Dec 2014 18:46:31 -0800
Message-ID: <1417833995-25687-5-git-send-email-sbeller@google.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 06 03:46:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx5OV-0004kd-70
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 03:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbaLFCqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 21:46:47 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:55455 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbaLFCqo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 21:46:44 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so280621igb.7
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 18:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6GxGgUHr2kYlSppAgWN4cUmvPNbheIQz/Z3rXxGZ3sg=;
        b=glZBVUw9JDdIckgPOk8Ua2eBPSmVbpcbcfiT6xwsMAhJ2wNU7HwsgePvhjFA6mj6lB
         i55rfy1Gt6RAtYAujpR2TFC8Kj2iE4UjOgD2jxWAI7dN87AwBg4hEZjE2xGWUjclxJ/T
         zjtOkgxAQYaTt0ZU6cRTCUVp2iqQABCNS0dsHpxKBV7T1PAQ6CMHUkHNeOX0CnE8iOQu
         OtbpXWv9pWVdbe2UmHdtRK+C3B0szAW8kvqVb04zvSFnWYwVfq4J6eTSOidJjbiI8Iiq
         P82n6t5ZNXE76sgCrFfTg8VUmMBfnqRg+hHkZV08hBvy6LDdrs0Wute22zSoEhOJpVgy
         tq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6GxGgUHr2kYlSppAgWN4cUmvPNbheIQz/Z3rXxGZ3sg=;
        b=Cx7FF7LwjyglgTS5hxFtugHJ5q76BGHxdX287BgTzxQ521o580DlOXkzQngkBEAMpP
         JW/S0VDda8mPvPywrGyr+uqPlxdlG0XHJqKJnFQXNh6Szy5ig2nZuR6c5b8nPRl0neYe
         i9R0S581CgVC+aA88O8ZGsgA+gi5LF1CgeUqfd4bXINjt6a7wCXKhF/Hiiccgx0eQUB9
         UEAdrQ4exZYAR3cgkTCEJmInEdEcGdmAK0Ywtai1ReOwyRoXRQuRYrkbwK7297pvNIuX
         4utZF8yTjHMB6MEGyq0+oqV4aE6W1WsnYJFzY9PLXTed2XEjlgnnvGTks21drjOXaR6J
         yDkQ==
X-Gm-Message-State: ALoCoQm6CSNCl7bmikmaT4oLwUfwtd7CyKSjOJf9gPYuj/CvYf+BvxzsykutMTfFw4UdENxpOajJ
X-Received: by 10.42.201.212 with SMTP id fb20mr18225824icb.2.1417834003485;
        Fri, 05 Dec 2014 18:46:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4022:de56:febc:d879])
        by mx.google.com with ESMTPSA id x10sm153820igl.19.2014.12.05.18.46.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 18:46:43 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417833995-25687-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260927>

Currently a transaction can include one or more reflog updates. But these
are not part of the contract of the transaction committing all or nothing.

Introduce a function transaction_update_reflog, which adds a reflog update
to a transaction. Later patches will update code that writes to reflogs to
use this function.

This will allow us to write code such as:

	t = transaction_begin()
	transaction_truncate_reflog(t, "foo"); // introduced by next patch
	loop-over-something...
		if (want_reflog_entry(...))
			transaction_reflog_update(t, "foo", 0, <message>);
	transaction_commit(t)

transaction_ref_update still updates the reflog along with its ref update.
A later patch will make it use transaction_update_reflog internally.

Unlike transaction_update_ref, this writes out the proposed contents of the
reflog to a temporary file at transaction_reflog_update time instead of
waiting for the transaction waiting to be committed. This avoids an
explosion of memory usage when writing lots of reflog updates within a
single transaction.

This requires changing where the temporary file is located. If the temporary
file is located at $GIT_DIR/logs/$REF_NAME.lock, then a transaction that
tries to remove refs/heads/foo and introduce refs/heads/foo/bar would run
into a directory/file conflict when trying to write to
$GIT_DIR/logs/refs/heads/foo/bar.lock because the reflog for branch foo is
not safe to remove yet.

We work around this by placing the temporary files at
$GIT_DIR/logs/lock/$REF_NAME.lock Putting the temporary file under .git/logs
ensures it's likely that it will be in the same file system as the reflogs
and can be atomically renamed into place.

During one transaction we allow to make multiple reflog updates to the same
ref. This means we only need to lock the reflog once during the first update
that touches the reflog and that all further updates can just write the
reflog entry since the reflog is already locked.

transaction_update_reflog should lock the corresponding ref to avoid having
to compete with other reflog updates, but this will be deferred to a later
patch for simplicity.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    This has been sent to the list before, but now it is split up
    into this and the next patch.
    The commit message was overhauled, a huge thanks to Jonathan!
    
    There are no major changes in the code.

 refs.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index aad44d5..d767418 100644
--- a/refs.c
+++ b/refs.c
@@ -3559,19 +3559,30 @@ struct transaction {
 	struct ref_update **ref_updates;
 	size_t alloc;
 	size_t nr;
+
+	/*
+	 * Sorted list of reflogs to be committed.
+	 * the util points to the lock_file.
+	 */
+	struct string_list reflog_updates;
 	enum transaction_state state;
 };
 
 struct transaction *transaction_begin(struct strbuf *err)
 {
+	struct transaction *ret;
+
 	assert(err);
 
-	return xcalloc(1, sizeof(struct transaction));
+	ret = xcalloc(1, sizeof(struct transaction));
+	ret->reflog_updates.strdup_strings = 1;
+	return ret;
 }
 
 void transaction_free(struct transaction *transaction)
 {
 	int i;
+	struct string_list_item *item;
 
 	if (!transaction)
 		return;
@@ -3581,6 +3592,12 @@ void transaction_free(struct transaction *transaction)
 		free(transaction->ref_updates[i]);
 	}
 	free(transaction->ref_updates);
+
+	for_each_string_list_item(item, &transaction->reflog_updates) {
+		rollback_lock_file(item->util);
+	}
+	string_list_clear(&transaction->reflog_updates, 0);
+
 	free(transaction);
 }
 
@@ -3631,6 +3648,71 @@ int transaction_update_ref(struct transaction *transaction,
 	return 0;
 }
 
+/*
+ * Append a reflog entry for refname.
+ */
+static int transaction_update_reflog(struct transaction *transaction,
+				     const char *refname,
+				     const unsigned char *new_sha1,
+				     const unsigned char *old_sha1,
+				     const char *email,
+				     unsigned long timestamp, int tz,
+				     const char *msg,
+				     struct strbuf *err)
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
+		int infd;
+		char *path = git_path("logs/locks/%s", refname);
+		lock = xcalloc(1, sizeof(struct lock_file));
+		item->util = lock;
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
+		if ((infd = open(git_path("logs/%s", refname), O_RDONLY)) < 0) {
+			strbuf_addf(err, "could not open the reflog '%s': %s",
+				    path, strerror(errno));
+			goto failure;
+		}
+		if (copy_fd(infd, lock->fd))
+			goto failure;
+		close(infd);
+	}
+	lock = item->util;
+
+	if (email)
+		strbuf_addf(&buf, "%s %lu %+05d", email, timestamp, tz);
+
+	if (log_ref_write_fd(lock->fd, old_sha1, new_sha1, buf.buf, msg)) {
+		strbuf_addf(err, "Could not write to reflog: '%s': %s",
+			    refname, strerror(errno));
+		goto failure;
+	}
+
+	strbuf_release(&buf);
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
@@ -3715,13 +3797,14 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3798,6 +3881,13 @@ int transaction_commit(struct transaction *transaction,
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
-- 
2.2.0
