From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] builtin-blame.c: allow more than 16 parents
Date: Thu, 03 Apr 2008 02:14:47 -0700
Message-ID: <7v3aq32tbs.fsf@gitster.siamese.dyndns.org>
References: <7v4paj486a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 11:15:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhLXo-0007Lu-Mx
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 11:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874AbYDCJO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 05:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756830AbYDCJO4
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 05:14:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbYDCJOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 05:14:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 252B32486;
	Thu,  3 Apr 2008 05:14:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2CB8C2484; Thu,  3 Apr 2008 05:14:50 -0400 (EDT)
In-Reply-To: <7v4paj486a.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 Apr 2008 02:08:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78738>

This removes the hardcoded 16 parents limit from git-blame by allowing the
parent array to be allocated dynamically.

As the ultimate objective is not about computing blame across dodecapus,
but about annotating the history upside down, it also renames "parent" in
the code to "scapegoat".  The name of the game used to be "pass blame to
your parents", but now it is "find a scapegoat to pass blame on".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c |   93 ++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 996f535..fbc441f 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1191,18 +1191,45 @@ static void pass_whole_blame(struct scoreboard *sb,
 	}
 }
 
-#define MAXPARENT 16
+/*
+ * We pass blame from the current commit to its parents.  We keep saying
+ * "parent" (and "porigin"), but what we mean is to find scapegoat to
+ * exonerate ourselves.
+ */
+static struct commit_list *first_scapegoat(struct commit *commit)
+{
+	return commit->parents;
+}
+
+static int num_scapegoats(struct commit *commit)
+{
+	int cnt;
+	struct commit_list *l = first_scapegoat(commit);
+	for (cnt = 0; l; l = l->next)
+		cnt++;
+	return cnt;
+}
+
+#define MAXSG 16
 
 static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 {
-	int i, pass;
+	int i, pass, num_sg;
 	struct commit *commit = origin->commit;
-	struct commit_list *parent;
-	struct origin *parent_origin[MAXPARENT], *porigin;
-
-	memset(parent_origin, 0, sizeof(parent_origin));
+	struct commit_list *sg;
+	struct origin *sg_buf[MAXSG];
+	struct origin *porigin, **sg_origin = sg_buf;
+
+	num_sg = num_scapegoats(commit);
+	if (!num_sg)
+		goto finish;
+	else if (num_sg < ARRAY_SIZE(sg_buf))
+		memset(sg_buf, 0, sizeof(sg_buf));
+	else
+		sg_origin = xcalloc(num_sg, sizeof(*sg_origin));
 
-	/* The first pass looks for unrenamed path to optimize for
+	/*
+	 * The first pass looks for unrenamed path to optimize for
 	 * common cases, then we look for renames in the second pass.
 	 */
 	for (pass = 0; pass < 2; pass++) {
@@ -1210,13 +1237,13 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 				       struct commit *, struct origin *);
 		find = pass ? find_rename : find_origin;
 
-		for (i = 0, parent = commit->parents;
-		     i < MAXPARENT && parent;
-		     parent = parent->next, i++) {
-			struct commit *p = parent->item;
+		for (i = 0, sg = first_scapegoat(commit);
+		     i < num_sg && sg;
+		     sg = sg->next, i++) {
+			struct commit *p = sg->item;
 			int j, same;
 
-			if (parent_origin[i])
+			if (sg_origin[i])
 				continue;
 			if (parse_commit(p))
 				continue;
@@ -1229,24 +1256,24 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 				goto finish;
 			}
 			for (j = same = 0; j < i; j++)
-				if (parent_origin[j] &&
-				    !hashcmp(parent_origin[j]->blob_sha1,
+				if (sg_origin[j] &&
+				    !hashcmp(sg_origin[j]->blob_sha1,
 					     porigin->blob_sha1)) {
 					same = 1;
 					break;
 				}
 			if (!same)
-				parent_origin[i] = porigin;
+				sg_origin[i] = porigin;
 			else
 				origin_decref(porigin);
 		}
 	}
 
 	num_commits++;
-	for (i = 0, parent = commit->parents;
-	     i < MAXPARENT && parent;
-	     parent = parent->next, i++) {
-		struct origin *porigin = parent_origin[i];
+	for (i = 0, sg = first_scapegoat(commit);
+	     i < num_sg && sg;
+	     sg = sg->next, i++) {
+		struct origin *porigin = sg_origin[i];
 		if (!porigin)
 			continue;
 		if (pass_blame_to_parent(sb, origin, porigin))
@@ -1257,10 +1284,10 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * Optionally find moves in parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_MOVE)
-		for (i = 0, parent = commit->parents;
-		     i < MAXPARENT && parent;
-		     parent = parent->next, i++) {
-			struct origin *porigin = parent_origin[i];
+		for (i = 0, sg = first_scapegoat(commit);
+		     i < num_sg && sg;
+		     sg = sg->next, i++) {
+			struct origin *porigin = sg_origin[i];
 			if (!porigin)
 				continue;
 			if (find_move_in_parent(sb, origin, porigin))
@@ -1271,23 +1298,25 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * Optionally find copies from parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_COPY)
-		for (i = 0, parent = commit->parents;
-		     i < MAXPARENT && parent;
-		     parent = parent->next, i++) {
-			struct origin *porigin = parent_origin[i];
-			if (find_copy_in_parent(sb, origin, parent->item,
+		for (i = 0, sg = first_scapegoat(commit);
+		     i < num_sg && sg;
+		     sg = sg->next, i++) {
+			struct origin *porigin = sg_origin[i];
+			if (find_copy_in_parent(sb, origin, sg->item,
 						porigin, opt))
 				goto finish;
 		}
 
  finish:
-	for (i = 0; i < MAXPARENT; i++) {
-		if (parent_origin[i]) {
-			drop_origin_blob(parent_origin[i]);
-			origin_decref(parent_origin[i]);
+	for (i = 0; i < num_sg; i++) {
+		if (sg_origin[i]) {
+			drop_origin_blob(sg_origin[i]);
+			origin_decref(sg_origin[i]);
 		}
 	}
 	drop_origin_blob(origin);
+	if (sg_buf != sg_origin)
+		free(sg_origin);
 }
 
 /*
-- 
1.5.5.rc3.139.g8b2cf
