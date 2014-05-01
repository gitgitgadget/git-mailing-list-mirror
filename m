From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 28/42] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Thu,  1 May 2014 13:37:28 -0700
Message-ID: <1398976662-6962-29-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:39:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxl4-0001wU-UO
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbaEAUiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:52 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:58858 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbaEAUh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:56 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so798601obb.1
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QEu7CoukxBNpffZi3p+v4r7PWiMaRXVD66yRl5jteW4=;
        b=a5DoyLL83hNoJ8VEq8WbDBvkrtzq1MOErDQLMRmKKL+AGW+SohD+smfLxcI7lD42VZ
         ebqA1NLRS+qHbYgpgfuG1bBBWqmfc/4P2MHZ3KUVV0KEk2o5uRKGfid7Bv1MOmwQMWg+
         CW5QWzwqBHux+70LqRZYYKLfGa1VFM5Q9/3NVtCegB7zX/Buy6WB4aadHY9AwFVGNrNW
         ADQAo7KHcdV9aN+zo8nmRVv95Ar/Xw5sp2SqjqQ9FM/R06iXoSxmi8cEcslcgeYqqjlV
         Y6u2PBlVAGcq2HlYSC2RCtmOJp5Ebd/jDHklluQmYYfc/m6yeG51mms+0m8ku0/FON+0
         KLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QEu7CoukxBNpffZi3p+v4r7PWiMaRXVD66yRl5jteW4=;
        b=i4Ln2fJVEX8WrqJrnB8QClLeR4IWggcA7XFjkcspWTr2fJJmtqAwuzAD3Ot291X4Va
         zpLJAHG8rylMDY2wakPzuDdfrC6biLyVeQPCD987kEcHEHxh+ad5ahMdODgIAS0hDsRn
         ARXKh4v2qrok9sAWP+bdoYEH8PZ1C+aSgEBN2SWsUjV2K2DsjY8IT7Klxmcq6RlKLQET
         56LuCZVJHh3HwzrZ8iORxNDoxU5uAaFyQAqSn0UynDh8iFw2FAjbqpCK1dPuGvTm/JrK
         kNG4FnDo2se6aoELBQ9HbW2EV8idzd74A69jp0WW57IgKkKrHNkkrMNLc4y9CZl8CBH5
         1XYQ==
X-Gm-Message-State: ALoCoQksVp8apJCEOwUk3jo/Q1M+EgOwG6FjOANBmBR3IqGzUFYUs//CQXNyYEB6ta300zYFHdKC
X-Received: by 10.182.78.97 with SMTP id a1mr2978956obx.33.1398976676397;
        Thu, 01 May 2014 13:37:56 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538078yhe.3.2014.05.01.13.37.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:56 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3FDAA31C1CC;
	Thu,  1 May 2014 13:37:56 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0485FE097F; Thu,  1 May 2014 13:37:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247854>

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
2.0.0.rc1.351.g4d2c8e4
