From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 5/6] Use sorted-array API for commit.c's commit_graft.
Date: Wed,  8 Dec 2010 23:51:34 +0100
Message-ID: <1291848695-24601-6-git-send-email-ydirson@altern.org>
References: <1291848695-24601-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 23:52:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQSs3-0003GC-M9
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107Ab0LHWvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 17:51:50 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:49474 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101Ab0LHWvt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 17:51:49 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 9AFBED48069;
	Wed,  8 Dec 2010 23:51:43 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PQSrL-0006Pu-6a; Wed, 08 Dec 2010 23:51:39 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291848695-24601-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163235>

Factorizing code fixes off-by-one error in the duplicated code (caused
mostly harmless anticipated growing of the array).

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 commit.c |   55 +++++++++++++++++++++----------------------------------
 1 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/commit.c b/commit.c
index b21335e..786bb7a 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "sorted-array.h"
 
 int save_commit_buffer = 1;
 
@@ -89,33 +90,32 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 	return strtoul(dateptr, NULL, 10);
 }
 
-static struct commit_graft **commit_graft;
-static int commit_graft_alloc, commit_graft_nr;
-
-static int commit_graft_pos(const unsigned char *sha1)
+static int commit_graft_cmp(const unsigned char *ref_sha1, struct commit_graft **elem)
 {
-	int lo, hi;
-	lo = 0;
-	hi = commit_graft_nr;
-	while (lo < hi) {
-		int mi = (lo + hi) / 2;
-		struct commit_graft *graft = commit_graft[mi];
-		int cmp = hashcmp(sha1, graft->sha1);
-		if (!cmp)
-			return mi;
-		if (cmp < 0)
-			hi = mi;
-		else
-			lo = mi + 1;
-	}
-	return -lo - 1;
+	return hashcmp(ref_sha1, (*elem)->sha1);
 }
+declare_sorted_array(static, struct commit_graft *, commit_graft);
+declare_sorted_array_search_check(static, struct commit_graft *, commit_graft_pos,
+				  const unsigned char *,
+				  commit_graft, commit_graft_cmp);
 
+// FIXME: do we want to/can we remove INITTYPE from gen_binsearch ?
+static int commit_graft_cmp2(struct commit_graft *ref_graft, struct commit_graft **elem)
+{
+	return commit_graft_cmp(ref_graft->sha1, elem);
+}
+static void commit_graft_init(struct commit_graft **elem, struct commit_graft *ref_graft)
+{
+	*elem = ref_graft;
+}
+declare_sorted_array_insertonly_check(static, struct commit_graft *, register_commit_graft0,
+				      struct commit_graft *,
+				      commit_graft, commit_graft_cmp2, commit_graft_init);
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
-	int pos = commit_graft_pos(graft->sha1);
+	int pos = register_commit_graft0(graft);
 
-	if (0 <= pos) {
+	if (pos >= 0) {
 		if (ignore_dups)
 			free(graft);
 		else {
@@ -124,19 +124,6 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 		}
 		return 1;
 	}
-	pos = -pos - 1;
-	if (commit_graft_alloc <= ++commit_graft_nr) {
-		commit_graft_alloc = alloc_nr(commit_graft_alloc);
-		commit_graft = xrealloc(commit_graft,
-					sizeof(*commit_graft) *
-					commit_graft_alloc);
-	}
-	if (pos < commit_graft_nr)
-		memmove(commit_graft + pos + 1,
-			commit_graft + pos,
-			(commit_graft_nr - pos - 1) *
-			sizeof(*commit_graft));
-	commit_graft[pos] = graft;
 	return 0;
 }
 
-- 
1.7.2.3
