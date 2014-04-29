From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 15/30] fast-import.c: change update_branch to use ref transactions
Date: Tue, 29 Apr 2014 15:19:00 -0700
Message-ID: <1398809955-32008-16-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:21:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGP7-0003nO-JM
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965335AbaD2WUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:30 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:59914 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965277AbaD2WTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:24 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so167846pab.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H2GZudY4mWdmMh+qLU+PyZu0Zuq9/tt8mZmGpL5NJzg=;
        b=XipEB5TwGm4W2DaBKROVq6sESLUv5XLISyvuOyrWqhKAq/9tchBSEILXgEXrUQ0mTX
         lvwSFBpJJ2SjI+AjSHr5GpWxA+UobAg7F3/qPtcDboxyyIvLnXbhwUq0R0nx0iA1UsCp
         iTJmXVoP7h/Y/RVyBcjLSfXnrcDK3uagnvtmWJ/xDvDj7D7Dv5pwtwQ9q4LTuzUqeIKc
         +xLJYNpwrtyIXDyFYEy2ZHygvFV2gXgCrnrYWfCKPQj4kr+R036aauCXzn7/5wWQ28Ac
         thR1kw9nX5KXIAFQHbFVFeQBiZfSFBKQv5HaLFpJKTAdqZFFm/40lfZT2/ar8yljfMDu
         tzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H2GZudY4mWdmMh+qLU+PyZu0Zuq9/tt8mZmGpL5NJzg=;
        b=LY2/Ayu1ZHqzxUjWp18FNZwBTNuNwqal4lKxTBa7QcEBnHebUEPu8cB+JavXjqoiaD
         SQ6Zbk5M7K5hrLN0pjHZfIZ4h/Sc7umgxjkprFTq+K0heSXuYPKa4uRT1ekjLH1W58uZ
         F+bwDwxD8xuVCbSvMV9CMdslLP5mLnq+M6iXTLPENPyyy8WQihFg3ri3BeC68idaoLNz
         KBoSzrd5BFWwuNlENlYXuqN0CiFy7HIE6bjuBhOB4HEd7ABwJ5RcyqkisUTmzKCvFr05
         DyxaEJ2hANB9JvmPUZ9oFPrHM6sgY6jA4uaSTNEd+wJlrq8bwg1S+gz+gyiMyjhGN5SF
         M+Ug==
X-Gm-Message-State: ALoCoQnlkuVHwhT/5IHIFspRPbP1jrzjAgOd+KJBrgDQm8BLxke9zP0brbAZvXR5QtsAH3jFyhCvPZOV+IgapwpO0BToQcJawB94MHD6SPX1DMil4Z0bumuRmH13EgBNCwTlnYHT1BSdWhhuYeA1oIHJ8ZSdIpH9/pNWvzwabWBbV+dm2osJQv/Qv/fdNH02UoMtgAPrJLLl
X-Received: by 10.66.232.38 with SMTP id tl6mr281051pac.33.1398809963902;
        Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si1400116yhh.0.2014.04.29.15.19.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AE64B31C20C;
	Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 734B8E0B2F; Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247651>

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index fb4738d..35de36a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1678,36 +1678,41 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (is_null_sha1(b->sha1))
 		return 0;
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
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
1.9.1.532.gf8485a6
