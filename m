From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC 4/7] refs: factor delete_ref loose ref step into a helper
Date: Thu, 29 Aug 2013 10:11:52 -0400
Message-ID: <f5a6f3552b16519b6568a7c745ab61c26bc4a072.1377784597.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 16:22:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF37M-0000xR-B9
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 16:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab3H2OW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 10:22:28 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:48741 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754492Ab3H2OWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 10:22:15 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 755489FB8B; Thu, 29 Aug 2013 10:11:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377784597.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233262>

Factor loose ref deletion into helper function delete_ref_loose to allow
later use elsewhere.  While at it, rename local names 'flag => type' and
'delopt => flags' for consistency with callers and called functions.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 2e755b4..5908648 100644
--- a/refs.c
+++ b/refs.c
@@ -2450,15 +2450,10 @@ static int repack_without_ref(const char *refname)
 	return commit_packed_refs();
 }
 
-int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
+static int delete_ref_loose(struct ref_lock *lock, int type)
 {
-	struct ref_lock *lock;
-	int err, i = 0, ret = 0, flag = 0;
-
-	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
-	if (!lock)
-		return 1;
-	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
+	int err, i, ret = 0;
+	if (!(type & REF_ISPACKED) || type & REF_ISSYMREF) {
 		/* loose */
 		i = strlen(lock->lk->filename) - 5; /* .lock */
 		lock->lk->filename[i] = 0;
@@ -2468,6 +2463,19 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 		lock->lk->filename[i] = '.';
 	}
+	return ret;
+}
+
+int delete_ref(const char *refname, const unsigned char *sha1, int flags)
+{
+	struct ref_lock *lock;
+	int ret = 0, type = 0;
+
+	lock = lock_ref_sha1_basic(refname, sha1, flags, &type);
+	if (!lock)
+		return 1;
+	ret |= delete_ref_loose(lock, type);
+
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
 	 * without it.
-- 
1.7.10.4
