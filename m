From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 2/3] refs.c: split delete_ref_loose() into a separate flag-for-deletion and commit phase
Date: Fri, 11 Apr 2014 13:39:49 -0700
Message-ID: <1397248790-10403-3-git-send-email-sahlberg@google.com>
References: <1397248790-10403-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 22:40:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYiFA-0004Iu-MD
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 22:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbaDKUj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 16:39:58 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:39546 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbaDKUj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 16:39:56 -0400
Received: by mail-ie0-f201.google.com with SMTP id rd18so1225302iec.0
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GDmpQ5ByrGu5iI08WlbuQYQKTu3QqY2qi802Ia+Vc1I=;
        b=hRtX1I1vBFw/Ta0yChd16URgYd3rmg+SoJERtkvVCOOXcJJR05JSKcvNm7YfIoO/uo
         v2JYzR4b70Zfc5Xca0B486nFW1xJQhoDsLKJnO0uzASaP8467V9vJQPrsk1/MpGmJu74
         wKVZyvjdYPSRKcGbIm+dSCpDwCx6vVs6olR28CaNBAVKegUmw+jw9rpF9egu/AXu6jHv
         sxmQZSun7H7AI3jc30j7avX8waRyEW9/sKjMJHp9BsXO3wNnMI2NqA6SqpEdZXpfXI8K
         SzD7OMvhbK91ufAot5dkY99pDwwaBGLM4BiDc9xSazrr3ehXJLTdx3MD3fPthoJdz2Tr
         0/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GDmpQ5ByrGu5iI08WlbuQYQKTu3QqY2qi802Ia+Vc1I=;
        b=kJvMSageJ+CGpKnJVsgJhqoy6o1EYMtIz54TzefFdly6mw3M22tbJWNw120UJbv0ta
         PFzOVm2na7oTdvTY6ulkcsXH0j2pI+qdYoFk8lJkJ/8mI201Eg8ilSwkj0VqzR+mjdDV
         CfS+abraiQotopsf4u45XHj6DAd53yh65Vi5abm1FaQ5sAe0M7zZtAcRKTQWOjjlq/0x
         DX8c/Q2iPj01IVYw+r99UhyOy+nukJybr9QlVxmAMwMluSCqS4VZBCbD7gQelGV+ePCQ
         Npm2CqB5zedGOJrTWM6GpoFk5LGKKtgkrpbRSj7cTtakw/x1n4IItlxD9Jg0Uyy5AXvd
         JbJg==
X-Gm-Message-State: ALoCoQkVJQL7UY6K2ygDVGN5VI8iqnKGZhOGcQUUtb12uy1/Ii/GdzWUGFIfQUyk4wvfNJs51tN/MBBKV/vuUs2G7CubPfU8NIHdZ1YG1nCV+FFHKJjfdevT9Vau/c7d0te/jzEUbpW9eQALDGjKtpuyvPOjOhNoxzERp2BijRFARu6oK/uZmSLAZSov/klM2JpYiEPMcB46
X-Received: by 10.182.28.99 with SMTP id a3mr13011893obh.40.1397248795515;
        Fri, 11 Apr 2014 13:39:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si1294013yhd.5.2014.04.11.13.39.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Apr 2014 13:39:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5AB5F31C255;
	Fri, 11 Apr 2014 13:39:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1E019E064B; Fri, 11 Apr 2014 13:39:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.505.g4f1e74f
In-Reply-To: <1397248790-10403-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246146>

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
index 815e328..ec104f2 100644
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
@@ -3487,6 +3494,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		if (update->lock) {
 			delnames[delnum++] = update->refname;
 			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= commit_ref_lock(update->lock);
+			update->lock = NULL;
 		}
 	}
 
diff --git a/refs.h b/refs.h
index f14a417..223be30 100644
--- a/refs.h
+++ b/refs.h
@@ -9,6 +9,8 @@ struct ref_lock {
 	int lock_fd;
 	int force_write;
 	int skipped_write;
+	int delete_ref;
+	int delete_flag;
 };
 
 struct ref_transaction;
-- 
1.9.1.505.g4f1e74f
