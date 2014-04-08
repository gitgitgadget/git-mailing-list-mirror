From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 3/3] Change update_refs to run a single commit loop once all work is finished.
Date: Tue,  8 Apr 2014 16:21:24 -0700
Message-ID: <1396999284-4691-4-git-send-email-sahlberg@google.com>
References: <1396999284-4691-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 01:21:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXfKw-0007QP-0z
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 01:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929AbaDHXVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 19:21:33 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:64010 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757875AbaDHXVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 19:21:31 -0400
Received: by mail-ob0-f202.google.com with SMTP id wo20so359476obc.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D2He6Qs/p9mxs/2qKR4MMd8AqxeqSCJY+DD2ANJBD/M=;
        b=Fux/q/NzYvNbzZ/RYNEuaEokfNQAW4y+KzEpgUSA6N+OxPy17t2FkbmFK2sBsRV+ar
         RLUxUvLda+0Owgh9VGegA3ELdV9tyGY/hqr+duPlG3hAPS26iXznHz+TkXHeC+sPI7ES
         AkNIF5ndOqkNUXOWD6ZUlPDYuAG513siCUXuwLKqJ/g5RCERZHP72wULrpzxhS0lUD3G
         m6xY3lQH1couHB5oByZxxXXxRH2xXEeDMKW4Jwv3333DXlrAHCr9HUhgRVGl1B5D6iXA
         kLLF8W/yYD3hzOQAKalJ1cVFu08mY/iX7nPxvJpAySSehgrhduQ2a761oLQ/Qm5mVSLN
         7L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D2He6Qs/p9mxs/2qKR4MMd8AqxeqSCJY+DD2ANJBD/M=;
        b=eheWTjjmTD5H8H1ZNfjEwqx5mEeAwZfWyx8BndyyPdc+PENGVG7Mefv2W1PE1Yol5a
         499AKYvJ9XCp/zIOv3+rWZ2eHTgamrE5zeGJ0fr17g0rwCeO09LmehCfIEJDeCeqHx0H
         +MyRYFFK1hmkRP02oz1UdF4MN4FwAlmMFZqMm7gGO+r75QnZeTsTCd0f4jWcjVN16Q7S
         ryRIjNTwD4FkIIPPv4uPknF6xpcWvTk7E4WVF+6hBVy+9AeFq+Wt7/9QgvQSvkXe09fh
         DZ+gmAbR5l1YAkBVZHT2wty+3z5aiEvF/3gPLA6mVf9sJxO1hvbhZYZi0s0PSgptBNl0
         WDEQ==
X-Gm-Message-State: ALoCoQnFf2PeFrqvAETiJTkLegtv7qZENruafHgp0/7bxyPTColdbtNZbhlsC0+CZw9xoLxTfLtDh3YuijCrIVkF7XQSBME/Op0mWmaKe4ZQe2y3TIa9MboBWEtudOrcpJoNVkU6mlDVP1hNc4PJgkaKUx8sEAJZtYsAO6LgLjZQiLxmVpuU9Ik1LVk3uLplhU2sviqt6KlN
X-Received: by 10.182.16.199 with SMTP id i7mr3237175obd.42.1396999290818;
        Tue, 08 Apr 2014 16:21:30 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g21si691891yhe.3.2014.04.08.16.21.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Apr 2014 16:21:30 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A66D05A4223;
	Tue,  8 Apr 2014 16:21:30 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 69594E07A7; Tue,  8 Apr 2014 16:21:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.477.g7668a0d.dirty
In-Reply-To: <1396999284-4691-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245969>

During update_refs we will both be deleting refs as well as updating/changing
the refs.
Since both delete and update now use the same lock/update/commit pattern

    lock = lock_ref_sha1_basic() (or varient of)
    write_ref_sha1(lock)/delete_ref_loose(lock)
    unlock_ref(lock) | commit_ref_lock(lock)

we can now simplify update_update refs to have one loop that locks all
involved refs.
A second loop that writes or flags for deletion, but does not commit, all
the refs.
And a final third loop that commits all the refs once all the work and
preparations are complete.

This makes updating/deleting multiple refs 'more atomic' since we will not start
the commit phase until all the preparations have completed successfully.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 038614d..e94099b 100644
--- a/refs.c
+++ b/refs.c
@@ -3369,33 +3369,31 @@ int update_refs(const char *action, const struct ref_update **updates_orig,
 	}
 
 	/* Perform updates first so live commits remain referenced */
-	for (i = 0; i < n; i++)
-		if (!is_null_sha1(updates[i]->new_sha1)) {
+	for (i = 0; i < n; i++) {
+		if (!is_null_sha1(updates[i]->new_sha1))
 			ret = update_ref_write(action,
 					       updates[i]->ref_name,
 					       updates[i]->new_sha1,
 					       locks[i], onerr);
-			if (ret)
-				unlock_ref(locks[i]);
-			else
-				commit_ref_lock(locks[i]);
-			locks[i] = NULL;
-			if (ret)
-				goto cleanup;
+		else {
+			delnames[delnum++] = locks[i]->ref_name;
+			ret = delete_ref_loose(locks[i], types[i]);
 		}
+		if (ret)
+			goto cleanup;
+	}
 
-	/* Perform deletes now that updates are safely completed */
+	ret = repack_without_refs(delnames, delnum);
+	for (i = 0; i < delnum; i++)
+		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	clear_loose_ref_cache(&ref_cache);
+
+	/* Commit all the updates/deletions */
 	for (i = 0; i < n; i++)
 		if (locks[i]) {
-			delnames[delnum++] = locks[i]->ref_name;
-			ret |= delete_ref_loose(locks[i], types[i]);
 			ret |= commit_ref_lock(locks[i]);
 			locks[i] = NULL;
 		}
-	ret |= repack_without_refs(delnames, delnum);
-	for (i = 0; i < delnum; i++)
-		unlink_or_warn(git_path("logs/%s", delnames[i]));
-	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
 	for (i = 0; i < n; i++)
-- 
1.9.1.477.g7668a0d.dirty
