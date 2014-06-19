From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 23/48] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Thu, 19 Jun 2014 08:53:05 -0700
Message-ID: <1403193210-6028-24-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeg8-0007mr-V1
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933410AbaFSPy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:58 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:42405 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so694427oac.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8vuM9HKZ3caRW1EsEZQzh5S8PAn6k8w8yzut2h+50HE=;
        b=YAMEeeEvenirZ5UeXlQr9TUb/jQYUEighKkgkZ/nehorQKW9SHJIPiqVNaXRaA7F3A
         ZYXAfqtpa3dndu2rV5hMB0ngmfSmWkgYqdCCqs8PS6AQrBULqWzIT8r3LJOi7T4jsqz+
         afmMrhzcUm92gdRr/WuKqVOggoBw4tlTYAPSvJnkOrV69J/WW6ZNi+lTv4O3951fE1AC
         cu/zcJSx9jZCP9YPdVI6qOIF4La9E/BYjta7Mqhpv11VsSDy+1jxu7gjlNDKu1Vf14mG
         3vI7pi77FhASr3EqXi4yphaaYQalaANr4zITEtwcWe9dGnkbsPfMts8xRYIUnUG2S8AC
         cA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8vuM9HKZ3caRW1EsEZQzh5S8PAn6k8w8yzut2h+50HE=;
        b=L+nADdRpt0A+DgMFHso23F6KDPWQr7zsXPMY+QYIWydFVJZvZ/fligj8E/5gJxi64X
         44j5ZYuxWJ84knS+4iAXWmU8MKpngvcK9RksXnXhFvmnJNUQyC6fX4WigTEF/UPL29lm
         TGyzyqzLyt0BG/tgtVYagraoQbyKDrelaiU4FlZt6Yb2ctaVGBD0Owdh+E9AJbkL6wqd
         B3XcYcqo8Ly90dylSg3t7Yyk7srga13VR/TkoUKNKCUWFccAkerY9fPjedFq2IB2mseW
         Wboqr9YgjUVqcRb7w67YL5R39hvIiGFI1usDoc2aZftt3rOiZM4xXI7Qj4oN1oydY9F1
         nMZg==
X-Gm-Message-State: ALoCoQn6Kb13fgEiC8+XLqcwLOCZ0/rTwa83G41UsWlR0LbKiBNc0LW/Al9yED0Ouddw+FTHwUWb
X-Received: by 10.182.28.102 with SMTP id a6mr2753771obh.44.1403193213616;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si419899yhb.3.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 55CB55A4552;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 33B17E0ED7; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252136>

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
2.0.0.438.g337c581
