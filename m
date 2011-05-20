From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH] cache-tree: Teach write_cache_as_tree to discard_cache
Date: Fri, 20 May 2011 08:30:21 +0000
Message-ID: <1305880223-7542-1-git-send-email-artagnon@gmail.com>
References: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 10:30:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNL6R-0005jM-U2
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 10:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934837Ab1ETIa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 04:30:28 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47304 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934634Ab1ETIa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 04:30:26 -0400
Received: by qyg14 with SMTP id 14so1988937qyg.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Nk5cwFz9Vo3iJnB2+6KsmioNywqGiGMt4r7CKmFzmfU=;
        b=r2n+3V7sYsetstWhxfFbVx/Hhi0WbQeWWMXTB4wTG+QDwFsxASbNWaYFwJ+jyy8CG/
         UsNtQaaKFELsVRncC7Ix6hon7lXpBH26tPbKcKwIlHxz8Yev+C6VxDOixjU6I08oNqx9
         iuJ7Pvou+HtL/3L4g2kpQtc3l+VnODfv4Kj3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P9pk6nEkkJQ/8Y+o4iHtaw1N7QYRqUypwlLNA8Azp6kBuExCjJdtDDIHkP85/cZJVH
         wMZb3Gy1xgA3tyTRGka+M+bL/AbXTb1iPvsBQO5pvQxIJF6KRl/zhcX3iSxaT39KeNtH
         fNwODyWOx4OnWyrQNoxAu3w9bPycFCBel7V88=
Received: by 10.224.69.225 with SMTP id a33mr3176403qaj.209.1305880225434;
        Fri, 20 May 2011 01:30:25 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id m9sm2128759qcu.15.2011.05.20.01.30.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2011 01:30:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174050>

If the read_cache() call succeeds, the function must call
discard_cache() before returning to the caller.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 cache-tree.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index f755590..17c5bab 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -573,8 +573,10 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 
 		if (cache_tree_update(active_cache_tree,
 				      active_cache, active_nr,
-				      missing_ok, 0) < 0)
+				      missing_ok, 0) < 0) {
+			discard_cache();
 			return WRITE_TREE_UNMERGED_INDEX;
+		}
 		if (0 <= newfd) {
 			if (!write_cache(newfd, active_cache, active_nr) &&
 			    !commit_lock_file(lock_file))
@@ -591,8 +593,10 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 	if (prefix) {
 		struct cache_tree *subtree =
 			cache_tree_find(active_cache_tree, prefix);
-		if (!subtree)
+		if (!subtree) {
+			discard_cache();
 			return WRITE_TREE_PREFIX_ERROR;
+		}
 		hashcpy(sha1, subtree->sha1);
 	}
 	else
@@ -601,6 +605,7 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 	if (0 <= newfd)
 		rollback_lock_file(lock_file);
 
+	discard_cache();
 	return 0;
 }
 
-- 
1.7.5.GIT
