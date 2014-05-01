From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 32/42] refs.c: make prune_ref use a transaction to delete the ref
Date: Thu,  1 May 2014 13:37:32 -0700
Message-ID: <1398976662-6962-33-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxkq-0001dO-1U
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbaEAUir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:47 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:53157 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbaEAUh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:58 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so799628iec.1
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6rrv4uuVRw6uiWdZrXH30rjcF9N/P7z2JIZIOnv0Q0w=;
        b=THa3emRlUesA6WwBeXGhQoieJJ1lbweR8i3QbNvAZHWhZCZA0lo6ZGgh7mA3yfD91K
         OwuwDNafpxht8rrnlkOVhg3CL3phe4VhsJ3xbx+dL7hFYw26GSfMc8WS7pZauCsMdbq/
         IYjNz1FqPONuplm/fe8gw9UyblwUNdTD3kzUIvkHxntyx7KXdsyohnEupN7UmDw7ml30
         Z7PB5j3D0RX58sZu44yMG9dm/tp7uIDkea/Syr8+4QHlI2mAOgMcnvoR5CS+i27CfTNt
         pUUsMDEys7BiRsL4E5ewyeoRaJ8V45dPY6Y5L7uBWuJQ5Sl/CrpCXUSe48ncp9IYDOcQ
         Sw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6rrv4uuVRw6uiWdZrXH30rjcF9N/P7z2JIZIOnv0Q0w=;
        b=ThrEtjTxgScibRw5/ySaUjqS8sn0X5UCWr2ccV/5szv0E5orAupsebfYgXVsgTNl5W
         Tc47bQl3y6tWpXlmqeOW8ibHzYA+ZMiiHyx1jHqBXlFk/NChlqqmy/WeyLsq/0q0XTyU
         Dy5YVXPD/7pLpyJMrn0TuPt8XQa9rQOcSAUyLEMQkZIfeFp2rnW8oyaG8o+CgT07HwnB
         dG7MNqYdIZOXZQHLSUhSdGiOce61PtvfiahjttDtb18Aj5vv3d7Z60dNhAlVfajEn/Su
         2xeGSYQt3BG2Rj9gZcE3sN8tyY1Ri3TvcCmqpwEjTzLgHiyWjkBQpZwc2fvZfFNHESdf
         gEQQ==
X-Gm-Message-State: ALoCoQk5gqMVvaN+6jdjSr6wc6L7ldw/AcTxW3j5XjJQzIbpT/lV8c64nRrjVxp7b/GxSEb/HG9A
X-Received: by 10.182.97.136 with SMTP id ea8mr6999322obb.3.1398976678032;
        Thu, 01 May 2014 13:37:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si3104427yhj.2.2014.05.01.13.37.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D35BF31C1CC;
	Thu,  1 May 2014 13:37:57 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 97524E097F; Thu,  1 May 2014 13:37:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247852>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 22 +++++++++++++++-------
 refs.h |  2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index a55cc38..2b82dce 100644
--- a/refs.c
+++ b/refs.c
@@ -2330,17 +2330,24 @@ static void try_remove_empty_parents(char *name)
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
@@ -3492,8 +3499,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->lock->ref_name;
 			ret |= delete_ref_loose(update->lock, update->type);
+			if (!(update->flags & REF_ISPRUNING))
+				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
diff --git a/refs.h b/refs.h
index b14fe86..340e11a 100644
--- a/refs.h
+++ b/refs.h
@@ -134,6 +134,8 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
+/** Deleting a loose ref during prune */
+#define REF_ISPRUNING	0x02
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.0.0.rc1.351.g4d2c8e4
