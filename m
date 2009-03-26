From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/10] rev-list: call new "filter_skip" function
Date: Thu, 26 Mar 2009 05:55:49 +0100
Message-ID: <20090326055549.e1f244d9.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:58:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmhfo-0003rO-Vb
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbZCZE4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967AbZCZE4v
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:56:51 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:40892 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844AbZCZE4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:56:50 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 0101E4C803D;
	Thu, 26 Mar 2009 05:56:40 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id E03254C8070;
	Thu, 26 Mar 2009 05:56:37 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114735>

This patch implements a new "filter_skip" function in C in
"bisect.c" that will later replace the existing implementation in
shell in "git-bisect.sh".

An array is used to store the skipped commits. But the array is
not yet fed anything.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c           |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 bisect.h           |    6 ++++-
 builtin-rev-list.c |   30 ++++++++++++++++++++----
 3 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 27def7d..39189f2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -4,6 +4,11 @@
 #include "revision.h"
 #include "bisect.h"
 
+
+static unsigned char (*skipped_sha1)[20];
+static int skipped_sha1_nr;
+static int skipped_sha1_alloc;
+
 /* bits #0-15 in revision.h */
 
 #define COUNTED		(1u<<16)
@@ -386,3 +391,63 @@ struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
+static int skipcmp(const void *a, const void *b)
+{
+	return hashcmp(a, b);
+}
+
+static void prepare_skipped(void)
+{
+	qsort(skipped_sha1, skipped_sha1_nr, sizeof(*skipped_sha1), skipcmp);
+}
+
+static int lookup_skipped(unsigned char *sha1)
+{
+	int lo, hi;
+	lo = 0;
+	hi = skipped_sha1_nr;
+	while (lo < hi) {
+		int mi = (lo + hi) / 2;
+		int cmp = hashcmp(sha1, skipped_sha1[mi]);
+		if (!cmp)
+			return mi;
+		if (cmp < 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+	return -lo - 1;
+}
+
+struct commit_list *filter_skipped(struct commit_list *list,
+				   struct commit_list **tried,
+				   int show_all)
+{
+	struct commit_list *filtered = NULL, **f = &filtered;
+
+	*tried = NULL;
+
+	if (!skipped_sha1_nr)
+		return list;
+
+	prepare_skipped();
+
+	while (list) {
+		struct commit_list *next = list->next;
+		list->next = NULL;
+		if (0 <= lookup_skipped(list->item->object.sha1)) {
+			/* Move current to tried list */
+			*tried = list;
+			tried = &list->next;
+		} else {
+			if (!show_all)
+				return list;
+			/* Move current to filtered list */
+			*f = list;
+			f = &list->next;
+		}
+		list = next;
+	}
+
+	return filtered;
+}
diff --git a/bisect.h b/bisect.h
index 31c99fe..2489630 100644
--- a/bisect.h
+++ b/bisect.h
@@ -5,7 +5,11 @@ extern struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all,
 					  int find_all);
 
+extern struct commit_list *filter_skipped(struct commit_list *list,
+					  struct commit_list **tried,
+					  int show_all);
+
 extern int show_bisect_vars(struct rev_info *revs, int reaches, int all,
-			    int show_all);
+			    int show_all, int show_tried);
 
 #endif
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index cdb0f9d..925d643 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -226,14 +226,28 @@ static int estimate_bisect_steps(int all)
 	return (e < 3 * x) ? n : n - 1;
 }
 
-int show_bisect_vars(struct rev_info *revs, int reaches, int all, int show_all)
+static void show_tried_revs(struct commit_list *tried)
+{
+	printf("bisect_tried='");
+	for (;tried; tried = tried->next) {
+		char *format = tried->next ? "%s|" : "%s";
+		printf(format, sha1_to_hex(tried->item->object.sha1));
+	}
+	printf("'\n");
+}
+
+int show_bisect_vars(struct rev_info *revs, int reaches, int all,
+		     int show_all, int show_tried)
 {
 	int cnt;
-	char hex[41];
+	char hex[41] = "";
+	struct commit_list *tried;
 
-	if (!revs->commits)
+	if (!revs->commits && !show_tried)
 		return 1;
 
+	revs->commits = filter_skipped(revs->commits, &tried, show_all);
+
 	/*
 	 * revs->commits can reach "reaches" commits among
 	 * "all" commits.  If it is good, then there are
@@ -247,13 +261,16 @@ int show_bisect_vars(struct rev_info *revs, int reaches, int all, int show_all)
 	if (cnt < reaches)
 		cnt = reaches;
 
-	strcpy(hex, sha1_to_hex(revs->commits->item->object.sha1));
+	if (revs->commits)
+		strcpy(hex, sha1_to_hex(revs->commits->item->object.sha1));
 
 	if (show_all) {
 		traverse_commit_list(revs, show_commit, show_object);
 		printf("------\n");
 	}
 
+	if (show_tried)
+		show_tried_revs(tried);
 	printf("bisect_rev=%s\n"
 	       "bisect_nr=%d\n"
 	       "bisect_good=%d\n"
@@ -278,6 +295,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
+	int bisect_show_all = 0;
 	int quiet = 0;
 
 	git_config(git_default_config, NULL);
@@ -305,6 +323,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--bisect-all")) {
 			bisect_list = 1;
 			bisect_find_all = 1;
+			bisect_show_all = 1;
 			revs.show_decorations = 1;
 			continue;
 		}
@@ -357,9 +376,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
+
 		if (bisect_show_vars)
 			return show_bisect_vars(&revs, reaches, all,
-						bisect_find_all);
+						bisect_show_all, 0);
 	}
 
 	traverse_commit_list(&revs,
-- 
1.6.2.1.317.g3d804
