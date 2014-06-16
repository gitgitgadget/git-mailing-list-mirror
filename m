From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 24/48] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Mon, 16 Jun 2014 11:03:55 -0700
Message-ID: <1402941859-29354-25-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKG-0007JM-SB
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbaFPSHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:14 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:44826 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932645AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so854680yha.3
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EgHGYAPhEyQasR26YgQukCBPFjKJvCWmEotEzQNwJts=;
        b=F9cQ6W34Butz2bWO5hDAX1cMaV9jrW49HqW/tOJYxl54mFIMCWGowhkBbWWQUhLI7S
         9weYA2DJEFZGiiJzMxWDWNZsqWOC9eZWN6NUdNza5KKQJ6oCL6dvIYKQLhqDYg4JA2AG
         DD7rACUmVecEOQNye/99k6H/qUhbgTWYBV/785ctUdt7OHZZ/wEmdPYisgzuvfawJaZ8
         By0xSreWlhjn6tujdjZ2XafEdRy6ltNFjrns2Oq5IHGJE5ehBepLBL/hUnmcCmwUWw1y
         EPqStbZiXCsAC/bZOFboBRDcvejERlmAo1VNUdmay0vwMrqS36rJoYso5RdlMq1ZjYti
         M+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EgHGYAPhEyQasR26YgQukCBPFjKJvCWmEotEzQNwJts=;
        b=dCXx6nDye4N7r1PHlH0wbWmzXwqT8WlDteAmcb+QyS7s0p+SYF2ewSTiDYvjIkzDjt
         VMQrlfEVRDOHaT+ZHwLuAnUol12lwzj2ZtwyJ9g/y2dlOh8OZQ7Wbwo3hAgCOovOWhma
         d+N+XeDw02abL9PoZrCteKr9c6cUcMzxRy/kmEjZuuDn+aL5P/Wb2UmE7raoCTIWK3wv
         PTgMSVcWowVYtHtIJiFCmVXtcnlGalAOFVjG2YAmZ7nAS+3ufBPfUwYGzEZj2CPdiNRM
         yqSJ39AemzOiBMIvlI3PM4grmVSDrWPUfBRQRHQgNUp5Uv4f1PSH+3oS8dUjjysG6YPE
         n/Xw==
X-Gm-Message-State: ALoCoQn+JaHZd+TS1tVIhzfeAlBxQ9qX/Qr5BKSEfuAlDl9oEvRhSjd/NMnJ4LA4ZREMMuSGgRaO
X-Received: by 10.52.175.3 with SMTP id bw3mr1327755vdc.5.1402941863230;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si997795yhb.3.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 03AF131C8AD;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D463BE0961; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251777>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 4937754..b75523f 100644
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
2.0.0.282.g3799eda.dirty
