From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/86] fast-import: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:05:56 +0100
Message-ID: <20131109070720.18178.66984.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2i1-0005uf-7I
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933402Ab3KIHLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:42 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36259 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932772Ab3KIHIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:22 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 40820A3;
	Sat,  9 Nov 2013 08:08:20 +0100 (CET)
X-git-sha1: 79a02e00a6c3d9a72e6a6aa432f7f4e018c279cb 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237538>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 fast-import.c | 80 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index f4d9969..14f69a1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1877,8 +1877,8 @@ static int read_next_command(void)
 				return EOF;
 
 			if (!seen_data_command
-				&& prefixcmp(command_buf.buf, "feature ")
-				&& prefixcmp(command_buf.buf, "option ")) {
+				&& !has_prefix(command_buf.buf, "feature ")
+				&& !has_prefix(command_buf.buf, "option ")) {
 				parse_argv();
 			}
 
@@ -1898,7 +1898,7 @@ static int read_next_command(void)
 			rc->prev->next = rc;
 			cmd_tail = rc;
 		}
-		if (!prefixcmp(command_buf.buf, "cat-blob ")) {
+		if (has_prefix(command_buf.buf, "cat-blob ")) {
 			parse_cat_blob();
 			continue;
 		}
@@ -1917,7 +1917,7 @@ static void skip_optional_lf(void)
 
 static void parse_mark(void)
 {
-	if (!prefixcmp(command_buf.buf, "mark :")) {
+	if (has_prefix(command_buf.buf, "mark :")) {
 		next_mark = strtoumax(command_buf.buf + 6, NULL, 10);
 		read_next_command();
 	}
@@ -1929,10 +1929,10 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 {
 	strbuf_reset(sb);
 
-	if (prefixcmp(command_buf.buf, "data "))
+	if (!has_prefix(command_buf.buf, "data "))
 		die("Expected 'data n' command, found: %s", command_buf.buf);
 
-	if (!prefixcmp(command_buf.buf + 5, "<<")) {
+	if (has_prefix(command_buf.buf + 5, "<<")) {
 		char *term = xstrdup(command_buf.buf + 5 + 2);
 		size_t term_len = command_buf.len - 5 - 2;
 
@@ -2306,7 +2306,7 @@ static void file_change_m(struct branch *b)
 	if (*p == ':') {
 		oe = find_mark(parse_mark_ref_space(&p));
 		hashcpy(sha1, oe->idx.sha1);
-	} else if (!prefixcmp(p, "inline ")) {
+	} else if (has_prefix(p, "inline ")) {
 		inline_data = 1;
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
 		p += strlen("inline");  /* advance to space */
@@ -2479,7 +2479,7 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
 	if (*p == ':') {
 		oe = find_mark(parse_mark_ref_space(&p));
 		hashcpy(sha1, oe->idx.sha1);
-	} else if (!prefixcmp(p, "inline ")) {
+	} else if (has_prefix(p, "inline ")) {
 		inline_data = 1;
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
 		p += strlen("inline");  /* advance to space */
@@ -2590,7 +2590,7 @@ static int parse_from(struct branch *b)
 	const char *from;
 	struct branch *s;
 
-	if (prefixcmp(command_buf.buf, "from "))
+	if (!has_prefix(command_buf.buf, "from "))
 		return 0;
 
 	if (b->branch_tree.tree) {
@@ -2636,7 +2636,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 	struct branch *s;
 
 	*count = 0;
-	while (!prefixcmp(command_buf.buf, "merge ")) {
+	while (has_prefix(command_buf.buf, "merge ")) {
 		from = strchr(command_buf.buf, ' ') + 1;
 		n = xmalloc(sizeof(*n));
 		s = lookup_branch(from);
@@ -2687,11 +2687,11 @@ static void parse_new_commit(void)
 
 	read_next_command();
 	parse_mark();
-	if (!prefixcmp(command_buf.buf, "author ")) {
+	if (has_prefix(command_buf.buf, "author ")) {
 		author = parse_ident(command_buf.buf + 7);
 		read_next_command();
 	}
-	if (!prefixcmp(command_buf.buf, "committer ")) {
+	if (has_prefix(command_buf.buf, "committer ")) {
 		committer = parse_ident(command_buf.buf + 10);
 		read_next_command();
 	}
@@ -2712,19 +2712,19 @@ static void parse_new_commit(void)
 
 	/* file_change* */
 	while (command_buf.len > 0) {
-		if (!prefixcmp(command_buf.buf, "M "))
+		if (has_prefix(command_buf.buf, "M "))
 			file_change_m(b);
-		else if (!prefixcmp(command_buf.buf, "D "))
+		else if (has_prefix(command_buf.buf, "D "))
 			file_change_d(b);
-		else if (!prefixcmp(command_buf.buf, "R "))
+		else if (has_prefix(command_buf.buf, "R "))
 			file_change_cr(b, 1);
-		else if (!prefixcmp(command_buf.buf, "C "))
+		else if (has_prefix(command_buf.buf, "C "))
 			file_change_cr(b, 0);
-		else if (!prefixcmp(command_buf.buf, "N "))
+		else if (has_prefix(command_buf.buf, "N "))
 			note_change_n(b, &prev_fanout);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
-		else if (!prefixcmp(command_buf.buf, "ls "))
+		else if (has_prefix(command_buf.buf, "ls "))
 			parse_ls(b);
 		else {
 			unread_command_buf = 1;
@@ -2793,7 +2793,7 @@ static void parse_new_tag(void)
 	read_next_command();
 
 	/* from ... */
-	if (prefixcmp(command_buf.buf, "from "))
+	if (!has_prefix(command_buf.buf, "from "))
 		die("Expected from command, got %s", command_buf.buf);
 	from = strchr(command_buf.buf, ' ') + 1;
 	s = lookup_branch(from);
@@ -2821,7 +2821,7 @@ static void parse_new_tag(void)
 	read_next_command();
 
 	/* tagger ... */
-	if (!prefixcmp(command_buf.buf, "tagger ")) {
+	if (has_prefix(command_buf.buf, "tagger ")) {
 		tagger = parse_ident(command_buf.buf + 7);
 		read_next_command();
 	} else
@@ -3209,7 +3209,7 @@ static void option_export_pack_edges(const char *edges)
 
 static int parse_one_option(const char *option)
 {
-	if (!prefixcmp(option, "max-pack-size=")) {
+	if (has_prefix(option, "max-pack-size=")) {
 		unsigned long v;
 		if (!git_parse_ulong(option + 14, &v))
 			return 0;
@@ -3221,20 +3221,20 @@ static int parse_one_option(const char *option)
 			v = 1024 * 1024;
 		}
 		max_packsize = v;
-	} else if (!prefixcmp(option, "big-file-threshold=")) {
+	} else if (has_prefix(option, "big-file-threshold=")) {
 		unsigned long v;
 		if (!git_parse_ulong(option + 19, &v))
 			return 0;
 		big_file_threshold = v;
-	} else if (!prefixcmp(option, "depth=")) {
+	} else if (has_prefix(option, "depth=")) {
 		option_depth(option + 6);
-	} else if (!prefixcmp(option, "active-branches=")) {
+	} else if (has_prefix(option, "active-branches=")) {
 		option_active_branches(option + 16);
-	} else if (!prefixcmp(option, "export-pack-edges=")) {
+	} else if (has_prefix(option, "export-pack-edges=")) {
 		option_export_pack_edges(option + 18);
-	} else if (!prefixcmp(option, "quiet")) {
+	} else if (has_prefix(option, "quiet")) {
 		show_stats = 0;
-	} else if (!prefixcmp(option, "stats")) {
+	} else if (has_prefix(option, "stats")) {
 		show_stats = 1;
 	} else {
 		return 0;
@@ -3245,14 +3245,14 @@ static int parse_one_option(const char *option)
 
 static int parse_one_feature(const char *feature, int from_stream)
 {
-	if (!prefixcmp(feature, "date-format=")) {
+	if (has_prefix(feature, "date-format=")) {
 		option_date_format(feature + 12);
-	} else if (!prefixcmp(feature, "import-marks=")) {
+	} else if (has_prefix(feature, "import-marks=")) {
 		option_import_marks(feature + 13, from_stream, 0);
-	} else if (!prefixcmp(feature, "import-marks-if-exists=")) {
+	} else if (has_prefix(feature, "import-marks-if-exists=")) {
 		option_import_marks(feature + strlen("import-marks-if-exists="),
 					from_stream, 1);
-	} else if (!prefixcmp(feature, "export-marks=")) {
+	} else if (has_prefix(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
 	} else if (!strcmp(feature, "cat-blob")) {
 		; /* Don't die - this feature is supported */
@@ -3350,7 +3350,7 @@ static void parse_argv(void)
 		if (parse_one_feature(a + 2, 0))
 			continue;
 
-		if (!prefixcmp(a + 2, "cat-blob-fd=")) {
+		if (has_prefix(a + 2, "cat-blob-fd=")) {
 			option_cat_blob_fd(a + 2 + strlen("cat-blob-fd="));
 			continue;
 		}
@@ -3404,25 +3404,25 @@ int main(int argc, char **argv)
 	while (read_next_command() != EOF) {
 		if (!strcmp("blob", command_buf.buf))
 			parse_new_blob();
-		else if (!prefixcmp(command_buf.buf, "ls "))
+		else if (has_prefix(command_buf.buf, "ls "))
 			parse_ls(NULL);
-		else if (!prefixcmp(command_buf.buf, "commit "))
+		else if (has_prefix(command_buf.buf, "commit "))
 			parse_new_commit();
-		else if (!prefixcmp(command_buf.buf, "tag "))
+		else if (has_prefix(command_buf.buf, "tag "))
 			parse_new_tag();
-		else if (!prefixcmp(command_buf.buf, "reset "))
+		else if (has_prefix(command_buf.buf, "reset "))
 			parse_reset_branch();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
 		else if (!strcmp("done", command_buf.buf))
 			break;
-		else if (!prefixcmp(command_buf.buf, "progress "))
+		else if (has_prefix(command_buf.buf, "progress "))
 			parse_progress();
-		else if (!prefixcmp(command_buf.buf, "feature "))
+		else if (has_prefix(command_buf.buf, "feature "))
 			parse_feature();
-		else if (!prefixcmp(command_buf.buf, "option git "))
+		else if (has_prefix(command_buf.buf, "option git "))
 			parse_option();
-		else if (!prefixcmp(command_buf.buf, "option "))
+		else if (has_prefix(command_buf.buf, "option "))
 			/* ignore non-git options*/;
 		else
 			die("Unsupported command: %s", command_buf.buf);
-- 
1.8.4.1.566.geca833c
