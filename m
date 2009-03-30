From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/2] rev-list: pass a flag as last argument of
 "show_bisect_vars"
Date: Mon, 30 Mar 2009 06:59:57 +0200
Message-ID: <20090330065957.5ba1675c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 07:02:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9dw-0004Hu-W7
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbZC3FBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbZC3FBF
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:01:05 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:44112 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569AbZC3FBE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:01:04 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 2DB014C805B;
	Mon, 30 Mar 2009 07:00:53 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id C6DE54C8062;
	Mon, 30 Mar 2009 07:00:50 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115067>

Instead of "int show_all, int show_tried" we now only pass "int flags",
because we will add more flags in a later patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c           |    2 +-
 bisect.h           |    8 ++++++--
 builtin-rev-list.c |   13 ++++++-------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index 66df05f..64a5ad5 100644
--- a/bisect.c
+++ b/bisect.c
@@ -554,5 +554,5 @@ int bisect_next_vars(const char *prefix)
 	revs.commits = find_bisection(revs.commits, &reaches, &all,
 				      !!skipped_sha1_nr);
 
-	return show_bisect_vars(&revs, reaches, all, 0, 1);
+	return show_bisect_vars(&revs, reaches, all, SHOW_TRIED);
 }
diff --git a/bisect.h b/bisect.h
index 05eea17..4cff2ba 100644
--- a/bisect.h
+++ b/bisect.h
@@ -9,13 +9,17 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
 					  int show_all);
 
+/* show_bisect_vars flags */
+#define SHOW_ALL	1
+#define SHOW_TRIED	2
+
 /*
- * The "show_all" parameter should be 0 if this function is called
+ * The flag SHOW_ALL should not be set if this function is called
  * from outside "builtin-rev-list.c" as otherwise it would use
  * static "revs" from this file.
  */
 extern int show_bisect_vars(struct rev_info *revs, int reaches, int all,
-			    int show_all, int show_tried);
+			    int flags);
 
 extern int bisect_next_vars(const char *prefix);
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 925d643..c1c4a18 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -236,17 +236,16 @@ static void show_tried_revs(struct commit_list *tried)
 	printf("'\n");
 }
 
-int show_bisect_vars(struct rev_info *revs, int reaches, int all,
-		     int show_all, int show_tried)
+int show_bisect_vars(struct rev_info *revs, int reaches, int all, int flags)
 {
 	int cnt;
 	char hex[41] = "";
 	struct commit_list *tried;
 
-	if (!revs->commits && !show_tried)
+	if (!revs->commits && !(flags & SHOW_TRIED))
 		return 1;
 
-	revs->commits = filter_skipped(revs->commits, &tried, show_all);
+	revs->commits = filter_skipped(revs->commits, &tried, flags & SHOW_ALL);
 
 	/*
 	 * revs->commits can reach "reaches" commits among
@@ -264,12 +263,12 @@ int show_bisect_vars(struct rev_info *revs, int reaches, int all,
 	if (revs->commits)
 		strcpy(hex, sha1_to_hex(revs->commits->item->object.sha1));
 
-	if (show_all) {
+	if (flags & SHOW_ALL) {
 		traverse_commit_list(revs, show_commit, show_object);
 		printf("------\n");
 	}
 
-	if (show_tried)
+	if (flags & SHOW_TRIED)
 		show_tried_revs(tried);
 	printf("bisect_rev=%s\n"
 	       "bisect_nr=%d\n"
@@ -379,7 +378,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&revs, reaches, all,
-						bisect_show_all, 0);
+						bisect_show_all ? SHOW_ALL : 0);
 	}
 
 	traverse_commit_list(&revs,
-- 
1.6.2.1.404.gb0085.dirty
