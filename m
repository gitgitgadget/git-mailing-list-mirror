From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 39/42] refs.c: add a new flag for transaction delete for refs we know are packed only
Date: Thu,  1 May 2014 13:37:39 -0700
Message-ID: <1398976662-6962-40-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxkf-0001Qi-AT
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbaEAUiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:19 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:53024 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbaEAUiB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:38:01 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so798623obb.1
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+nLkEf01+7Lq2B/oeWURbZn3M0qwZsB+CGwgqOl94po=;
        b=fmM4mpsPZqqrFJaTmJpKre0XM5mVUjMhqn+kasBmN4+ijaJpdnvI5w3/7n8M5ewEb0
         a+85i17FqKVP7LDiQzJcKu9qoXke40g3DcWfZ8ElcL1rS4bfbjmjPs4Ij1kJU+MXUZSV
         b+InqoYMlar+9gRMtozIbdGwyrTcTghE2Ajwl3Czakt2OTGP0IHmrkbASkO1cAxsUJli
         F7qaIZJsFMFloNo99TkfUNmt4sKgsBd9kN02u1X3Sq8QA9h6onGE9gWnOh9mjg8fCuhY
         OxZiQ56cDVhZ7/HQ30O/lDodIBEnAVm47539PsQxhwJ8/75QUgMY7qKSgB/29qfC+mkO
         W6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+nLkEf01+7Lq2B/oeWURbZn3M0qwZsB+CGwgqOl94po=;
        b=VFtl0aBZX9AG2WVUlUT6XWGQfUlvi363lGFpw937ngLJz80d09PbuqUVTCYzFLwpQJ
         gqcvG65uGvO4oLHXJqFMt+M0E/6j+uTppg60vJ1Uck803JF9dNdWaZki2eceI3RyIevn
         VrOXIJrj6Op/bozjV+d9HyRG5F2iS9POKnXJLM+/GbECZW1+o5c8HIYBZCosGrucIJ8B
         GGmqTv+YrpxN2haqPrKheODucNtIMWlbU9++W2/pENJI4Y+0/n2ypD+RMJVICbLKU/iy
         CGS2f8oO37Lu/P9F6DoBUHpm5c2yolWvygAI9NqQVnbSo9Ula+UEeYH850eAYrjQFKMo
         IVLg==
X-Gm-Message-State: ALoCoQl0E8XL2keNfCOcnZ/J9/SBr64ZTUz0/MHKVA9rLbZOy9avAdA55121SNy2sjOg2rFtmkDY
X-Received: by 10.42.209.18 with SMTP id ge18mr5924306icb.7.1398976680626;
        Thu, 01 May 2014 13:38:00 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538109yhe.3.2014.05.01.13.38.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:38:00 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 75F1B31C1CC;
	Thu,  1 May 2014 13:38:00 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3A4DAE097F; Thu,  1 May 2014 13:38:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247847>

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
 refs.c | 19 +++++++++++++++++++
 refs.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/refs.c b/refs.c
index 51cd41e..b525076 100644
--- a/refs.c
+++ b/refs.c
@@ -3321,6 +3321,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: update on transaction that is not open");
 
+	if (flags & REF_ISPACKONLY)
+		die("BUG: REF_ISPACKONLY can not be used with updates");
+
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3345,6 +3348,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: create on transaction that is not open");
 
+	if (flags & REF_ISPACKONLY)
+		die("BUG: REF_ISPACKONLY can not be used with creates");
+
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
@@ -3458,10 +3464,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3499,6 +3515,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->flags & REF_ISPACKONLY)
+			continue;
+
 		if (update->lock) {
 			ret |= delete_ref_loose(update->lock, update->type);
 			if (!(update->flags & REF_ISPRUNING))
diff --git a/refs.h b/refs.h
index 7a89415..71e39b9 100644
--- a/refs.h
+++ b/refs.h
@@ -136,6 +136,8 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
 #define REF_NODEREF	0x01
 /** Deleting a loose ref during prune */
 #define REF_ISPRUNING	0x02
+/** Deletion of a ref that only exists as a packed ref */
+#define REF_ISPACKONLY	0x04
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.0.0.rc1.351.g4d2c8e4
