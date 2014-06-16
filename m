From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 39/48] refs.c: make prune_ref use a transaction to delete the ref
Date: Mon, 16 Jun 2014 11:04:10 -0700
Message-ID: <1402941859-29354-40-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:05:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbHP-000402-32
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbaFPSEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:04:44 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:62396 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so766260vcb.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HrxEUVxulSAZjgVW2GDhAIqhAmoKYX/CB5MZtKTPr9g=;
        b=ivdi2b8CiJvfLNDBhnIdCaw9ttFDQM/mXIrwvfRCnFmzKT0Ubd6392sl7Xb7f+nUKs
         BZ1kHcDQbH14u9mWEgJkxpYGB0xAv1f09d8B5GTTrXVcOiItlYD3tssDMmgnyQ1dZ38Y
         TbXme0Yax8HTeOxfTNGhgZixu01XdgVt/mkbAA7NDwShHjRlIO3G/dGwOUdQbucQsGlp
         w5PqvB+Jb4vZMHdF3Zgfyi/WhOX0d0SS6pHP+57TMOvTBiulDbk/37B04s1zQk9QRo4S
         gWEh0ahYqEe9xD8mWnCg0C0DiRxugRPhNQbyQZooQlMd/JCbmZsKxZJNLIWgqDH45O0x
         wsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HrxEUVxulSAZjgVW2GDhAIqhAmoKYX/CB5MZtKTPr9g=;
        b=YIYZkHAu16fXhpErx0dzLEeNFOuObIKDEHfg4IfkObPLDUgGMaollcO6n2fFZxdqZc
         YLRb6XH7qMrftfZ3IwcmAhrvzV7TgLIVgPOSGo5gVD3FO4Flii+bnaEE9tRWQgf4sGwF
         dpRJd/hCNfehEP6Lu3GpqjEYCeT0Rz0txuwilxf2DSsQrfnBdFiLAevSkssJMGgyvJPv
         jXrlxvvN7ptBAWLybaPCv+h6CY8oaRQMyZt9QG+AwyGx1I9vQMXq3JNZfpr1z7oNSyVn
         gpfw8WyaSRQL4m3qVPcrM+jpCha/DquYkeDMJKpUWYMF77Dzr4qCzRbhzZc8F7MlGNSU
         /D0g==
X-Gm-Message-State: ALoCoQnU1wej7PMDXc17+5nG3bl8Emmu7ACiIvbIYONEWObew44tU3tHoTbf4NocYCVZlpb+VcgF
X-Received: by 10.58.227.10 with SMTP id rw10mr1608090vec.39.1402941863926;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si996136yhl.7.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C27EB31C8AA;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9F1A5E0D03; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251747>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 28 +++++++++++++++++++++-------
 refs.h | 14 ++++++++++++--
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 6c3e34c..94fda74 100644
--- a/refs.c
+++ b/refs.c
@@ -30,6 +30,12 @@ static inline int bad_ref_char(int ch)
 }
 
 /*
+ * Used as a flag to ref_transaction_delete when a loose ref is being
+ * pruned.
+ */
+#define REF_ISPRUNING	0x0100
+
+/*
  * Try to read one refname component from the front of refname.  Return
  * the length of the component found, or -1 if the component is not
  * legal.
@@ -2352,17 +2358,24 @@ static void try_remove_empty_parents(char *name)
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
@@ -3593,9 +3606,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->lock->ref_name;
 			ret |= delete_ref_loose(update->lock, update->type,
 						err);
+			if (!(update->flags & REF_ISPRUNING))
+				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
diff --git a/refs.h b/refs.h
index 21ec3f9..b3c6fa6 100644
--- a/refs.h
+++ b/refs.h
@@ -173,9 +173,19 @@ extern int ref_exists(const char *);
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
2.0.0.282.g3799eda.dirty
