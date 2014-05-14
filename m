From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 07/31] refs.c: add a flag to allow reflog updates to truncate the log
Date: Wed, 14 May 2014 15:13:06 -0700
Message-ID: <1400105610-21194-8-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhSA-0000IL-Kq
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbaENWPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:15:05 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:46816 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaENWNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:35 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so51763pab.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7+kfVy9QsBuEC0wx+ICuG4/xatlPPJq0NF5iKjGJUgE=;
        b=ZFYcizh5twvC+eYuqyFqv0KEd/j9S3WVOVqsGgRf/wq00f77bADBvDkzew8VQJgSJB
         RAwgwtPCb1ONKR0MwBop3NJeVZVIHR6Mv5e9bOlDQQuQS/WhpKJjdSrn+ocIaz2uhc0O
         Qjc2KJ/V3VJU0uM6QKB6TZnHI+xPjyHcu3IDgxQsepYYwmkNCdI//G+PTTXJhckOeB1Y
         NG8Sqj/Z/jmZlAqYwucXfN0Xpe5HDWGt1JA9gXnF7x6rHWrlgWX1dhBU7NfhcvBLtM9E
         kIeqFVgD55wlh6b52QOePU8qp1pa20BnCUFOJq3rzZIusJ/+EbmPvvnhYnPVsA/35dFZ
         V1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7+kfVy9QsBuEC0wx+ICuG4/xatlPPJq0NF5iKjGJUgE=;
        b=jDjodroT3WMBnWxHrMBk/OKQfp+00flWGF5ziycvRJETKPzWiNuDyAByX804zZx0Nm
         05hIMVEFOVPty8JtS3l5FeTN/hS/QlF7achHHDi5/99cT7YBw1at+sEc7EBtQ4E/QgyG
         4OTVCEogn/7i5Ryx3Ywmd6i7rKsyI85i64wJWhDXE6yWSGl8w1jHAmjCzFonlGTwze+u
         8F1UTYPsm8g/5/mBRrulSM3gDcKPQAolE8e1r/ViIYnbqXZrReUBZ3g5ZqLfcNjK/Wz5
         VEjCTWJu6fDeMwYUQN3+gMbZvfDYTeYDSV9NT9yo0CzyauboISwiizbvbA0UgRFMr+xL
         Trnw==
X-Gm-Message-State: ALoCoQl0EEKxRL3e7U95fJHLA3n0nmgukqH6NEeid/ve5CZbSah+uj9vJ3qaQ2aEH94fPw0rnOlb
X-Received: by 10.68.134.233 with SMTP id pn9mr3133820pbb.5.1400105614930;
        Wed, 14 May 2014 15:13:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si150750yhl.7.2014.05.14.15.13.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BBCEB31C1F8;
	Wed, 14 May 2014 15:13:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 60F7FE038E; Wed, 14 May 2014 15:13:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249030>

Add a flag that allows us to truncate the reflog before we write the update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++++++--
 refs.h |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index d8a1568..a8b583a 100644
--- a/refs.c
+++ b/refs.c
@@ -3608,7 +3608,11 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	/* Update all reflog files */
+	/* Update all reflog files
+	   We have already done all ref updates and deletes.
+	   There is not much we can do here if there are any reflog
+	   update errors, other than complain.
+	*/
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3616,7 +3620,11 @@ int transaction_commit(struct ref_transaction *transaction,
 			continue;
 		if (update->reflog_fd == -1)
 			continue;
-
+		if (update->flags & REFLOG_TRUNCATE)
+			if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
+			    ftruncate(update->reflog_fd, 0)) {
+				error("Could not truncate reflog");
+			}
 		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
 				     update->new_sha1,
 				     update->committer, update->msg)) {
diff --git a/refs.h b/refs.h
index 2e22a26..b1b97e7 100644
--- a/refs.h
+++ b/refs.h
@@ -269,8 +269,10 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 			    const unsigned char *old_sha1,
 			    int flags, int have_old, const char *msg);
 
+#define REFLOG_TRUNCATE 0x01
 /*
- * Append a reflog entry for refname.
+ * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
+ * this update will first truncate the reflog before writing the entry.
  */
 int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
-- 
2.0.0.rc3.506.g3739a35
