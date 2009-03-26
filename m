From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/10] rev-list: move code to show bisect vars into its own
 function
Date: Thu, 26 Mar 2009 05:55:30 +0100
Message-ID: <20090326055530.14425db4.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:58:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmhfL-0003jA-4h
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbZCZE4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbZCZE4c
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:56:32 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:40860 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbZCZE4b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:56:31 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 2508C4C802E;
	Thu, 26 Mar 2009 05:56:21 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id 037A14C8079;
	Thu, 26 Mar 2009 05:56:18 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114727>

This is a straightforward clean up to make "cmd_rev_list" function
smaller.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   83 ++++++++++++++++++++++++++++------------------------
 1 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index b1e8200..74d22b4 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -226,6 +226,49 @@ static int estimate_bisect_steps(int all)
 	return (e < 3 * x) ? n : n - 1;
 }
 
+static int show_bisect_vars(int reaches, int all, int bisect_find_all)
+{
+	int cnt;
+	char hex[41];
+
+	if (!revs.commits)
+		return 1;
+
+	/*
+	 * revs.commits can reach "reaches" commits among
+	 * "all" commits.  If it is good, then there are
+	 * (all-reaches) commits left to be bisected.
+	 * On the other hand, if it is bad, then the set
+	 * to bisect is "reaches".
+	 * A bisect set of size N has (N-1) commits further
+	 * to test, as we already know one bad one.
+	 */
+	cnt = all - reaches;
+	if (cnt < reaches)
+		cnt = reaches;
+	strcpy(hex, sha1_to_hex(revs.commits->item->object.sha1));
+
+	if (bisect_find_all) {
+		traverse_commit_list(&revs, show_commit, show_object);
+		printf("------\n");
+	}
+
+	printf("bisect_rev=%s\n"
+	       "bisect_nr=%d\n"
+	       "bisect_good=%d\n"
+	       "bisect_bad=%d\n"
+	       "bisect_all=%d\n"
+	       "bisect_steps=%d\n",
+	       hex,
+	       cnt - 1,
+	       all - reaches - 1,
+	       reaches - 1,
+	       all,
+	       estimate_bisect_steps(all));
+
+	return 0;
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
@@ -313,44 +356,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
-		if (bisect_show_vars) {
-			int cnt;
-			char hex[41];
-			if (!revs.commits)
-				return 1;
-			/*
-			 * revs.commits can reach "reaches" commits among
-			 * "all" commits.  If it is good, then there are
-			 * (all-reaches) commits left to be bisected.
-			 * On the other hand, if it is bad, then the set
-			 * to bisect is "reaches".
-			 * A bisect set of size N has (N-1) commits further
-			 * to test, as we already know one bad one.
-			 */
-			cnt = all - reaches;
-			if (cnt < reaches)
-				cnt = reaches;
-			strcpy(hex, sha1_to_hex(revs.commits->item->object.sha1));
-
-			if (bisect_find_all) {
-				traverse_commit_list(&revs, show_commit, show_object);
-				printf("------\n");
-			}
-
-			printf("bisect_rev=%s\n"
-			       "bisect_nr=%d\n"
-			       "bisect_good=%d\n"
-			       "bisect_bad=%d\n"
-			       "bisect_all=%d\n"
-			       "bisect_steps=%d\n",
-			       hex,
-			       cnt - 1,
-			       all - reaches - 1,
-			       reaches - 1,
-			       all,
-			       estimate_bisect_steps(all));
-			return 0;
-		}
+		if (bisect_show_vars)
+			return show_bisect_vars(reaches, all, bisect_find_all);
 	}
 
 	traverse_commit_list(&revs,
-- 
1.6.2.1.317.g3d804
