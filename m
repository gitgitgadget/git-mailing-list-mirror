From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] rev-list: embed "struct rev_info revs" into
 "struct rev_list_info"
Date: Sat, 18 Apr 2009 06:43:28 +0200
Message-ID: <20090418064328.ad64accf.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 18 06:46:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv2RZ-0000Qx-1y
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 06:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbZDREon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 00:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbZDREon
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 00:44:43 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:33453 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbZDREom (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 00:44:42 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D5FDA94008D;
	Sat, 18 Apr 2009 06:44:34 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id 90EE3940096;
	Sat, 18 Apr 2009 06:44:31 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116810>

There are downsides to this patch. First it is big. And "revs" is
initialized once when doing "memset(&info, 0, sizeof(info))" and
once in "init_revisions".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c                 |   14 ++++------
 bisect.h                 |    2 +-
 builtin-bisect--helper.c |    3 ++
 builtin-rev-list.c       |   58 ++++++++++++++++++++++-----------------------
 4 files changed, 38 insertions(+), 39 deletions(-)

So I think this patch should not be applied.

diff --git a/bisect.c b/bisect.c
index 58f7e6f..6425501 100644
--- a/bisect.c
+++ b/bisect.c
@@ -534,23 +534,21 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix)
 
 int bisect_next_vars(const char *prefix)
 {
-	struct rev_info revs;
 	struct rev_list_info info;
 	int reaches = 0, all = 0;
 
 	memset(&info, 0, sizeof(info));
-	info.revs = &revs;
 	info.bisect_show_flags = BISECT_SHOW_TRIED | BISECT_SHOW_STRINGED;
 
-	bisect_rev_setup(&revs, prefix);
+	bisect_rev_setup(&info.revs, prefix);
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&info.revs))
 		die("revision walk setup failed");
-	if (revs.tree_objects)
-		mark_edges_uninteresting(revs.commits, &revs, NULL);
+	if (info.revs.tree_objects)
+		mark_edges_uninteresting(info.revs.commits, &info.revs, NULL);
 
-	revs.commits = find_bisection(revs.commits, &reaches, &all,
-				      !!skipped_sha1_nr);
+	info.revs.commits = find_bisection(info.revs.commits, &reaches, &all,
+					   !!skipped_sha1_nr);
 
 	return show_bisect_vars(&info, reaches, all);
 }
diff --git a/bisect.h b/bisect.h
index fdba913..afedfaa 100644
--- a/bisect.h
+++ b/bisect.h
@@ -15,7 +15,7 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
 #define BISECT_SHOW_STRINGED	(1<<2)
 
 struct rev_list_info {
-	struct rev_info *revs;
+	struct rev_info revs;
 	int bisect_show_flags;
 	int show_timestamp;
 	int hdr_termination;
diff --git a/builtin-bisect--helper.c b/builtin-bisect--helper.c
index 8fe7787..6d3ccb0 100644
--- a/builtin-bisect--helper.c
+++ b/builtin-bisect--helper.c
@@ -1,6 +1,9 @@
 #include "builtin.h"
 #include "cache.h"
 #include "parse-options.h"
+#include "diff.h"
+#include "commit.h"
+#include "revision.h"
 #include "bisect.h"
 
 static const char * const git_bisect_helper_usage[] = {
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 193993c..433c5bc 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -46,7 +46,7 @@ static void finish_commit(struct commit *commit, void *data);
 static void show_commit(struct commit *commit, void *data)
 {
 	struct rev_list_info *info = data;
-	struct rev_info *revs = info->revs;
+	struct rev_info *revs = &info->revs;
 
 	graph_show_commit(revs->graph);
 
@@ -238,7 +238,7 @@ int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 	int cnt, flags = info->bisect_show_flags;
 	char hex[41] = "", *format;
 	struct commit_list *tried;
-	struct rev_info *revs = info->revs;
+	struct rev_info *revs = &info->revs;
 
 	if (!revs->commits && !(flags & BISECT_SHOW_TRIED))
 		return 1;
@@ -295,7 +295,6 @@ int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
-	struct rev_info revs;
 	struct rev_list_info info;
 	int i;
 	int read_from_stdin = 0;
@@ -304,21 +303,20 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_find_all = 0;
 	int quiet = 0;
 
-	git_config(git_default_config, NULL);
-	init_revisions(&revs, prefix);
-	revs.abbrev = 0;
-	revs.commit_format = CMIT_FMT_UNSPECIFIED;
-	argc = setup_revisions(argc, argv, &revs, NULL);
-
 	memset(&info, 0, sizeof(info));
-	info.revs = &revs;
 
-	quiet = DIFF_OPT_TST(&revs.diffopt, QUIET);
+	git_config(git_default_config, NULL);
+	init_revisions(&info.revs, prefix);
+	info.revs.abbrev = 0;
+	info.revs.commit_format = CMIT_FMT_UNSPECIFIED;
+	argc = setup_revisions(argc, argv, &info.revs, NULL);
+
+	quiet = DIFF_OPT_TST(&info.revs.diffopt, QUIET);
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
 
 		if (!strcmp(arg, "--header")) {
-			revs.verbose_header = 1;
+			info.revs.verbose_header = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--timestamp")) {
@@ -333,7 +331,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_list = 1;
 			bisect_find_all = 1;
 			info.bisect_show_flags = BISECT_SHOW_ALL;
-			revs.show_decorations = 1;
+			info.revs.show_decorations = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--bisect-vars")) {
@@ -344,51 +342,51 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--stdin")) {
 			if (read_from_stdin++)
 				die("--stdin given twice?");
-			read_revisions_from_stdin(&revs);
+			read_revisions_from_stdin(&info.revs);
 			continue;
 		}
 		usage(rev_list_usage);
 
 	}
-	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
+	if (info.revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
 		info.hdr_termination = '\n';
-		if (revs.commit_format == CMIT_FMT_ONELINE)
+		if (info.revs.commit_format == CMIT_FMT_ONELINE)
 			info.header_prefix = "";
 		else
 			info.header_prefix = "commit ";
 	}
-	else if (revs.verbose_header)
+	else if (info.revs.verbose_header)
 		/* Only --header was specified */
-		revs.commit_format = CMIT_FMT_RAW;
+		info.revs.commit_format = CMIT_FMT_RAW;
 
-	if ((!revs.commits &&
-	     (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) &&
-	      !revs.pending.nr)) ||
-	    revs.diff)
+	if ((!info.revs.commits &&
+	     (!(info.revs.tag_objects||info.revs.tree_objects||info.revs.blob_objects) &&
+	      !info.revs.pending.nr)) ||
+	    info.revs.diff)
 		usage(rev_list_usage);
 
-	save_commit_buffer = revs.verbose_header ||
-		revs.grep_filter.pattern_list;
+	save_commit_buffer = info.revs.verbose_header ||
+		info.revs.grep_filter.pattern_list;
 	if (bisect_list)
-		revs.limited = 1;
+		info.revs.limited = 1;
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(&info.revs))
 		die("revision walk setup failed");
-	if (revs.tree_objects)
-		mark_edges_uninteresting(revs.commits, &revs, show_edge);
+	if (info.revs.tree_objects)
+		mark_edges_uninteresting(info.revs.commits, &info.revs, show_edge);
 
 	if (bisect_list) {
 		int reaches = reaches, all = all;
 
-		revs.commits = find_bisection(revs.commits, &reaches, &all,
+		info.revs.commits = find_bisection(info.revs.commits, &reaches, &all,
 					      bisect_find_all);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
 	}
 
-	traverse_commit_list(&revs,
+	traverse_commit_list(&info.revs,
 			     quiet ? finish_commit : show_commit,
 			     quiet ? finish_object : show_object,
 			     &info);
-- 
1.6.2.2.574.g3b0a.dirty
