From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/3] bisect: add parameters to "filter_skipped"
Date: Fri, 05 Jun 2009 06:10:41 +0200
Message-ID: <20090605041044.8885.91204.chriscool@tuxfamily.org>
References: <20090605040238.8885.92790.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 06:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCQnL-0001a8-4R
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 06:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbZFEEM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 00:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbZFEEM2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 00:12:28 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:32960 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbZFEEM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 00:12:26 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6F53F818049;
	Fri,  5 Jun 2009 06:12:19 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5BF03818062;
	Fri,  5 Jun 2009 06:12:17 +0200 (CEST)
X-git-sha1: fc3c33febdcb5bd8417224894b37be0195816ad0 
X-Mailer: git-mail-commits v0.4.5
In-Reply-To: <20090605040238.8885.92790.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120735>

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

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c           |   26 ++++++++++++++++++++++----
 bisect.h           |    4 +++-
 builtin-rev-list.c |    4 +++-
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2c14f4d..02497f7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -523,12 +523,19 @@ static char *join_sha1_array_hex(struct sha1_array *array, char delim)
 
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
 
@@ -537,19 +544,30 @@ struct commit_list *filter_skipped(struct commit_list *list,
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
 
@@ -865,7 +883,7 @@ int bisect_next_all(const char *prefix)
 
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
