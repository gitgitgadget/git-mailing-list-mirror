From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 5/6] Use sorted-array API for commit.c's commit_graft.
Date: Mon, 29 Nov 2010 23:57:20 +0100
Message-ID: <1291071441-11808-6-git-send-email-ydirson@altern.org>
References: <1291071441-11808-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 23:57:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCfK-0001U5-8O
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247Ab0K2W5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:57:44 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:33279 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755046Ab0K2W5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 17:57:42 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id F411BD480D5;
	Mon, 29 Nov 2010 23:57:35 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PNCf5-00035I-F2; Mon, 29 Nov 2010 23:57:31 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291071441-11808-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162440>

Factorizing code fixes off-by-one error in the duplicated code (caused
mostly harmless anticipated growing of the array).

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 commit.c |   62 +++++++++++++++++++++++++++-----------------------------------
 1 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/commit.c b/commit.c
index 0094ec1..5b9a554 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "sorted-array.h"
 
 int save_commit_buffer = 1;
 
@@ -76,33 +77,37 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
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
+declare_gen_binsearch(static, struct commit_graft *, _commit_graft_pos,
+		      const unsigned char *);
+declare_sorted_array_search_check(static, commit_graft_pos, const unsigned char *,
+				  _commit_graft_pos, commit_graft, commit_graft_cmp);
 
+// FIXME: do we want to/can we remove INITTYPE from gen_binsearch ?
+static int commit_graft_cmp2(struct commit_graft *ref_graft, struct commit_graft **elem)
+{
+	return commit_graft_cmp(ref_graft->sha1, elem);
+}
+declare_gen_binsearch(static, struct commit_graft *, _commit_graft_pos2,
+		      struct commit_graft *);
+static void commit_graft_init(struct commit_graft **elem, struct commit_graft *ref_graft)
+{
+	*elem = ref_graft;
+}
+declare_gen_sorted_insert(static, struct commit_graft *, _register_commit_graft0,
+			  _commit_graft_pos2, struct commit_graft *)
+declare_sorted_array_insert_check(static, register_commit_graft0, struct commit_graft *,
+				  _register_commit_graft0, commit_graft,
+				  commit_graft_cmp2, commit_graft_init);
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
-	int pos = commit_graft_pos(graft->sha1);
+	int pos = register_commit_graft0(graft);
 
-	if (0 <= pos) {
+	if (pos >= 0) {
 		if (ignore_dups)
 			free(graft);
 		else {
@@ -111,19 +116,6 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
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
