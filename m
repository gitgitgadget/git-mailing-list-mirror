From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 15/42] fast-import.c: change update_branch to use ref transactions
Date: Wed, 14 May 2014 14:16:49 -0700
Message-ID: <1400102236-30082-16-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:17:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgYV-0002V2-Ts
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbaENVR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:27 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:52987 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaENVRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:25 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so40753obc.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nzn6ssOkGSuoKAv6XJIYLMHjO7G5WT/v6asRs1bpVI4=;
        b=m+JWXTRIm3aJUlcZDJMNCVDfVXooQRsZ+SNUizkYPvX7F67VLs1VYn9bRKIspbp675
         ZoJv4PGN4O6fjgPTG1I+6y7/t9NV6gSbhYyYntU8enb1qGbdmehOT92e5zfti82S6j7D
         oTThrMXF9bSh/w3HTRTBOw9GrruqFcmKJ5iVY59WqowVemNm2i65Dj9pGlr2H99ixYF3
         8Z6s5CxCYrPqgXTTxzAmproRuVNUBe7FIPrVe30H9MQmjO4UWFWpqdnVTofGrfZoFBgN
         TNPyjy9T0GdC6ep5EEJ2890tnESvXVS8KA0syRmJ1Dy0mrdwF5PUtDW7tHE7PKypqXQ/
         ok5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nzn6ssOkGSuoKAv6XJIYLMHjO7G5WT/v6asRs1bpVI4=;
        b=IzmN1rHosluJq412s3/9ENBIUCfh6RTu7YMlyaQD/24G4OU1IiPJJDdmbtLzJ8ytt0
         E8p5aSwWrTD+vnNGSPnZ9FpDe6Xr7dwF8t/F+Fzf5tCJViKVtqj+4LuruzMyvzyFJodc
         pplGNj9/10WsteaZRgLqJtzxQYPi+h4hExNSMvByxxpQ3Sz0Wt/iqYyW5whruk2ofWgA
         H+HRWNsMwjnSFMBLc+AQZpSVCIy/kflu/buqgwXI1wzzeir31FVqi9fC/o6gdZWCMFZt
         ViZdWXxrRCR8A1xJ/ZzKLHQGyvAui0XKmV8IIBZt9OZ7IeUMmuKsQNAFlBx7961kZocQ
         9Qtw==
X-Gm-Message-State: ALoCoQnEd3UKP8ZIWlqyh6Zd47Q2j2CCfR7vFaqCD2AEGy1JlrDpa8KoIW963akF08i3pyyJlCDo
X-Received: by 10.182.78.97 with SMTP id a1mr2920184obx.33.1400102245045;
        Wed, 14 May 2014 14:17:25 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si145197yhk.4.2014.05.14.14.17.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:25 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DF2CC31C1F8;
	Wed, 14 May 2014 14:17:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A23A2E0CB6; Wed, 14 May 2014 14:17:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248956>

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..79d219b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1679,39 +1679,45 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
+
 	if (is_null_sha1(b->sha1)) {
 		if (b->delete)
 			delete_ref(b->name, old_sha1, 0);
 		return 0;
 	}
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
 		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
 			return error("Branch %s is missing commits.", b->name);
 		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
-			unlock_ref(lock);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	transaction = ref_transaction_begin();
+	if ((!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1)) ||
+	    (ref_transaction_commit(transaction, msg, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		error("Unable to update branch %s: %s", b->name, err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
 	return 0;
 }
 
-- 
2.0.0.rc3.471.g2055d11.dirty
