From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 39/48] refs.c: make prune_ref use a transaction to delete the ref
Date: Tue, 10 Jun 2014 15:29:27 -0700
Message-ID: <1402439376-25839-40-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZH-0005av-2o
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbaFJWa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:56 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:63939 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so428343qcz.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gbx57Iu6Chrs59Wgsm3Xf9e+onEFw8kZCyZZk76Aqac=;
        b=mTnQl3n7Efk0m8nuLm8q20iJ80UwsCCEekePNCQKuGrjtj+w9odWOE1LC7+hwgk4Ra
         wSoVTA/3Oj3vz9CWvyafZ0ciU6+N3P8sxVHxzcXD9qvydCosBtH8iZdjYmjTEQX+7hdg
         ijrUMmRdvAGfQ2aCkV3EfntlQOqjqhu62s28WCsQRmGGv9V2cTrSwVRQMKpbHmC2+HIX
         GjSwa5rFuC63/KUu1eXGErXreI9SxzS9Ijo3CoeUlI31LjCgI28GS+wzojb714DGsytN
         RrAhqdh1VigBG2zlpAgPWRi0lbXfmVslU1Uh3Pq/dp831ylryScKrh49WwQnVwTR834x
         z/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gbx57Iu6Chrs59Wgsm3Xf9e+onEFw8kZCyZZk76Aqac=;
        b=i+zgip3k5dfI3ftjMOMO78JKsBBzdqf1lEosiShzTzHRwdp0DZjrc1ICqYa4cUjKWo
         lXnUx0VLH9VCMWysv5jXBIsSuxUOD40xVlAJ0iD/92CqELhz5EffxPSYjAr1UigEc+ml
         M7wQS6s6U90hMwo1JhepXIw5ulINr0WXZvreYFB1/ZESE6xZefQujXe6WdI5Jv+Q0xHD
         Du6kEs1Ji5r395umciArvcyXwnTw+DvC/gMH+k4hhvzJWGgPgOCI9eyN52ZCwgE7ye7H
         1KHpYFLdk4TOSMDZebm9ZWn8SmVQ3jmS4cuhxup95FaFpsil82e1Xox7v4Cf4JH2OnOg
         HAWg==
X-Gm-Message-State: ALoCoQkW+PQWKRX2oYoDqpNKAWpaMQ8HkMz6SUIBhHnOdu64iiZXF0pNGtamMKeep07XQNwCly9W
X-Received: by 10.58.227.10 with SMTP id rw10mr16609389vec.39.1402439381795;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si1395564yhj.5.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A35105A46F1;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6ACEAE0DEE; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251304>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 28 +++++++++++++++++++++-------
 refs.h | 14 ++++++++++++--
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 4ea9a3e..568bf9e 100644
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
2.0.0.574.g30c2c5e
