From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 39/42] refs.c: add a new flag for transaction delete for refs we know are packed only
Date: Wed, 14 May 2014 14:17:13 -0700
Message-ID: <1400102236-30082-40-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:19:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkga8-00056h-FT
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbaENVSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:18:23 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:62694 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbaENVRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:33 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so37133pbc.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bjlCYYhukhAC4JALcmpjWWrhRLq/l9+8w5WfO84kuzU=;
        b=XwRFxP1fAa0XwldF2yu1bVGetm8YpCvFLhEQv+oPVOlEX24zKYDJNVhPJMo/fF7X+d
         WNDdyueL+GYjE+ljOzvnc5YXbLavow2iFe+udS62iTzxla4idvWYeOshl4wWmtm6eztZ
         FgMgSotNZBz0IB95zcDZ3HgT14YXkB20DlsWMfZYsihgMacV3csJ/VNTK3ZBJrquP8fB
         5lPc8/1FkbrTURfoSzHbK+6SImMDuPdAdSPyRfMu3nug7Ait0q1SjLrnx0Z8OUZULlBo
         ckDj5O6159EbCl/q8K5xIDsS6pR8CDyAxjSmN/YNGTtJJrqKdnWHJs1VNzd8ZnfMvaJ/
         Lb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bjlCYYhukhAC4JALcmpjWWrhRLq/l9+8w5WfO84kuzU=;
        b=GU77pLdr8Q8Dn4x2mEk1JmMEEBGK/jZZXcSad8K/LXaCh4VND+LMry1D60kbZ+hric
         ZS842PVhPua5FvCstNbN04ulomfQxHbUGTIFTX09qX+amLci0RsnzGRPJIQ3McPggj2F
         ipHD4o81yJi8rzqG8iYlEsR6WvCo1wakpIhlNidjXEjIHpiS3vZJyFiX9VURra+diqtB
         SAVR+QVPuk2qb+yjFgDMupDbD+14Wx9AHKdkJPKKI+CueYWIb7POLRMdeIdjR3tc6C2d
         VxMoxIUjyTnhyb9yJkVh1x0Finsqt+c0zxTZ6UZymTgvBao+VD0ccnzx2LN7JgWU1I9b
         9q5A==
X-Gm-Message-State: ALoCoQkQ5nt8RIQH/6XDsVyIGXeFvdN09xm41e2tsLhBNmDYqm/KWVepl4wcle9dkOD+xJNoIz+A
X-Received: by 10.66.65.142 with SMTP id x14mr2999469pas.14.1400102253089;
        Wed, 14 May 2014 14:17:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si145576yhq.3.2014.05.14.14.17.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E31A731C1F8;
	Wed, 14 May 2014 14:17:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A60F1E0973; Wed, 14 May 2014 14:17:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248968>

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
index a376dd6..6b8b7fe 100644
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
@@ -3335,6 +3339,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: update on transaction that is not open");
 
+	if (flags & REF_ISPACKONLY)
+		die("BUG: REF_ISPACKONLY can not be used with updates");
+
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3359,6 +3366,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: create on transaction that is not open");
 
+	if (flags & REF_ISPACKONLY)
+		die("BUG: REF_ISPACKONLY can not be used with creates");
+
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
@@ -3472,10 +3482,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3513,6 +3533,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->flags & REF_ISPACKONLY)
+			continue;
+
 		if (update->lock) {
 			ret |= delete_ref_loose(update->lock, update->type);
 			if (!(update->flags & REF_ISPRUNING))
-- 
2.0.0.rc3.471.g2055d11.dirty
