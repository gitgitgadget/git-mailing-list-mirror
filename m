From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 41/44] refs.c: add a new flag for transaction delete for refs we know are packed only
Date: Thu, 15 May 2014 16:15:38 -0700
Message-ID: <1400195741-22996-42-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tY-0006FX-Ao
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbaEOXQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:16 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:37162 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127AbaEOXPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:47 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so720760vcb.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MH/RAEOC9GMxpp8yORglEP0J7xCpV+AgyULKJ2ex540=;
        b=Kh7SONAYsLWX9Z9QHZiGIBCj7HwKoZEx1pTJ9y/3pyxDJ3evmBijLxWlf4skkgRC64
         gfjSujdJOyd7plvoqjTNCcZVAg4xksKW997RRabs6XVdLEDXX5isNLtrGkjyvO5XG+C9
         6qB4MCQ75PLftXhDXgl103GMyYYPIauPhft8Xr82/xiXivQZb1uzLvbwaFz4yum6mznl
         xFqtkZuExtY0/x7dfWilPoi6xeBhu1LH7uc2nef1I5F9LDs0IQaGg+biKztfB6RB8hn5
         lHE7gzjHQOJ6tnBGnY9XGcc6bcRyJSjD6V2kse5+dfH5I3SPdej80slA3gVINSmMu8WR
         mlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MH/RAEOC9GMxpp8yORglEP0J7xCpV+AgyULKJ2ex540=;
        b=OJf++ZdwuB7JzY8X1CL6iv3RhN1M2RdI/Pczl7d5xu6+TUwewJ5S0JCqcHkl6C1HsO
         W5vVVUxJez32+IlJ6dVMhOwt+voZaU1ELlZETRevsDtKVBJfOyXqOKl5A401JOssDGcf
         obMun6ZRIqhTIQ9R7vzNcKojtsaBBq/lbYj1VanHQPXNJ9foQljVdDA7f2aDkbAzc6M5
         GLa4ycxgZUEypviiMTgwfQtPj/hwqGJk7CmsZsrHnFK9uhS54+r2D8v5EN51vjJtCmb3
         MhEYOopMuG4pL9N10KLbGBDqKGmLjAfVwO1b2jnRN/w82BChWsKWqxG6jL/Uo3/SYn+4
         f/NA==
X-Gm-Message-State: ALoCoQl0Oq8r4u7pl4H8t+rsc65MMT3q+4/fSao7PU2mmIPSWW3j8yP6rUesdj+07uWqt+rPh2lB
X-Received: by 10.52.12.33 with SMTP id v1mr2546138vdb.5.1400195746446;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si244844yhj.5.2014.05.15.16.15.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 43CF131C25B;
	Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2004FE0528; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249243>

Add a new flag REF_ISPACKONLY that we can use in ref_transaction_delete.
This flag indicates that the ref does not exist as a loose ref andf only as
a packed ref. If this is the case we then change the commit code so that
we skip taking out a lock file and we skip calling delete_ref_loose.
Check for this flag and die(BUG:...) if used with _update or _create.

At the start of the transaction, before we even start locking any refs,
we add all such REF_ISPACKONLY refs to delnames so that we have a list of
all pack only refs that we will be deleting during this transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/refs.c b/refs.c
index 87113af..6299b3d 100644
--- a/refs.c
+++ b/refs.c
@@ -33,6 +33,10 @@ static inline int bad_ref_char(int ch)
  *  pruned.
  */
 #define REF_ISPRUNING	0x0100
+/** Deletion of a ref that only exists as a packed ref in which case we do not
+ *  need to lock the loose ref during the transaction.
+ */
+#define REF_ISPACKONLY	0x0200
 
 /*
  * Try to read one refname component from the front of refname.  Return
@@ -3376,6 +3380,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: update on transaction that is not open");
 
+	if (flags & REF_ISPACKONLY)
+		die("BUG: REF_ISPACKONLY can not be used with updates");
+
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3402,6 +3409,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: create on transaction that is not open");
 
+	if (flags & REF_ISPACKONLY)
+		die("BUG: REF_ISPACKONLY can not be used with creates");
+
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
@@ -3517,10 +3527,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	if (ret)
 		goto cleanup;
 
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->flags & REF_ISPACKONLY)
+			delnames[delnum++] = update->refname;
+	}
+
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->flags & REF_ISPACKONLY)
+			continue;
+
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
@@ -3558,6 +3578,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->flags & REF_ISPACKONLY)
+			continue;
+
 		if (update->lock) {
 			ret |= delete_ref_loose(update->lock, update->type,
 						err);
-- 
2.0.0.rc3.477.gffe78a2
