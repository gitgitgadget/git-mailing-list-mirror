From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 09/14] refs.c: allow multiple reflog updates during a single transaction
Date: Mon, 17 Nov 2014 17:35:45 -0800
Message-ID: <1416274550-2827-10-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXiN-0000Hz-DS
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbaKRBgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:36:14 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:57230 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbaKRBgG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:36:06 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so6256302igd.7
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fdj6sqAeL5ETtO7zz1toQoNkow7Ul98am6kB2ENFQCs=;
        b=hI3d7f4fU1+Aweb/CvmNLlyU+MW03gUbc0WKCaCDwff4FrTZKS/s+miBl1zRc3Bfdm
         T7KRQ4B5+r8Vp7IUqQLe7z700epFSvC//owzh/InumxmiugATgxAOjW7/BSVj/003zoX
         kIZk4VBhE9szIBflNhONrPdMbJv+K4dWtJ6QJCXENSk+kdLZDvNFtMK1dv3oPWC1uV8S
         nOFD1hiV6vqeIDaSuvHH63055EUNgZZVDOmbQlQtIS3bDuiwAiuUa5VYAGC6XWsePYxU
         mUBKxbSI006lmjBvxw9UBPkfwIbJMnrwRM3hPffypzi1hpnDbO15+qFjgbCasaIm6YAl
         9gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fdj6sqAeL5ETtO7zz1toQoNkow7Ul98am6kB2ENFQCs=;
        b=B/2o7wJmljDkcZpPqnGZ3JJWHqgxXxjFtvvW8c5fnkS6XIpBASg1feACFc/nZJmMlN
         TycvlDPW7UbZPFXe/bSl+FhsVyTeI8ArxJtg4tHQu/++uagfDm5hYC9Ud2pQPvBPn+gG
         PFFds1voXs5xLh6Ggx4XF6dC435s/aoPQvcZ34bU8KACCJlPrbxcAg3GFdsCUwFb3U8y
         VmvzCs9y9dt0XXMsLHuaXOydYivbFVJCWwx058QvG1OfG4tqEH7RcxRXhLHseRdDEnr9
         1lwWPU6pgS5h4yB5SIGnVdODHh1J/0R8+WnKQFA+0nVZBNq2OjqGlhhf5FR6OF9NUOSQ
         KGJw==
X-Gm-Message-State: ALoCoQnoe4JhTAwNSqLdXSDw9KKdycve3IiGc78OxsFHSVa1dPoyzB581u3HV6pjnM98AeLakw02
X-Received: by 10.43.127.73 with SMTP id gz9mr31005725icc.6.1416274566188;
        Mon, 17 Nov 2014 17:36:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id l62sm19779154ioe.42.2014.11.17.17.36.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:36:05 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Allow to make multiple reflog updates to the same ref during a transaction.
This means we only need to lock the reflog once, during the first update
that touches the reflog, and that all further updates can just write the
reflog entry since the reflog is already locked.

This allows us to write code such as:

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

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 3572977..0fb4196 100644
--- a/refs.c
+++ b/refs.c
@@ -31,6 +31,12 @@ static unsigned char refname_disposition[256] = {
  */
 #define REF_ISPRUNING	0x0100
 /*
+ * Only the first reflog update needs to lock the reflog file. Further updates
+ * just use the lock taken by the first update.
+ */
+#define UPDATE_REFLOG_NOLOCK 0x0200
+
+/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -3521,7 +3527,7 @@ enum transaction_update_type {
 	UPDATE_LOG = 1
 };
 
-/**
+/*
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
  * while locking the ref, set have_old to 1 and set old_sha1 to the
@@ -3531,7 +3537,9 @@ struct ref_update {
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
@@ -3539,8 +3547,9 @@ struct ref_update {
 
 	/* used by reflog updates */
 	int reflog_fd;
-	struct lock_file reflog_lock;
+	struct lock_file *reflog_lock;
 	char *committer;
+	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
 
 	const char refname[FLEX_ARRAY];
 };
@@ -3619,11 +3628,26 @@ int transaction_update_reflog(struct transaction *transaction,
 			      struct strbuf *err)
 {
 	struct ref_update *update;
+	int i;
 
 	if (transaction->state != TRANSACTION_OPEN)
 		die("BUG: update_reflog called for transaction that is not open");
 
 	update = add_update(transaction, refname, UPDATE_LOG);
+	update->flags = flags;
+	for (i = 0; i < transaction->nr - 1; i++) {
+		if (transaction->updates[i]->update_type != UPDATE_LOG)
+			continue;
+		if (!strcmp(transaction->updates[i]->refname,
+			    update->refname)) {
+			update->flags |= UPDATE_REFLOG_NOLOCK;
+			update->orig_update = transaction->updates[i];
+			break;
+		}
+	}
+	if (!(update->flags & UPDATE_REFLOG_NOLOCK))
+		update->reflog_lock = xcalloc(1, sizeof(struct lock_file));
+
 	hashcpy(update->new_sha1, new_sha1);
 	hashcpy(update->old_sha1, old_sha1);
 	update->reflog_fd = -1;
@@ -3639,7 +3663,6 @@ int transaction_update_reflog(struct transaction *transaction,
 	}
 	if (msg)
 		update->msg = xstrdup(msg);
-	update->flags = flags;
 
 	return 0;
 }
@@ -3822,10 +3845,15 @@ int transaction_commit(struct transaction *transaction,
 
 		if (update->update_type != UPDATE_LOG)
 			continue;
+		if (update->flags & UPDATE_REFLOG_NOLOCK) {
+			update->reflog_fd = update->orig_update->reflog_fd;
+			update->reflog_lock = update->orig_update->reflog_lock;
+			continue;
+		}
 		update->reflog_fd = hold_lock_file_for_append(
-					&update->reflog_lock,
+					update->reflog_lock,
 					git_path("logs/%s", update->refname),
-					0);
+					LOCK_NO_DEREF);
 		if (update->reflog_fd < 0) {
 			const char *str = "Cannot lock reflog for '%s'. %s";
 
@@ -3891,7 +3919,7 @@ int transaction_commit(struct transaction *transaction,
 				ftruncate(update->reflog_fd, 0)) {
 				error("Could not truncate reflog: %s. %s",
 				      update->refname, strerror(errno));
-				rollback_lock_file(&update->reflog_lock);
+				rollback_lock_file(update->reflog_lock);
 				update->reflog_fd = -1;
 				continue;
 			}
@@ -3901,7 +3929,7 @@ int transaction_commit(struct transaction *transaction,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
-			rollback_lock_file(&update->reflog_lock);
+			rollback_lock_file(update->reflog_lock);
 			update->reflog_fd = -1;
 		}
 	}
@@ -3912,9 +3940,11 @@ int transaction_commit(struct transaction *transaction,
 
 		if (update->update_type != UPDATE_LOG)
 			continue;
+		if (update->flags & UPDATE_REFLOG_NOLOCK)
+			continue;
 		if (update->reflog_fd == -1)
 			continue;
-		if (commit_lock_file(&update->reflog_lock)) {
+		if (commit_lock_file(update->reflog_lock)) {
 			error("Could not commit reflog: %s. %s",
 			      update->refname, strerror(errno));
 			update->reflog_fd = -1;
-- 
2.2.0.rc2.5.gf7b9fb2
