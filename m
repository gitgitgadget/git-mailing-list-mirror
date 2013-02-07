From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 6/6] combine-diff.c: teach combined diffs about line prefix
Date: Thu,  7 Feb 2013 20:15:28 +0000
Message-ID: <ca0ba198f798a5d9aeac2bf23a4ec2d0ceebcdb7.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 21:24:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Y0f-0001if-Fs
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 21:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759362Ab3BGUX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 15:23:26 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:37268 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759369Ab3BGUXG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 15:23:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A70F3161E515;
	Thu,  7 Feb 2013 20:16:09 +0000 (GMT)
X-Quarantine-ID: <pDrcw9WH2gYb>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pDrcw9WH2gYb; Thu,  7 Feb 2013 20:16:08 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 9F2C7161E4D6;
	Thu,  7 Feb 2013 20:16:01 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215728>

When running "git log --graph --cc -p" the diff output for merges is not
indented by the graph structure, unlike the diffs of non-merge commits
(added in commit 7be5761 - diff.c: Output the text graph padding before
each diff line).

Fix this by teaching the combined diff code to output diff_line_prefix()
before each line.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 combine-diff.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index bb1cc96..35c817b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -526,7 +526,8 @@ static void show_line_to_eol(const char *line, int len, const char *reset)
 	       saw_cr_at_eol ? "\r" : "");
 }
 
-static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
+static void dump_sline(struct sline *sline, const char *line_prefix,
+		       unsigned long cnt, int num_parent,
 		       int use_color, int result_deleted)
 {
 	unsigned long mark = (1UL<<num_parent);
@@ -582,7 +583,7 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 			rlines -= null_context;
 		}
 
-		fputs(c_frag, stdout);
+		printf("%s%s", line_prefix, c_frag);
 		for (i = 0; i <= num_parent; i++) putchar(combine_marker);
 		for (i = 0; i < num_parent; i++)
 			show_parent_lno(sline, lno, hunk_end, i, null_context);
@@ -614,7 +615,7 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 			struct sline *sl = &sline[lno++];
 			ll = (sl->flag & no_pre_delete) ? NULL : sl->lost_head;
 			while (ll) {
-				fputs(c_old, stdout);
+				printf("%s%s", line_prefix, c_old);
 				for (j = 0; j < num_parent; j++) {
 					if (ll->parent_map & (1UL<<j))
 						putchar('-');
@@ -627,6 +628,7 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 			if (cnt < lno)
 				break;
 			p_mask = 1;
+			fputs(line_prefix, stdout);
 			if (!(sl->flag & (mark-1))) {
 				/*
 				 * This sline was here to hang the
@@ -680,11 +682,13 @@ static void reuse_combine_diff(struct sline *sline, unsigned long cnt,
 static void dump_quoted_path(const char *head,
 			     const char *prefix,
 			     const char *path,
+			     const char *line_prefix,
 			     const char *c_meta, const char *c_reset)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
+	strbuf_addstr(&buf, line_prefix);
 	strbuf_addstr(&buf, c_meta);
 	strbuf_addstr(&buf, head);
 	quote_two_c_style(&buf, prefix, path, 0);
@@ -696,6 +700,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 				 int num_parent,
 				 int dense,
 				 struct rev_info *rev,
+				 const char *line_prefix,
 				 int mode_differs,
 				 int show_file_header)
 {
@@ -714,8 +719,8 @@ static void show_combined_header(struct combine_diff_path *elem,
 		show_log(rev);
 
 	dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
-			 "", elem->path, c_meta, c_reset);
-	printf("%sindex ", c_meta);
+			 "", elem->path, line_prefix, c_meta, c_reset);
+	printf("%s%sindex ", line_prefix, c_meta);
 	for (i = 0; i < num_parent; i++) {
 		abb = find_unique_abbrev(elem->parent[i].sha1,
 					 abbrev);
@@ -734,11 +739,12 @@ static void show_combined_header(struct combine_diff_path *elem,
 			    DIFF_STATUS_ADDED)
 				added = 0;
 		if (added)
-			printf("%snew file mode %06o",
-			       c_meta, elem->mode);
+			printf("%s%snew file mode %06o",
+			       line_prefix, c_meta, elem->mode);
 		else {
 			if (deleted)
-				printf("%sdeleted file ", c_meta);
+				printf("%s%sdeleted file ",
+				       line_prefix, c_meta);
 			printf("mode ");
 			for (i = 0; i < num_parent; i++) {
 				printf("%s%06o", i ? "," : "",
@@ -755,16 +761,16 @@ static void show_combined_header(struct combine_diff_path *elem,
 
 	if (added)
 		dump_quoted_path("--- ", "", "/dev/null",
-				 c_meta, c_reset);
+				 line_prefix, c_meta, c_reset);
 	else
 		dump_quoted_path("--- ", a_prefix, elem->path,
-				 c_meta, c_reset);
+				 line_prefix, c_meta, c_reset);
 	if (deleted)
 		dump_quoted_path("+++ ", "", "/dev/null",
-				 c_meta, c_reset);
+				 line_prefix, c_meta, c_reset);
 	else
 		dump_quoted_path("+++ ", b_prefix, elem->path,
-				 c_meta, c_reset);
+				 line_prefix, c_meta, c_reset);
 }
 
 static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
@@ -782,6 +788,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	struct userdiff_driver *userdiff;
 	struct userdiff_driver *textconv = NULL;
 	int is_binary;
+	const char *line_prefix = diff_line_prefix(opt);
 
 	context = opt->context;
 	userdiff = userdiff_find_by_path(elem->path);
@@ -901,7 +908,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	}
 	if (is_binary) {
 		show_combined_header(elem, num_parent, dense, rev,
-				     mode_differs, 0);
+				     line_prefix, mode_differs, 0);
 		printf("Binary files differ\n");
 		free(result);
 		return;
@@ -962,8 +969,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 	if (show_hunks || mode_differs || working_tree_file) {
 		show_combined_header(elem, num_parent, dense, rev,
-				     mode_differs, 1);
-		dump_sline(sline, cnt, num_parent,
+				     line_prefix, mode_differs, 1);
+		dump_sline(sline, line_prefix, cnt, num_parent,
 			   opt->use_color, result_deleted);
 	}
 	free(result);
@@ -990,6 +997,7 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 	int i, offset;
 	const char *prefix;
 	int line_termination, inter_name_termination;
+	const char *line_prefix = diff_line_prefix(opt);
 
 	line_termination = opt->line_termination;
 	inter_name_termination = '\t';
@@ -1000,6 +1008,7 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 		show_log(rev);
 
 	if (opt->output_format & DIFF_FORMAT_RAW) {
+		printf("%s", line_prefix);
 		offset = strlen(COLONS) - num_parent;
 		if (offset < 0)
 			offset = 0;
@@ -1040,6 +1049,7 @@ void show_combined_diff(struct combine_diff_path *p,
 		       struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
+
 	if (!p->len)
 		return;
 	if (opt->output_format & (DIFF_FORMAT_RAW |
@@ -1150,8 +1160,10 @@ void diff_tree_combined(const unsigned char *sha1,
 
 		if (show_log_first && i == 0) {
 			show_log(rev);
+
 			if (rev->verbose_header && opt->output_format)
-				putchar(opt->line_termination);
+				printf("%s%c", diff_line_prefix(opt),
+				       opt->line_termination);
 		}
 		diff_flush(&diffopts);
 	}
@@ -1179,7 +1191,8 @@ void diff_tree_combined(const unsigned char *sha1,
 
 		if (opt->output_format & DIFF_FORMAT_PATCH) {
 			if (needsep)
-				putchar(opt->line_termination);
+				printf("%s%c", diff_line_prefix(opt),
+				       opt->line_termination);
 			for (p = paths; p; p = p->next) {
 				if (p->len)
 					show_patch_diff(p, num_parent, dense,
-- 
1.8.1.2
