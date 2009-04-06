From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] rev-list: remove last static vars used in "show_commit"
Date: Mon, 6 Apr 2009 22:28:00 +0200
Message-ID: <20090407040854.4338.40055.chriscool@tuxfamily.org>
References: <20090407040819.4338.4291.chriscool@tuxfamily.org>
	<20090407040854.4338.94304.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 06:12:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr2fj-0002PG-AQ
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 06:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547AbZDGEKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 00:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755529AbZDGEKY
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 00:10:24 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:40688 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757790AbZDGEKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 00:10:23 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 186B34B0064;
	Tue,  7 Apr 2009 06:10:13 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 0CB7C4B004D;
	Tue,  7 Apr 2009 06:10:11 +0200 (CEST)
X-git-sha1: fc5ead426475333945ac4bb26a43e008c7c2b712 
X-Mailer: git-mail-commits v0.2
In-Reply-To: <20090407040854.4338.94304.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115902>

This patch removes the last static variables that were used in
the "show_commit" function.

To do that, we create a new "rev_list_info" struct that we will pass
in the "void *data" argument to "show_commit".

This means that we have to change the first argument to
"show_bisect_vars" too.

While at it, we also remove a "struct commit_list *list" variable
in "cmd_rev_list" that is not really needed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c           |    6 +++++-
 bisect.h           |   14 ++++++++------
 builtin-rev-list.c |   42 +++++++++++++++++++++---------------------
 3 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/bisect.c b/bisect.c
index 69f8860..4d2a150 100644
--- a/bisect.c
+++ b/bisect.c
@@ -535,8 +535,12 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix)
 int bisect_next_vars(const char *prefix)
 {
 	struct rev_info revs;
+	struct rev_list_info info;
 	int reaches = 0, all = 0;
 
+	memset(&info, 0, sizeof(info));
+	info.revs = &revs;
+
 	bisect_rev_setup(&revs, prefix);
 
 	if (prepare_revision_walk(&revs))
@@ -547,6 +551,6 @@ int bisect_next_vars(const char *prefix)
 	revs.commits = find_bisection(revs.commits, &reaches, &all,
 				      !!skipped_sha1_nr);
 
-	return show_bisect_vars(&revs, reaches, all,
+	return show_bisect_vars(&info, reaches, all,
 				BISECT_SHOW_TRIED | BISECT_SHOW_STRINGED);
 }
diff --git a/bisect.h b/bisect.h
index f5d1067..b1c334d 100644
--- a/bisect.h
+++ b/bisect.h
@@ -14,12 +14,14 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
 #define BISECT_SHOW_TRIED	(1<<1)
 #define BISECT_SHOW_STRINGED	(1<<2)
 
-/*
- * The flag BISECT_SHOW_ALL should not be set if this function is called
- * from outside "builtin-rev-list.c" as otherwise it would use
- * static "revs" from this file.
- */
-extern int show_bisect_vars(struct rev_info *revs, int reaches, int all,
+struct rev_list_info {
+	struct rev_info *revs;
+	int show_timestamp;
+	int hdr_termination;
+	const char *header_prefix;
+};
+
+extern int show_bisect_vars(struct rev_list_info *info, int reaches, int all,
 			    int flags);
 
 extern int bisect_next_vars(const char *prefix);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index cd6f6b8..244b73e 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -42,21 +42,18 @@ static const char rev_list_usage[] =
 "    --bisect-all"
 ;
 
-static int show_timestamp;
-static int hdr_termination;
-static const char *header_prefix;
-
 static void finish_commit(struct commit *commit, void *data);
 static void show_commit(struct commit *commit, void *data)
 {
-	struct rev_info *revs = data;
+	struct rev_list_info *info = data;
+	struct rev_info *revs = info->revs;
 
 	graph_show_commit(revs->graph);
 
-	if (show_timestamp)
+	if (info->show_timestamp)
 		printf("%lu ", commit->date);
-	if (header_prefix)
-		fputs(header_prefix, stdout);
+	if (info->header_prefix)
+		fputs(info->header_prefix, stdout);
 
 	if (!revs->graph) {
 		if (commit->object.flags & BOUNDARY)
@@ -138,7 +135,7 @@ static void show_commit(struct commit *commit, void *data)
 			}
 		} else {
 			if (buf.len)
-				printf("%s%c", buf.buf, hdr_termination);
+				printf("%s%c", buf.buf, info->hdr_termination);
 		}
 		strbuf_release(&buf);
 	} else {
@@ -236,11 +233,13 @@ static void show_tried_revs(struct commit_list *tried, int stringed)
 	printf(stringed ? "' &&\n" : "'\n");
 }
 
-int show_bisect_vars(struct rev_info *revs, int reaches, int all, int flags)
+int show_bisect_vars(struct rev_list_info *info, int reaches, int all,
+		     int flags)
 {
 	int cnt;
 	char hex[41] = "", *format;
 	struct commit_list *tried;
+	struct rev_info *revs = info->revs;
 
 	if (!revs->commits && !(flags & BISECT_SHOW_TRIED))
 		return 1;
@@ -264,7 +263,7 @@ int show_bisect_vars(struct rev_info *revs, int reaches, int all, int flags)
 		strcpy(hex, sha1_to_hex(revs->commits->item->object.sha1));
 
 	if (flags & BISECT_SHOW_ALL) {
-		traverse_commit_list(revs, show_commit, show_object, revs);
+		traverse_commit_list(revs, show_commit, show_object, info);
 		printf("------\n");
 	}
 
@@ -298,7 +297,7 @@ int show_bisect_vars(struct rev_info *revs, int reaches, int all, int flags)
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	struct commit_list *list;
+	struct rev_list_info info;
 	int i;
 	int read_from_stdin = 0;
 	int bisect_list = 0;
@@ -313,6 +312,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
+	memset(&info, 0, sizeof(info));
+	info.revs = &revs;
+
 	quiet = DIFF_OPT_TST(&revs.diffopt, QUIET);
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
@@ -322,7 +324,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--timestamp")) {
-			show_timestamp = 1;
+			info.show_timestamp = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--bisect")) {
@@ -352,19 +354,17 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
-		hdr_termination = '\n';
+		info.hdr_termination = '\n';
 		if (revs.commit_format == CMIT_FMT_ONELINE)
-			header_prefix = "";
+			info.header_prefix = "";
 		else
-			header_prefix = "commit ";
+			info.header_prefix = "commit ";
 	}
 	else if (revs.verbose_header)
 		/* Only --header was specified */
 		revs.commit_format = CMIT_FMT_RAW;
 
-	list = revs.commits;
-
-	if ((!list &&
+	if ((!revs.commits &&
 	     (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) &&
 	      !revs.pending.nr)) ||
 	    revs.diff)
@@ -387,14 +387,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 					      bisect_find_all);
 
 		if (bisect_show_vars)
-			return show_bisect_vars(&revs, reaches, all,
+			return show_bisect_vars(&info, reaches, all,
 						bisect_show_all ? BISECT_SHOW_ALL : 0);
 	}
 
 	traverse_commit_list(&revs,
 			     quiet ? finish_commit : show_commit,
 			     quiet ? finish_object : show_object,
-			     &revs);
+			     &info);
 
 	return 0;
 }
-- 
1.6.2.2.537.g3b83b
