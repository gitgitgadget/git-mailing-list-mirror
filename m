From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 2/4] combine-diff.c: refactor: extract insert_path()
Date: Fri,  3 Apr 2015 18:58:34 +0300
Message-ID: <1428076716-4449-3-git-send-email-max@max630.net>
References: <1428006853-21212-1-git-send-email-max@max630.net>
 <1428076716-4449-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 18:00:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye40n-0008N6-Mo
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 18:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbbDCP71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 11:59:27 -0400
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:46648
	"EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752591AbbDCP6f (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 11:58:35 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-03.prod.phx3.secureserver.net with 
	id BTyS1q0045B68XE01TyZ37; Fri, 03 Apr 2015 08:58:34 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1428076716-4449-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266710>

Signed-off-by: Max Kirillov <max@max630.net>
---
 combine-diff.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 8eb7278..a236bb5 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -22,6 +22,28 @@ static int compare_paths(const struct combine_diff_path *one,
 				 two->path, strlen(two->path), two->mode);
 }
 
+static void insert_path(struct combine_diff_path **pos, const char* path, int n, int num_parent, struct diff_filepair *queue_item)
+{
+	int len;
+	struct combine_diff_path *p;
+
+	len = strlen(path);
+	p = xmalloc(combine_diff_path_size(num_parent, len));
+	p->path = (char *) &(p->parent[num_parent]);
+	memcpy(p->path, path, len);
+	p->path[len] = 0;
+	p->next = *pos;
+	memset(p->parent, 0,
+	       sizeof(p->parent[0]) * num_parent);
+
+	hashcpy(p->oid.hash, queue_item->two->sha1);
+	p->mode = queue_item->two->mode;
+	hashcpy(p->parent[n].oid.hash, queue_item->one->sha1);
+	p->parent[n].mode = queue_item->one->mode;
+	p->parent[n].status = queue_item->status;
+	*pos = p;
+}
+
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -30,27 +52,10 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 
 	if (!n) {
 		for (i = 0; i < q->nr; i++) {
-			int len;
-			const char *path;
 			if (diff_unmodified_pair(q->queue[i]))
 				continue;
-			path = q->queue[i]->two->path;
-			len = strlen(path);
-			p = xmalloc(combine_diff_path_size(num_parent, len));
-			p->path = (char *) &(p->parent[num_parent]);
-			memcpy(p->path, path, len);
-			p->path[len] = 0;
-			p->next = NULL;
-			memset(p->parent, 0,
-			       sizeof(p->parent[0]) * num_parent);
-
-			hashcpy(p->oid.hash, q->queue[i]->two->sha1);
-			p->mode = q->queue[i]->two->mode;
-			hashcpy(p->parent[n].oid.hash, q->queue[i]->one->sha1);
-			p->parent[n].mode = q->queue[i]->one->mode;
-			p->parent[n].status = q->queue[i]->status;
-			*tail = p;
-			tail = &p->next;
+			insert_path(tail, q->queue[i]->two->path, n, num_parent, q->queue[i]);
+			tail = &(*tail)->next;
 		}
 		return curr;
 	}
-- 
2.3.4.2801.g3d0809b
