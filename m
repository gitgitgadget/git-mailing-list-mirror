From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/3] Split delete_ref_loose() into a separate flag-for-deletion and commit phase
Date: Tue,  8 Apr 2014 16:21:23 -0700
Message-ID: <1396999284-4691-3-git-send-email-sahlberg@google.com>
References: <1396999284-4691-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 01:21:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXfKo-0007MX-NB
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 01:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758037AbaDHXVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 19:21:34 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:63071 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756846AbaDHXVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 19:21:30 -0400
Received: by mail-pb0-f74.google.com with SMTP id md12so225137pbc.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZeyboVJXefHtOc+idGJBeVs9iAe5R2SbflLNzekPSiM=;
        b=cuCZdflxaBx6wdkc/fM7Ln8odn4qyA0zdqwUKWM03Vo0QhjiwZOCDJF9deZ3AmgLXM
         z+BqnJG/YU3WTtT5Sb+8J7P5df5PzywJMl2TnQtyQiKaMUbFQ9fmvVGq0ZDTJ2ZvCIhs
         38/bvdFF25PHkMHiTjEh+W9iWbvfPyI9GDk96U0NV3Tf6MTXzGGP4GZtQsE3CYnFvPe8
         DRa/FofEqS+JRs2v55q30mtIfpyNaCJoVSzNQ0kmoZVJlkVm3Q+rcenJ7NJGG6EesXb6
         vSb9qiG0lr1nm3V06N0yF8QILiU6y11DvVT4e77CbcA9wPuLoZt9B65gbXwZOA3Ti4gg
         NOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZeyboVJXefHtOc+idGJBeVs9iAe5R2SbflLNzekPSiM=;
        b=isgCk9cbij9pViHGOb8fJCPfTqQzAyzrNdU5si+vUglwm9RCt8GTygDmfNy2nTk0XD
         cQ6yzlytxErTm96fmb8uIA4ZDIL0uEzJ7TW/iDUl4/bbxNEmUe6jMzqSGiSCj8uFvzm1
         QTKQ1GuzAaJTLgJ2Hw4AwCEoFTbAkAfd57YUp4tbInWeyJq+CiORaA+cDyDqkPM0mYZT
         qlMK42JVl8407uvvszFf6RJu4o02plKFYmiy9MHxkvtTXaPjtT5B5Cfo5dkMz0ZH65m6
         ituk+4ktwpbM+dFH9hPeML/L645ccB5DzSkjg/AXeVMS16AmnYf7ctxBx8oynMo+UaQ+
         4WgQ==
X-Gm-Message-State: ALoCoQkz5At0fzM9pT3MUKZExsuZ9iyM/UUi04LOfAsdhXdtTJrRB4PPjzeUZN99LZtjzGHCjKvORclmN9qWk5/t29Ny3WwZ1td0R+7yJRHkKOD/BVBi0LVwNjhNA6qcaT0ZLqOD1qzDDQ+L8ZD0lLFU1NocFu3rbojF7QlPR7xjaeaTHLUbL7ovQa2PMv+6rivmYRZZLHJl
X-Received: by 10.68.230.193 with SMTP id ta1mr3256845pbc.6.1396999290179;
        Tue, 08 Apr 2014 16:21:30 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si689776yhb.6.2014.04.08.16.21.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Apr 2014 16:21:30 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id EFEC931C25D;
	Tue,  8 Apr 2014 16:21:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B2615E07A7; Tue,  8 Apr 2014 16:21:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.477.g7668a0d.dirty
In-Reply-To: <1396999284-4691-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245968>

Change delete_ref_loose()) to just flag that a ref is to be deleted but do
not actually unlink the files.
Change commit_ref_lock() so that it will unlink refs that are flagged for
deletion.
Change all callers of delete_ref_loose() to explicitely call commit_ref_lock()
to commit the deletion.

The new pattern for deleting loose refs thus become:

lock = lock_ref_sha1_basic() (or varient of)
delete_ref_loose(lock)
unlock_ref(lock) | commit_ref_lock(lock)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 31 ++++++++++++++++++++-----------
 refs.h |  2 ++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 9771237..038614d 100644
--- a/refs.c
+++ b/refs.c
@@ -2484,16 +2484,9 @@ static int repack_without_ref(const char *refname)
 
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
-	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
-
-		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
-		lock->lk->filename[i] = '.';
-		if (err && errno != ENOENT)
-			return 1;
-	}
+	lock->delete_ref = 1;
+	lock->delete_flag = flag;
+
 	return 0;
 }
 
@@ -2515,7 +2508,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
 	clear_loose_ref_cache(&ref_cache);
-	unlock_ref(lock);
+	ret |= commit_ref_lock(lock);
 	return ret;
 }
 
@@ -2868,6 +2861,20 @@ int write_ref_sha1(struct ref_lock *lock,
 
 int commit_ref_lock(struct ref_lock *lock)
 {
+	if (lock->delete_ref) {
+		int flag = lock->delete_flag;
+
+		if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
+			/* loose */
+			int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+
+			lock->lk->filename[i] = 0;
+			err = unlink_or_warn(lock->lk->filename);
+			lock->lk->filename[i] = '.';
+			if (err && errno != ENOENT)
+				return 1;
+		}
+	} else
         if (!lock->skipped_write && commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
@@ -3382,6 +3389,8 @@ int update_refs(const char *action, const struct ref_update **updates_orig,
 		if (locks[i]) {
 			delnames[delnum++] = locks[i]->ref_name;
 			ret |= delete_ref_loose(locks[i], types[i]);
+			ret |= commit_ref_lock(locks[i]);
+			locks[i] = NULL;
 		}
 	ret |= repack_without_refs(delnames, delnum);
 	for (i = 0; i < delnum; i++)
diff --git a/refs.h b/refs.h
index 0382128..2230d67 100644
--- a/refs.h
+++ b/refs.h
@@ -9,6 +9,8 @@ struct ref_lock {
 	int lock_fd;
 	int force_write;
 	int skipped_write;
+	int delete_ref;
+	int delete_flag;
 };
 
 /**
-- 
1.9.1.477.g7668a0d.dirty
