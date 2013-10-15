From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: [PATCH v5] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Tue, 15 Oct 2013 13:24:06 +0300
Message-ID: <79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> <AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 15 12:24:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW1nW-0002jc-1n
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 12:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274Ab3JOKYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 06:24:14 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:55895 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab3JOKYN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Oct 2013 06:24:13 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so6591100lab.39
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 03:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=GHE5C9TNZCclEeasV8qh5NKQQ/+wP1lL/W69kpl8RF0=;
        b=y96O5fFcAynO5hoNj+4/m5BnA061wd8ml0lbd9ncV+o8vkeWcp+Na60FHwDpqR+9wF
         b68r5KTr+JWElaLMTW2s22P/EmCP7PAhjPYt88PVDQMf7SVwgxwCuZkg5r8H6kGKiohe
         vLdwnDzJlbzbs/ZOcki53+Mo9x48AXkbhP9pCudlrCkKv5X3Ip+10soj33GW0v+KdEKM
         akZuj3Fkb42R7gYwsGJnsiIhQKBDLrYVKxYGLUrgMHByiYuP0cEUU7zZiamZ3U565s9y
         S3WZRPoXiRhnTi1Rts1hh4WGu/5WJw5w/r6/Hk4zugnmseCpMiOQxjSYlStIFZpG1xaE
         wg2g==
X-Received: by 10.152.26.201 with SMTP id n9mr309239lag.52.1381832651435;
        Tue, 15 Oct 2013 03:24:11 -0700 (PDT)
Received: from [10.128.134.109] (fsgw.f-secure.com. [193.110.108.33])
        by mx.google.com with ESMTPSA id ua4sm46970957lbb.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 03:24:10 -0700 (PDT)
In-Reply-To: <AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236173>


"git diff -M --stat" can detect rename and show renamed file name like
"foofoofoo => barbarbar". But if destination filename is long, the line
is shortened like "...barbarbar" so there is no way to know whether the
file is renamed or existed in the source commit.
Make sure there is always an arrow, like "...foo => ...bar".
The output can contains curly braces('{','}') for grouping.
So, in general, the outpu format is "<pfx>{<mid_a> => <mid_b>}<sfx>"
To keep arrow("=>"), try to omit <pfx> as long as possible at first
because later part or changing part will be the more important part.
If it is not enough, shorten <mid_a>, <mid_b>, and <sfx> trying to
have the maximum length the same because those will be equaly important.

Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
Test-added-by: Thomas Rast <trast@inf.ethz.ch>
---
 diff.c                 | 187 +++++++++++++++++++++++++++++++++++++++++++------
 t/t4001-diff-rename.sh |  12 ++++
 2 files changed, 177 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index a04a34d..cf50807 100644
--- a/diff.c
+++ b/diff.c
@@ -1258,11 +1258,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 }
 
-static char *pprint_rename(const char *a, const char *b)
+static void pprint_rename_find_common_prefix_suffix(const char *a, const char *b
+													, struct strbuf *pfx, struct strbuf *a_mid
+													, struct strbuf *b_mid, struct strbuf *sfx)
 {
 	const char *old = a;
 	const char *new = b;
-	struct strbuf name = STRBUF_INIT;
 	int pfx_length, sfx_length;
 	int pfx_adjust_for_slash;
 	int len_a = strlen(a);
@@ -1272,10 +1273,9 @@ static char *pprint_rename(const char *a, const char *b)
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
@@ -1321,18 +1321,151 @@ static char *pprint_rename(const char *a, const char *b)
 		a_midlen = 0;
 	if (b_midlen < 0)
 		b_midlen = 0;
+	
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
+ * those 3 parts(including "...") to the same.
+ * Ex:
+ * "foofoofoo => barbarbar"
+ *   will be like
+ * "...foo => ...bar".
+ * "long_parent{foofoofoo => barbarbar}longfilename"
+ *   will be like
+ * "...parent{...foofoo => ...barbar}...lename"
+ */
+static void pprint_rename_omit(struct strbuf *pfx, struct strbuf *a_mid, struct strbuf *b_mid
+							   , struct strbuf *sfx, int name_width)
+{
+
+#define ARROW " => "
+#define ELLIPSIS "..."
+#define swap(a, b) myswap((a), (b), sizeof(a))
+	
+#define myswap(a, b, size) do {		\
+unsigned char mytmp[size];	\
+memcpy(mytmp, &a, size);		\
+memcpy(&a, &b, size);		\
+memcpy(&b, mytmp, size);		\
+} while (0)
+
+	int use_curly_braces = (pfx->len > 0) || (sfx->len > 0);
+	size_t name_len;
+	size_t len;
+	size_t part_lengths[4];
+	size_t max_part_len = 0;
+	size_t remainder_part_len = 0;
+	int i, j;
+
+	name_len = pfx->len + a_mid->len + b_mid->len + sfx->len + strlen(ARROW)
+		+ (use_curly_braces ? 2 : 0);
+	
+	if (name_len <= name_width) {
+		/* Everthing fits in name_width */
+		return;
+	}
+	
+	if (use_curly_braces) {
+		if (strlen(ELLIPSIS) + (name_len - pfx->len) <= name_width) {
+			/*
+			 Just omitting left of '{' is enough
+			 Ex: ...aaa{foofoofoo => bar}file
+			 */
+			strbuf_splice(pfx, name_len - pfx->len, name_width - (name_len - pfx->len), ELLIPSIS, strlen(ELLIPSIS));
+			return;
+		} else {
+			if (pfx->len > strlen(ELLIPSIS)) {
+				/*
+				 Just omitting left of '{' is not enough
+				 name will be "...{SOMETHING}SOMETHING"
+				 */
+				strbuf_reset(pfx);
+				strbuf_addstr(pfx, ELLIPSIS);
+			}
+		}
+	}
 
-	strbuf_grow(&name, pfx_length + a_midlen + b_midlen + sfx_length + 7);
-	if (pfx_length + sfx_length) {
-		strbuf_add(&name, a, pfx_length);
+	/* available length for a_mid, b_mid and sfx */
+	len = name_width - strlen(ARROW) - (use_curly_braces ? 2 : 0);
+	
+	/* a_mid, b_mid, sfx will be have the same max, including ellipsis("..."). */
+	part_lengths[0] = (int)a_mid->len;
+	part_lengths[1] = (int)b_mid->len;
+	part_lengths[2] = (int)sfx->len;
+	
+	/* bubble sort of part_lengths, descending order */
+	for (i=0; i<3; i++) {
+		for (j=i+1; j<3; j++) {
+			if (part_lengths[j] > part_lengths[i]) {
+				swap(part_lengths[i], part_lengths[j]);
+			}
+		}
+	}
+	
+	if (part_lengths[1] + part_lengths[1] + part_lengths[2] <= len) {
+		/*
+		 * "{...foofoo => barbar}file"
+		 * There is only one omitting part.
+		 */
+		max_part_len = len - part_lengths[1] - part_lengths[2];
+	} else if (part_lengths[2] + part_lengths[2] + part_lengths[2] <= len) {
+		/*
+		 * "{...foofoo => ...barbar}file"
+		 * There are 2 omitting part.
+		 */
+		max_part_len = (len - part_lengths[2]) / 2;
+		remainder_part_len = (len - part_lengths[2]) - max_part_len * 2;
+	} else {
+		/*
+		 * "{...ofoo => ...rbar}...file"
+		 * There are 3 omitting part.
+		 */
+		max_part_len = len / 3;
+		remainder_part_len = len - (max_part_len) * 3;
+	}
+	
+	if (max_part_len < strlen(ELLIPSIS))
+		max_part_len = strlen(ELLIPSIS);
+	
+	if (sfx->len > max_part_len)
+		strbuf_splice(sfx, 0, sfx->len - max_part_len + strlen(ELLIPSIS), ELLIPSIS, strlen(ELLIPSIS));
+	if (remainder_part_len == 2)
+		max_part_len++;
+	if (a_mid->len > max_part_len)
+		strbuf_splice(a_mid, 0, a_mid->len - max_part_len + strlen(ELLIPSIS), ELLIPSIS, strlen(ELLIPSIS));
+	if (remainder_part_len == 1)
+		max_part_len++;
+	if (b_mid->len > max_part_len)
+		strbuf_splice(b_mid, 0, b_mid->len - max_part_len + strlen(ELLIPSIS), ELLIPSIS, strlen(ELLIPSIS));
+}
+
+static char *pprint_rename(const char *a, const char *b, int name_width)
+{
+	struct strbuf pfx = STRBUF_INIT, a_mid = STRBUF_INIT, b_mid = STRBUF_INIT, sfx = STRBUF_INIT;
+	struct strbuf name = STRBUF_INIT;
+	
+	pprint_rename_find_common_prefix_suffix(a, b, &pfx, &a_mid, &b_mid, &sfx);
+	pprint_rename_omit(&pfx, &a_mid, &b_mid, &sfx, name_width);
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
@@ -1418,23 +1551,31 @@ static void show_graph(FILE *file, char ch, int cnt, const char *set, const char
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
@@ -1517,7 +1658,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			count++; /* not shown == room for one more */
 			continue;
 		}
-		fill_print_name(file);
+		fill_print_name(file, INT_MAX);
 		len = strlen(file->print_name);
 		if (max_len < len)
 			max_len = len;
@@ -1629,7 +1770,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	for (i = 0; i < count; i++) {
 		const char *prefix = "";
 		struct diffstat_file *file = data->files[i];
-		char *name = file->print_name;
+		char *name;
 		uintmax_t added = file->added;
 		uintmax_t deleted = file->deleted;
 		int name_len;
@@ -1637,6 +1778,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (!file->is_interesting && (added + deleted == 0))
 			continue;
 
+		fill_print_name(file, name_width);
+		name = file->print_name;
 		/*
 		 * "scale" the filename
 		 */
@@ -1772,7 +1915,7 @@ static void show_numstat(struct diffstat_t *data, struct diff_options *options)
 				"%"PRIuMAX"\t%"PRIuMAX"\t",
 				file->added, file->deleted);
 		if (options->line_termination) {
-			fill_print_name(file);
+			fill_print_name(file, INT_MAX);
 			if (!file->is_renamed)
 				write_name_quoted(file->name, options->file,
 						  options->line_termination);
@@ -4258,7 +4401,7 @@ static void show_mode_change(FILE *file, struct diff_filepair *p, int show_name,
 static void show_rename_copy(FILE *file, const char *renamecopy, struct diff_filepair *p,
 			const char *line_prefix)
 {
-	char *names = pprint_rename(p->one->path, p->two->path);
+	char *names = pprint_rename(p->one->path, p->two->path, INT_MAX);
 
 	fprintf(file, " %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
 	free(names);
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2f327b7..03d6371 100755
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
+	test_i18ngrep "=>.*path1" output
+'
+
 test_done
-- 
1.8.4.475.g867697c
