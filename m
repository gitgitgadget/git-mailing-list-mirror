From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 23/48] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Fri, 20 Jun 2014 07:43:04 -0700
Message-ID: <1403275409-28173-24-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05F-0003jx-GS
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbaFTOqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:12 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:33409 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-yh0-f73.google.com with SMTP id f10so505523yha.2
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OOKABHGjPzH4+oBOS91eL1zNxNQJDq3sOLYXgVUfTgo=;
        b=DzQWSOTcOaDVmv0+Dn94mbCGe7+gsjEZ/v3NH3z6FVtdr/WbxUlnp0RlnWg/B/4NFo
         1jYS/OThwPt7UDRl9SR+M7C5aNGfyXflQlqdjifAzlK8AH/h8+vthjlaAPTyPHz2GA1u
         /BOE5FB98701uKAJTyrzatscZSPod+M5Eg5QFDl0V0d/Z4MTwNGyMZ5FFHsVc6u2u0mv
         WghGBSj/Y5v8+hHXo6dQ4JWWH5OsQOWltuxeCSP3KgtD8oZESD/xDe/+W6m7YMRyy8Bi
         1HVYnOQyuAJ+fsI9MIIFpjY2jBzve6nPGKoSuf0t7FkL0z1UGr7vW+KFZ/TVhavLemlF
         HHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OOKABHGjPzH4+oBOS91eL1zNxNQJDq3sOLYXgVUfTgo=;
        b=lQEZrDDgv4S3al9aGjqnn5Gf53KhO1Ypdhbh3yHSRny9sVIz/nCKg1wUVl8XurdjfE
         w/PUmsh7tqmlgoABqgiHwwtAK4JJAT5gwQB7J6DT1CaiGvEGOYruG8yAq1zu82iSYG6H
         QoHDgwPO4753/k5bAlwfkIRNri/DwsdJ4LL+3RlGZnA9RCNEtqSWB2gRztHq/5/8CyP+
         grDwx5+ZUdn9zHdSwYt95Bq5mO5af7N0tSa78mIue7hrc/cDmKS7Y3p7NhBjBxAkfNc+
         Q156hYh3dq0dc/oiiuzUqww16AF/OBOK9iBYqeaXcJI1mNIb6/Lk0ZJwSQNK1cHuwbCe
         DPlw==
X-Gm-Message-State: ALoCoQlVc9df4lOP4GiFxnwEznGEQZalRLEBBEANNaQN2/RxheK466qS9Ppr9KbCca2VNI5TS2s7
X-Received: by 10.52.121.13 with SMTP id lg13mr1308326vdb.8.1403275413165;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si663238yhl.7.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DB1B031C6B1;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B7625E0ABA; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252258>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 9cb7908..8c695ba 100644
--- a/refs.c
+++ b/refs.c
@@ -3387,6 +3387,25 @@ struct ref_update {
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
@@ -3395,6 +3414,8 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_state state;
+	int status;
 };
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
@@ -3437,6 +3458,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3457,6 +3481,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: create called for transaction that is not open");
+
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
@@ -3477,6 +3504,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: delete called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3532,8 +3562,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3595,6 +3630,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->state = ret ? REF_TRANSACTION_ERROR
+		: REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.420.g181e020.dirty
