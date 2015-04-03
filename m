From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 3/4] diff --cc: relax too strict paths picking
Date: Fri,  3 Apr 2015 18:58:35 +0300
Message-ID: <1428076716-4449-4-git-send-email-max@max630.net>
References: <1428006853-21212-1-git-send-email-max@max630.net>
 <1428076716-4449-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 17:59:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye400-0007sj-II
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 17:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbbDCP65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 11:58:57 -0400
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:46660
	"EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753181AbbDCP6h (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 11:58:37 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-03.prod.phx3.secureserver.net with 
	id BTyS1q0045B68XE01Tya3J; Fri, 03 Apr 2015 08:58:36 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1428076716-4449-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266708>

For diff --cc, paths fitering used to select only paths which have
changed in all parents, while diffing itself output hunks which are
changed in as few as 2 parents.

Fix intersect_paths() to add paths which have at least 2 changed
parents. In this new functionality does not require special treatment of
first pass, because path can be added from any parent, not just the
first one.

Signed-off-by: Max Kirillov <max@max630.net>
---
 combine-diff.c                                    | 56 ++++++++++++++++-------
 t/t4059-diff-cc-not-affected-by-path-filtering.sh |  4 +-
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index a236bb5..2285c7c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -25,6 +25,7 @@ static int compare_paths(const struct combine_diff_path *one,
 static void insert_path(struct combine_diff_path **pos, const char* path, int n, int num_parent, struct diff_filepair *queue_item)
 {
 	int len;
+	int parent_idx;
 	struct combine_diff_path *p;
 
 	len = strlen(path);
@@ -41,43 +42,64 @@ static void insert_path(struct combine_diff_path **pos, const char* path, int n,
 	hashcpy(p->parent[n].oid.hash, queue_item->one->sha1);
 	p->parent[n].mode = queue_item->one->mode;
 	p->parent[n].status = queue_item->status;
+	for (parent_idx = 0; parent_idx < n; parent_idx++) {
+		hashcpy(p->parent[parent_idx].oid.hash, p->oid.hash);
+		p->parent[parent_idx].mode = p->mode;
+		p->parent[parent_idx].status = ' ';
+	}
 	*pos = p;
 }
 
+static int changed_parents(struct combine_diff_path *p, int n)
+{
+	int parent_idx;
+	int result = 0;
+
+	for (parent_idx = 0; parent_idx < n; parent_idx++) {
+		if (p->parent[parent_idx].status != ' ')
+			result++;
+	}
+
+	return result;
+}
+
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct combine_diff_path *p, **tail = &curr;
 	int i, cmp;
 
-	if (!n) {
-		for (i = 0; i < q->nr; i++) {
-			if (diff_unmodified_pair(q->queue[i]))
-				continue;
-			insert_path(tail, q->queue[i]->two->path, n, num_parent, q->queue[i]);
-			tail = &(*tail)->next;
-		}
-		return curr;
-	}
-
 	/*
 	 * paths in curr (linked list) and q->queue[] (array) are
 	 * both sorted in the tree order.
 	 */
 	i = 0;
-	while ((p = *tail) != NULL) {
-		cmp = ((i >= q->nr)
-		       ? -1 : compare_paths(p, q->queue[i]->two));
+	while ((p = *tail) != NULL || i < q->nr) {
+		cmp = (i >= q->nr) ? -1
+		      : (p == NULL) ? 1
+		      : compare_paths(p, q->queue[i]->two);
 
 		if (cmp < 0) {
-			/* p->path not in q->queue[]; drop it */
-			*tail = p->next;
-			free(p);
+			/* p->path not in q->queue[] */
+			if (num_parent > 2 && 2 - changed_parents(p, n) <= num_parent - n - 1) {
+				/* still can get 2 changed parents */
+				hashcpy(p->parent[n].oid.hash, p->oid.hash);
+				p->parent[n].mode = p->mode;
+				p->parent[n].status = ' ';
+				tail = &p->next;
+			} else {
+				*tail = p->next;
+				free(p);
+			}
 			continue;
 		}
 
 		if (cmp > 0) {
-			/* q->queue[i] not in p->path; skip it */
+			/* q->queue[i] not in p->path */
+			if (1 <= num_parent - n - 1) {
+				insert_path(tail, q->queue[i]->two->path, n, num_parent, q->queue[i]);
+				tail = &(*tail)->next;
+			}
 			i++;
 			continue;
 		}
diff --git a/t/t4059-diff-cc-not-affected-by-path-filtering.sh b/t/t4059-diff-cc-not-affected-by-path-filtering.sh
index 3e6e59b..ab3dbd2 100755
--- a/t/t4059-diff-cc-not-affected-by-path-filtering.sh
+++ b/t/t4059-diff-cc-not-affected-by-path-filtering.sh
@@ -95,12 +95,12 @@ test_expect_success 'diff with mergebase shows discarded change from parent 1 in
 	test -s actual
 '
 
-test_expect_failure 'diff with mergebase shows fully discarded file from parent 2' '
+test_expect_success 'diff with mergebase shows fully discarded file from parent 2' '
 	git diff --cc merge branch1 branch2 mergebase -- short/win1 >actual &&
 	test -s actual
 '
 
-test_expect_failure 'diff with mergebase shows fully discarded file from parent 1' '
+test_expect_success 'diff with mergebase shows fully discarded file from parent 1' '
 	git diff --cc merge branch1 branch2 mergebase -- short/win2 >actual &&
 	test -s actual
 '
-- 
2.3.4.2801.g3d0809b
