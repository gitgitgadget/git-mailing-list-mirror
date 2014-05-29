From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 16/41] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Thu, 29 May 2014 09:07:45 -0700
Message-ID: <1401379676-9307-4-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2sF-0006K1-54
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757526AbaE2QIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:05 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:57416 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-ie0-f202.google.com with SMTP id rd18so105623iec.5
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48sAlzbSmVGKAif3F11yvCJJGjk+enesr99mYCu6gpU=;
        b=BDIrb0d2A4O6z0g2CChUqpZx3muv4TCrVKA8QHe9cO0UXocgNFy7UqxP/XhB27i7sq
         21LuB2sRKYy+y/7XL4AEorTwe39jqs1ZQ/VYgT4XNEVmRS2j9CZI2NlW+lV5+Lq3GOZU
         UcxyvyW95nhrIB29NuxbLlPyZ8MTBe3A/M5qZ4Eidr8gewPyx7hrxCkX4GucpMxVJM+S
         +LR/7FBQ2COeQRmP+Pn+7/PdUs4MCC7kaPLI+yD1YDpa5gPCd9LM+WMgM84JuZcnj2UE
         TNbwJugX4f7Hjs5AqtibDDe0Spjofa2wLLeiG2OmKmJ9M9diXv+2lMrzm5wFFzWE7TyL
         4V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48sAlzbSmVGKAif3F11yvCJJGjk+enesr99mYCu6gpU=;
        b=T6qF9cLH6QMxzEHko7ISruzzzcmOS0lY5GCWhl9A2UWkyAEohT4pP03nlCsK1kQpdC
         JyYTJMgs+jr4pQz4OllZcqy8G8kOMaeclDdTlRobHMQ0Nmf4cvDid9RIcqUu2ogVDxuj
         B90wQ9Akeycvzs2+UavjMfAi0cO/svDW/xQ3jT202Mvr08Pb98B9wIFmF3IQQjbD82OE
         Ii/6FZ5Yczw8vmoR5oAzzZxLyhHqm4vBba8Im3n0TWy2tJIEapKSrQrw1OqMdnWbVnXW
         GPKCxQxGdGiqs1DmQ/kCCAzVdh+vB7CIrF/YJLYgttJV9ze8L+3yq5IOJMuWjjE4VsKM
         1IjQ==
X-Gm-Message-State: ALoCoQl2OhHBP5WFJ8Qi6Il+imKycfJ66ORLUwHdPgZtkUeD3teCn231+rRQy5M5n5kv4N1dcCdw
X-Received: by 10.183.11.102 with SMTP id eh6mr3351304obd.37.1401379679306;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n59si80700yhi.6.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1DC525A4351;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C2432E110F; Thu, 29 May 2014 09:07:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250375>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index b5186cd..00d8fc9 100644
--- a/refs.c
+++ b/refs.c
@@ -3331,6 +3331,30 @@ struct ref_update {
 };
 
 /*
+ * Transaction states.
+ * OPEN:   The transaction is in a valid state and can accept new updates.
+ *         An OPEN transaction can be committed.
+ * CLOSED: If an open transaction is successfully committed the state will
+ *         change to CLOSED. No further changes can be made to a CLOSED
+ *         transaction.
+ *         CLOSED means that all updates have been successfully committed and
+ *         the only thing that remains is to free the completed transaction.
+ * ERROR:  The transaction has failed and is no longer committable.
+ *         Eventhough the transaction can no longer be committed it is still
+ *         possible to add additional updates to the transaction. The reason
+ *         for this is to allow a caller to continue trying more updates
+ *         so that a caller can report a list of ALL updates that would fail
+ *         instead of just the first update that fails.
+ *         An ERRORed transaction can not be committed and must be rolled
+ *         back using transaction_free.
+ */
+enum ref_transaction_state {
+	REF_TRANSACTION_OPEN   = 0,
+	REF_TRANSACTION_CLOSED = 1,
+	REF_TRANSACTION_ERROR  = 2,
+};
+
+/*
  * Data structure for holding a reference transaction, which can
  * consist of checks and updates to multiple references, carried out
  * as atomically as possible.  This structure is opaque to callers.
@@ -3339,6 +3363,8 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_state state;
+	int status;
 };
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
@@ -3476,8 +3502,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n)
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		return transaction->status;
+
+	if (!n) {
+		transaction->state = REF_TRANSACTION_CLOSED;
 		return 0;
+	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3540,6 +3571,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->state = ret ? REF_TRANSACTION_ERROR
+		: REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.rc3.474.g3833130
