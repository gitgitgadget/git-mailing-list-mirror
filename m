From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 30/44] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Fri, 16 May 2014 10:37:18 -0700
Message-ID: <1400261852-31303-31-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6N-0001vJ-59
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757995AbaEPRjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:18 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:49223 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-qc0-f202.google.com with SMTP id x3so490027qcv.1
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JA9FDR5qJR31vqpkGx/UuEycKdrsCd8ufVLlEy9X7Jc=;
        b=OlB88rA4mtFtfDYN8XK9WJmuMcgNGqt4WPnS7DWCx5iisvRfGjTri7EqnQ/FVVHvAU
         HFLk6YYMmoCdGAvoxSq/10AMlBG7109ExFUcVvy8vPu+8RzMp0hlBobLYPiaZSZgadDl
         0mHC1QulBEMgI5vDvfal3512aw4cqMFP7TQCpXm3WIXzwvJk/Aj97bZgKw1IzxToFAzE
         47AZdLoLvkeqPxWD1IX/Eb1BMmMMbru6bwokeZsWQ3d5agBsViYoUwntWVCiV3Bccckg
         qEP2wog8hfm0Zd8Wf91r0XLRzgPoaaNJCwiK1kKX7h61WFO8RDeeZHTlHqOiZhmb6MvK
         LCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JA9FDR5qJR31vqpkGx/UuEycKdrsCd8ufVLlEy9X7Jc=;
        b=C5jmvLaVqUlfsKn4b1iC02xXelhSMsWY/hyxNE0HYc8hNUCzKG7hO8Zwgc4JgCP9kR
         e+1GXBPGRmarUlO1LjU7vrWXgkY4jSJkqkwT6RiPxekGsVSOPHZ19yEvrg6w3wykg0hS
         fylejNpc+qMFbMr4XzsDzlvhXtNrL2K38zBNFWOmoe2l6y/g2WZl7/OOsqPJo2qJOz0E
         vAYvrgRsONPyZF3JWk2cQFMLCNps4C2bLx4KVSW4beA38kv8DdUeP9d+AqXDmh77xe7h
         OL6MXi1A4T06obcDm+7bg9CbBWvtacWyOUmQEZQS/c97ocqA/eKMZELzIhY0SQyloiIF
         l1JA==
X-Gm-Message-State: ALoCoQk0wHTYf4oquNQglmfQsETs/72L9cdsDBYYxZDEx9v2nuLXPhLuU+oisQyUE75cJ9hlA8Du
X-Received: by 10.58.94.163 with SMTP id dd3mr1154577veb.29.1400261858080;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si442307yhk.4.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E983B5A427A;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C55E2E0746; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249383>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 2d9789f..4f7ae92 100644
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
@@ -3390,6 +3397,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: update on transaction that is not open");
+
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3410,6 +3420,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: create on transaction that is not open");
+
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
@@ -3430,6 +3443,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: delete on transaction that is not open");
+
 	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3500,8 +3516,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3564,6 +3585,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->status = ret ? REF_TRANSACTION_ERROR
+	  : REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.rc3.510.g20c254b
