From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 11/17] Make rewrite_parents public to other part of git
Date: Wed, 11 Aug 2010 23:03:36 +0800
Message-ID: <1281539022-31616-12-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:06:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCsS-0005Yv-8v
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab0HKPF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:05:26 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62685 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab0HKPFY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:05:24 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so75417pvg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jyq8GUmv9c2hvfG5T/x70a9Kr6bQfpFrJtU2sOxojZg=;
        b=nN4GgftaorQBWvD4iOnfsfCX+2noKpzPDkJtmag7sCzIm/7w7aR8ASfO7UQMvlUcvi
         AWez4O6ipOeAixQ191MD1m83uZfuGpJmupBn0ZTYAzo3lF3NaesMGBJpq8u0imS6Pn0e
         wT8NnFSEvknep8/0RMWpyS27PcDa+eaYvnZUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=czfgakLFnE5EG11WU9c+9wawEc48UtsrGYsmYZVaOAJBO/yoX0OUfztyQC5h/eVKq+
         aJdb0CUr9gHXLAYjCvhLa4cgGUydTJMzSgJstb07fxkIMEmpKZcIEp/tBTO6D3vvhnNE
         89AEBJF0PquYXWMIvlw25m4vzntQ4Rhnvid1k=
Received: by 10.114.79.20 with SMTP id c20mr22155749wab.117.1281539124662;
        Wed, 11 Aug 2010 08:05:24 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.05.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:05:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153250>

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
1.7.2.19.g79e5d
