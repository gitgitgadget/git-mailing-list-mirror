From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 09/11] fast-import.c: change update_branch to use ref transactions
Date: Thu, 17 Apr 2014 12:46:25 -0700
Message-ID: <1397763987-4453-10-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:47:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasHW-0004jR-SX
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbaDQTr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:47:26 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:56349 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbaDQTqk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:46:40 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so175581iec.5
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iljdhEJnI3FvuIg9xZWrQLIqIuMWzlE0iOKEAZyMmus=;
        b=nqFvITz4PRC6CmWQMU9Vb1bFuhFACHQCMr1qpOJHAEEKnSvSSvdVSrWss+xOta/D5F
         uWCfR1tkji08egpACRDOxMF2DT6I95bo1YT3t7uF0a+gLBnvIX0uJxtJ+D4LFiQVzMFw
         BkvJjPFgGKO7KC6CFvbf/NOGZUtd7wzd+aMfWIfYwvjaMm51ZYHkjpFwQXRNJCG/hzpZ
         +MxuxrEH5AL/xdmVa9iSe/sqjH+b4Bxi/SurYVt8JrsS3uQ8+RkhDDUYBHVznaG7vfc6
         tNSq5SPulQZipCVxM95sLvXJ7H0jP9mJedV2Vegrdjc7bmW6PzVljls3Oo200+gOwnYb
         mHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iljdhEJnI3FvuIg9xZWrQLIqIuMWzlE0iOKEAZyMmus=;
        b=SMT1M70YMOcp9H2NxteQAeTRTxIGJBsIDYRzlUmVK5yVMkGU3NEYm/Ql/OuG62OkLO
         fiycEke3cQ6Ulydj303AT5KArl+e7JXGq42Qlu05EEfxeTmtIhp0M33ssygu4H5mKxOD
         alyetTrzFVdHmfm2WrMRnTSsmpTPatt1WNeGgk2byFkBlUZfwctpiwRLHrMWmcmPd4N1
         Zh6n+OuE2RtmdfIAJSFsBgUVLhfllOAi3EDkioED1idVG/swSd9wWRhm1GYH91oUUWZM
         Aya4YxhZASg1jlHdeHlZY8soIBunbkzQMOlD7La7+3gQMMwRQhUpKH7JMcrgY31iWV/y
         gpqw==
X-Gm-Message-State: ALoCoQnjnIV+EOuqY3+zrMSkmRsq6Xuu04c7kMszKxwdgZK9qQ+qM3GiP6qsYOraJaIedTP0j6HwbNtLVj7iUpSy6HcySL2RxAJ7ytDge8fUVdzkUqtOLEHFCsm7aXn3F2xK1oCt/YUNNk4KAlbpdVshIfluIa5jVDt/bparz2/0KLeoDcRlSmiOdpDWtVHK/NqdU1oDkXkw
X-Received: by 10.50.136.198 with SMTP id qc6mr6548569igb.4.1397764000407;
        Thu, 17 Apr 2014 12:46:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id f65si3652227yhg.7.2014.04.17.12.46.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 322BA5A4252;
	Thu, 17 Apr 2014 12:46:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EA832E0967; Thu, 17 Apr 2014 12:46:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246445>

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index fb4738d..466dfe3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1678,36 +1678,43 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
 
 	if (is_null_sha1(b->sha1))
 		return 0;
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
+	transaction = ref_transaction_begin();
+	if (!transaction)
+		return error("Unable to begin transaction for %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
 		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
+			ref_transaction_rollback(transaction);
 			return error("Branch %s is missing commits.", b->name);
 		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
-			unlock_ref(lock);
+			ref_transaction_rollback(transaction);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	if (ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1)) {
+		ref_transaction_rollback(transaction);
+		return error("Unable to update transaction for %s", b->name);
+	}
+	if (ref_transaction_commit(transaction, msg,
+				   UPDATE_REFS_QUIET_ON_ERR))
+		return error("Unable to commit transaction for %s", b->name);
+
 	return 0;
 }
 
-- 
1.9.1.513.gd486896
