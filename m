From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] combine-diff: use color
Date: Thu, 10 Aug 2006 00:31:47 -0700
Message-ID: <7v64h1xd0c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 10 09:31:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB51F-0002cl-F3
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 09:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWHJHbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 03:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWHJHbt
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 03:31:49 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:28403 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751448AbWHJHbs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 03:31:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810073148.UEQW27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 03:31:48 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25158>

Using the same mechanism as the regular diffs, color combined diff
output.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I do not use color myself, but I thought this would be good
   for consistency's sake...

 combine-diff.c |   50 ++++++++++++++++++++++++++++++++++----------------
 1 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 919112b..ba8baca 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -497,11 +497,17 @@ static void show_parent_lno(struct sline
 	printf(" -%lu,%lu", l0, l1-l0);
 }
 
-static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent)
+static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
+		       int use_color)
 {
 	unsigned long mark = (1UL<<num_parent);
 	int i;
 	unsigned long lno = 0;
+	const char *c_frag = diff_get_color(use_color, DIFF_FRAGINFO);
+	const char *c_new = diff_get_color(use_color, DIFF_FILE_NEW);
+	const char *c_old = diff_get_color(use_color, DIFF_FILE_OLD);
+	const char *c_plain = diff_get_color(use_color, DIFF_PLAIN);
+	const char *c_reset = diff_get_color(use_color, DIFF_RESET);
 
 	if (!cnt)
 		return; /* result deleted */
@@ -522,12 +528,13 @@ static void dump_sline(struct sline *sli
 		rlines = hunk_end - lno;
 		if (cnt < hunk_end)
 			rlines--; /* pointing at the last delete hunk */
+		fputs(c_frag, stdout);
 		for (i = 0; i <= num_parent; i++) putchar(combine_marker);
 		for (i = 0; i < num_parent; i++)
 			show_parent_lno(sline, lno, hunk_end, i);
 		printf(" +%lu,%lu ", lno+1, rlines);
 		for (i = 0; i <= num_parent; i++) putchar(combine_marker);
-		putchar('\n');
+		printf("%s\n", c_reset);
 		while (lno < hunk_end) {
 			struct lline *ll;
 			int j;
@@ -535,18 +542,23 @@ static void dump_sline(struct sline *sli
 			sl = &sline[lno++];
 			ll = sl->lost_head;
 			while (ll) {
+				fputs(c_old, stdout);
 				for (j = 0; j < num_parent; j++) {
 					if (ll->parent_map & (1UL<<j))
 						putchar('-');
 					else
 						putchar(' ');
 				}
-				puts(ll->line);
+				printf("%s%s\n", ll->line, c_reset);
 				ll = ll->next;
 			}
 			if (cnt < lno)
 				break;
 			p_mask = 1;
+			if (!(sl->flag & (mark-1)))
+				fputs(c_plain, stdout);
+			else
+				fputs(c_new, stdout);
 			for (j = 0; j < num_parent; j++) {
 				if (p_mask & sl->flag)
 					putchar('+');
@@ -554,7 +566,7 @@ static void dump_sline(struct sline *sli
 					putchar(' ');
 				p_mask <<= 1;
 			}
-			printf("%.*s\n", sl->len, sl->bol);
+			printf("%.*s%s\n", sl->len, sl->bol, c_reset);
 		}
 	}
 }
@@ -586,14 +598,15 @@ static void reuse_combine_diff(struct sl
 	sline->p_lno[i] = sline->p_lno[j];
 }
 
-static void dump_quoted_path(const char *prefix, const char *path)
+static void dump_quoted_path(const char *prefix, const char *path,
+			     const char *c_meta, const char *c_reset)
 {
-	fputs(prefix, stdout);
+	printf("%s%s", c_meta, prefix);
 	if (quote_c_style(path, NULL, NULL, 0))
 		quote_c_style(path, NULL, stdout, 0);
 	else
 		printf("%s", path);
-	putchar('\n');
+	printf("%s\n", c_reset);
 }
 
 static int show_patch_diff(struct combine_diff_path *elem, int num_parent,
@@ -699,18 +712,22 @@ static int show_patch_diff(struct combin
 
 	if (show_hunks || mode_differs || working_tree_file) {
 		const char *abb;
+		int use_color = opt->color_diff;
+		const char *c_meta = diff_get_color(use_color, DIFF_METAINFO);
+		const char *c_reset = diff_get_color(use_color, DIFF_RESET);
 
 		if (rev->loginfo)
 			show_log(rev, opt->msg_sep);
-		dump_quoted_path(dense ? "diff --cc " : "diff --combined ", elem->path);
-		printf("index ");
+		dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
+				 elem->path, c_meta, c_reset);
+		printf("%sindex ", c_meta);
 		for (i = 0; i < num_parent; i++) {
 			abb = find_unique_abbrev(elem->parent[i].sha1,
 						 abbrev);
 			printf("%s%s", i ? "," : "", abb);
 		}
 		abb = find_unique_abbrev(elem->sha1, abbrev);
-		printf("..%s\n", abb);
+		printf("..%s%s\n", abb, c_reset);
 
 		if (mode_differs) {
 			int added = !!elem->mode;
@@ -719,10 +736,11 @@ static int show_patch_diff(struct combin
 				    DIFF_STATUS_ADDED)
 					added = 0;
 			if (added)
-				printf("new file mode %06o", elem->mode);
+				printf("%snew file mode %06o",
+				       c_meta, elem->mode);
 			else {
 				if (!elem->mode)
-					printf("deleted file ");
+					printf("%sdeleted file ", c_meta);
 				printf("mode ");
 				for (i = 0; i < num_parent; i++) {
 					printf("%s%06o", i ? "," : "",
@@ -731,11 +749,11 @@ static int show_patch_diff(struct combin
 				if (elem->mode)
 					printf("..%06o", elem->mode);
 			}
-			putchar('\n');
+			printf("%s\n", c_reset);
 		}
-		dump_quoted_path("--- a/", elem->path);
-		dump_quoted_path("+++ b/", elem->path);
-		dump_sline(sline, cnt, num_parent);
+		dump_quoted_path("--- a/", elem->path, c_meta, c_reset);
+		dump_quoted_path("+++ b/", elem->path, c_meta, c_reset);
+		dump_sline(sline, cnt, num_parent, opt->color_diff);
 	}
 	free(result);
 
-- 
1.4.2.rc4.gcdaa
