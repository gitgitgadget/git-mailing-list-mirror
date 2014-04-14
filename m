From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 2/3] refs.c: split delete_ref_loose() into a separate flag-for-deletion and commit phase
Date: Mon, 14 Apr 2014 11:29:22 -0700
Message-ID: <1397500163-7617-3-git-send-email-sahlberg@google.com>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 20:29:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZldY-00065D-LP
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 20:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbaDNS3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 14:29:39 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:42593 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbaDNS3i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 14:29:38 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so1236690qcz.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2014 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BuLQ5B0p7CBH+SV4DUfR12tTiWEeAndPACz5a27xFGk=;
        b=n96kNGz6WeLmFc2n2/b5G22fokooLRnCb9AzQW1JN3W+ffgaZnay2wgQQvoaY/HpR6
         L+LmTHnDDXWcTsiiW8v3u78Q2Qint2bIrwTbfr0u65vKaoIVPKQ4rTzWnvc2SxXnHYfC
         nUzVxaYxWEZUf8XEYs4TcKX8SH7U/14LSHztSZycyvWZMlCJhlhZ9XiX5YKzKGUSXw/9
         xx66RVYKsbaycseA3ECMt8wascNbgwqkrNelN3YdLUDNbP+tNWZG0cFBuQQ6EdMHviyL
         Uje0mw4gJs7SMl4ZmDXUZVAyWJsM5Pw/pL2uddgXw93AM+j+KvST7ffkesu2HzwTdBy0
         XG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BuLQ5B0p7CBH+SV4DUfR12tTiWEeAndPACz5a27xFGk=;
        b=INKWknchYusznaU8mFh0UZXkWHzW35UkT9sClep63VaOV/VD7BK2Kl0FBGrQI9BmIu
         hGBi10r89qmXMZRP9oG7mhAXLwVOEuoXwvlom1CMGP4yLLxdC8GX+iSPB1elK/VX0qzO
         V4gUsT5J20eqbuIq92xvmbCrc862J9WPjspSCRubAtPrbDx/Ieq+4jb9fMKpLo/U7scz
         EQNGYoIg8yRFxVkUGsCeTLof4KrQjxgQdyRC3el3LlsDpxS+FQL4wmvN5hkMvik6+ZM/
         /Jx6QTPOihc0dyZZuewIQT5L9Iu01VfD6fZnGN3GYqLK2ea/ZhFfkEVAKsh0FDGtLqP+
         SiMg==
X-Gm-Message-State: ALoCoQnQP2stA0HmTFOfIaMsrSGL+vHFk/69O8qO3bGNRjxpxtlIsgeELGKSI3PS7dAlgXYEBcJ/yWPz3Gl8rdbmrVNa6AdfYs8IZXVwDhjDg/9lgzDek09UpwvjsygAQzK2YnyDuZcOolw0N19xl5SR0XFJWtA4wEZCZVACSYZjMNf6X1hxvKedhnlPIBkNm01lR7ZyD+SM
X-Received: by 10.58.30.78 with SMTP id q14mr19983659veh.10.1397500177397;
        Mon, 14 Apr 2014 11:29:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si2363681yhe.3.2014.04.14.11.29.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Apr 2014 11:29:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 31D8D31C1E3;
	Mon, 14 Apr 2014 11:29:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E6FAEE08C1; Mon, 14 Apr 2014 11:29:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.505.gd05696d
In-Reply-To: <1397500163-7617-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246252>

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
 refs.c | 32 ++++++++++++++++++++------------
 refs.h |  2 ++
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 646afd7..a14addb 100644
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
 
@@ -2868,7 +2861,20 @@ int write_ref_sha1(struct ref_lock *lock,
 
 int commit_ref_lock(struct ref_lock *lock)
 {
-	if (!lock->skipped_write && commit_ref(lock)) {
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
+	} else if (!lock->skipped_write && commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3487,6 +3493,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
1.9.1.505.gd05696d
