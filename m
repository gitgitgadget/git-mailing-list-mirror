From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v1 1/4] make rewrite_parents an external function
Date: Sun, 11 Jul 2010 14:27:34 +0800
Message-ID: <1278829657-26607-2-git-send-email-struggleyb.nku@gmail.com>
References: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXq3H-0003wy-US
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab0GKG34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:29:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46564 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0GKG3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:29:48 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so1397241pvc.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8PLnAPwWjLOTkUNNbVGWvRw2q4YAXK9xPO/58CHxEbc=;
        b=qNva+eZSrgA1wYbWOrFXDtPi2G8JGtsT84ew1jpskUC1Nc9g+laf1RNuyF0aUSXGYZ
         9Y2VvW0T4eWz7jyHAdAo2X70PydyEpCOQRfJ8qlY9nbvgWEGv9kGkDaY95vKFE6gy9e5
         iwT08OoN9uQ8KQqRXJFPcuLJh0n6qbF74I7Ms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HxBILXhtvZv86uMjGzv0QWwN9DVv9x6u8TXuPnTeXPw4FpxPtiXuJfbglTc7awK5Kg
         55LhpYwOUS6K5ZzOzkjy2ochvE1MlncdYWpxr9KGTyDDpDZIfkqbp0IuzF6pVVsPjv4X
         A2W4njy4pKZk/833fkWECIP1vVm0eIW0GSJug=
Received: by 10.114.60.5 with SMTP id i5mr13934415waa.165.1278829787571;
        Sat, 10 Jul 2010 23:29:47 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id b19sm1874759rvf.3.2010.07.10.23.29.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:29:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
In-Reply-To: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150760>

The function rewrite_one is used to rewrite a single
parent of the current commit, and is used by rewrite_parents
to rewrite all the parents.
This commit decouple the dependence between them, make
rewrite_one as a callback function and be passed to
rewrite_parents. Make rewrite_parents public to other
part of git.
We will use this function in line.c.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 revision.c |   11 +++--------
 revision.h |   10 ++++++++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 63f37ea..72d9654 100644
--- a/revision.c
+++ b/revision.c
@@ -1893,12 +1893,6 @@ int prepare_revision_walk(struct rev_info *revs)
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
@@ -1920,7 +1914,8 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 	}
 }
 
-static int rewrite_parents(struct rev_info *revs, struct commit *commit)
+int rewrite_parents(struct rev_info *revs, struct commit *commit,
+	rewrite_parent rewrite_one)
 {
 	struct commit_list **pp = &commit->parents;
 	while (*pp) {
@@ -1993,7 +1988,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (action == commit_show &&
 	    !revs->show_all &&
 	    revs->prune && revs->dense && want_ancestry(revs)) {
-		if (rewrite_parents(revs, commit) < 0)
+		if (rewrite_parents(revs, commit, rewrite_one) < 0)
 			return commit_error;
 	}
 	return action;
diff --git a/revision.h b/revision.h
index 433da9a..9b8e3d9 100644
--- a/revision.h
+++ b/revision.h
@@ -200,4 +200,14 @@ enum commit_action {
 extern enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit);
 extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
 
+enum rewrite_result {
+	rewrite_one_ok,
+	rewrite_one_noparents,
+	rewrite_one_error
+};
+
+typedef enum rewrite_result (*rewrite_parent)(struct rev_info *revs, struct commit **pp);
+
+extern int rewrite_parents(struct rev_info *revs, struct commit *commit,
+	rewrite_parent rewrite_one);
 #endif
-- 
1.7.0.2.273.gc2413.dirty
