From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 14/22] Make rewrite_parents public to other part of git
Date: Sat, 24 Jul 2010 23:13:46 +0800
Message-ID: <1279984434-28933-15-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:15:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgRr-00020D-Va
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab0GXPPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:19 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64670 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab0GXPPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:14 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so3930617pvc.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1FYdO3l1REoUX0CUJYziZaQ4rc5uz+zedt1Qb1B+SLA=;
        b=iGFNxv8IprhdBx1XL5ZUKlbZiJ7auIyqBqkOAdGsZuFcozvr51MJ92TpYKctKvOjuT
         cNviZmA+SZqYy5DAi3SPSuKjvobX54ithAPTn+p2IpEwpKsbcOFVr/3OhtuiP7s08N9X
         aXxxQvZEQEqG3C399GFh3z6FUNXViWCFfmcOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bLdWHQ8D9RCmn3iT4rXnURlcnHe1aJahox8dg69zuKkDEGaMQnSX4yA7ocaMJsk11k
         sO8vEu07pw0XYIamjtq11ALAWD8LQ4STv4MFfKordiegnM9kITxVaPG5B0bkTMaiqpSB
         P5bSJJplZm2BPZe6SDnvbQSncRn9ezwaX0j+Q=
Received: by 10.142.225.8 with SMTP id x8mr5939210wfg.292.1279984514101;
        Sat, 24 Jul 2010 08:15:14 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151645>

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
index e4b6adf..e625c3d 100644
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
+typedef enum rewrite_result (*rewrite_parent_fn_t)(struct rev_info *revs, struct commit **pp);
+
+extern int rewrite_parents(struct rev_info *revs, struct commit *commit,
+	rewrite_parent_fn_t rewrite_parent);
 #endif
-- 
1.7.0.2.273.gc2413.dirty
