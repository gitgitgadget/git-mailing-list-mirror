From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 05/16] refs.c: add transaction support for renaming a reflog
Date: Fri,  7 Nov 2014 11:38:54 -0800
Message-ID: <1415389145-6391-6-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:46:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpTy-0002VI-Qp
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbaKGTqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:46:00 -0500
Received: from mail-qc0-f202.google.com ([209.85.216.202]:44011 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaKGTp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:45:59 -0500
Received: by mail-qc0-f202.google.com with SMTP id m20so278188qcx.3
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/0OdXmuXw9L/8m3xKX8639j4DPGyCPFv5LlZfKfibHg=;
        b=GcMh2Z6jKQMcQqQlMaePfuKzwd722Pgg0Z1kMEKwmaW+Vj3v8Mvqhq1EPH/PotuwHs
         0ewUCGDHpYHJ5Nuqo4QJ8UopECaxy/h0f0qUkfTBmpuLTYdLrZvZToqvXzBe4F4C6CUW
         sBoz4uqjQL46GJjVr/+K8bfOjAAe9C3l9pzxEMDd7NKe0JtISgiCVlv+LHeGFbLpqK3B
         0QwSkR9kdsk95IgkCucWL7hN2H5qVABO/xci9f8Xi2SHhedCvbhdA07qVBVtwQzPLMI/
         uTLvULfKxVZcL+9F4S90xWKfGDz0BwNbmYKrcxgiUfCdNPg9fulxlzBRqr+59eoM0hbD
         Rfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/0OdXmuXw9L/8m3xKX8639j4DPGyCPFv5LlZfKfibHg=;
        b=hU1Z+eUuqck+Kh8vQtR2APXWZVoAxi2eggyoUHIwXVsjTiLbDZJzzmrEk8y+pYnBwk
         R6OTkEEGiZhjABgEsO17JQy85GzHvSMdeL/0qysa95BpcdYlmmzaEDkwKzL+BR/Gl4Dy
         bcBqQzqY4Mi2vGpgTAkTOA+xEBCK7Wiu5NgKyNALAGcJwqzbCs0KaMrEAbLz5Da8mBGM
         SIcHafff2QRTVjtvGZcKSQpWMW2As3vqQLhrKsaOTAnJt1mN1E0i+BA/yZoDWZ/wZ0MV
         k4dE3MUYFcbHv+2lKeAJDOep5BsYchoLYkdMDLI0YbDYceMaZsWPhnFceOohp+oJveCa
         mMZg==
X-Gm-Message-State: ALoCoQmiVEwLyU0ClAaXUc5nkGiJHMBfminLTsw0Swc9vT/XnNaZRWSbZMhXMnnzqtMD7w67b62R
X-Received: by 10.224.30.133 with SMTP id u5mr10405483qac.8.1415389150390;
        Fri, 07 Nov 2014 11:39:10 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si405356yhf.0.2014.11.07.11.39.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:10 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id Y1wOX2aw.1; Fri, 07 Nov 2014 11:39:10 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 874F9E0A83; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new transaction function transaction_rename_reflog.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 refs.h |  8 ++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e9e321e..8ca6add 100644
--- a/refs.c
+++ b/refs.c
@@ -35,6 +35,11 @@ static unsigned char refname_disposition[256] = {
  * just use the lock taken by the first update.
  */
 #define UPDATE_REFLOG_NOLOCK 0x0200
+/*
+ * This update is used to replace a new or existing reflog with new content
+ * held in update->new_reflog.
+ */
+#define REFLOG_REPLACE 0x0400
 
 /*
  * Try to read one refname component from the front of refname.
@@ -2821,6 +2826,37 @@ static int rename_ref_available(const char *oldname, const char *newname)
 static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
 			  const char *logmsg);
 
+/*
+ * This is an optimized function to read the whole reflog as a blob
+ * into a strbuf. It is used during ref_rename so that we can use an
+ * efficient method to read the whole log and later write it back to a
+ * different file.
+ */
+static int copy_reflog_into_strbuf(const char *refname, struct strbuf *buf)
+{
+	struct stat st;
+	int fd;
+
+	if (lstat(git_path("logs/%s", refname), &st) == -1)
+		return 1;
+	if ((fd = open(git_path("logs/%s", refname), O_RDONLY)) == -1) {
+		error("failed to open reflog %s, %s",
+		      refname, strerror(errno));
+		return 1;
+	}
+	strbuf_init(buf, st.st_size);
+	strbuf_setlen(buf, st.st_size);
+	if (read_in_full(fd, buf->buf, st.st_size) != st.st_size) {
+		close(fd);
+		error("failed to read reflog %s, %s",
+		      refname, strerror(errno));
+		return 1;
+	}
+	close(fd);
+
+	return 0;
+}
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -3561,6 +3597,7 @@ struct ref_update {
 	struct lock_file *reflog_lock;
 	char *committer;
 	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
+	struct strbuf new_reflog;
 
 	const char refname[FLEX_ARRAY];
 };
@@ -3607,6 +3644,7 @@ void transaction_free(struct transaction *transaction)
 		return;
 
 	for (i = 0; i < transaction->nr; i++) {
+		strbuf_release(&transaction->updates[i]->new_reflog);
 		free(transaction->updates[i]->msg);
 		free(transaction->updates[i]->committer);
 		free(transaction->updates[i]);
@@ -3622,6 +3660,7 @@ static struct ref_update *add_update(struct transaction *transaction,
 	size_t len = strlen(refname);
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
+	strbuf_init(&update->new_reflog, 0);
 	strcpy((char *)update->refname, refname);
 	update->update_type = update_type;
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
@@ -3681,6 +3720,27 @@ int transaction_update_reflog(struct transaction *transaction,
 	return 0;
 }
 
+int transaction_rename_reflog(struct transaction *transaction,
+			      const char *oldrefname,
+			      const char *newrefname,
+			      struct strbuf *err)
+{
+	struct ref_update *update;
+
+	if (transaction->state != TRANSACTION_OPEN)
+		die("BUG: transaction_replace_reflog called for transaction "
+		    "that is not open");
+
+	update = add_update(transaction, newrefname, UPDATE_LOG);
+	update->flags = REFLOG_REPLACE;
+	update->reflog_lock = xcalloc(1, sizeof(struct lock_file));
+	if (copy_reflog_into_strbuf(oldrefname, &update->new_reflog))
+		die("BUG: failed to read old reflog in "
+		    "transaction_rename_reflog");
+
+	return 0;
+}
+
 int transaction_update_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
@@ -4012,7 +4072,7 @@ int transaction_commit(struct transaction *transaction,
 			continue;
 		if (update->reflog_fd == -1)
 			continue;
-		if (update->flags & REFLOG_TRUNCATE)
+		if (update->flags & (REFLOG_TRUNCATE|REFLOG_REPLACE))
 			if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
 				ftruncate(update->reflog_fd, 0)) {
 				error("Could not truncate reflog: %s. %s",
@@ -4030,6 +4090,16 @@ int transaction_commit(struct transaction *transaction,
 			rollback_lock_file(update->reflog_lock);
 			update->reflog_fd = -1;
 		}
+		if (update->flags & REFLOG_REPLACE)
+			if (write_in_full(update->reflog_fd,
+					  update->new_reflog.buf,
+					  update->new_reflog.len) !=
+			    update->new_reflog.len) {
+				error("Could write to reflog: %s. %s",
+				      update->refname, strerror(errno));
+				rollback_lock_file(update->reflog_lock);
+				update->reflog_fd = -1;
+			}
 	}
 
 	/* Commit all reflog files */
diff --git a/refs.h b/refs.h
index d174380..0ba078e 100644
--- a/refs.h
+++ b/refs.h
@@ -354,6 +354,14 @@ int transaction_update_reflog(struct transaction *transaction,
 			      struct strbuf *err);
 
 /*
+ * Rename a reflog.
+ */
+int transaction_rename_reflog(struct transaction *transaction,
+			      const char *oldrefname,
+			      const char *newrefname,
+			      struct strbuf *err);
+
+/*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.
  *
-- 
2.1.0.rc2.206.gedb03e5
