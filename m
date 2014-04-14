From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 3/3] refs.c: change ref_transaction_commit to run the commit loops once all work is finished
Date: Mon, 14 Apr 2014 11:29:23 -0700
Message-ID: <1397500163-7617-4-git-send-email-sahlberg@google.com>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 20:36:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZlkQ-0007oh-Uk
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 20:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbaDNSgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 14:36:46 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:41767 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaDNSgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 14:36:45 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Apr 2014 14:36:45 EDT
Received: by mail-pd0-f202.google.com with SMTP id fp1so1086953pdb.5
        for <git@vger.kernel.org>; Mon, 14 Apr 2014 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UsH1bnxhJO5coW8+/lRWcm/NDeqldpBBgD78Bpe1fFc=;
        b=HrVBxhysKcc2Mfsp6VnSzLDws6f2XmbsKSfabQBMvmF5GAjxCnx/oPaJq4Z4hzOTy7
         ThNuE82Hr0a2jlNZ3LIEKNvG6Ge/Yx/EgdXNt9maYhQQKDLUtdejfeaIaCf3bhD1sLY5
         qj+poRbcsV70mpzuACdOH6ywXTp1ppwknUKASsuXTfe3s8pJ40uSRZ/jjcBPS865B5dc
         PunwSp7lPjKspLth28nFxWB63ftAiyuiUpy/16j4LYxpcUTtgYo+gRZsfJaZGzbNxl6V
         cozbwjMiUcb+d26WAHiO9JKRaGefDYWY38Mg290cNTmBDsDRKq4GFJ7UwcBy6f3Dn6TP
         w2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UsH1bnxhJO5coW8+/lRWcm/NDeqldpBBgD78Bpe1fFc=;
        b=iQejTW8bEE1v7OAmulm5dA9tE1rfgJl3qLhWF1jqeZueqUbOqeISCz+gxt7H8wklYL
         KpVG63MCSauI/7iYuFt+lxi2urI18vEmqjUGa9oOs2HyUviootszieMuc+br1WbqnQzn
         EHxKRt0M0zzQ0+RMLxggBaEEF7MqZpoDMBUH+FCE5oNFsTe+a9mJsjD6lp50UvfLX8Za
         7PpbrTmTfyTVevRVj8nJton8fbl8059SaU5vkJee6GkeGf0DGMUObhWENkq5q9Pl5lbo
         qfwuk7UVkE+iEbseUvUuwN50WsH4EZaSXeJZocSElkmJ7/rf7tvCCd02qT8VP1hCpH/S
         UtdQ==
X-Gm-Message-State: ALoCoQlcgWfYkPNnKUHRSFPokv/CQRU/9jDum9GqS3tm6GDl/d4L3M4V4g10FQzhzImocX9R1tPvRJtUsHpcpGn3evF45F8wC4gMNiTmZLOf4xHYnYTW0JnQGBLz8Cz28AE8fgYTN3vJE6uGY1rZZo1oOfN4/B98KULkXu4Q7YNCkiCvG7rDPfvqAyJ3g03YYN6ZUsaXPrOA
X-Received: by 10.66.66.109 with SMTP id e13mr20704187pat.1.1397500178745;
        Mon, 14 Apr 2014 11:29:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id u45si2362929yhl.4.2014.04.14.11.29.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Apr 2014 11:29:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8DCD631C230;
	Mon, 14 Apr 2014 11:29:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 50EA9E08C1; Mon, 14 Apr 2014 11:29:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.505.gd05696d
In-Reply-To: <1397500163-7617-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246254>

During a transaction commit we will both update and delete refs.
Since both update and delete now use the same pattern

    lock = lock_ref_sha1_basic() (or varient of)
    write_ref_sha1(lock)/delete_ref_loose(lock)
    unlock_ref(lock) | commit_ref_lock(lock)

we can now simplify ref_transaction_commit to have one loop that locks all
involved refs.
A second loop that writes or flags for deletion, but does not commit, all
the refs.
And a final third loop that commits all the refs once all the work and
preparations are complete.

This makes updating/deleting multiple refs more atomic since we will not start
the commit phase until all the preparations have completed successfully.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index a14addb..87193c7 100644
--- a/refs.c
+++ b/refs.c
@@ -3467,42 +3467,47 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	/* Perform updates first so live commits remain referenced */
+	/* Prepare all the updates/deletes */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (!is_null_sha1(update->new_sha1)) {
+		if (!is_null_sha1(update->new_sha1))
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
 					       update->lock, onerr);
-			if (ret)
-				unlock_ref(update->lock);
-			else
-				commit_ref_lock(update->lock);
-			update->lock = NULL;
-			if (ret)
-				goto cleanup;
+		else {
+			delnames[delnum++] = update->refname;
+			ret = delete_ref_loose(update->lock, update->type);
 		}
+		if (ret)
+			goto cleanup;
 	}
 
-	/* Perform deletes now that updates are safely completed */
+	ret |= repack_without_refs(delnames, delnum);
+	for (i = 0; i < delnum; i++)
+		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	clear_loose_ref_cache(&ref_cache);
+
+	/* Perform updates first so live commits remain referenced */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->lock && !update->lock->delete_ref) {
+			ret |= commit_ref_lock(update->lock);
+			update->lock = NULL;
+		}
+	}
+	/* And finally perform all deletes */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->refname;
-			ret |= delete_ref_loose(update->lock, update->type);
 			ret |= commit_ref_lock(update->lock);
 			update->lock = NULL;
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum);
-	for (i = 0; i < delnum; i++)
-		unlink_or_warn(git_path("logs/%s", delnames[i]));
-	clear_loose_ref_cache(&ref_cache);
-
 cleanup:
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
-- 
1.9.1.505.gd05696d
