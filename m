From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 05/17] refs.c: add transaction support for replacing a reflog
Date: Mon,  3 Nov 2014 11:02:07 -0800
Message-ID: <1415041339-18450-6-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:02:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMtp-0001Xv-7g
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbaKCTC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:27 -0500
Received: from mail-pa0-f74.google.com ([209.85.220.74]:59895 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbaKCTCY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:24 -0500
Received: by mail-pa0-f74.google.com with SMTP id kx10so1995341pab.5
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOvXeDFuGb5+WqPCd0JjS9tmoyv4TYmoeR0nuaLUdJ4=;
        b=ISkjZhUi9BF5PBwt6kqbXl67megkaQ+RBRbcLgPdHMVAKUFnKMcxr34N/UC1LpWdYu
         Rz2KifrkKpkzhfI3Zx0jAcPCTtGrjcTAXi5mVtlcMhI0yFkXgn7wnlx7TuQ5K1abi6ZE
         q7XMuetSlnpzNiF9Ht0q8Q+SgKrJ5up7FXZpuDrUMgeF1PmK4yUJtDSR9nsswrULnGTy
         dEDZQ9G4noq10IyjuafmmDskby578riPg66dHb0OrcVYT77w0Gz3kt33NPR89c/YgcKY
         6cOskExcvBTlcuDAmP32QxKeL7CRjSfsT5/m/lvIOIkghqSBi5JNICk9VWbSASbAG1PT
         2IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOvXeDFuGb5+WqPCd0JjS9tmoyv4TYmoeR0nuaLUdJ4=;
        b=f99r5egzJefxrZSXv2o1HR3Hw7sKpJt/pe66+OaMuR+/7kYoP8MOPnL6kE1jfFLkQG
         bKe7UWpiL3RM2agiFZcxQfcPWSe4O/h7XSv1iSXlg2+Ty8eyqegw+hl4wjrHEI1Fruyp
         efxdaKNjf6UCDBueecmAJt0AwTlw42HNBIrMHjYuku7tkH16coKG580goFKluziv1FZb
         xy6hMbfVsLkQImW9I//tXGG6fHRpw4nn0ngLI/8Xi+kqEwisZl6zfSQl7J1bci9UcSwi
         GBD8t8tnRH4Rkvgktfu0sjmvdaIwk3Q+TM4ORCrJ7YQMfwCpgpsuIYbx5h2XCLSSS28s
         d8Xw==
X-Gm-Message-State: ALoCoQm8FZDCenSMFwb9PBnoM0HhAtrcABPSXdmWOF7IHSiv8RVHzlpquwIpUsoYiRmZRypb135x
X-Received: by 10.66.119.41 with SMTP id kr9mr10025706pab.24.1415041343583;
        Mon, 03 Nov 2014 11:02:23 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id k66si973043yho.7.2014.11.03.11.02.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:23 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id UUJZjMYR.1; Mon, 03 Nov 2014 11:02:23 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A768FE0D1C; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new transaction function transaction_replace_reflog.
This function takes a blob and replaces the new or existing reflog with the
content of this blob. This will be used by rename_ref where we basically want
to copy the existing blob as is.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 38 +++++++++++++++++++++++++++++++++++++-
 refs.h | 16 ++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e9e321e..3d13624 100644
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
@@ -3561,6 +3566,7 @@ struct ref_update {
 	struct lock_file *reflog_lock;
 	char *committer;
 	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
+	struct strbuf new_reflog;
 
 	const char refname[FLEX_ARRAY];
 };
@@ -3607,6 +3613,7 @@ void transaction_free(struct transaction *transaction)
 		return;
 
 	for (i = 0; i < transaction->nr; i++) {
+		strbuf_release(&transaction->updates[i]->new_reflog);
 		free(transaction->updates[i]->msg);
 		free(transaction->updates[i]->committer);
 		free(transaction->updates[i]);
@@ -3622,6 +3629,7 @@ static struct ref_update *add_update(struct transaction *transaction,
 	size_t len = strlen(refname);
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
+	strbuf_init(&update->new_reflog, 0);
 	strcpy((char *)update->refname, refname);
 	update->update_type = update_type;
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
@@ -3681,6 +3689,24 @@ int transaction_update_reflog(struct transaction *transaction,
 	return 0;
 }
 
+int transaction_replace_reflog(struct transaction *transaction,
+			       const char *refname,
+			       struct strbuf *buf,
+			       struct strbuf *err)
+{
+	struct ref_update *update;
+
+	if (transaction->state != TRANSACTION_OPEN)
+		die("BUG: replace_reflog called for transaction that is "
+		    "not open");
+
+	update = add_update(transaction, refname, UPDATE_LOG);
+	update->flags = REFLOG_REPLACE;
+	strbuf_swap(&update->new_reflog, buf);
+	update->reflog_lock = xcalloc(1, sizeof(struct lock_file));
+	return 0;
+}
+
 int transaction_update_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
@@ -4012,7 +4038,7 @@ int transaction_commit(struct transaction *transaction,
 			continue;
 		if (update->reflog_fd == -1)
 			continue;
-		if (update->flags & REFLOG_TRUNCATE)
+		if (update->flags & (REFLOG_TRUNCATE|REFLOG_REPLACE))
 			if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
 				ftruncate(update->reflog_fd, 0)) {
 				error("Could not truncate reflog: %s. %s",
@@ -4030,6 +4056,16 @@ int transaction_commit(struct transaction *transaction,
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
index d174380..ec4965f 100644
--- a/refs.h
+++ b/refs.h
@@ -354,6 +354,22 @@ int transaction_update_reflog(struct transaction *transaction,
 			      struct strbuf *err);
 
 /*
+ * Replace the reflog with the content of buf.
+ * This function can be used when replacing the whole content of the reflog
+ * during for example a rename operation. For these cases we do not want
+ * to have to spend time processing and marshaling each entry individually
+ * if instead we can just pass one single blob to the transaction system and
+ * say "write this blob, it is the new reflog".
+ *
+ * When successful, this function will take over ownership of buf.
+ * Thus meaning that buf will become cleared from the callers view.
+ */
+int transaction_replace_reflog(struct transaction *transaction,
+			       const char *refname,
+			       struct strbuf *buf,
+			       struct strbuf *err);
+
+/*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.
  *
-- 
2.1.0.rc2.206.gedb03e5
