From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 41/44] refs.c: add a new flag for transaction delete for refs we know are packed only
Date: Fri, 16 May 2014 10:37:29 -0700
Message-ID: <1400261852-31303-42-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5Z-0008J2-7O
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099AbaEPRiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:12 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:65110 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757591AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so521666pab.2
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zklSgRnJTKtpRKMLrItGWZI85t9FwUsNQca4V1kmy6k=;
        b=UcLiytNBvrbEkqy68fmcqAfOadkpZkg0bn1QQ+Fzc+Tm3HbgECBkwCkOhMcSO/RV1K
         YXYxDaOMTIOLEEyyjmbjZdQBUp/+GDmEWd1ttlMj+DFH65axC8r6bPh87tvHF6nZBgj9
         oF/jzcAA1qG7JoG7igOvIFnJiEZPiWkQKV/eDmhc2P4lDaY2hQAy0bPRwFhCJH0gLxLz
         CtI4SL2m3U8GhEM0duE/YM4xqfB/LJmY0+LD604n62hR1kkoSpLOCf+YfIRL9dGMFe5f
         waXLsqDSNjw97Sbx2T7Tb0jZywXSOEVMRLEZ5ZIs36BkGOb4EP9kl4bmaCHuWDiYyXl/
         6c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zklSgRnJTKtpRKMLrItGWZI85t9FwUsNQca4V1kmy6k=;
        b=TVKnbEPzGL8tt5YWfyrVL95nDogV1O2yf1TXyeCwzwtHjUh/YyF4Yd5NIsknd8sRxR
         Tg+vcHfX8AucWFBh+97vEvQSSw8eEV9PYruGevr1PtutW+Q7qqsHM6AoLcc5Z9XE0NET
         LVP5+IwJLreaEySgoIeIgtsOkONi+mjj/iw3B0u/YyoX43SMeRLR81+ajP6x4RfVAWH6
         nxvwyuIuk03TS9+afNGRYqQe5sT15REVgx8TGr/B8SmPAWnO3MyCSGBtb4VO/n90PUsa
         nLBybQLyREqkODeMA6PrKT6PwlLr5FI6cGftz1A9jhvhyXXQtUjnsm7oBGHW1vdEOjLX
         udjg==
X-Gm-Message-State: ALoCoQnbhW8tkgS/3AGLorLVW7mCPdAP0bEIF5Jc7DfhkGLD0KL2A2Z/IUfV7pyAEJAl4bRZIY+b
X-Received: by 10.66.66.35 with SMTP id c3mr6442977pat.7.1400261858754;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si368521yhj.5.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 90D435A40F6;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6E8ACE0746; Fri, 16 May 2014 10:37:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249367>

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
index 564feb6..c5d41bb 100644
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
@@ -3366,6 +3370,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: update on transaction that is not open");
 
+	if (flags & REF_ISPACKONLY)
+		die("BUG: REF_ISPACKONLY can not be used with updates");
+
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3392,6 +3399,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: create on transaction that is not open");
 
+	if (flags & REF_ISPACKONLY)
+		die("BUG: REF_ISPACKONLY can not be used with creates");
+
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
@@ -3507,10 +3517,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3548,6 +3568,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->flags & REF_ISPACKONLY)
+			continue;
+
 		if (update->lock) {
 			ret |= delete_ref_loose(update->lock, update->type,
 						err);
-- 
2.0.0.rc3.510.g20c254b
