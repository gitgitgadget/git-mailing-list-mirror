From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 04/20] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Tue, 15 Jul 2014 16:34:02 -0700
Message-ID: <1405467258-24102-5-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFu-0003dK-60
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbaGOXex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:53 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:63520 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934032AbaGOXe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:29 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so21342vcb.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2Hs0FKzXxJhHHKoVYzdOKDv05evFBc36irC25csGIk=;
        b=absSYHWvbhe8XZgPT+UMa+sATNfVUnB91jwhrs3T4DgC1xYiwKCao2xLged5rIdE/K
         uyWkBWp2UPc5fUCvgYwNx+eCNEPTNiKhbeArM4lf0QSE+kKMlvObwXQ4xFnyfwqOqsYy
         fka8+aO7flBOjFmCFogPcXf79mj8BMnwvvWhBgM776xDDf8/DRXl1gK6YOcUhQLRR4qL
         Gz1bzlEw7wAjdXgGwjeK23Tf42xPA7qCYJW5C/OsMd0tqBQOVCOPaiLWbLKuHnnnxuWj
         b2l2mUXAAlyE4QZIazjGfUMPPOmCXS2tOkg8mm5QwmybXD0QhX87M7suOHtzpjQZrxTz
         r9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2Hs0FKzXxJhHHKoVYzdOKDv05evFBc36irC25csGIk=;
        b=XXD/aPJ40GsGlMdx5i4QxmpjWpLKE9pGBXGZPJcfIxMX+zyhqKeXBnJ3Hbk27GNVoH
         nXR1VEWTsMGfUUbWK7uX84zr5Y7WhSS8YSkofqcQ8dmwQCqUNP22a9xn9uIH2jZEms0X
         /lQntyshdI/ksr5HEDIZLd5T1SnnO/fU24KZUd5ZcNsXYvJkx8PO2XlYiGqtcaGJmQ4J
         AygYX/tPwGBM4KhrSCCVttrSMlAUEt1AegTe7X+pPCtEYaUTXnu99sd4fqwZzR+QpClx
         +epsxeYkeC/3YW20urqvo/WtpIErf79fMDI4ABnbKS9g/SxSFNxvSXtPOIxxisTUzqfz
         NynQ==
X-Gm-Message-State: ALoCoQlcf6rNwWNnZQHgs7odtYXDqFPzU6lfMomCkZ+GnStNTYrlVXrgx8sCEUUQd430SbFdeVAU
X-Received: by 10.52.116.241 with SMTP id jz17mr1271833vdb.9.1405467268498;
        Tue, 15 Jul 2014 16:34:28 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si1060899yhe.2.2014.07.15.16.34.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:28 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 320D45A425F;
	Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BABD9E0B27; Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253643>

Track the state of a transaction in a new state field. Check the field for
sanity, i.e. that state must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 9cb7908..d015285 100644
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
@@ -3395,6 +3414,7 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_state state;
 };
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
@@ -3437,6 +3457,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3457,6 +3480,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: create called for transaction that is not open");
+
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
@@ -3477,6 +3503,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: delete called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3532,8 +3561,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3595,6 +3629,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->state = ret ? REF_TRANSACTION_ERROR
+		: REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.1.442.g7fe6834.dirty
