From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 31/41] refs.c: make prune_ref use a transaction to delete the ref
Date: Thu, 29 May 2014 09:07:49 -0700
Message-ID: <1401379676-9307-8-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2sN-0006TU-1X
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554AbaE2QIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:09 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:55495 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757453AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so97011pbc.0
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3mzGC5Ay1k7maOOE0cZqQl8LCcad0nRdQ0/9l7NCwds=;
        b=KE+pSF0J8SONqnuNAsmeUaa2BzXR2T32ODOl9iwxDNjSajkj0RsimH1sA2R9+U2/ZR
         meLdYQoFBA/uvmqz+gNUFIRfXIr7R6zxkHC4mI/zuWQ+e9jRWP0//pqyPhb1qkRIzJFD
         kj/Gxx7wFcfw7+7kXbT39NlI46IS0YFlAqMfsPwP3rSWHIKx6LHwINc0NwWvhJMtGbGJ
         /NWyic0djJWdRYAMd1TiMczWdhmZ28kaG5B3EjGK8waijlyKRXD3q7+qqpYmR4qTar+H
         XkspAuTzpIU2voBjVn2C4GCNorPUnBb+/19Y3ytn4g3dLHOVCW7C708BAEMon5L20p0F
         GZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3mzGC5Ay1k7maOOE0cZqQl8LCcad0nRdQ0/9l7NCwds=;
        b=Rymf5FXvkVxqOQSoIM+Wb2aRMNRVEMKJd/3AbCvCemIPDD0mac01bGeN15bVC7THSj
         Q9QAVmfeJXkL1hDwjyMXaHXIyf3HpyyXPtZWK56dShAKisF1bIdo/88hi4+E8Wz/sz+1
         KXsdXnbfwJ4qji4Rw7XH7+LPhmwAKpxw0m1vt0B5LZAnQJPWiu24PobDIg1YOmHExU1a
         P4LhNt9aivpnSjI4N+O8TYJJdWi2NW5/FumdvZOXYfjkipx/OrHS1p9IE+LORzhgME4u
         oRrD0yJo7mNQT0YdQ3TeGS9g/NK7I26X8Fcx+XR4u7U+4fUxegkCJD//MLoCYmIp7VNG
         428A==
X-Gm-Message-State: ALoCoQkbvm+4D/FMTJRlbpL420zGfiVnJUPOp+z0kDw9VXXMH7E+PzB5mGYBQcSSTGm5B+43/K3i
X-Received: by 10.66.216.130 with SMTP id oq2mr3536426pac.44.1401379679577;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si81559yhq.3.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5F04E5A445E;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 143C9E0DDD; Thu, 29 May 2014 09:07:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250376>

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
index 7cea694..60593d7 100644
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
@@ -2328,17 +2334,24 @@ static void try_remove_empty_parents(char *name)
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
@@ -3536,9 +3549,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.474.g3833130
