From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 06/14] refs.c: add a transaction function to append a reflog entry
Date: Mon, 17 Nov 2014 17:35:42 -0800
Message-ID: <1416274550-2827-7-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXiY-0000Mh-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbaKRBgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:36:11 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58991 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbaKRBgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:36:03 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so3656561ieb.37
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZubYpm4EHgACF0bzO9a+oP3u7esXdiKI3t9QD7A8AXA=;
        b=AWDq4H9TL+lZ7fu1qgAAGPeFItklFyDWKvZ7M36/Noxrde9SzNPzCXkidBAdr1lGjW
         BFUhap1+SunwAJ9WSu9wutAdGUk3gkhSz/jUcvExMcm6w2jZHcS9kKnriGGQamvYgilQ
         M0gEuZZXbFYuuxoBtNFQi8LKUguO0VefIOW4VovtXgSrW3kC37XXjmnCaoslCzcc1wul
         iMYPkXJGkMQXVny7GRsiOW8mY9oTEkVJo/6fZk4ZVAGxQtNLbOuIlSCFGbZ86g7H00eQ
         YQtF4RZZfGL/sbIrIbtGR7SuJtXuJukJVn+iWYHgociAaoWmqzhOpxx0sXcu0LWhmXdh
         Lv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZubYpm4EHgACF0bzO9a+oP3u7esXdiKI3t9QD7A8AXA=;
        b=WWO5BL9LUQCIBQU3DZX96RH8WTBwrFOk8jsZRlFeN2qLe/OdsgVqH0opJI87PlVG/e
         Z+S4i9T00EcBC0adMX7X9Q7pItmR0h+JfoRf5kS6LQa5ubInNKPJaZIYfCsmG8Rzez0j
         VGroTO6o41b9s7BCmU2JcCbXe/Hol6HBQjnubMMOnEbZHCY6p7fzcAF0gmX6Ithj9q+J
         2K1HQaXLwglwoeUOk9k1bOQfZfMTIMWooCCnHveowOw3oKO6iH6KQgTGtS5RwI4XQ6uM
         Rx1jscHc5gr4ZkIP9qDs3uYlumthiKvV8a8jstToj4/w3exmT891JuLXafLvSoQQkEaX
         IExQ==
X-Gm-Message-State: ALoCoQl7CwJ2MviEOorkzPZO8lAzBlxzE02DRYfwm/Rm38fETibWMOK6CNZ4vVqMgy5HTk4w8X2C
X-Received: by 10.43.127.73 with SMTP id gz9mr31005486icc.6.1416274561821;
        Mon, 17 Nov 2014 17:36:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id a4sm6863931igx.10.2014.11.17.17.36.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:36:00 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Define a new transaction update type, UPDATE_LOG, and a new function
transaction_update_reflog. This function will lock the reflog and append
an entry to it during transaction commit.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs.h |  12 ++++++++
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 84e086f..9a46e1c 100644
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
2.2.0.rc2.5.gf7b9fb2
