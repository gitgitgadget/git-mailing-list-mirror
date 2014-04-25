From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 15/19] fast-import.c: change update_branch to use ref transactions
Date: Fri, 25 Apr 2014 09:14:50 -0700
Message-ID: <1398442494-23438-16-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:17:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdioX-0001bF-LC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbaDYQQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:16:35 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:43998 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbaDYQPH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:07 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so633201qab.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1CLPOPXv/GxBdhKsBfdKR9pw2FLqoukxjq4ZmB6jW1c=;
        b=SU0LWFAx4LG1ihpu1mBPtSkC5zZ8/Db37o4OJvHUGu9Bmq31KrgSFjw9LOnrH4qqlw
         1r0r0PTQ5WdqhxrBE/Ht/y+zIcfXWLH11IxhkLZwVjPjYNdMOw5ZaCkEUVEwEx559Xdr
         ShCpd12jvKDAcO/uTTfz054xXjNNnl0xahicnsuAtU4Fva5nIC7f+b2jNnXMXyC1lI42
         gxAhGZvVQtOdy0QVY4X29QcCWd+EnZAtuk3eO2TX5L7bpkV9bPK6btomVH9x6IlStxcl
         BqOvqMeuAtE4ONYdqeQqCZj2Lm5NUfEgt8kQZbx2oKjjPt1xJCr/6zvXHj7JivkZQns9
         cfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1CLPOPXv/GxBdhKsBfdKR9pw2FLqoukxjq4ZmB6jW1c=;
        b=TFIihnOGY1Oj5CZZNh0WguUEmmZi6ZibEzIM7PVsQ6Q85EGoup1ZG7k4AFIyx+JUS/
         1vn3UySsCZbZIxgm/1LWaB+eQetoFpEijXVrrF/o4YoWCB5VBjt0ac6cE2gbX1KtmV11
         Qd0ZDgWeJ1wgWBZNH9tpLY6Bl9FDjIscvXmyn8E3OjO28tflhc9LN9Sae8W+XpNGgZw2
         fPYH6OXi3WA3uquQF6x1LGzmnQPheMq3OMmmVRjllocmCYUisK8neijvZRjs5T32rmtJ
         DcituatHQy2Hjra3HSll9zj0kMmVIKmRfGkvfBHdgxsXovDt6G85gIl5rhpp0d8wql+0
         H30Q==
X-Gm-Message-State: ALoCoQl8jkC0/XHIaxjtnjU7QzzmyJXORQE4HRmP39HiE1IaZFR6AIfTsFM0K17zGk62B/epNa9DoUNQHC+WSyAyN2Gq6yxcgXWXvpUhMukFUO2jQX+pL7uguNMD2b7FggBgG1hZqasiYezNfxXpgSJOYXHJXqUbHytv26sGfe1sviBFwNV2vgvDfISpNMRqQAOv+w3hqcKi
X-Received: by 10.58.41.39 with SMTP id c7mr5067852vel.25.1398442507184;
        Fri, 25 Apr 2014 09:15:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r61si1051922yhf.1.2014.04.25.09.15.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0C3E15A4260;
	Fri, 25 Apr 2014 09:15:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B2801E0855; Fri, 25 Apr 2014 09:15:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247068>

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index fb4738d..a2b05fa 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1678,36 +1678,39 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	char *err = NULL;
 
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
+		return error("Unable to update branch %s: %s", b->name, err);
+	}
 	return 0;
 }
 
-- 
1.9.1.521.g5dc89fa
