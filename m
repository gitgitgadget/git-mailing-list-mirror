From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 06/31] refs.c: add a transaction function to append a reflog entry
Date: Wed, 14 May 2014 15:13:05 -0700
Message-ID: <1400105610-21194-7-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhSH-0000ZF-DP
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbaENWPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:15:06 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:57658 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbaENWNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:35 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so442382yhl.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=26tCp1+jtraXp6pgCugnRgOcyJZVSg9AVxKInnMYXWY=;
        b=IYvS1C2vjsJ9z/+WU8VSz2d8bgauSsoqwqtRBA7aYJOGjioG56+MgrYCZO4QsU3Opp
         9twxP9rT+H5Zamfnvtk46M/qjS5Fz6atrgCnJ5+d+SWrCb6LLxPUDvxiacHCxRR86PjI
         s3iC4H5cn99Mah4wajl9OT1FwbNaF3pY5kpHyYgiiFb0RMBmxU9wEqYxJTAa6kgRcfP5
         uIh6/rLFu7D8/cNSd+yJeFsGTn+ypKSQCQeflb8GExElssksG6qpFdviG3cELM2je5bi
         SECBsoAqKaX5MtrM9aoe0TGbs26TBHWP/TNtxtm0hilqdOYtznY9zW57mQ+1MaA6VYTg
         DWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=26tCp1+jtraXp6pgCugnRgOcyJZVSg9AVxKInnMYXWY=;
        b=PfOoXlGbxc0R3HdFxTr8NvtqEt7NrygVIBMdcuQr5bULKwG9RNr4d4U756VUQZCWT3
         viIwG0jx74HIY+2LqMYZNjJlg/gh55gVeU4tc3tjFIx15IrMLHYFAuXWvYGbrowCMGxv
         mz3wZd5lPYcBIX72aX0xK0JKqsS+hVGWds3HPOFDfqmJP3o6zQX0dAZR+Dqp2eYMDsZ+
         RMBYs9eJdDRUF/xRxYyI3CZ5G4WAoy99jtJKIDoJR5FzSevzCgykHWx0OTIvIjBK4yPn
         QJhldcBtzTb62EYbEqBMF42h+6FsrewG9rkimy/emOrxHWi7mYHf1S8srMjjQHfH80kX
         JGYQ==
X-Gm-Message-State: ALoCoQn2QUbkKMP/jCEI+75oSJKUKbp9CtzR87cCa5ez0sWmTPfLeWzuczF5dYCKzMKH20MIjnz/
X-Received: by 10.58.168.137 with SMTP id zw9mr3291192veb.15.1400105614553;
        Wed, 14 May 2014 15:13:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si150747yhl.7.2014.05.14.15.13.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 575045A41E5;
	Wed, 14 May 2014 15:13:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 03311E0CB6; Wed, 14 May 2014 15:13:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249034>

Define a new transaction update type, UPDATE_LOG, and a new function
transaction_update_reflog. This function will lock the reflog and append
an entry to it during transaction commit.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>

Conflicts:
	refs.h
---
 refs.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 refs.h |  13 ++++++++
 2 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 98c6c00..d8a1568 100644
--- a/refs.c
+++ b/refs.c
@@ -3249,6 +3249,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 
 enum transaction_update_type {
        UPDATE_SHA1 = 0,
+       UPDATE_LOG = 1,
 };
 
 /**
@@ -3266,6 +3267,12 @@ struct ref_update {
 	struct ref_lock *lock;
 	int type;
 	const char *msg;
+
+	/* used by reflog updates */
+	int reflog_fd;
+	struct lock_file reflog_lock;
+	const char *committer;
+
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3300,7 +3307,8 @@ void transaction_free(struct ref_transaction *transaction)
 		return;
 
 	for (i = 0; i < transaction->nr; i++) {
-	  free((char *)transaction->updates[i]->msg);
+		free((char *)transaction->updates[i]->committer);
+		free((char *)transaction->updates[i]->msg);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -3331,6 +3339,38 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
+int transaction_update_reflog(struct ref_transaction *transaction,
+			      const char *refname,
+			      const unsigned char *new_sha1,
+			      const unsigned char *old_sha1,
+			      const unsigned char *email,
+			      unsigned long timestamp, int tz,
+			      const char *msg,
+			      int flags)
+{
+	struct ref_update *update;
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
@@ -3440,6 +3480,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 {
 	int i;
 	for (i = 1; i < n; i++)
+		if (updates[i]->update_type != UPDATE_SHA1)
+			continue;
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
@@ -3479,14 +3521,18 @@ int transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->flags & REF_ISPACKONLY)
 			delnames[delnum++] = update->refname;
 	}
 
-	/* Acquire all locks while verifying old values */
+	/* Acquire all ref locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->flags & REF_ISPACKONLY)
 			continue;
 
@@ -3506,10 +3552,32 @@ int transaction_commit(struct ref_transaction *transaction,
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
+			const char *str = "Cannot lock reflog for '%s'.";
+
+			ret = -1;
+			if (err)
+				strbuf_addf(err, str, update->refname);
+			goto cleanup;
+		}
+	}
+
+	/* Perform ref updates first so live commits remain referenced */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
 					     update->msg);
@@ -3528,6 +3596,8 @@ int transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->flags & REF_ISPACKONLY)
 			continue;
 
@@ -3538,6 +3608,36 @@ int transaction_commit(struct ref_transaction *transaction,
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
+			rollback_lock_file(&update->reflog_lock);
+			update->reflog_fd = -1;
+		}
+	}
+
+	/* Unock all reflog files */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->update_type != UPDATE_LOG)
+			continue;
+		if (update->reflog_fd == -1)
+			continue;
+		if (commit_lock_file(&update->reflog_lock)) {
+			update->reflog_fd = -1;
+		}
+	}
+
 	ret |= repack_without_refs(delnames, delnum);
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
@@ -3688,4 +3788,5 @@ int ref_is_hidden(const char *refname)
 			return 1;
 	}
 	return 0;
+
 }
diff --git a/refs.h b/refs.h
index 127c12f..2e22a26 100644
--- a/refs.h
+++ b/refs.h
@@ -134,6 +134,7 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
+
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
@@ -269,6 +270,18 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 			    int flags, int have_old, const char *msg);
 
 /*
+ * Append a reflog entry for refname.
+ */
+int transaction_update_reflog(struct ref_transaction *transaction,
+			      const char *refname,
+			      const unsigned char *new_sha1,
+			      const unsigned char *old_sha1,
+			      const unsigned char *email,
+			      unsigned long timestamp, int tz,
+			      const char *msg,
+			      int flags);
+
+/*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem. If err is non-NULL we will add an error string to it to explain
-- 
2.0.0.rc3.506.g3739a35
