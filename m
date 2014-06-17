From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 39/48] refs.c: make prune_ref use a transaction to delete the ref
Date: Tue, 17 Jun 2014 08:53:53 -0700
Message-ID: <1403020442-31049-40-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:55:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvjn-0005YN-3X
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397AbaFQPyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:54 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:37816 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344AbaFQPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:08 -0400
Received: by mail-yk0-f202.google.com with SMTP id q200so355207ykb.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DNADEdkXauDd4eyl3zrckVAs1EXzWdQAzso7m0Uhcrk=;
        b=MHg8fbWzjVs63Zre6OJwUMPTlO2I/Mt5ilBOmH4P9pTjg24uSToWgaNdK6TqUE48iJ
         7qkkq+fd0qn6UdTlNdYWYxuS17S4dYtYprc0X+38A2i68qDx/PXAMFd5xzjWunzmpluG
         GF7qteBU/UjIwNUFjNV5JhGN0JpZ4hKz1Aw2n11E/uGLTBTwBgZMTpYMM/WMuflPN4E8
         SN4nHRUJpo/wcLpWrUYhaNQL7nw1tHAqNmGhPCxJWvXW4aJ127YjGcwabKBzYuvvk6XO
         yNdoR2wO0P0p4WJucToKAWsPSl+jrv2Pxr2wIikQXvdSMRAj+WM5DNBYEfVRXCC8hjVb
         cDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DNADEdkXauDd4eyl3zrckVAs1EXzWdQAzso7m0Uhcrk=;
        b=FcGbysXD3G+ZRRvBPyJDmIPeLH+6BXT5qjsgmnp02eF5OQNNvD3gxQuPU55N6i8H1F
         SVuNKyCG3lwqG5VWAJbiosaSxlH8yEx+NkB+r6EoVG2PXoSvo+fxR18fxyf/iwsTUDBL
         iRAF+l7qgJGEdKovQFEYMr4dSeEzlt0Yolk/ZfDZs7JOJTIEU3+He79o5cHDpb3eo4fm
         9F4HDGsV/eOZlLRsByba9L+CWbC+/WGf789G+gTvHTOF+Wi4fCYnS34GBM1mUeXerRum
         uxBOjc24qkCFWdbkl2on6As8/6biiC6W7BUx2nx4FnCgzVZQdcp2r6hhO7qqSRVjUYKy
         jRYQ==
X-Gm-Message-State: ALoCoQnFT5/PwAnH13UbMv3pl+ah+mClaozCevQEmvsa0dDtzq9HM2zp9+PZKd5IWLSldjMnWRf1
X-Received: by 10.58.65.38 with SMTP id u6mr579712ves.16.1403020445934;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1208721yhk.4.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C577B5A45BA;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A1D61E0FBE; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251893>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 29 +++++++++++++++++++++--------
 refs.h | 14 ++++++++++++--
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index e8118de..e753711 100644
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
@@ -2380,17 +2385,24 @@ static void try_remove_empty_parents(char *name)
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
-	}
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, r->name, r->sha1,
+				   REF_ISPRUNING, 1, &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return;
+ 	}
+	ref_transaction_free(transaction);
+	try_remove_empty_parents(r->name);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3619,9 +3631,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.438.gec92e5c
