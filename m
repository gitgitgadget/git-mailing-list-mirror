From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 12/18] Make rewrite_parents public to other part of git
Date: Fri,  6 Aug 2010 00:11:51 +0800
Message-ID: <1281024717-7855-13-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:14:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh35I-0001XF-IM
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933612Ab0HEQNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:13:22 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59045 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933595Ab0HEQNT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:13:19 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so2531057pxi.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=j2U3jNRji2OA1yf+QBJ6NGXJtPAConJwhgxbZd0Ml6Q=;
        b=lGn74tiUf0Yi5VY/Ao4pIvYdqgbYln784Ufnn/6X8Xxl/D4+Sz+sD7GvvznmIxLaF4
         XkW3wKnEcmvI9XOQcDawIFoRrO7xnUTc9vUBDiMhI23KL+hUrof5NZqlJEEvG4OKwQJW
         ikbXVKxa5IkYJAtmoPKf8tQhgs3oqURxphv8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uaqAsoWcSDU5zHUAsEET9bz7iCBC/ajvVE4INeue+QR/NdhZBN7ZHBSWL8OHhTMpY+
         Mdq6mEufGWYZWxTH/IyTbbcYwoCeri+Ma1ctvhtnBdhvVoUeM2xKSDd1IJq0i3TzcuDZ
         hxgd4juhO+wUiXevl3cihf6bHgkY47jwDCaO4=
Received: by 10.142.230.19 with SMTP id c19mr6557997wfh.41.1281024798981;
        Thu, 05 Aug 2010 09:13:18 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.13.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:13:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152682>

The function rewrite_one is used to rewrite a single
parent of the current commit, and is used by rewrite_parents
to rewrite all the parents.

Decouple the dependence between them by making rewrite_one
a callback function that is passed to rewrite_parents. Then
export rewrite_parents for reuse by the line history browser.

We will use this function in line.c.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 revision.c |   13 ++++---------
 revision.h |   10 ++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 25c9a94..fb08978 100644
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
@@ -1920,12 +1914,13 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
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
index 2627ec4..48222f6 100644
--- a/revision.h
+++ b/revision.h
@@ -199,4 +199,14 @@ enum commit_action {
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
1.7.2.20.g388bbb
