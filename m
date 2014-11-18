From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 05/16] refs.c: add transaction support for renaming a reflog
Date: Mon, 17 Nov 2014 17:44:46 -0800
Message-ID: <1416275097-3616-6-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:46:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXs4-0004BF-46
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbaKRBpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:11 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:52315 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbaKRBpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:08 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so6251158igd.13
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2nCco+Ln8T/QNp/fLMfvnoQ7yllrTZu11bGjOAN3FQk=;
        b=L8Z7gGID9fl1FeCf+rE3by50u354ArMIKFKvCEggCWyKTTsjVKpwWBwjoPLK1ideL2
         VsgdNOrsjVpxxo82t3Lo1UB/uOEqcaZsXi4b9WzsQ3NsTGr6+caQKMPW1R7OU0F0W72R
         KK6yW5m0bbjN5etReFkq9bBNpgbYQCn8Tq72+D5s6DKX7iHU7fysRQSzhqOqqb8pi46e
         K/xl5tM7+dtt32tm8M7pn2GjHht0PD99Nd3zA/ldjKDVx/nmnFgrs/pE5ENm3hfEEE6N
         cdJDMLKOBBjeK950o1sm8U18BNtdIJRPuyjMsdA0YV3FsCMl9TGmMq2uE5wrIeVrHAHI
         7UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2nCco+Ln8T/QNp/fLMfvnoQ7yllrTZu11bGjOAN3FQk=;
        b=VQagaF5hpx91CLrHQ51cDfTFD+Cakb7m6NRNY6Brvow01JZw1YMlJn45h0Exl9omMv
         3t1kYBPwiX/A85eTgoRnm9dTA+VaWB8+J4uDGIba7OULWM42BwrVzj7xQmrP0oWBRMW/
         s05Ni/+1P+VEdp79mGMfZa1wxaSC6a0fPM9okJfNGgOWn68rXtmtc5vs7PVYbOUyS99H
         7/8bPxqOJ4rahlhtjfeSXsu3tqZBY5TgNwLw2+xH9/mZCM93dR/fUDzunGWh4/FqiiOg
         HfsmlHAJKsd2VOr0wHko6A3BfIAEmtHNkHgGlTQcRHAnbeFRcQO+ca4CHYUL8Ik972Xa
         FbdQ==
X-Gm-Message-State: ALoCoQnhyAdIuWClwF6QAN45ZcJcpxuZcyZQ9vFZnYh6iw4ElJValzwDdGHBfo4fCaBjsAHXaa9s
X-Received: by 10.50.134.9 with SMTP id pg9mr29966592igb.28.1416275108204;
        Mon, 17 Nov 2014 17:45:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id ik2sm6878464igb.9.2014.11.17.17.45.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:07 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Add a new transaction function transaction_rename_reflog.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 refs.h |  8 ++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 519bfed..c721184 100644
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
2.2.0.rc2.5.gf7b9fb2
