From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 31/40] refs.c: make prune_ref use a transaction to delete the ref
Date: Fri,  6 Jun 2014 15:29:09 -0700
Message-ID: <1402093758-3162-32-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2fW-0003Fz-0i
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbaFFWak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:40 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:40312 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so741056obc.4
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwB03x9FtuSmgSwwC/8hc6X4wkDrPhQOAi+3UH9aV1M=;
        b=BhD4D2VYWgwOMy85w0UkIrwFgBUl0KzvquWFwVrRRoSe2l0bGUGrZYJGi9xzyWCn3A
         DAG2dQsNpqymoO004cG18fhitA1u8djFxJ4zUXh74coz5v0O7TigQcbrQ35yCnpYvRuY
         yYSriQHBNRwgk1NicXgAJdlvxCFUIrOc5Qcz6GESekNNOX1QgaPM/82QT8sRlj4RXB9o
         k1L+r+r74ARG+K5qrupUL/czw3aNZGVZZKKaqHUpqOh3D6LBX0lQZCPsPzu6DvRg2lpg
         xPhzqb4/TTP+pPFumpJfnpN0/v2knaTLIOf9zKJazGKfeEHYhSp7ap4BpSrVKoxLtoPN
         DM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwB03x9FtuSmgSwwC/8hc6X4wkDrPhQOAi+3UH9aV1M=;
        b=R+p+xY5WK9mxzJVpeUS3zdDh24eKWS9N6lysYcpGGtKGMpEH4VxMzfDBtaM9bHJZzs
         nRLxhCYSBJb81GZ4VFeA4FXTbVKkmmHsrrTyNG2YX392b95WKoUCtessl8LU+5AWsgMc
         Ph29P6YkszM06PF+ZvBLKwDkQQ26V9WLAOvJi3e7/ffM/iXNJMqNC+jXP2yJkS/bHW6K
         WjxLN9cYRcG6tuXb7+09A3JQUFVJfCCAkseqVNKlUqzuSg10eZ3VteXOs7ahBlzr1kHo
         lVg95dmbO+FkYJKMJ8N49OxyoPA5qVATxb6V0flld9saL9Ws5rOjcf4dMAeIv7q0V+pp
         RqNg==
X-Gm-Message-State: ALoCoQnYe4A25QB6kHkc0tyfHRd1jstN6a/PjEQ4gqP7alF651Qu4wcaXH8heryZQKu16MQv3rac
X-Received: by 10.182.191.73 with SMTP id gw9mr4236791obc.50.1402093763049;
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l7si751220vda.3.2014.06.06.15.29.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C727A5A44EE;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A5482E1084; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251001>

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
2.0.0.582.ge25c160
