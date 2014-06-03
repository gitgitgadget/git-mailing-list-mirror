From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 16/41] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Tue,  3 Jun 2014 14:37:34 -0700
Message-ID: <1401831479-3388-17-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:42:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwT5-0007ro-S5
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965420AbaFCVlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:46 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:54360 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934196AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-ie0-f201.google.com with SMTP id tp5so1464376ieb.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=127mWai8UkVpEeej2Ycx2VPfsINYbCaSMWTvS514vm0=;
        b=ijdH5MEU2TqEw8F6bdof1tuR9OBSaNj5i72Rqgvn940nx4tpscaUOGX7ZnZo7x1ENM
         R3TpDNS7eqjJf+oXUNzQnmkZ1ryl2hxu0u8kBkR8V3iVUS+aAdGRklHJNJ18c7OmsYBj
         qsKvHHtmLtJ1OfLPa7bbUzcEtWwj4PX4XZtfsRqe2/E9urXfST2ZTRgRq151K4sylZr/
         gpARUgLxxP0kjul+zdfW2OMjizME+nhuc9BwvkiY9+xQgYTwIjxfk+0v2AYxvmSGL7TL
         xlmMaCFAie0sC6erlCtQ6IuMUZZXpYv1zHBJ09Co9j4M36zrUcMgenA9k2W6m1WzuGap
         00vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=127mWai8UkVpEeej2Ycx2VPfsINYbCaSMWTvS514vm0=;
        b=SUa0HXkSM2nuVWt15W7on3lKgjBLhaLIrMIBHrtArgl3I9X6C6Vp9rsI+o7J3tU60+
         r/eZkHZxIx5cG+vilnEsofnC5rwdt+DW+jTVR04uX5UkQvYNTHCxhLPr2MuW0KhjN3IJ
         Euyi8nF6eYX96cj9pQxgdHZ0Q5PvJzPVXhDYCI+9oM40vQQRa3eNYDQl/iFydJhG46o+
         /moidWr5ONMt56rf3LQJMQUkgpWzg8fiV4Dp1PEmwveWkAB6l6GB/uFCtFdKdYfLcDPB
         seZZs3qAdDACrLGApgcOwaCaaUyaC1M/BKBkFxMJuCkULhNX/q48XCfWo17xCecv06BX
         IuwA==
X-Gm-Message-State: ALoCoQmNkkdauJLXEO+jS/SOCgqsx+RprNY2qA3yXGp0HWbHk6gtgWHfXk+icSfI74v1yIhJ/96l
X-Received: by 10.182.226.166 with SMTP id rt6mr8315928obc.47.1401831487632;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si28349yhl.7.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 520B931C425;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2B585E06DA; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250679>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index ee87eda..dd98202 100644
--- a/refs.c
+++ b/refs.c
@@ -3377,6 +3377,25 @@ struct ref_update {
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
@@ -3385,6 +3404,8 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_state state;
+	int status;
 };
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
@@ -3427,6 +3448,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3447,6 +3471,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: create called for transaction that is not open");
+
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
@@ -3467,6 +3494,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: delete called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3522,8 +3552,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3586,6 +3621,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->state = ret ? REF_TRANSACTION_ERROR
+		: REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.567.g64a7adf
