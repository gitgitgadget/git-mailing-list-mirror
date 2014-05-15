From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 41/44] refs.c: add a new flag for transaction delete for refs we know are packed only
Date: Thu, 15 May 2014 10:29:56 -0700
Message-ID: <1400174999-26786-42-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVR-0001gX-F5
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778AbaEORbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:05 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:62291 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so636840vcb.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6MO918zGcTwXKtdKL56ZsKyktqLZ//Xc+bmQj8LonVI=;
        b=Wj2Ludg88FfeJAWdmmY64EbhlTAAUizI5XJSLH8GU/seGGNotnO8/ScukG/0u9GmkM
         HWSM1hEA4Fv1Ax9hvUKe7p8lTwPZF9II/npz3sNg5SSwvM2vKHeYvycFXvQ5SXGKxOsr
         n/8WaCbiCg3ylceSSO0QxswV4s6xWbSYYkXabJovqw5blK5PkzxL6s4Mcauvnpe5djp5
         Fd+7euXpR/PeoWm1lRjTz+/HFvBzLmao4bpoCVCv9XtWxeoQmXDQf5OARLyOFmwIg0AT
         z4aX4by7rRDgcthZm1zLmTrKD1LZBwJBA2W+0khtvaKYNA+1wot3CzuYPAgfPPlmjOO4
         FFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6MO918zGcTwXKtdKL56ZsKyktqLZ//Xc+bmQj8LonVI=;
        b=TJ5tliLrvzY78rNkk2QJR3nQ2RWMRYyLCLQ/KL4pv6vs1RraoGlJcTwh1baW7QftEK
         kzWOtuVWevdojM4OoELCbOviU2rC259thuxXTZKaXMLzXnDt4iCF/W8SCEEH0lqzdprj
         YEBgwXF0zzqe0Jj+Ce64PpTzWlMri0Zz56eXX6hgWLoW0CQgtSVNiJO6wpvlTKG9AEFJ
         Ky3Xf3AG8peLiWkim3enKhS8O8eD/UGJGD2ymb1zfCtH64vaJc2O1pEz7J/sCLTZsaO3
         LHBUgbbqVGcurHWFkx2tnWCWFr25SdeQ1iAdphpFE+wUh6YZK+GDBweJoT/KpOEeUd9P
         Iu0A==
X-Gm-Message-State: ALoCoQkMTTvXT4eKisOjd85S1iGqKcDlO7a4rX/lgupJ9wtpUCj9hN0lmQTAHbqmoxyxwQyIQH4d
X-Received: by 10.58.30.108 with SMTP id r12mr1795246veh.17.1400175007628;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si199313yhj.5.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 784D431C2D6;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 566BEE1797; Thu, 15 May 2014 10:30:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249145>

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
index 69ad51d..f458ff9 100644
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
@@ -3346,6 +3350,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: update on transaction that is not open");
 
+	if (flags & REF_ISPACKONLY)
+		die("BUG: REF_ISPACKONLY can not be used with updates");
+
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3370,6 +3377,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: create on transaction that is not open");
 
+	if (flags & REF_ISPACKONLY)
+		die("BUG: REF_ISPACKONLY can not be used with creates");
+
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
@@ -3483,10 +3493,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3524,6 +3544,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->flags & REF_ISPACKONLY)
+			continue;
+
 		if (update->lock) {
 			ret |= delete_ref_loose(update->lock, update->type,
 						err);
-- 
2.0.0.rc3.477.g0f8edf7
