From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 32/42] refs.c: make prune_ref use a transaction to delete the ref
Date: Wed, 14 May 2014 14:17:06 -0700
Message-ID: <1400102236-30082-33-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:18:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgZX-0003iM-F6
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbaENVS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:18:29 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:62537 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbaENVRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:31 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so36878pab.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fg6aiT/m3r+BcctdCIJL1JESSps2I6iaCt6BIQRgp+M=;
        b=XlqEzeZ+eQWiXBtEzSnqeu23pRW+y8kgImKWhrwjhmjl+r+tl1MODkg5Uds3x03TW8
         /4bhht8TNiCgIChGlVybUpfsTVft66/9mp/bD7oblJL51EL/njn0BAc4DnoEsM0XHdjE
         3J3fuLlenl5EDhYj3jxpKP8pigiM4Bo6FtgUTYD3cxXVAyJll3zGXYBai6NjPW1heRaI
         2RY9GZWuDPEDEQ6YafaAL0ZnGBjFQtqTPpiq/Q2tXHgvOfdWcZdjEDE5U5o9MGMxaspC
         7zqHrnoTkPxjUsOZHw8x+i0rRdeeEKCFFPelq9YCA6FD99v4W3l1zK8fiUMs1aPhm+oC
         Lvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fg6aiT/m3r+BcctdCIJL1JESSps2I6iaCt6BIQRgp+M=;
        b=hIPv4TajM52w4BGvB1oemc0W/N2x4KGI75ixud+UBO+FLzIuPnVdxl5fye+J4WAhw8
         /MNOWH62/qR9RnWUBLRPDDeI/WVoIux7pmdg5Ri/5llGCNzpaBjPDyu0Vxll9nfGZxGI
         JKgUhHp5AaJ5OxD+gf9kfg8WOIsmGO/H+ys0QS1XTVR8k6m+m04OH0ob5srJTLpA4/1+
         JAevnPNROlz8J0FUBG9tydjE2AeA3Bt/ATRGxMm0O2qxhR8U8hO+y1bBQ45BelKQxVVX
         Y/xddqHYp6RJYVHPphPFoBrf8uL5TTOm/GKp+BChWLrgYeGz28cO8xw6yj0RT87LPh3F
         4rJQ==
X-Gm-Message-State: ALoCoQmtkeAaRviO8wFgTfrFHTSvA3NRVEPZ0N4gFVx7LjEzw50tdwDEu+PYDh00Zo9/STPWTaUt
X-Received: by 10.67.5.165 with SMTP id cn5mr411786pad.9.1400102250844;
        Wed, 14 May 2014 14:17:30 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si145571yhq.3.2014.05.14.14.17.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:30 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A734E5A42DA;
	Wed, 14 May 2014 14:17:30 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 69531E0CB6; Wed, 14 May 2014 14:17:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248965>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index cc7556f..fa5befe 100644
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
@@ -3501,8 +3513,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->lock->ref_name;
 			ret |= delete_ref_loose(update->lock, update->type);
+			if (!(update->flags & REF_ISPRUNING))
+				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-- 
2.0.0.rc3.471.g2055d11.dirty
