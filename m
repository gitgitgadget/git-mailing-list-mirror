From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: [PATCH v7] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible
Date: Fri, 18 Oct 2013 01:08:24 +0300
Message-ID: <FB9897CC-EDC7-4EBB-8DAB-140CEB5F93B3@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> <AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com> <79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com> <89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 18 00:08:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWvkA-00023p-5R
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 00:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762799Ab3JQWIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 18:08:30 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:41406 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245Ab3JQWI3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 18:08:29 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so17507lab.40
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=/taM40OR83hkCDM73KpPpqPNaHcmIscl8HogKSpGHlM=;
        b=yssH3r9rdOo8YV7jM3ApiaodmWsIF/SpOVA7OhcG6LLwjcBAlqqbq3jBpv42FKd1ft
         0uWkg+G+4XlD6QujpqI3pr/KIpFjlrKUAKEuaaMtZbwddhccQrTAObIOS/3yItsJy/ng
         pgt3ZMdZefNPI2hk7e45MXWy0l0k3LkhHmYi3m+uukrQVYyPEmxCdbrH4hoomsNRcb8Y
         0Dlamptx7RWXiY34HOXpK09uQOGVB+mf69zPR7wzHrjzMntl08hzwpmePfsIMXDjd3OH
         pminPptWoGBytipatWyCFhkuAlMu1XmhTw22SzxwLHHmFZuFPRuh/+ZbuOJMnljajuUE
         Gm8w==
X-Received: by 10.152.7.105 with SMTP id i9mr9036009laa.9.1382047707296;
        Thu, 17 Oct 2013 15:08:27 -0700 (PDT)
Received: from [192.168.0.14] (cs27064221.pp.htv.fi. [89.27.64.221])
        by mx.google.com with ESMTPSA id m13sm56276353lbo.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 15:08:26 -0700 (PDT)
In-Reply-To: <89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236326>


"git diff -M --stat" can detect rename and show renamed file name like
"foofoofoo => barbarbar".

Before this commit, this output is shortened always by omitting left most
part like "...foo => barbarbar". So, if the destination filename is too long,
source filename putting left or arrow can be totally omitted like
"...barbarbar", without including any of "foofoofoo =>".
In such a case where arrow symbol is omitted, there is no way to know
whether the file is renamed or existed in the original.

Make sure there is always an arrow, like "...foo => ...bar".

The output can contain curly braces('{','}') for grouping.
So, in general, the output format is "<pfx>{<mid_a> => <mid_b>}<sfx>"

To keep arrow("=>"), try to omit <pfx> as long as possible at first
because later part or changing part will be the more important part.
If it is not enough, shorten <mid_a>, <mid_b>, and <sfx> trying to
have the same maximum length, but as long as filename part of <sfx>
is kept.

Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
Test-added-by: Thomas Rast <trast@inf.ethz.ch>
---
 diff.c                 | 184 +++++++++++++++++++++++++++++++++++++++++++------
 t/t4001-diff-rename.sh |  12 ++++
 2 files changed, 174 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index a04a34d..cdf59c0 100644
--- a/diff.c
+++ b/diff.c
@@ -1258,11 +1258,13 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 }
 
-static char *pprint_rename(const char *a, const char *b)
+static void find_common_prefix_suffix(const char *a, const char *b,
+				struct strbuf *pfx,
+				struct strbuf *a_mid, struct strbuf *b_mid,
+				struct strbuf *sfx)
 {
 	const char *old = a;
 	const char *new = b;
-	struct strbuf name = STRBUF_INIT;
 	int pfx_length, sfx_length;
 	int pfx_adjust_for_slash;
 	int len_a = strlen(a);
@@ -1272,10 +1274,9 @@ static char *pprint_rename(const char *a, const char *b)
 	int qlen_b = quote_c_style(b, NULL, NULL, 0);
 
 	if (qlen_a || qlen_b) {
-		quote_c_style(a, &name, NULL, 0);
-		strbuf_addstr(&name, " => ");
-		quote_c_style(b, &name, NULL, 0);
-		return strbuf_detach(&name, NULL);
+		quote_c_style(a, a_mid, NULL, 0);
+		quote_c_style(b, b_mid, NULL, 0);
+		return;
 	}
 
 	/* Find common prefix */
@@ -1322,17 +1323,146 @@ static char *pprint_rename(const char *a, const char *b)
 	if (b_midlen < 0)
 		b_midlen = 0;
 
-	strbuf_grow(&name, pfx_length + a_midlen + b_midlen + sfx_length + 7);
-	if (pfx_length + sfx_length) {
-		strbuf_add(&name, a, pfx_length);
+	strbuf_add(pfx, a, pfx_length);
+	strbuf_add(a_mid, a + pfx_length, a_midlen);
+	strbuf_add(b_mid, b + pfx_length, b_midlen);
+	strbuf_add(sfx, a + len_a - sfx_length, sfx_length);
+}
+
+/*
+ * Omit each parts to fix in name_width.
+ * Formatted string is "<pfx>{<a_mid> => <b_mid>}<sfx>".
+ * At first, omit <pfx> as long as possible.
+ * If it is not enough, omit <a_mid>, <b_mid>, <sfx> by tring to set the length of
+ * those 3 parts(including "...") to the same, but keeping filename part of <sfx>.
+ * Ex:
+ * "foofoofoo => barbarbar"
+ *   will be like
+ * "...foo => ...bar".
+ * "long_parent{foofoofoo => barbarbar}path/filename"
+ *   will be like
+ * "...parent{...foofoo => ...barbar}.../filename"
+ */
+static void rename_omit(struct strbuf *pfx,
+				struct strbuf *a_mid, struct strbuf *b_mid,
+				struct strbuf *sfx,
+				int name_width)
+{
+	static const char arrow[] = " => ";
+	static const char dots[] = "...";
+	int use_curly_braces = (pfx->len > 0) || (sfx->len > 0);
+	size_t name_len;
+	size_t max_part_len = 0;
+	size_t remainder_part_len = 0;
+	size_t left, right;
+	size_t sfx_minlen;
+	char *sfx_last_slash;
+	size_t max_sfx_len;
+
+	name_len = pfx->len + a_mid->len + b_mid->len + sfx->len + strlen(arrow)
+		+ (use_curly_braces ? 2 : 0);
+
+	if (name_len <= name_width)
+		return; /* everything fits in name_width */
+
+	if (use_curly_braces) {
+		if (strlen(dots) + (name_len - pfx->len) <= name_width) {
+			/*
+			 * Just omitting left of '{' is enough
+			 * Ex: ...aaa{foofoofoo => bar}file
+			 */
+			strbuf_splice(pfx, 0, name_len - name_width + strlen(dots), dots, strlen(dots));
+			return;
+		} else {
+			if (pfx->len > strlen(dots)) {
+				/*
+				 * Just omitting left of '{' is not enough
+				 * name will be "...{SOMETHING}SOMETHING"
+				 */
+				strbuf_reset(pfx);
+				strbuf_addstr(pfx, dots);
+			}else{
+				/*
+				 * If <pfx> is shorter than dots("..."),
+				 * there is no sense to replace <pfx> to dots
+				 * but name will be just like "a{SOMETHING}SOMETHING".
+				 */
+				;
+			}
+		}
+	}
+
+	left = 0;
+	right = name_width + 1;
+
+#define MIN(X, Y) ((X < Y) ? (X) : (Y))
+#define MAX(X, Y) ((X > Y) ? (X) : (Y))
+
+	/* Try to keep filename part(later than last '/') of <sfx> */
+	sfx_last_slash = strrchr(sfx->buf, '/');
+	if(sfx_last_slash){
+		sfx_minlen = MIN(sfx->len - (sfx_last_slash - sfx->buf) + strlen(dots), sfx->len);
+	}else{
+		sfx_minlen = sfx->len;
+	}
+	/* In case other than <sfx> is omitted like: "...{... => ...}<sfx>" */
+	sfx_minlen = MIN(sfx_minlen,
+			name_width
+			- MIN(strlen(dots), pfx->len)
+			- MIN(strlen(dots), a_mid->len)
+			- MIN(strlen(dots), b_mid->len)
+			- strlen(arrow)
+			- (use_curly_braces ? 2 : 0) );
+
+	/* binary search to find max_part_len(maximum length of omitted parts) */
+	while(left + 1 < right){
+		size_t mid = (left + right) / 2;
+
+		/* length of "<pfx>{<a_mid> => <b_mid>}<sfx>" */
+		size_t l = pfx->len + MIN(mid, a_mid->len) + MIN(mid, b_mid->len) + MAX(MIN(mid, sfx->len), sfx_minlen) + strlen(arrow) + (use_curly_braces ? 2 : 0);
+		if(l <= name_width){
+			left = mid;
+			remainder_part_len = name_width - l;
+		}else{
+			right = mid;
+		}
+	}
+	max_part_len = left;
+
+	if (max_part_len < strlen(dots))
+		max_part_len = strlen(dots);
+	max_sfx_len = MAX(max_part_len, sfx_minlen);
+	if (sfx->len > max_sfx_len)
+		strbuf_splice(sfx, 0, sfx->len - max_sfx_len + strlen(dots), dots, strlen(dots));
+	if (remainder_part_len == 2)
+		max_part_len++;
+	if (a_mid->len > max_part_len)
+		strbuf_splice(a_mid, 0, a_mid->len - max_part_len + strlen(dots), dots, strlen(dots));
+	if (remainder_part_len == 1)
+		max_part_len++;
+	if (b_mid->len > max_part_len)
+		strbuf_splice(b_mid, 0, b_mid->len - max_part_len + strlen(dots), dots, strlen(dots));
+}
+
+static char *pprint_rename(const char *a, const char *b, int name_width)
+{
+	struct strbuf pfx = STRBUF_INIT, a_mid = STRBUF_INIT, b_mid = STRBUF_INIT, sfx = STRBUF_INIT;
+	struct strbuf name = STRBUF_INIT;
+
+	find_common_prefix_suffix(a, b, &pfx, &a_mid, &b_mid, &sfx);
+	rename_omit(&pfx, &a_mid, &b_mid, &sfx, name_width);
+
+	strbuf_grow(&name, pfx.len + a_mid.len + b_mid.len + sfx.len + 7);
+	if (pfx.len + sfx.len) {
+		strbuf_addbuf(&name, &pfx);
 		strbuf_addch(&name, '{');
 	}
-	strbuf_add(&name, a + pfx_length, a_midlen);
+	strbuf_addbuf(&name, &a_mid);
 	strbuf_addstr(&name, " => ");
-	strbuf_add(&name, b + pfx_length, b_midlen);
-	if (pfx_length + sfx_length) {
+	strbuf_addbuf(&name, &b_mid);
+	if (pfx.len + sfx.len) {
 		strbuf_addch(&name, '}');
-		strbuf_add(&name, a + len_a - sfx_length, sfx_length);
+		strbuf_addbuf(&name, &sfx);
 	}
 	return strbuf_detach(&name, NULL);
 }
@@ -1418,23 +1548,31 @@ static void show_graph(FILE *file, char ch, int cnt, const char *set, const char
 	fprintf(file, "%s", reset);
 }
 
-static void fill_print_name(struct diffstat_file *file)
+static void fill_print_name(struct diffstat_file *file, int name_width)
 {
 	char *pname;
 
-	if (file->print_name)
-		return;
-
 	if (!file->is_renamed) {
 		struct strbuf buf = STRBUF_INIT;
+		if (file->print_name)
+			return;
 		if (quote_c_style(file->name, &buf, NULL, 0)) {
 			pname = strbuf_detach(&buf, NULL);
 		} else {
 			pname = file->name;
 			strbuf_release(&buf);
 		}
+		if (strlen(pname) > name_width) {
+			struct strbuf buf2 = STRBUF_INIT;
+			strbuf_addstr(&buf2, "...");
+			strbuf_addstr(&buf2, pname + strlen(pname) - name_width - 3);
+		}
 	} else {
-		pname = pprint_rename(file->from_name, file->name);
+		if (file->print_name) {
+			free(file->print_name);
+			file->print_name = NULL;
+		}
+		pname = pprint_rename(file->from_name, file->name, name_width);
 	}
 	file->print_name = pname;
 }
@@ -1517,7 +1655,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			count++; /* not shown == room for one more */
 			continue;
 		}
-		fill_print_name(file);
+		fill_print_name(file, INT_MAX);
 		len = strlen(file->print_name);
 		if (max_len < len)
 			max_len = len;
@@ -1629,7 +1767,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	for (i = 0; i < count; i++) {
 		const char *prefix = "";
 		struct diffstat_file *file = data->files[i];
-		char *name = file->print_name;
+		char *name;
 		uintmax_t added = file->added;
 		uintmax_t deleted = file->deleted;
 		int name_len;
@@ -1637,6 +1775,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (!file->is_interesting && (added + deleted == 0))
 			continue;
 
+		fill_print_name(file, name_width);
+		name = file->print_name;
 		/*
 		 * "scale" the filename
 		 */
@@ -1772,7 +1912,7 @@ static void show_numstat(struct diffstat_t *data, struct diff_options *options)
 				"%"PRIuMAX"\t%"PRIuMAX"\t",
 				file->added, file->deleted);
 		if (options->line_termination) {
-			fill_print_name(file);
+			fill_print_name(file, INT_MAX);
 			if (!file->is_renamed)
 				write_name_quoted(file->name, options->file,
 						  options->line_termination);
@@ -4258,7 +4398,7 @@ static void show_mode_change(FILE *file, struct diff_filepair *p, int show_name,
 static void show_rename_copy(FILE *file, const char *renamecopy, struct diff_filepair *p,
 			const char *line_prefix)
 {
-	char *names = pprint_rename(p->one->path, p->two->path);
+	char *names = pprint_rename(p->one->path, p->two->path, INT_MAX);
 
 	fprintf(file, " %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
 	free(names);
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2f327b7..f79b526 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -156,4 +156,16 @@ test_expect_success 'rename pretty print common prefix and suffix overlap' '
 	test_i18ngrep " d/f/{ => f}/e " output
 '
 
+test_expect_success 'rename of very long path shows =>' '
+	mkdir long_dirname_that_does_not_fit_in_a_single_line &&
+	mkdir another_extremely_long_path_but_not_the_same_as_the_first &&
+	cp path1 long_dirname*/ &&
+	git add long_dirname*/path1 &&
+	test_commit add_long_pathname &&
+	git mv long_dirname*/path1 another_extremely_*/ &&
+	test_commit move_long_pathname &&
+	git diff -M --stat HEAD^ HEAD >output &&
+	grep "=>.*path1" output
+'
+
 test_done
-- 
1.8.4.475.g867697c
