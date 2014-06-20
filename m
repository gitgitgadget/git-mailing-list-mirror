From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 38/48] refs.c: make prune_ref use a transaction to delete the ref
Date: Fri, 20 Jun 2014 07:43:19 -0700
Message-ID: <1403275409-28173-39-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy03E-0001eH-1c
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbaFTOoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:44:14 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:47546 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbaFTOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:35 -0400
Received: by mail-yh0-f73.google.com with SMTP id f10so505793yha.4
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RtHS+qItHtYqLbbNmIi//8GuwH7Fp8ny2Xl6nigRVb0=;
        b=bVN5oZ5AYjDluROvX2ldf2IAKY/r0uiMiJC4jXJtonYVRPDectfa1gwQKyG+slur2x
         JByzmpPJEsEmWWfbo3+iT/gE0f/BrLwgoGFhQRn7nFuwZ9fdg1ANoQe/mF0ygtFtJArP
         FIn2cL5QuKtTrbdtG6hkDHBvKHU8bw0oZqoGSuJfBmXT6EBzalT2LsXmQzR8wQihBNRZ
         8M/aTSQ3DNCuGbMd9S4CI4/w6pKlPiGaI9GZvFxi2ejgQ6Ul+CvelsE6EhdBTojZ3/IT
         Ibx10RjyC/Q4uC+59BmAN2vFTWpY6LlQhjB6o/DLrKWYGE13jeugKbJA1TdWcpDFnxQx
         GPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RtHS+qItHtYqLbbNmIi//8GuwH7Fp8ny2Xl6nigRVb0=;
        b=QgWCLmnFAzCF11FRGNz2niGdF+Ssb5jIfTz5i1R/taeX5BYf6VNcW5YDuN6x3XbPlG
         XAFYh7IIspnTOoZ27SNUV3ORR86ppel+dI/DDg5RJ9rOZwKSwpDa6YQNdN2BVEets8Rm
         ped1rL/Pk1caJmChpmeE2nL99wfHKHwACe9cdlVvQSnP9zyWQiELYM6holDwkyI2WQ7L
         wwf1GIFbuHZnvsQFBkRY451TbDekF0iLc1Qfzx9RpAtbqkkXtZDksLN9MJrTY3C0MvyX
         NlZUS3BN6g6jZ+ofkBur0C2AiUrF7fqFgLNmgISX+iu2a/hwDl+naSAyo0a1VBNAkAZ0
         p7JA==
X-Gm-Message-State: ALoCoQlJuF6rU+0XVJCDPu+hdyj4Hg/Cxa9dXcXN4itCrshihIx3Qbru3k9LewMZnPJOfpJkOsDY
X-Received: by 10.236.134.49 with SMTP id r37mr1313934yhi.14.1403275413817;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si664712yhb.3.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9FFC831C6B5;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7A1E9E0961; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252239>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 27 ++++++++++++++++++++-------
 refs.h | 14 ++++++++++++--
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 699f1f6..3d070d5 100644
--- a/refs.c
+++ b/refs.c
@@ -25,6 +25,11 @@ static unsigned char refname_disposition[256] = {
 };
 
 /*
+ * Used as a flag to ref_transaction_delete when a loose ref is being
+ * pruned.
+ */
+#define REF_ISPRUNING	0x0100
+/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -2379,17 +2384,24 @@ static void try_remove_empty_parents(char *name)
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
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, r->name, r->sha1,
+				   REF_ISPRUNING, 1, &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return;
 	}
+	ref_transaction_free(transaction);
+	try_remove_empty_parents(r->name);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3599,8 +3611,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->lock->ref_name;
 			ret |= delete_ref_loose(update->lock, update->type);
+			if (!(update->flags & REF_ISPRUNING))
+				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
diff --git a/refs.h b/refs.h
index 4ac4a7d..3b321c2 100644
--- a/refs.h
+++ b/refs.h
@@ -177,9 +177,19 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks any ref (for 'HEAD' type refs). */
+/*
+ * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
+ * ref_transaction_create(), etc.
+ * REF_NODEREF: act on the ref directly, instead of dereferencing
+ *              symbolic references.
+ *
+ * Flags >= 0x100 are reserved for internal use.
+ */
 #define REF_NODEREF	0x01
-/* errno is set to something meaningful on failure */
+/*
+ * Locks any ref (for 'HEAD' type refs) and sets errno to something
+ * meaningful on failure.
+ */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.0.0.420.g181e020.dirty
