From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/10] rev-list: pass "revs" to "show_bisect_vars"
Date: Thu, 26 Mar 2009 05:55:41 +0100
Message-ID: <20090326055541.caaabdc9.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmhfo-0003rO-7o
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbZCZE4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbZCZE4o
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:56:44 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:40879 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756AbZCZE4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:56:43 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 1B6F64C8038;
	Thu, 26 Mar 2009 05:56:33 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id C03184C803D;
	Thu, 26 Mar 2009 05:56:30 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114733>

instead of using static "revs" data

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.h           |    3 ++-
 builtin-rev-list.c |   13 +++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/bisect.h b/bisect.h
index 860a15c..31c99fe 100644
--- a/bisect.h
+++ b/bisect.h
@@ -5,6 +5,7 @@ extern struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all,
 					  int find_all);
 
-extern int show_bisect_vars(int reaches, int all, int show_all);
+extern int show_bisect_vars(struct rev_info *revs, int reaches, int all,
+			    int show_all);
 
 #endif
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c700c34..cdb0f9d 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -226,16 +226,16 @@ static int estimate_bisect_steps(int all)
 	return (e < 3 * x) ? n : n - 1;
 }
 
-int show_bisect_vars(int reaches, int all, int show_all)
+int show_bisect_vars(struct rev_info *revs, int reaches, int all, int show_all)
 {
 	int cnt;
 	char hex[41];
 
-	if (!revs.commits)
+	if (!revs->commits)
 		return 1;
 
 	/*
-	 * revs.commits can reach "reaches" commits among
+	 * revs->commits can reach "reaches" commits among
 	 * "all" commits.  If it is good, then there are
 	 * (all-reaches) commits left to be bisected.
 	 * On the other hand, if it is bad, then the set
@@ -247,10 +247,10 @@ int show_bisect_vars(int reaches, int all, int show_all)
 	if (cnt < reaches)
 		cnt = reaches;
 
-	strcpy(hex, sha1_to_hex(revs.commits->item->object.sha1));
+	strcpy(hex, sha1_to_hex(revs->commits->item->object.sha1));
 
 	if (show_all) {
-		traverse_commit_list(&revs, show_commit, show_object);
+		traverse_commit_list(revs, show_commit, show_object);
 		printf("------\n");
 	}
 
@@ -358,7 +358,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
 		if (bisect_show_vars)
-			return show_bisect_vars(reaches, all, bisect_find_all);
+			return show_bisect_vars(&revs, reaches, all,
+						bisect_find_all);
 	}
 
 	traverse_commit_list(&revs,
-- 
1.6.2.1.317.g3d804
