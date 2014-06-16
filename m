From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 07/14] refs.c: add a transaction function to append a reflog entry
Date: Mon, 16 Jun 2014 09:51:38 -0700
Message-ID: <1402937505-6091-8-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa8u-0002pd-RI
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbaFPQwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:08 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:56461 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbaFPQvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:51 -0400
Received: by mail-ve0-f202.google.com with SMTP id oy12so458584veb.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/aam+hXdqS4J8y0d/tQDlwLoowLcfNN5hwV6Jl11OXM=;
        b=a2cJR9Jw+W7SbS4mGnIeCLgJRQApmrMDzr5wyPbTLrNeRdH2r+pPSJ5TrUxVTfu64+
         kM9ylyfJl7udKfrANNGBmtupXrMpbcdEp0XocxpmS+gUOYVz/8ZiL/tEOv2bGg425Q24
         nsWyFPueCDLFOD3ALD7OQ2HLy095QADDM6J1UsvhiEfN+DXP78yjndxLEpdXxZ00f1Um
         ABiOVGMwrxY9mxI9q70OrMrlsHbbUqkytVBETfdd8Eh2i0F83HsiWwvtbWrWnQax6otG
         qC3a5E42msWwuubZjEcVmugoQcg2MmA72nE/nqP7b9d9n/wQTjfdNegkx8w5PhzCgGuh
         EoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/aam+hXdqS4J8y0d/tQDlwLoowLcfNN5hwV6Jl11OXM=;
        b=WouRkPonKxgQy2eFx8APOf/pKC1DWb5duvCYX47VcROLHzJWAc6nmzr1hvPk8dqyTG
         4guF6wOW7wYAyG0jvhxTRBjyA6lkqyV82Nughtlv94g6EKFXF3WgT3ITnhH3xYs3HCG2
         QsQ/tu07qmwBSy677qrtM91cgjNQxSWaJoJRevxuvngAc2y1OZHxphgw6yrFMGQgxXqd
         zIbRwWREsodZbJUiePKoQ82Ef+skK1t7OHrUC8VmDsHa9uAG7nIfwih5h2+yP2eLoZp9
         c7Zce0mOnQbt2fgC2G687R+giXnLKSZvPEoAx+cj2yr7qUxPcGgI37avHpYCkh4KXb1O
         dtQQ==
X-Gm-Message-State: ALoCoQl5WNubHHUIis5bGfIsRiOfuGL7035NhmDIo2nI/Kj9Ltbr4P77mYaGp0xRCj70UHpU4kdU
X-Received: by 10.236.123.68 with SMTP id u44mr5713197yhh.19.1402937509796;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si982741yhp.6.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 97EBB5A47AE;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2D19AE12AA; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251724>

Define a new transaction update type, UPDATE_LOG, and a new function
transaction_update_reflog. This function will lock the reflog and append
an entry to it during transaction commit.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 refs.h |  12 ++++++++
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e951f34..9db5896 100644
--- a/refs.c
+++ b/refs.c
@@ -3410,6 +3410,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 
 enum transaction_update_type {
        UPDATE_SHA1 = 0,
+       UPDATE_LOG = 1,
 };
 
 /**
@@ -3427,6 +3428,12 @@ struct ref_update {
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
 
@@ -3476,6 +3483,7 @@ void transaction_free(struct ref_transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free(transaction->updates[i]->committer);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -3496,6 +3504,42 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
+int transaction_update_reflog(struct ref_transaction *transaction,
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
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update_reflog called for transaction that is not "
+		    "open");
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
@@ -3662,7 +3706,28 @@ int transaction_commit(struct ref_transaction *transaction,
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
+				  strbuf_addf(err, str, update->refname,
+					      strerror(errno));
+			goto cleanup;
+		}
+	}
+
+	/* Perform ref updates first so live commits remain referenced */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3698,6 +3763,40 @@ int transaction_commit(struct ref_transaction *transaction,
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
 	if (repack_without_refs(delnames, delnum, err))
 		ret = -1;
 	for (i = 0; i < delnum; i++)
diff --git a/refs.h b/refs.h
index 07bd621..5f4deef 100644
--- a/refs.h
+++ b/refs.h
@@ -327,6 +327,18 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 			    struct strbuf *err);
 
 /*
+ * Append a reflog entry for refname.
+ */
+int transaction_update_reflog(struct ref_transaction *transaction,
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
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
-- 
2.0.0.770.gd892650.dirty
