From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 4/8] refs: factor delete_ref loose ref step into a helper
Date: Fri, 30 Aug 2013 14:12:02 -0400
Message-ID: <aa8dc7fb089894b43fdf25e2e0e144229db544a6.1377885441.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 20:13:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFTCh-0007cv-W7
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab3H3SNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 14:13:48 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:50943 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755264Ab3H3SNq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 14:13:46 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id D2B089FB8C; Fri, 30 Aug 2013 14:12:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377885441.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233451>

Factor loose ref deletion into helper function delete_ref_loose to allow
later use elsewhere.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 2e755b4..5dd86ee 100644
--- a/refs.c
+++ b/refs.c
@@ -2450,14 +2450,9 @@ static int repack_without_ref(const char *refname)
 	return commit_packed_refs();
 }
 
-int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
+static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
-	struct ref_lock *lock;
-	int err, i = 0, ret = 0, flag = 0;
-
-	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
-	if (!lock)
-		return 1;
+	int err, i, ret = 0;
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
 		i = strlen(lock->lk->filename) - 5; /* .lock */
@@ -2468,6 +2463,19 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 		lock->lk->filename[i] = '.';
 	}
+	return ret;
+}
+
+int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
+{
+	struct ref_lock *lock;
+	int ret = 0, flag = 0;
+
+	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
+	if (!lock)
+		return 1;
+	ret |= delete_ref_loose(lock, flag);
+
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
 	 * without it.
-- 
1.7.10.4
