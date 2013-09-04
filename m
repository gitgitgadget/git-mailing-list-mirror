From: Brad King <brad.king@kitware.com>
Subject: [PATCH v4 4/8] refs: factor delete_ref loose ref step into a helper
Date: Wed,  4 Sep 2013 11:22:41 -0400
Message-ID: <d699bcba91dc16500b7762759ce53b6ea4eb9939.1378307529.git.brad.king@kitware.com>
References: <cover.1378142795.git.brad.king@kitware.com> <cover.1378307529.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 04 17:25:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHEx3-0008E7-16
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 17:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935092Ab3IDPYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 11:24:39 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:60242 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934966Ab3IDPYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 11:24:38 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 7FEA19FB93; Wed,  4 Sep 2013 11:22:45 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378307529.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233839>

Factor loose ref deletion into helper function delete_ref_loose to allow
later use elsewhere.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 4347826..ab9d22e 100644
--- a/refs.c
+++ b/refs.c
@@ -2450,24 +2450,31 @@ static int repack_without_ref(const char *refname)
 	return commit_packed_refs();
 }
 
+static int delete_ref_loose(struct ref_lock *lock, int flag)
+{
+	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
+		/* loose */
+		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+
+		lock->lk->filename[i] = 0;
+		err = unlink_or_warn(lock->lk->filename);
+		lock->lk->filename[i] = '.';
+		if (err && errno != ENOENT)
+			return 1;
+	}
+	return 0;
+}
+
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
 	struct ref_lock *lock;
-	int err, i = 0, ret = 0, flag = 0;
+	int ret = 0, flag = 0;
 
 	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
-	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/* loose */
-		i = strlen(lock->lk->filename) - 5; /* .lock */
-		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
-		if (err && errno != ENOENT)
-			ret = 1;
+	ret |= delete_ref_loose(lock, flag);
 
-		lock->lk->filename[i] = '.';
-	}
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
 	 * without it.
-- 
1.8.4.rc3
