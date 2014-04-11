From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 3/3] refs.c: change ref_transaction_commit to run the commit loops once all work is finished
Date: Fri, 11 Apr 2014 13:39:50 -0700
Message-ID: <1397248790-10403-4-git-send-email-sahlberg@google.com>
References: <1397248790-10403-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 22:40:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYiFE-0004MG-DY
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 22:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbaDKUkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 16:40:08 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:61734 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605AbaDKUj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 16:39:58 -0400
X-Greylist: delayed 94168 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Apr 2014 16:39:57 EDT
Received: by mail-yh0-f73.google.com with SMTP id c41so848490yho.2
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PGHa/KEKxZUzRfcemswdSM1SX4Kc5EGcRBZ9sGQiyTI=;
        b=XM8drcYomoUeGamEMYdg6JxZE6Sfoc7QDN7jxXIJnriVmMAJuy5w1eylDavKdz7wKk
         jyP6Wexxdu1ZaUy9EQsr0dGXa18b3Za1B+KzL27+VICd8fX/0hIYNL49to6CxgNdpTXo
         Jpoct8Wp6Izw/lwZcFBQBvI/3Q1IXrQ5OI0PtzBr+XvIyK3d9VBfxdXEj5YVr/41iDNn
         tAWqzc8/HIOi1orUrRRwRdCNWXIVpY7fN/L9XMkquiQlL8LxxTik+KRlLyORb24Z1QBb
         5Dyvkbq21XjPS1sLVXK0iupDUQu+JEj3K5DfRZf6b0vEEPSu0dnJH52XsRkcLmfsMWyV
         mWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PGHa/KEKxZUzRfcemswdSM1SX4Kc5EGcRBZ9sGQiyTI=;
        b=knrS0RoM53oiSWREsy+NAlKVwhRsoS3sHk3xOO+KrceAZALYChvYVEpqwT0hLufjJ3
         eLdYn1E2vd8yJX8ZiIxGNvFIXAX88VdhxpC44qk5+Qmennu6CJyv2N1NrM/N2q3Rat1i
         kDP/vJRB9B0fehhkQSwWz79ojRn2iUg0C0UkoC5z8nq86laCVH7Aidr/DqA2uukles93
         v13iGy4SiRXBoOfgPkvrqGvfoGirRMEpH/VFGAo1OGRVRmmAWLdRhY+1Q5DLsv4w4xEB
         TcSayrxxBqEBZgcorElG6WRfbKpX2pWcBGt1F0E6UmZVhySS3umiP1ZgYeGPmqJDvD2y
         gJDg==
X-Gm-Message-State: ALoCoQkaSEBBZT50h5I2yv/anSG4X+r2VZ6gTpf4mjrJgAodUzt6IW+TT6xO2pyvpYbbXvhU1w33pDuWx65uscE8xIvOlS/9LoDs6TkvN8vj4x5YTTQHMC8+gCvWBO4YPe6X/3NA7fj/7oiCPkQolQzI4Uy0XY4sSN+yjyMxBI5Z/GzFQSGvMRGO7ad2foa3fw48/1r5CIA6
X-Received: by 10.58.142.135 with SMTP id rw7mr12026316veb.14.1397248797115;
        Fri, 11 Apr 2014 13:39:57 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si1293556yhb.6.2014.04.11.13.39.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Apr 2014 13:39:57 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id EDA8331C318;
	Fri, 11 Apr 2014 13:39:56 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B0B0FE064B; Fri, 11 Apr 2014 13:39:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.505.g4f1e74f
In-Reply-To: <1397248790-10403-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246147>

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
index ec104f2..293bb43 100644
--- a/refs.c
+++ b/refs.c
@@ -3468,42 +3468,47 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
1.9.1.505.g4f1e74f
