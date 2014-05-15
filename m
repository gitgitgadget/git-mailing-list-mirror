From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 34/44] refs.c: make prune_ref use a transaction to delete the ref
Date: Thu, 15 May 2014 10:29:49 -0700
Message-ID: <1400174999-26786-35-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzV7-0000tR-7P
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbaEORbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:17 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:62710 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so637651vcb.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LwA5sP9JhC02uXjm692Q6jVkj4RdkfIkf5QJv0vZ7Jg=;
        b=pY6kXI/P8bfeDstOqVZOagrDTkMjTLVYIkQHXiVR/kzjMEi/LWLLKX+kbY3kekiuSG
         G0bO8QVKV7W+7QO1yS7BfEerjMiMF0Gg9hENMpq6yEf/rAsPItxDDhuQkTOGODzQEkHw
         zyXJ8870P0e7XcW5cPHDlBakKVOzC1vYg9SnfiYOLzeRg12yO1ssqV/BfezxssZ0VxL9
         gDf8xNcDLeD0XWQAGF1NpTFw71axbnLQXvEXfhRreIecCa488dlq+kQM4gaw7G3xE/2a
         ZkKKhIVELL9Jhi42Xeqx9XIKaPlzsv3do3t1gZmbkRpMj8Vtwh1Uf09R3y5hlMzA+amU
         G9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LwA5sP9JhC02uXjm692Q6jVkj4RdkfIkf5QJv0vZ7Jg=;
        b=Z5adz3OmA/plZus4F5rBBdytS7U9sUlpy1sjaDLFn9HOBfDo2MDGIk/+o8+UW/AivJ
         p6ipXVMPp2IO8Gg89XGD2O0dtSgAt7Jahhj6m2z5Tif5j9dCjFPVfWNEBr1rXLKMYr2L
         S7yhjPAzBS4IWE1YPMHSYGncwei9aqAI8V85/dU8pmWiVn/PoR0tAxEWDW+NyB1Rdx0U
         tqsO1IANjly8cothq5pWKrgywx0UL2Zt8SBdmp6XSfb5br8lde+I9CEZcDprCjXlIITH
         4XwHTK1ABMCpM5kT/9OHKEbR4KUl6kazwKMLvjVpPAagIEh3gqc6M8ab2dcwfRDGPQfG
         7vfg==
X-Gm-Message-State: ALoCoQk9ada0SfBlWSL7inSqXPOIYMBFix7IjLRgCQwNZB/6a8JUWzVUXa23ku77L+6xg+TwjM6q
X-Received: by 10.58.43.170 with SMTP id x10mr5408944vel.36.1400175007338;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si273668yhj.2.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 319055A428A;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0FAEAE038E; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249140>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index f1ef940..88ab012 100644
--- a/refs.c
+++ b/refs.c
@@ -29,6 +29,11 @@ static inline int bad_ref_char(int ch)
 	return 0;
 }
 
+/** Used as a flag to ref_transaction_delete when a loose ref is beeing
+ *  pruned.
+ */
+#define REF_ISPRUNING	0x0100
+
 /*
  * Try to read one refname component from the front of refname.  Return
  * the length of the component found, or -1 if the component is not
@@ -2326,17 +2331,24 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (check_refname_format(r->name + 5, 0))
 		return;
 
-	lock = lock_ref_sha1_basic(r->name, r->sha1, 0, NULL);
-	if (lock) {
-		unlink_or_warn(git_path("%s", r->name));
-		unlock_ref(lock);
-		try_remove_empty_parents(r->name);
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_delete(transaction, r->name, r->sha1,
+				   REF_ISPRUNING, 1) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		ref_transaction_rollback(transaction);
+		warning("prune_ref: %s", err.buf);
+		strbuf_release(&err);
+		return;
 	}
+	ref_transaction_free(transaction);
+	try_remove_empty_parents(r->name);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3512,9 +3524,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->lock->ref_name;
 			ret |= delete_ref_loose(update->lock, update->type,
 						err);
+			if (!(update->flags & REF_ISPRUNING))
+				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-- 
2.0.0.rc3.477.g0f8edf7
