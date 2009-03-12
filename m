From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/7] rev-list: move code to show bisect vars into its own
 function
Date: Thu, 12 Mar 2009 08:51:31 +0100
Message-ID: <20090312085131.9c923d14.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 08:55:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhfkl-0007QV-R7
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 08:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbZCLHwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 03:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbZCLHw3
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 03:52:29 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:46880 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899AbZCLHw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 03:52:28 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 94056940011;
	Thu, 12 Mar 2009 08:52:19 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id 72E4794014F;
	Thu, 12 Mar 2009 08:52:16 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113016>

This is a straightforward clean up to make "cmd_rev_list" function
smaller.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |  101 ++++++++++++++++++++++++++++------------------------
 1 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index b50d304..6e0466e 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -237,6 +237,57 @@ static void show_tried(struct commit_list *tried)
 	printf("'\n");
 }
 
+static int show_bisect_vars(int reaches, int all, int show_all, int skip)
+{
+	int cnt;
+	char hex[41];
+	struct commit_list *tried;
+
+	revs.commits = filter_skipped(revs.commits, &tried, show_all);
+
+	if (!revs.commits && !skip)
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
+	if (revs.commits)
+		strcpy(hex, sha1_to_hex(revs.commits->item->object.sha1));
+	else
+		hex[0] = '\0';
+
+	if (show_all) {
+		traverse_commit_list(&revs, show_commit, show_object);
+		printf("------\n");
+	}
+
+	if (skip)
+		show_tried(tried);
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
@@ -332,57 +383,13 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (bisect_list) {
 		int reaches = reaches, all = all;
-		struct commit_list *tried;
 
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
 
-		revs.commits = filter_skipped(revs.commits, &tried,
-					      bisect_show_all);
-
-		if (bisect_show_vars) {
-			int cnt;
-			char hex[41];
-			if (!revs.commits && !bisect_skip)
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
-			if (revs.commits)
-				strcpy(hex, sha1_to_hex(revs.commits->item->object.sha1));
-			else
-				hex[0] = '\0';
-
-			if (bisect_show_all) {
-				traverse_commit_list(&revs, show_commit, show_object);
-				printf("------\n");
-			}
-
-			if (bisect_skip)
-				show_tried(tried);
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
+			return show_bisect_vars(reaches, all,
+						bisect_show_all, bisect_skip);
 	}
 
 	traverse_commit_list(&revs,
-- 
1.6.2.83.g012a16.dirty
