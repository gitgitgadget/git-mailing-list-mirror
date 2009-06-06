From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/3] bisect: add parameters to "filter_skipped"
Date: Sat, 06 Jun 2009 06:41:33 +0200
Message-ID: <20090606044136.4031.97844.chriscool@tuxfamily.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 06:44:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCnlI-0006bC-VB
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 06:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbZFFEnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 00:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbZFFEnw
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 00:43:52 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:45213 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbZFFEns (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 00:43:48 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 2450DE08080;
	Sat,  6 Jun 2009 06:43:42 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id C8BA3E0803F;
	Sat,  6 Jun 2009 06:43:39 +0200 (CEST)
X-git-sha1: 24d3f2133ddfa2d82393557e48d34093e2d0b270 
X-Mailer: git-mail-commits v0.4.5
In-Reply-To: <20090606043853.4031.78284.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120870>

because we will need to get more information from this function in
some later patches.

The new "int *count" parameter gives the number of commits left after
the skipped commit have been filtered out.

The new "int *skipped_first" parameter tells us if the first commit
in the list has been skipped. Note that using this parameter also
changes the behavior of the function if the first commit is indeed
skipped. Because we assume that in this case we will want all the
filtered commits, not just the first one, even if "show_all" is not
set.

So using a not NULL "skipped_first" parameter really means that we
plan to choose to test another commit than the first non skipped
one if the first commit in the list is skipped. That in turn means
that, in case the first commit is skipped, we have to return a
fully filtered list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c           |   40 ++++++++++++++++++++++++++++++++++++----
 bisect.h           |    4 +++-
 builtin-rev-list.c |    4 +++-
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2c14f4d..115cf5f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -521,14 +521,34 @@ static char *join_sha1_array_hex(struct sha1_array *array, char delim)
 	return strbuf_detach(&joined_hexs, NULL);
 }
 
+/*
+ * In this function, passing a not NULL skipped_first is very special.
+ * It means that we want to know if the first commit in the list is
+ * skipped because we will want to test a commit away from it if it is
+ * indeed skipped.
+ * So if the first commit is skipped, we cannot take the shortcut to
+ * just "return list" when we find the first non skipped commit, we
+ * have to return a fully filtered list.
+ *
+ * We use (*skipped_first == -1) to mean "it has been found that the
+ * first commit is not skipped". In this case *skipped_first is set back
+ * to 0 just before the function returns.
+ */
 struct commit_list *filter_skipped(struct commit_list *list,
 				   struct commit_list **tried,
-				   int show_all)
+				   int show_all,
+				   int *count,
+				   int *skipped_first)
 {
 	struct commit_list *filtered = NULL, **f = &filtered;
 
 	*tried = NULL;
 
+	if (skipped_first)
+		*skipped_first = 0;
+	if (count)
+		*count = 0;
+
 	if (!skipped_revs.sha1_nr)
 		return list;
 
@@ -537,19 +557,31 @@ struct commit_list *filter_skipped(struct commit_list *list,
 		list->next = NULL;
 		if (0 <= lookup_sha1_array(&skipped_revs,
 					   list->item->object.sha1)) {
+			if (skipped_first && !*skipped_first)
+				*skipped_first = 1;
 			/* Move current to tried list */
 			*tried = list;
 			tried = &list->next;
 		} else {
-			if (!show_all)
-				return list;
+			if (!show_all) {
+				if (!skipped_first || !*skipped_first)
+					return list;
+			} else if (skipped_first && !*skipped_first) {
+				/* This means we know it's not skipped */
+				*skipped_first = -1;
+			}
 			/* Move current to filtered list */
 			*f = list;
 			f = &list->next;
+			if (count)
+				(*count)++;
 		}
 		list = next;
 	}
 
+	if (skipped_first && *skipped_first == -1)
+		*skipped_first = 0;
+
 	return filtered;
 }
 
@@ -865,7 +897,7 @@ int bisect_next_all(const char *prefix)
 
 	revs.commits = find_bisection(revs.commits, &reaches, &all,
 				       !!skipped_revs.sha1_nr);
-	revs.commits = filter_skipped(revs.commits, &tried, 0);
+	revs.commits = filter_skipped(revs.commits, &tried, 0, NULL, NULL);
 
 	if (!revs.commits) {
 		/*
diff --git a/bisect.h b/bisect.h
index fb744fd..82f8fc1 100644
--- a/bisect.h
+++ b/bisect.h
@@ -7,7 +7,9 @@ extern struct commit_list *find_bisection(struct commit_list *list,
 
 extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
-					  int show_all);
+					  int show_all,
+					  int *count,
+					  int *skipped_first);
 
 extern void print_commit_list(struct commit_list *list,
 			      const char *format_cur,
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 73bff84..69753dc 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -262,7 +262,9 @@ int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 	if (!revs->commits && !(flags & BISECT_SHOW_TRIED))
 		return 1;
 
-	revs->commits = filter_skipped(revs->commits, &tried, flags & BISECT_SHOW_ALL);
+	revs->commits = filter_skipped(revs->commits, &tried,
+				       flags & BISECT_SHOW_ALL,
+				       NULL, NULL);
 
 	/*
 	 * revs->commits can reach "reaches" commits among
-- 
1.6.3.GIT
