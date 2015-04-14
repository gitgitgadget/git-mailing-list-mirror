From: Max Kirillov <max@max630.net>
Subject: [PATCH/RFC] combine-diff.c: make intersect_paths() behave like hunk filtering
Date: Tue, 14 Apr 2015 07:09:13 +0300
Message-ID: <1428984553-11363-1-git-send-email-max@max630.net>
References: <20150412054332.GA28555@wheezy.local>
Cc: Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 06:09:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhsAH-00048g-Pg
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 06:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbbDNEJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 00:09:30 -0400
Received: from p3plsmtpa11-05.prod.phx3.secureserver.net ([68.178.252.106]:41192
	"EHLO p3plsmtpa11-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750715AbbDNEJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2015 00:09:28 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-05.prod.phx3.secureserver.net with 
	id Fg9K1q0085B68XE01g9SHK; Mon, 13 Apr 2015 21:09:28 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-reply-to: <20150412054332.GA28555@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267113>

* for `diff --cc` 2 cases:
  * the path must be changed since at least 2 parents, which
    should have the path different. In other words, the child and its
    parents must contain at least 3 different versions of file.
    Non-existing in the commit path counts as one version.
  * All parents are the same, but child commit differs from them.
* for `diff -c`: the path must be changed since at least 1 parent.

Signed-off-by: Max Kirillov <max@max630.net>
---
This what could be done to hide the added and removed files.
It also makes it work faster - diff --cc on the evil merge runs now 2.5 seconds
instead of 11 (or 0.4 without the series).

This also fails t4057, but I really don't see the logic of `diff -c`
othwerwise. It should show all changes, with trivial merges also, and it
is shown by long files in my t4059. But it uses same path filtering as
`diff --cc`, which is even more restrictive.
 combine-diff.c | 91 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 25 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 2285c7c..f44032a 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -50,20 +50,49 @@ static void insert_path(struct combine_diff_path **pos, const char* path, int n,
 	*pos = p;
 }
 
-static int changed_parents(struct combine_diff_path *p, int n)
+static int path_not_interesting(struct combine_diff_path *p, int n,
+				struct diff_filespec *new_parent)
 {
 	int parent_idx;
-	int result = 0;
+	struct object_id first_parent;
+	int found_first = 0;
+	int found_same_parent = 0;
 
 	for (parent_idx = 0; parent_idx < n; parent_idx++) {
-		if (p->parent[parent_idx].status != ' ')
-			result++;
+		if (p->parent[parent_idx].status != ' ') {
+			if (found_first) {
+				if (hashcmp(p->parent[parent_idx].oid.hash, first_parent.hash)) {
+					/* found second different unique parent - non-trivial merge */
+					return 0;
+				}
+			} else {
+				found_first = 1;
+				hashcpy(first_parent.hash,
+					p->parent[parent_idx].oid.hash);
+			}
+		} else {
+			/* the new commit repeats some of parents */
+			found_same_parent = 1;
+		}
 	}
 
-	return result;
+	if (new_parent) {
+		if (hashcmp(p->oid.hash, new_parent->sha1)) {
+			if (!found_same_parent || hashcmp(first_parent.hash, new_parent->sha1)) {
+				return 0;
+			} else {
+				return 1;
+			}
+		} else {
+			found_same_parent = 1;
+		}
+	}
+
+	return found_same_parent;
 }
 
-static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
+static struct combine_diff_path *intersect_paths(
+	struct combine_diff_path *curr, int n, int num_parent, int dense)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct combine_diff_path *p, **tail = &curr;
@@ -81,35 +110,46 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 
 		if (cmp < 0) {
 			/* p->path not in q->queue[] */
-			if (num_parent > 2 && 2 - changed_parents(p, n) <= num_parent - n - 1) {
-				/* still can get 2 changed parents */
+			if (dense &&
+			    n == num_parent - 1 &&
+			    path_not_interesting(p, n, NULL)) {
+				/* only 1 unique different parent
+				   not interesting change */
+				*tail = p->next;
+				free(p);
+			} else {
+				/* already has or still can get 2 changed parents */
 				hashcpy(p->parent[n].oid.hash, p->oid.hash);
 				p->parent[n].mode = p->mode;
 				p->parent[n].status = ' ';
 				tail = &p->next;
-			} else {
-				*tail = p->next;
-				free(p);
 			}
 			continue;
-		}
-
-		if (cmp > 0) {
+		} else if (cmp > 0) {
 			/* q->queue[i] not in p->path */
-			if (1 <= num_parent - n - 1) {
-				insert_path(tail, q->queue[i]->two->path, n, num_parent, q->queue[i]);
+			if (!dense || n < num_parent - 1) {
+				insert_path(tail, q->queue[i]->two->path,
+					    n, num_parent, q->queue[i]);
 				tail = &(*tail)->next;
 			}
 			i++;
 			continue;
-		}
+		} else {
+			if (dense &&
+			    n == num_parent - 1 &&
+			    path_not_interesting(p, n, q->queue[i]->one)) {
+				*tail = p->next;
+				free(p);
+			} else {
+				hashcpy(p->parent[n].oid.hash, q->queue[i]->one->sha1);
+				p->parent[n].mode = q->queue[i]->one->mode;
+				p->parent[n].status = q->queue[i]->status;
 
-		hashcpy(p->parent[n].oid.hash, q->queue[i]->one->sha1);
-		p->parent[n].mode = q->queue[i]->one->mode;
-		p->parent[n].status = q->queue[i]->status;
+				tail = &p->next;
+			}
+			i++;
+		}
 
-		tail = &p->next;
-		i++;
 	}
 	return curr;
 }
@@ -1341,7 +1381,8 @@ static const char *path_path(void *obj)
 
 /* find set of paths that every parent touches */
 static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
-	const struct sha1_array *parents, struct diff_options *opt)
+	const struct sha1_array *parents, struct diff_options *opt,
+	int dense)
 {
 	struct combine_diff_path *paths = NULL;
 	int i, num_parent = parents->nr;
@@ -1367,7 +1408,7 @@ static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
 			opt->output_format = DIFF_FORMAT_NO_OUTPUT;
 		diff_tree_sha1(parents->sha1[i], sha1, "", opt);
 		diffcore_std(opt);
-		paths = intersect_paths(paths, i, num_parent);
+		paths = intersect_paths(paths, i, num_parent, dense);
 
 		/* if showing diff, show it in requested order */
 		if (opt->output_format != DIFF_FORMAT_NO_OUTPUT &&
@@ -1477,7 +1518,7 @@ void diff_tree_combined(const unsigned char *sha1,
 		 * diff(sha1,parent_i) for all i to do the job, specifically
 		 * for parent0.
 		 */
-		paths = find_paths_generic(sha1, parents, &diffopts);
+		paths = find_paths_generic(sha1, parents, &diffopts, dense);
 	}
 	else {
 		int stat_opt;
-- 
2.3.4.2801.g3d0809b
