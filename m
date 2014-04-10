From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/4] refs.c: split delete_ref_loose() into a separate flag-for-deletion and commit phase
Date: Thu, 10 Apr 2014 11:30:23 -0700
Message-ID: <1397154625-11884-3-git-send-email-sahlberg@google.com>
References: <1397154625-11884-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 20:30:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYJkD-0000zY-No
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 20:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758573AbaDJSae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 14:30:34 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:50370 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbaDJSab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 14:30:31 -0400
Received: by mail-pb0-f73.google.com with SMTP id rp16so558554pbb.0
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UrY/AIf+hgr23UYyhEvA2rVaDsV7Z8cnxkkfqrqPLiU=;
        b=BQ5NPfxFZfRucgTPx33GDbfYKLkNJMrD7lol1Up4TLXBQonFLTgD4c8r7ouGzJPqKE
         R2iWJv+UWmGX85s58RC2uLa6PUaAqWBSS9aJwVsTdNa5UTGFdL0k9qnaz7kFATyUNAIR
         eGmWUP1r0X5BA1Uo37EafpjEa3B7uua8M1uexm6HUI6P1UU8IjmC9elkWYOqTjSbBJbH
         d98tKwIQ/EGwcxzyjh8UHEIV5tEw8fhYmddVfLCU1vcS4lEAkxUb1uwss8g5yKUfBCPL
         uCozBDsYXNCGLpE5ZNtP2A2bdiQdSaHO/5Q9l6QuAMf6iOe4rFBEhx9zzyuZV752oxiX
         K9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UrY/AIf+hgr23UYyhEvA2rVaDsV7Z8cnxkkfqrqPLiU=;
        b=CSJY9ryA7fySUs5wfgZ/JWBd1dTSemyrg5zfPpt4M+jDJXSJ0HO5AWmc9NXCNrz5ra
         5KfFxAO5cdxFok9dSRJs/6qf5B9ht0o17IcrzYp2T/2ZIm0qCYS/RodLegJNTHdO8X2+
         QQeAhdhiwd0zRtFoTrIAt9Uy7Bbu0vdgwEBpeKKZbSD3jkR5nQ+ZpkDPbPW1cu8suCn4
         A3FrE0B116Q7c94ilfJRCzOajKuOEaI03N1OLnyTsD3jYKLZV+f5zboKl+VHS7XmRjCi
         qo4RWD9CFSB5fQu4yrjetdwZ+GVlz5qzVNYD8RllSFzljX7wdqCT9QdkfEUYas8/4YrP
         i0YQ==
X-Gm-Message-State: ALoCoQnB9vFrYvdYmtZBkIVurLpV6eKXLoRsI7+JomHtZ4N7GaJh0iDmjJBXalcuQBucaKRLVNCYWRpAZmxQLP89v47zbJ+gGOgBsDQyvIbtOlwltwBCqkN9LgsD/qE1e856N5F5f7MN1eqYQHNYmJgmK2Ln2RCJv9bgW7JXZ0e/EPAG7cGMjDqeS7fgXeOAC5vIXE45Deqb
X-Received: by 10.68.201.134 with SMTP id ka6mr8916029pbc.4.1397154630509;
        Thu, 10 Apr 2014 11:30:30 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g21si798988yhe.3.2014.04.10.11.30.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Apr 2014 11:30:30 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 549C75A4082;
	Thu, 10 Apr 2014 11:30:30 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1776DE0591; Thu, 10 Apr 2014 11:30:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.478.ga5a8238.dirty
In-Reply-To: <1397154625-11884-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246023>

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
1.9.1.478.ga5a8238.dirty
