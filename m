From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 24/48] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Tue, 17 Jun 2014 08:53:38 -0700
Message-ID: <1403020442-31049-25-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:56:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvjx-0005ko-Mv
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbaFQPz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:55:58 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:34644 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so1489369oag.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TX0bzIfJ+uPrQB6DCDNQ9N+izoagHIfi5DcHKWxJ8z8=;
        b=UDY37mIqNu/c/719P0ukgkBYk6ZSqt2b3D4qUSNE6o9Tl6ilji87yQ8Bk7u7NInuxx
         MjFDqQajAWy/Kyd+joqpd7zwuyqzLP1AKFnuWR8NwX25KojA2yXJ/3MR+cM/C2gmFQfD
         rfxHndNeSAads2vYOjBg+0RmpNCsou8Y1+qeUeuCtYHNFkRbwFhY1haJm954HXsmQbfL
         JIwbSH6CjBG7l59OmRMG7Nuy6WQ43PvZV7abq2Ht7OSQbBC0Hewg8VvLbwMPyOwroww5
         xE56aetjS/1vDSsEuqTWHxuQB0HIpTH/yKL4HjjOAMR6mf1/2lINaX2VfiXsY59dBCyV
         32YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TX0bzIfJ+uPrQB6DCDNQ9N+izoagHIfi5DcHKWxJ8z8=;
        b=dI0JQUTm4p9WK1uzITGQRjJ25OtACKMm4h/fNyWVZw57pJP0Wpsj4KttUFche/KCl3
         tJ41yEfc8Qd3T4Qn0q+e1kiFWbgwG5y/4nyMXos87tE+0/gEzfF79vpYvhmc5BJ+QH3z
         ptHrG84eflSxS5H0qCdCEUFOoF172zG9OfIFG4GcMAvPRdo3TbHKmDdiEEYyUb6dN9bO
         ILDI7D6I1dF81NnPKJ1xkTmTmncEZH9IzW5GipZj/ejDUAcrhDl1UR2EmLOE80Zc+oRX
         DxtO4ZMz61u2WByHjO/BnelUSl5C2xOfbLYyLUwJzvNogtsW9UwqEnKho00MiMxkvC1m
         vRDQ==
X-Gm-Message-State: ALoCoQlSSVkYXCpSVhzz/clZ5Qh8lSA+SLhyhkR+MMirOYOupXxM+XUoj9/XTT5AtkZLmQLR/Fwa
X-Received: by 10.182.128.166 with SMTP id np6mr1033169obb.16.1403020445357;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si1209157yhb.3.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0288F5A4367;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D4CD5E106F; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251898>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e2a035b..be29f66 100644
--- a/refs.c
+++ b/refs.c
@@ -3410,6 +3410,25 @@ struct ref_update {
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
+ *         No further changes can be made to a CLOSED transaction and it must
+ *         be rolled back using transaction_free.
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
@@ -3418,6 +3437,8 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_state state;
+	int status;
 };
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
@@ -3460,6 +3481,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3480,6 +3504,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: create called for transaction that is not open");
+
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
@@ -3500,6 +3527,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: delete called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3555,8 +3585,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n)
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: commit called for transaction that is not open");
+
+	if (!n) {
+		transaction->state = REF_TRANSACTION_CLOSED;
 		return 0;
+	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3619,6 +3654,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->state = ret ? REF_TRANSACTION_ERROR
+		: REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.438.gec92e5c
