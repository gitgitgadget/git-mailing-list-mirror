From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 30/44] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Thu, 15 May 2014 10:29:45 -0700
Message-ID: <1400174999-26786-31-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVq-0002Gy-Na
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769AbaEORbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:47 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:61663 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so636161yha.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FYRBqlRD3Rormk0B6JitAqnGvVADtu9jpWRqlKrnu1k=;
        b=heZsB67cciHpn5E9OCIjsykNpG7Q8vg5tdgSA54k4028ZvE7Cq7BRWKGbJ42Xoh741
         0FChm/WANYyq2WcfedUebRPbRGOhNfdQarNHxSlWxzXeMqqftMPYicWqkZUKD1dTVHQs
         NEIvIPEuARSfzUCNdFpYwsOCEJPJ0ybKHWRvqgKLZo83TaapGCelxrCm874nbVNU+1Oa
         H31FjgjaXjD0VveVfIjE69sZhhycQMTeMV/3bAErnTGVVPhRIffaVWSdocX/AKwcoiYk
         uQ8E4PWKi7smRg+kRsXJ421IQYBPClbnSPzLO7TybxOXFTBKIfIkkbJYWopTxHEUyFUc
         cFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FYRBqlRD3Rormk0B6JitAqnGvVADtu9jpWRqlKrnu1k=;
        b=BMNEeWo7xb1Cg8+KJhu9MwilebU2fMhPxOqas96rHiqvPZQO3O/gNAIF6Pqj2BXyIQ
         rpd+6i7aNA6nlnzQXtKC5tdJHkec7g9yac2sLhJMawN3XFbZoDtkFoVHWG19fhGsMhnS
         tQJ39+qkqrzSEQBtMNZ85LtFMN9wxRblG1j73Pqu8vYci6txKxRpZj/Mg40J0Yslp8N8
         Wn0k8bwx4bqtzjgHa6O6yfMCzsmFVQlQS8AAFbtKhYyjRVs7hZvCfC4PRlNVdOPNsvoj
         0sPTH/6lnBaMJ45tccdT+DPALk/cEiqBq0+8xxjFjWz9WiRvrs3W8WEzr6oUbfvqhJcD
         sTDw==
X-Gm-Message-State: ALoCoQkLhtbs4dzyZCORuoNd7BbdRFFays6AB/LEnL3EOeVj4LNhmo5mXADiHeotAcHQj5HLnPGu
X-Received: by 10.236.36.33 with SMTP id v21mr4669522yha.53.1400175007119;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si273453yhq.3.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id EA4685A42E1;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C585AE11CC; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249154>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 600f9b3..f11f832 100644
--- a/refs.c
+++ b/refs.c
@@ -3308,6 +3308,12 @@ struct ref_update {
 	const char refname[FLEX_ARRAY];
 };
 
+enum ref_transaction_status {
+	REF_TRANSACTION_OPEN   = 0,
+	REF_TRANSACTION_CLOSED = 1,
+	REF_TRANSACTION_ERROR  = 2,
+};
+
 /*
  * Data structure for holding a reference transaction, which can
  * consist of checks and updates to multiple references, carried out
@@ -3317,6 +3323,7 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_status status;
 };
 
 struct ref_transaction *ref_transaction_begin(void)
@@ -3340,6 +3347,11 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 void ref_transaction_rollback(struct ref_transaction *transaction)
 {
+	if (!transaction)
+		return;
+
+	transaction->status = REF_TRANSACTION_ERROR;
+
 	ref_transaction_free(transaction);
 }
 
@@ -3366,6 +3378,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: update on transaction that is not open");
+
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3385,6 +3400,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: create on transaction that is not open");
+
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
@@ -3404,6 +3422,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: delete on transaction that is not open");
+
 	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3474,8 +3495,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n)
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: commit on transaction that is not open");
+
+	if (!n) {
+		transaction->status = REF_TRANSACTION_CLOSED;
 		return 0;
+	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3538,6 +3564,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->status = ret ? REF_TRANSACTION_ERROR
+	  : REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.rc3.477.g0f8edf7
