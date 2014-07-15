From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 10/20] branch.c: use ref transaction for all ref updates
Date: Tue, 15 Jul 2014 16:34:08 -0700
Message-ID: <1405467258-24102-11-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:34:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFO-0003Pj-O3
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbaGOXem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:42 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:61371 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934312AbaGOXeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:24 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so40014pab.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/qdRQZ4pMwPuqIyvqwcPMllsxiE2c6vq9YMsM1c7Hr8=;
        b=O51zaxZlo7uH1jiOhdI1nd7qDS6CuDtJuoET8JQgEej1ReijVo0aDtCzYLV8sHlptH
         KKQs7tYcitciZQktvMYd8+d8ywHDKOdL0N4hBkLCdtpO0LMWzjidETYRebSzvlbLF+c6
         ZNflLLFxusYA5RCLFa90wJW+RcgOEZGlOlQ1Op36XTvY2AV0uKNoqYKv5MCHfIuMkh7C
         0xPyd9GLyTYQy0Ylg4IT56cGKYV7nrdX2zvpiB894aa688xw4DsEScvfmh1Nv2Z+Zqwx
         LhwiiBYxRGJKOmXLZon1HiWP0+kYd+zYI/w5fYAXFIRJ/9QSTUSVm3xDo07EmSWMWhES
         VE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/qdRQZ4pMwPuqIyvqwcPMllsxiE2c6vq9YMsM1c7Hr8=;
        b=IR8+bcaGVCL8XSznhg5f2nSLmVt2wKB4VRiMC/Kht5LTRKVO6EFkpyH7SJW1jVMk43
         UUxCY7gNbaRS+nrNrzLs3XqUxkkeKBL10bbfurS+fwJqykdX82hbQHXJkpU3kr+Q2S0f
         fQXIDOdRRLIjd4qjRUWIHWyof9Ri/rNex5116sEZ72BdwZLoL7gc41nAWDiiCudLTe9h
         NBPruJF1gz8CwzvIsbPcQzy1tcsrsGDjBi8JNesojSmcF7A+BNaxywHpSpbc7X/dlJZ0
         j5m4Be1Ok4HqbeqxpuGM+qGnZuhvVwWHeVkG6kJvAsxT6un4rLX/n4cCl89kLoSA0+vr
         TBBA==
X-Gm-Message-State: ALoCoQlCY0TLiumdCb19KkDEn0se5PqKHaLjYH0d7BllrqtbmztAxs3NJfjvFcHfdUxJILHadxcB
X-Received: by 10.66.157.67 with SMTP id wk3mr12711514pab.24.1405467264230;
        Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si1060886yhe.2.2014.07.15.16.34.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 10C5B5A428F;
	Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C4796E0C21; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253635>

Change create_branch to use a ref transaction when creating the new branch.

This also fixes a race condition in the old code where two concurrent
create_branch could race since the lock_any_ref_for_update/write_ref_sha1
did not protect against the ref already existing. I.e. one thread could end up
overwriting a branch even if the forcing flag is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..c1eae00 100644
--- a/branch.c
+++ b/branch.c
@@ -226,7 +226,6 @@ void create_branch(const char *head,
 		   int force, int reflog, int clobber_head,
 		   int quiet, enum branch_track track)
 {
-	struct ref_lock *lock = NULL;
 	struct commit *commit;
 	unsigned char sha1[20];
 	char *real_ref, msg[PATH_MAX + 20];
@@ -285,15 +284,6 @@ void create_branch(const char *head,
 		die(_("Not a valid branch point: '%s'."), start_name);
 	hashcpy(sha1, commit->object.sha1);
 
-	if (!dont_change_ref) {
-		lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
-		if (!lock)
-			die_errno(_("Failed to lock ref for update"));
-	}
-
-	if (reflog)
-		log_all_ref_updates = 1;
-
 	if (forcing)
 		snprintf(msg, sizeof msg, "branch: Reset to %s",
 			 start_name);
@@ -301,13 +291,25 @@ void create_branch(const char *head,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	if (reflog)
+		log_all_ref_updates = 1;
+
+	if (!dont_change_ref) {
+		struct ref_transaction *transaction;
+		struct strbuf err = STRBUF_INIT;
+
+		transaction = ref_transaction_begin(&err);
+		if (!transaction ||
+		    ref_transaction_update(transaction, ref.buf, sha1,
+					   null_sha1, 0, !forcing, &err) ||
+		    ref_transaction_commit(transaction, msg, &err))
+			die("%s", err.buf);
+		ref_transaction_free(transaction);
+	}
+
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
-	if (!dont_change_ref)
-		if (write_ref_sha1(lock, sha1, msg) < 0)
-			die_errno(_("Failed to write ref"));
-
 	strbuf_release(&ref);
 	free(real_ref);
 }
-- 
2.0.1.442.g7fe6834.dirty
