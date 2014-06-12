From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 24/48] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Thu, 12 Jun 2014 10:21:15 -0700
Message-ID: <1402593699-13983-25-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8iq-0008N4-R4
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbaFLRX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:29 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:39487 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so246105veb.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38wscQfJQgoCWPlapnG+m3O2u2J3FktZe4uLuhjuMwQ=;
        b=mv9f84+UalfegxeCoxk/nlGTEWZWakC18aJ1YC62njajy98Lr+u9MlXL93cs5GqouL
         BTuteYIyZ9lug05tgXL7pWqPf0UJIUQnHMFZehWkKg55PN3n3iP+DCQFIlNi0MlC/YCx
         MNfEykteHjIUUBlFCV7aLWbaDIR+kwbBpOyAE2AVDoC3/IOO3AjnzNOGsvEYKOs9bNAP
         /QmjrAyXgGE3GA1rDcwYtLJxaR7WfcdAr4igOOVJZIeKOLNupupSgUrljk8tzaS9ekbz
         FWeAXjFxdWAqxgKDNA742onLHGN05EOu61CJBWJoqOnXg260+pB/XCy1bI/xiUoQ80gc
         H8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38wscQfJQgoCWPlapnG+m3O2u2J3FktZe4uLuhjuMwQ=;
        b=fIUmJTCqvWomHoinTvJqC2lYh85dSPHB8/pUI+cof2fmGNg0isiw9yYthRwGdSstMg
         L9eo3e/cGShrX2IRZe7phSWdNODaTzMOeFdcL2k45bNtzdGG9nvZ5VkT2/cdjYNPkSqE
         AGgOiwpdTXpVJJHjEd9cY/yerB4ZcGyzFwvr0ccZIF5rEdFhXbB2jHkaTNeoe+ivMtbp
         lTSn8ykrO4tOhSKhYAJCUdHDpXnffia6bdI/waIqmhI1sQ7OMjz4M/cPxVp/gkhrHopQ
         diRePjFjRamJJHBAm0beFhlmeTlcOkwMvPuibUUWkR9i7xc4blUKAdRHSdPSEgZW1Rmc
         38yA==
X-Gm-Message-State: ALoCoQl5ArvQrCA9V8y0h0vQAdJ+KxCX0NheBq5QPC4ZvMNORLg0kI5JfgbhPVhuxdCeq2uLPtez
X-Received: by 10.58.182.137 with SMTP id ee9mr3441458vec.37.1402593703827;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si113015yhb.3.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 88C955A4749;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 674A1E01A0; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251448>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 8c29af0..8523c39 100644
--- a/refs.c
+++ b/refs.c
@@ -3384,6 +3384,25 @@ struct ref_update {
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
@@ -3392,6 +3411,8 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_state state;
+	int status;
 };
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
@@ -3434,6 +3455,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3454,6 +3478,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: create called for transaction that is not open");
+
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
@@ -3474,6 +3501,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: delete called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3529,8 +3559,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3593,6 +3628,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->state = ret ? REF_TRANSACTION_ERROR
+		: REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.599.g83ced0e
