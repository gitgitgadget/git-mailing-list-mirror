From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 16/41] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Tue, 27 May 2014 13:25:35 -0700
Message-ID: <1401222360-21175-17-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:28:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyh-0004zy-BP
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbaE0U1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:37 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:46446 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so1919781obc.5
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ssgSr9nEjXHHd1nbFKsfzW5ktzYIzA5x9gegvD25IsI=;
        b=TPIDa2gEzQZJ5nLAOEYUcelM2MrOmTjTk9dR7tP6JcQ/IfIOr84gNq3rbb56VYgr+z
         DXPh/gfAuKqTLJ7iGzrzTciAWXGDf0cwZWFZVDwZn/LDxtrgiLj4kmSf5X2n89ESJaTa
         9+e/39MWOG1+IoqXtAJDHKBgWa/PTPJmQH9tslBXnQAgFFTPsyGVywBKBa9mjKuwtzYX
         hmZBSoNgyPZgY6dPb/9O3CRvBtToDbxCOTp2spw9Y4LQcY0fC30sU6lkDtPUB/dOQ50G
         sM1GkaOIYqODp0jVRItlVQq2+oJwfnIGsko9kLT5ZTSf7tPIKoFF6yYBlr/hY6YNM1d8
         /uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ssgSr9nEjXHHd1nbFKsfzW5ktzYIzA5x9gegvD25IsI=;
        b=MINQKFy8S+b/hdizwjp1XG8vvEJWodg5vniWSTtarb9rjOzB5xoLdWcMJrUL3DuNUY
         M3HPX2gpNa9LQ2SPjHJxDDtYIV1/7bv9hfVSCL8RW7qttC7c1ie3JfJHcYM2BZbuXCYO
         +SZK9OBWNsutOjgEkUS4E7A7DXHqIALXSf6t8zm5pfVB282/X3hZ+jEbefRfIqlSsoxg
         8THSB8nHyMtGKY32s0V/4l0V1JOM0vwli9s6VI15956uV9GjTd+Nk8u4uFOTDiLOaFcK
         yZbY0l+qtBGH3iNEjsXMVv7eaTSn9tcSBlmJ/6EfJCPunlaAMdbN3qP1eLXv5LimiQL/
         8joQ==
X-Gm-Message-State: ALoCoQmYbumuKS991r9vVl5unWJAxqJ4oNdMLFaMdAkosSVBZ4b2jTLmekahze6oNd21ys4/gsgb
X-Received: by 10.42.94.8 with SMTP id z8mr12620673icm.3.1401222364492;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si1575167yhq.3.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3DA5A2F4AD1;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E5A81E1AF5; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250230>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1c660e0..9992da4 100644
--- a/refs.c
+++ b/refs.c
@@ -3335,6 +3335,27 @@ struct ref_update {
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
+ * ERROR:  The transaction has failed. No further updates are possible
+ *         and any calls except free will return an error.
+ *         An ERRORed transaction can not be committed.
+ *         An ERRORed transaction can be rolled back and discarded by calling
+ *         by calling transaction_free.
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
@@ -3343,6 +3364,8 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_state state;
+	int status;
 };
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
@@ -3385,6 +3408,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		return -1;
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3405,6 +3431,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		return -1;
+
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
@@ -3425,6 +3454,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		return -1;
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3480,8 +3512,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3544,6 +3581,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->state = ret ? REF_TRANSACTION_ERROR
+		: REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.rc3.474.g0203784
