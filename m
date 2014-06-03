From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 31/41] refs.c: make prune_ref use a transaction to delete the ref
Date: Tue,  3 Jun 2014 14:37:49 -0700
Message-ID: <1401831479-3388-32-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:39:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwQp-0006Kv-IC
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbaFCVjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:39:20 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:53672 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934271AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so1372685vcb.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=orgGUdnBcRbH2zL5mXq+7BHl2AUu7JXKB8LfcIxwnow=;
        b=IjkDSVMN2xT7X88spQpSGuF44f1U74u/u1ZJUiHFmfN2ueUfT4dQTKA4Qbw0DOp7ZZ
         +10dxmIqST3qiuYncwxxsHGSDpldeYnq+hJ+XCVKelNwWVNJ7DEwyXxbztLJ1WnNRvib
         E/TWhnn7ULERjblYEekOkG9xDy7MtyZaAFI0bJRMgdN9iiPFlVeiUYmcU5ZdnIyCm9Jx
         jlJjHvW3WKOv6xl9LazpLJ30rDw2OCOKlTh+BnuGBPQv9caw29Ez3d+u8BWXYiCPBvDf
         CxQ3MZfu6aEKSins4k8dTb3/rSQxlSh3fQv4XmM9oRJtAF+3wW2mAWW9mVuU8pZrI9pl
         OUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=orgGUdnBcRbH2zL5mXq+7BHl2AUu7JXKB8LfcIxwnow=;
        b=dx8jy6WasAFRXWeGUPkqvAWKJkp2B5rsUgvNvh/kCOiL8n2j/uU+oHA7fpMY+7WIZV
         J8rwB8W+86m0tw8ALWWJRQJAZ7NJLb8L48u0rMqOPkleOUF8bgDYk1hRv7r8k4tFs9cp
         DFB+pV+rEKOQJBd0jJZ5Vmgun4+1YY2g+kTMX31WrVMozXHwbhppnn8oiW5ZE4V6U6Gj
         Fbkb8B0nKsMsmJ3GUMHQxv2aiXOuYzGPeVBdXIivjYNtdYx+q65BCCNh/wpyX7NMv5Hq
         x3WDzP2PFdoy/nkH9n6KtkRcak1+Bs1iXVA6RvxUQuYF0xqSbGfSRXQU+1YAK2XE7fU1
         ZXAA==
X-Gm-Message-State: ALoCoQm4nkHmSSmUb2ok19PqeoJ5z7g4YHHCbZRcZC8kPAZrrkVLIjSnx6B4VpTL2Tn0z2PYC72X
X-Received: by 10.58.238.7 with SMTP id vg7mr19209762vec.22.1401831488136;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si28351yhl.7.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0109331C45F;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D1247E0FBE; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250663>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 28 +++++++++++++++++++++-------
 refs.h | 11 ++++++++++-
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index bc750f4..e19041a 100644
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
@@ -2347,17 +2353,24 @@ static void try_remove_empty_parents(char *name)
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
@@ -3586,9 +3599,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index c38ee09..dee7c8f 100644
--- a/refs.h
+++ b/refs.h
@@ -171,8 +171,17 @@ extern int ref_exists(const char *);
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
+
+/** Locks any ref (for 'HEAD' type refs). */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.0.0.567.g64a7adf
