From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v10 2/5] Export rewrite_parents() for 'log -L'
Date: Thu, 28 Mar 2013 17:47:31 +0100
Message-ID: <2b6463e4f448b85940080e15b2b8fdf23e0dcd2f.1364488205.git.trast@inf.ethz.ch>
References: <cover.1364488205.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:48:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFzm-0003sx-65
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812Ab3C1Qrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:47:41 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:35631 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756779Ab3C1Qrj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:47:39 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:34 +0100
Received: from linux-k42r.v.cablecom.net (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:35 +0100
X-Mailer: git-send-email 1.8.2.446.g2b4de83
In-Reply-To: <cover.1364488205.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219429>

From: Bo Yang <struggleyb.nku@gmail.com>

The function rewrite_one is used to rewrite a single
parent of the current commit, and is used by rewrite_parents
to rewrite all the parents.

Decouple the dependence between them by making rewrite_one
a callback function that is passed to rewrite_parents. Then
export rewrite_parents for reuse by the line history browser.

We will use this function in line-log.c.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 revision.c | 13 ++++---------
 revision.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index ef60205..46319d5 100644
--- a/revision.c
+++ b/revision.c
@@ -2173,12 +2173,6 @@ int prepare_revision_walk(struct rev_info *revs)
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
@@ -2200,12 +2194,13 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
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
@@ -2371,7 +2366,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (action == commit_show &&
 	    !revs->show_all &&
 	    revs->prune && revs->dense && want_ancestry(revs)) {
-		if (rewrite_parents(revs, commit) < 0)
+		if (rewrite_parents(revs, commit, rewrite_one) < 0)
 			return commit_error;
 	}
 	return action;
diff --git a/revision.h b/revision.h
index 5da09ee..640110d 100644
--- a/revision.h
+++ b/revision.h
@@ -241,4 +241,14 @@ enum commit_action {
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
1.8.2.446.g2b4de83
