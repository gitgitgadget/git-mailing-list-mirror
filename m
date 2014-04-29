From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 28/30] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Tue, 29 Apr 2014 15:19:13 -0700
Message-ID: <1398809955-32008-29-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGO6-0002jC-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965324AbaD2WUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:04 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:62033 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965291AbaD2WT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:29 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so205584oag.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J7lLmfwfhXxfqrPgN8QzD4hDSmKebZzAfsLRvpXa8K8=;
        b=hlit5xplJfU+RLXbW0Aujf7oP4D/1HID5Lzxjksdo4rgzzKMw7HexJJJl8PY80uDpQ
         uE+EiGF7CULjcMgWfofZOroRBgZw3zQaUucqgW6NU+v9cLntTWkCNPX5AFPEQWoxmLVN
         YgSWOe2lz6k+1o8Ua6GigT2LgZMHFHjS8OR339I5HhI2rNdeYvDYGeG7wEBN7hYSj0Ug
         TzLPw9zSm+sfmsKJ0IwYlQss1DB730fywdD9I+m/m3DTjCMqVBHfeBa33DDEO5CV2Z8p
         UhoK74Noy+l09PMvPEbkv1tAIZU9ddzO+MaaMI5rLDDNvVvRv7OiAL04UXexYpXjyw/l
         id5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J7lLmfwfhXxfqrPgN8QzD4hDSmKebZzAfsLRvpXa8K8=;
        b=B4rSdWkvBoDlP0pDWM0YPFjUEqTuKSiBQE+kephS+91cJwv7z5BSvrn7gHVayZkoVe
         oBVqePcJdWz5DPgBdt4gVPQo7mr90CyHXoLZFkhYR++3ednEKOSrmO0uowzDqM8alIBw
         MqqtXSbljVX3djxzPZwvs3oWcidfiEjhj/B1zcGaoBj4oSUBdQoYsDon/nr+NmYhxC3K
         sHI/vcaS6OyeaPlgWy74wZFbIm7X5AtVc4Qnk0nqwIPL5jc3kveLueLGyVJpFX2ACPlN
         zHT+b2oe/lWVuqcLCjnCpzcowJTDNa5pQ1oj3CrI58jsrJIylGj0YwTOZ2ETynQLjoya
         0vHg==
X-Gm-Message-State: ALoCoQkxLpkWZjP1Yu7yq9iMc8tsVViY9bx3UvpDmZYBg4eW90OEQgt4W83MzmNgrEe83lOtzfrdygOM6ipMtBOq5V++ZgJB+qHKwCN6cBRgv960WTIngY1uV4P/BsUcCXkfgQyuWeiI16N8qjEFVIVK3uFpbYvqFZkTgN5N3GSCqouXFV6+NbACMxoEMg80iaWE3Txv7NnO
X-Received: by 10.42.39.210 with SMTP id i18mr273913ice.19.1398809969042;
        Tue, 29 Apr 2014 15:19:29 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si2738520yhb.6.2014.04.29.15.19.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:29 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C433B5A4121;
	Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 89082E0A5B; Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247640>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index a82d6ba..206e1a2 100644
--- a/refs.c
+++ b/refs.c
@@ -3288,6 +3288,12 @@ struct ref_update {
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
@@ -3297,6 +3303,7 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_status status;
 };
 
 struct ref_transaction *ref_transaction_begin(void)
@@ -3320,6 +3327,11 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 void ref_transaction_rollback(struct ref_transaction *transaction)
 {
+	if (!transaction)
+		return;
+
+	transaction->status = REF_TRANSACTION_ERROR;
+
 	ref_transaction_free(transaction);
 }
 
@@ -3344,7 +3356,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	struct ref_update *update;
 
 	if (have_old && !old_sha1)
-		die("have_old is true but old_sha1 is NULL");
+		die("BUG: have_old is true but old_sha1 is NULL");
+
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: update on transaction that is not open");
 
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
@@ -3363,7 +3378,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	struct ref_update *update;
 
 	if (!new_sha1 || is_null_sha1(new_sha1))
-		die("create ref with null new_sha1");
+		die("BUG: create ref with null new_sha1");
+
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: create on transaction that is not open");
 
 	update = add_update(transaction, refname);
 
@@ -3382,7 +3400,10 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	struct ref_update *update;
 
 	if (have_old && !old_sha1)
-		die("have_old is true but old_sha1 is NULL");
+		die("BUG: have_old is true but old_sha1 is NULL");
+
+	if (transaction->status != REF_TRANSACTION_OPEN)
+		die("BUG: delete on transaction that is not open");
 
 	update = add_update(transaction, refname);
 	update->flags = flags;
@@ -3454,8 +3475,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3517,6 +3543,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->status = ret ? REF_TRANSACTION_ERROR
+	  : REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
1.9.1.532.gf8485a6
