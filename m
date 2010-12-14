From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/8] Export rewrite_parents() for 'log -L'
Date: Tue, 14 Dec 2010 03:03:26 +0100
Message-ID: <fb904e7dc0298c3efa8bb8cd25f62b5e83f59918.1292291624.git.trast@student.ethz.ch>
References: <cover.1292291624.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 03:03:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSKEx-0008LJ-SK
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 03:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759041Ab0LNCDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 21:03:38 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:54357 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758902Ab0LNCDg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 21:03:36 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:29 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:31 +0100
X-Mailer: git-send-email 1.7.3.3.797.g7a32f
In-Reply-To: <cover.1292291624.git.trast@student.ethz.ch>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163614>

From: Bo Yang <struggleyb.nku@gmail.com>

The function rewrite_one is used to rewrite a single
parent of the current commit, and is used by rewrite_parents
to rewrite all the parents.

Decouple the dependence between them by making rewrite_one
a callback function that is passed to rewrite_parents. Then
export rewrite_parents for reuse by the line history browser.

We will use this function in line.c.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 revision.c |   13 ++++---------
 revision.h |   10 ++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index ded8812..6465c45 100644
--- a/revision.c
+++ b/revision.c
@@ -1912,12 +1912,6 @@ int prepare_revision_walk(struct rev_info *revs)
 	return 0;
 }
 
-enum rewrite_result {
-	rewrite_one_ok,
-	rewrite_one_noparents,
-	rewrite_one_error
-};
-
 static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
 {
 	struct commit_list *cache = NULL;
@@ -1939,12 +1933,13 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 	}
 }
 
-static int rewrite_parents(struct rev_info *revs, struct commit *commit)
+int rewrite_parents(struct rev_info *revs, struct commit *commit,
+	rewrite_parent_fn_t rewrite_parent)
 {
 	struct commit_list **pp = &commit->parents;
 	while (*pp) {
 		struct commit_list *parent = *pp;
-		switch (rewrite_one(revs, &parent->item)) {
+		switch (rewrite_parent(revs, &parent->item)) {
 		case rewrite_one_ok:
 			break;
 		case rewrite_one_noparents:
@@ -2012,7 +2007,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (action == commit_show &&
 	    !revs->show_all &&
 	    revs->prune && revs->dense && want_ancestry(revs)) {
-		if (rewrite_parents(revs, commit) < 0)
+		if (rewrite_parents(revs, commit, rewrite_one) < 0)
 			return commit_error;
 	}
 	return action;
diff --git a/revision.h b/revision.h
index 05659c6..8897368 100644
--- a/revision.h
+++ b/revision.h
@@ -193,4 +193,14 @@ enum commit_action {
 extern enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit);
 extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
 
+enum rewrite_result {
+	rewrite_one_ok,
+	rewrite_one_noparents,
+	rewrite_one_error
+};
+
+typedef enum rewrite_result (*rewrite_parent_fn_t)(struct rev_info *revs, struct commit **pp);
+
+extern int rewrite_parents(struct rev_info *revs, struct commit *commit,
+	rewrite_parent_fn_t rewrite_parent);
 #endif
-- 
1.7.3.3.811.g76615
