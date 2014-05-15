From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 30/44] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Thu, 15 May 2014 16:15:27 -0700
Message-ID: <1400195741-22996-31-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tr-0007Dp-5O
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285AbaEOXRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:05 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:48387 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-ie0-f201.google.com with SMTP id rp18so390339iec.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LOnrTmGuFJX3K+YWvpku4O50zkQvNyVprx8LeHgSUdg=;
        b=SOuSAH6FHknHfBvW+y0APl3SXvAb0WlcQN6Qh3Xuqx5odPX1wBwGQlp7IQObDPhtaE
         ZkoG0NOC0Ms3KIqdYL0/wXVDO7unI4lqmsKoy3yR75yhNpUrm3OQAX6FmMqoUq7dFD4h
         mye42AmrxjqtC3D2v7PQ5b5zQ38iNDOyw54FNeTZ2ME1F7QRo9SnWsGJdU3r66LXLssG
         s8fpHaotGR1OVwAomTO12Ky5ljdDPZ9g0YLVgXshVrJ6QMFS66B7Ay0y8p3X0eZLZTWt
         rxl+JXtpdTei+RlS1mUbhRC9KM66wiBF0ZjvipfDvA/xxfuQrDUe6V6qn8e4YvGKzb5d
         pzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LOnrTmGuFJX3K+YWvpku4O50zkQvNyVprx8LeHgSUdg=;
        b=WQ5utV7jAYQVSmT4wuFgjzbPYToAgt9fY++wr8dS7LXYsEyC1K4kdntj0K0k5YrSAU
         zrULJio8VE22pj0FadmhK21I3Yi4DSqoRgAr7JKDCDp34M+4k1uuUCGRLOcZL0jLTzJt
         1gotGP/gnY3nKLMY0A2X0GAYzLidaRR4l9W46gVK/bmbJtzd87wLkZBqcBVT4ixJBRYf
         FJW2H5BYH8wsqqJWU9wj08NOMqsX0YWy3/AsOIi9LHpAc0HHYuY6QMKfeXYr2OwdJUjP
         U+H8ZEHzgAi4R0m5khu+9qgB1VuhyG/GiqOOPdwLia1u6UM30/RpIQ7uKi9TqQBuwjb2
         OmVg==
X-Gm-Message-State: ALoCoQlKWPnByEOpd2AYqpEq7UlKS89oiFUam1/4QbIcNKaXVpbzQyd7p5snVAe8kL4h0fPVY844
X-Received: by 10.43.141.196 with SMTP id jf4mr6021041icc.9.1400195745856;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si244840yhj.5.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AF54D31C1ED;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8D4B6E0B9F; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249248>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 733dfb3..3fb5cb8 100644
--- a/refs.c
+++ b/refs.c
@@ -3336,6 +3336,12 @@ struct ref_update {
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
@@ -3345,6 +3351,7 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_status status;
 };
 
 struct ref_transaction *ref_transaction_begin(void)
@@ -3368,6 +3375,11 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 void ref_transaction_rollback(struct ref_transaction *transaction)
 {
+	if (!transaction)
+		return;
+
+	transaction->status = REF_TRANSACTION_ERROR;
+
 	ref_transaction_free(transaction);
 }
 
@@ -3395,6 +3407,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: update on transaction that is not open");
+
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3415,6 +3430,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: create on transaction that is not open");
+
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
@@ -3435,6 +3453,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: delete on transaction that is not open");
+
 	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3505,8 +3526,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3569,6 +3595,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->status = ret ? REF_TRANSACTION_ERROR
+	  : REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.rc3.477.gffe78a2
