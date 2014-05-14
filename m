From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 28/42] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Wed, 14 May 2014 14:17:02 -0700
Message-ID: <1400102236-30082-29-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgag-0006Pz-Kk
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbaENVTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:19:42 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:60898 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbaENVRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:30 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so36231pab.4
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mrpD8sBdzGaWU22vmRgRjJPPoEa1pe9oIzNI6SpxQE4=;
        b=asThExq0skra+x+Y9zqf6PY0IhyD1CwsqQaSmXEhnPJLvUVE+u4E5skq7Jw0/pcAh7
         K7QPohQd7U9irQBzjjsNdPYEXIriN0ku+8JE0NcaxHtdMj64kAAOtunJZ3KU10s2Wr1G
         IaXdjnPm+g0qSnZDGs5LRfpaou4beVaAnoBepi/MI8xDzYww7fz445arcj7RGhP0lqPt
         f9JU0nJ17WwVDtq8K64huQ0+NGaLt6qlnGeD9II6TDcGxpPF0FqkAmR1lShikOoSn9f2
         SiSyzFkbhbmlcFRP2lrMcqn9koRrJflrvUhXVIQxqQeMyAWCZj36re3GsBnEJsvLkd/3
         iyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mrpD8sBdzGaWU22vmRgRjJPPoEa1pe9oIzNI6SpxQE4=;
        b=VL8cs49jJUkIwmGFpNSs7OUMD3iOLjd4ir+Q9TIVfqegMljhkfec2rVLEjB4PZh+My
         8cdRfPha75syCzth+BrTBWiIm2gRPRyU8t6guK2ErAQ+D3bgczMrYElRNlZzOalkhA+h
         uStV3CZ0bQqNmjMqqWzJMLqRafazWZTb4cvoyOo/Daxtojr/mFWq+PwQ9cyJ+gZUQEWI
         Od9O05qFpRWisSVd3RzCi1L7+DJU8Pmnn2KZ3D//7EUUoKhGbLkaY+VhJgeZdvWESRJ1
         xEaZu86e1t7DmI8jeXZRIQ7DfMVa7MTdQ1gD0uUlxBa5D2IdtrKV8yJE02bHQkDraTPd
         VoJw==
X-Gm-Message-State: ALoCoQlN0cw9SyWPfjTPYrUjsToQuruWswHCQ0o4KejCKkDNxlYl53pGneB/tIyFPjH7tYjm9xji
X-Received: by 10.67.5.165 with SMTP id cn5mr411723pad.9.1400102249509;
        Wed, 14 May 2014 14:17:29 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si145203yhk.4.2014.05.14.14.17.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:29 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5525E5A42DA;
	Wed, 14 May 2014 14:17:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 18CCCE0973; Wed, 14 May 2014 14:17:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248974>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index b7fa79b..38193f1 100644
--- a/refs.c
+++ b/refs.c
@@ -3297,6 +3297,12 @@ struct ref_update {
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
@@ -3306,6 +3312,7 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_status status;
 };
 
 struct ref_transaction *ref_transaction_begin(void)
@@ -3329,6 +3336,11 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 void ref_transaction_rollback(struct ref_transaction *transaction)
 {
+	if (!transaction)
+		return;
+
+	transaction->status = REF_TRANSACTION_ERROR;
+
 	ref_transaction_free(transaction);
 }
 
@@ -3353,7 +3365,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	struct ref_update *update;
 
 	if (have_old && !old_sha1)
-		die("have_old is true but old_sha1 is NULL");
+		die("BUG: have_old is true but old_sha1 is NULL");
+
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: update on transaction that is not open");
 
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
@@ -3372,7 +3387,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	struct ref_update *update;
 
 	if (!new_sha1 || is_null_sha1(new_sha1))
-		die("create ref with null new_sha1");
+		die("BUG: create ref with null new_sha1");
+
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: create on transaction that is not open");
 
 	update = add_update(transaction, refname);
 
@@ -3391,7 +3409,10 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	struct ref_update *update;
 
 	if (have_old && !old_sha1)
-		die("have_old is true but old_sha1 is NULL");
+		die("BUG: have_old is true but old_sha1 is NULL");
+
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: delete on transaction that is not open");
 
 	update = add_update(transaction, refname);
 	update->flags = flags;
@@ -3463,8 +3484,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3526,6 +3552,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->status = ret ? REF_TRANSACTION_ERROR
+	  : REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.rc3.471.g2055d11.dirty
