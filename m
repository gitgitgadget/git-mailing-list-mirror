From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 34/44] refs.c: make prune_ref use a transaction to delete the ref
Date: Fri, 16 May 2014 10:37:22 -0700
Message-ID: <1400261852-31303-35-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6E-0001eO-KW
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969AbaEPRil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:41 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:45819 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758093AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so885229vcb.2
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n0bNSXyUz+NX2TQMm07zIYZimR/Ymru3My70Zaj5ZQw=;
        b=ILgRN3mBil50syNsr4iP6ZXnaMSHgv4z3GLuw+c3wVyBIzSHRL23x9Ju02qcAsLs2M
         2gbRVklvGcKoPI48ZRerh2kReD0uqbMvRhkb3tLycFe2GpkhWFAYodL0zAXfuDJSa0b8
         wR6PrKngewq4yeSv6R/JPNiORPVokVKczk4MkQ/udfPQyTzt78tqyRIdgpkWcZtHkTfx
         XbTJKXmRgOd0o1IR+pmJJCtl+3B7mLnAe7S5K7EF9+zBiBZsXMzWYj/IQDXbNyOwelU3
         Ts5nqJ4ViPRegZL0qYYH2VIJfaI21SXnfOAwTK9Q8k/gcE/spB+/KtrX7GRF7rOVD67A
         078Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n0bNSXyUz+NX2TQMm07zIYZimR/Ymru3My70Zaj5ZQw=;
        b=ge6ogFhF0xEO6MY8chWvEABExOvDJevAP8Wf55/s7wexvBcqCbv2Q88LWpcldFXuoR
         J32ueQEUVTFjjwpppHlurur8XlfTFSf46t6pPBKqux/QJew+KlPb9Dh3oKT5Ds5triVy
         bic3qVMpkFCdG8N4vGNux3CEq2TYPuCviX2zit4f44mKkCjGQs/Rh0uBxJy3F14PIy1R
         hL/QVeB3jGQ8mHvcLtoc4lQ4SUarT/wVbTRwrasC36JiMKQk1YRBRPIpvlQGMzMveXAp
         9sEQKv3GJ6Rok0OIyXwuJCA6Ww9PPYLl0vamwc3c20lB7MUwK6YALJpwGVYJNHjA4CZn
         N9Zg==
X-Gm-Message-State: ALoCoQlvfriMqxwn/tl/A5qU8xsTbSNtxyzTPdAkWYvYWuimtVAQ/mRGJLM4AeVfC+57IR4bcnp9
X-Received: by 10.58.18.200 with SMTP id y8mr1109646ved.20.1400261858450;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n43si191483yhe.1.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4E7255A4292;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2A5CEE0D39; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249380>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 69623e4..3a5f1e5 100644
--- a/refs.c
+++ b/refs.c
@@ -29,6 +29,11 @@ static inline int bad_ref_char(int ch)
 	return 0;
 }
 
+/** Used as a flag to ref_transaction_delete when a loose ref is being
+ *  pruned.
+ */
+#define REF_ISPRUNING	0x0100
+
 /*
  * Try to read one refname component from the front of refname.  Return
  * the length of the component found, or -1 if the component is not
@@ -2330,17 +2335,24 @@ static void try_remove_empty_parents(char *name)
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
+				   REF_ISPRUNING, 1, &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		ref_transaction_free(transaction);
+		warning("prune_ref: %s", err.buf);
+		strbuf_release(&err);
+		return;
 	}
+	ref_transaction_free(transaction);
+	try_remove_empty_parents(r->name);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3533,9 +3545,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.510.g20c254b
