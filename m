From: Brad King <brad.king@kitware.com>
Subject: [PATCH v6 4/8] refs: factor delete_ref loose ref step into a helper
Date: Mon,  9 Sep 2013 20:57:42 -0400
Message-ID: <3795a3f88051f01fb2ced6f4bef1f91a6f812a9b.1378773895.git.brad.king@kitware.com>
References: <cover.1378732710.git.brad.king@kitware.com> <cover.1378773895.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 03:00:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJCJS-0007RA-RN
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 03:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756476Ab3IJBAC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 21:00:02 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:41686 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756372Ab3IJBAB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 21:00:01 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 95A699FB93; Mon,  9 Sep 2013 20:57:46 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378773895.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234411>

Factor loose ref deletion into helper function delete_ref_loose to allow
later use elsewhere.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index f7d3c09..b14f59b 100644
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
