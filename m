From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 7/7] Make --color-words work well with --graph.
Date: Sat, 15 May 2010 04:02:11 -0700
Message-ID: <1273921331-32702-8-git-send-email-struggleyb.nku@gmail.com>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-2-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-3-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-4-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-5-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-6-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-7-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 13:02:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODF8r-0007wy-9v
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 13:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0EOLCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 07:02:30 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56582 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914Ab0EOLC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 07:02:28 -0400
Received: by mail-pw0-f46.google.com with SMTP id 10so1055800pwi.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gAR/VIvYdyVZmQbc6eMul95wHdAze8orJAg6WeE4/KA=;
        b=jv5jhLChU5a1bMsfb8eBz173FyaPUoC663A6VhtDWAtUvgh/eGJtupdaNaJeAdx9h7
         SXXiTBH6NqlCVXu6YeejQNuRSEU0vKA2O7MppH9YUzTYKaczYgsMftt2YoWs81kAJV+D
         81n1XDhOgqLurfVe5i34BUhJNjUDzcSlKR+yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F+nUvhjZSmBCH/fWrRv7ThkhSW2tr4bkQALSEHoWRdBb+4/liETHfzwNMnDBdh1b6M
         dVE2PkZFNmzT3NNdmpRaImrn0g6In1nY+lhhgke3jqTAdIGfwPqEFdzKT2u+/JJarF9m
         osCcnnai1z7Phn7qjFA7IogvQLPdRLb/6q238=
Received: by 10.115.65.12 with SMTP id s12mr2151389wak.76.1273921347888;
        Sat, 15 May 2010 04:02:27 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id d16sm28703988wam.12.2010.05.15.04.02.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 04:02:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1273921331-32702-7-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147146>

Align color words output with text graph lines.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 color.c |   21 +++++++++++----
 color.h |    3 +-
 diff.c  |   84 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 83 insertions(+), 25 deletions(-)

diff --git a/color.c b/color.c
index bcf4e2c..e034e3b 100644
--- a/color.c
+++ b/color.c
@@ -218,22 +218,31 @@ int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...)
  * Returns 0 on success.
  */
 int color_fwrite_lines(FILE *fp, const char *color,
-		size_t count, const char *buf)
+		size_t count, const char *buf, const char *prefix)
 {
-	if (!*color)
-		return fwrite(buf, count, 1, fp) != 1;
+	int printing = 0;
+	const char *reset = GIT_COLOR_RESET;
+
+	if (strlen(color) == 0)
+		reset = "";
+
 	while (count) {
 		char *p = memchr(buf, '\n', count);
-		if (p != buf && (fputs(color, fp) < 0 ||
+		if (printing)
+			fputs(prefix, fp);
+		if (p != buf) {
+			if (fputs(color, fp) < 0 ||
 				fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
-				fputs(GIT_COLOR_RESET, fp) < 0))
-			return -1;
+				fputs(reset, fp) < 0)
+				return -1;
+		}
 		if (!p)
 			return 0;
 		if (fputc('\n', fp) < 0)
 			return -1;
 		count -= p + 1 - buf;
 		buf = p + 1;
+		printing = 1;
 	}
 	return 0;
 }
diff --git a/color.h b/color.h
index 5c264b0..55fea4f 100644
--- a/color.h
+++ b/color.h
@@ -61,6 +61,7 @@ __attribute__((format (printf, 3, 4)))
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
-int color_fwrite_lines(FILE *fp, const char *color, size_t count, const char *buf);
+int color_fwrite_lines(FILE *fp, const char *color, size_t count,
+	const char *buf, const char *prefix);
 
 #endif /* COLOR_H */
diff --git a/diff.c b/diff.c
index ed97115..216cd5b 100644
--- a/diff.c
+++ b/diff.c
@@ -600,7 +600,8 @@ static void diff_words_append(char *line, unsigned long len,
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	const char *current_plus;
-	FILE *file;
+	int last_minus;
+	struct diff_options *opt;
 	regex_t *word_regex;
 };
 
@@ -609,11 +610,21 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	struct diff_words_data *diff_words = priv;
 	int minus_first, minus_len, plus_first, plus_len;
 	const char *minus_begin, *minus_end, *plus_begin, *plus_end;
+	struct diff_options *opt = diff_words->opt;
+	struct strbuf *msgbuf;
+	char *line_prefix = "";
+	int print = 0;
 
 	if (line[0] != '@' || parse_hunk_header(line, len,
 			&minus_first, &minus_len, &plus_first, &plus_len))
 		return;
 
+	assert(opt);
+	if (opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt->file, 0, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
+
 	/* POSIX requires that first be decremented by one if len == 0... */
 	if (minus_len) {
 		minus_begin = diff_words->minus.orig[minus_first].begin;
@@ -629,20 +640,39 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	} else
 		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
 
-	if (diff_words->current_plus != plus_begin)
-		fwrite(diff_words->current_plus,
-				plus_begin - diff_words->current_plus, 1,
-				diff_words->file);
-	if (minus_begin != minus_end)
-		color_fwrite_lines(diff_words->file,
+	if (diff_words->current_plus != plus_begin) {
+		if ((diff_words->current_plus == diff_words->plus.text.ptr &&
+			diff_words->last_minus == 0) ||
+			(diff_words->current_plus > diff_words->plus.text.ptr &&
+			*(diff_words->current_plus - 1) == '\n')) {
+			fputs(line_prefix, diff_words->opt->file);
+			print = 1;
+		}
+		color_fwrite_lines(diff_words->opt->file, "",
+				plus_begin - diff_words->current_plus,
+				diff_words->current_plus, line_prefix);
+	}
+	if (minus_begin != minus_end) {
+		if ((plus_begin > diff_words->plus.text.ptr &&
+			*(plus_begin - 1) == '\n') || 
+			(minus_first == 1 && print == 0))
+			fputs(line_prefix, diff_words->opt->file);
+		color_fwrite_lines(diff_words->opt->file,
 				diff_get_color(1, DIFF_FILE_OLD),
-				minus_end - minus_begin, minus_begin);
-	if (plus_begin != plus_end)
-		color_fwrite_lines(diff_words->file,
+				minus_end - minus_begin, minus_begin, line_prefix);
+	}
+	if (plus_begin != plus_end) {
+		if((minus_len == 0 && plus_first == 1 && print == 0) ||
+			(plus_begin > diff_words->plus.text.ptr &&
+			*(plus_begin - 1) == '\n' && minus_len == 0))
+			fputs(line_prefix, diff_words->opt->file);
+		color_fwrite_lines(diff_words->opt->file,
 				diff_get_color(1, DIFF_FILE_NEW),
-				plus_end - plus_begin, plus_begin);
+				plus_end - plus_begin, plus_begin, line_prefix);
+	}
 
 	diff_words->current_plus = plus_end;
+	diff_words->last_minus = minus_first;
 }
 
 /* This function starts looking at *begin, and returns 0 iff a word was found. */
@@ -721,17 +751,29 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	mmfile_t minus, plus;
+	struct diff_options *opt = diff_words->opt;
+	struct strbuf *msgbuf;
+	char *line_prefix = "";
+
+	assert(opt);
+	if (opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt->file, 0, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
-		color_fwrite_lines(diff_words->file,
+		fputs(line_prefix, diff_words->opt->file);
+		color_fwrite_lines(diff_words->opt->file,
 			diff_get_color(1, DIFF_FILE_OLD),
-			diff_words->minus.text.size, diff_words->minus.text.ptr);
+			diff_words->minus.text.size,
+			diff_words->minus.text.ptr, line_prefix);
 		diff_words->minus.text.size = 0;
 		return;
 	}
 
 	diff_words->current_plus = diff_words->plus.text.ptr;
+	diff_words->last_minus = 0;
 
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
@@ -745,11 +787,17 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	free(minus.ptr);
 	free(plus.ptr);
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
-			diff_words->plus.text.size)
-		fwrite(diff_words->current_plus,
+			diff_words->plus.text.size) {
+		if ((diff_words->current_plus == diff_words->plus.text.ptr &&
+			diff_words->last_minus == 0) ||
+			(diff_words->current_plus > diff_words->plus.text.ptr &&
+			*(diff_words->current_plus - 1) == '\n'))
+			fputs(line_prefix, diff_words->opt->file);
+		color_fwrite_lines(diff_words->opt->file, "",
 			diff_words->plus.text.ptr + diff_words->plus.text.size
-			- diff_words->current_plus, 1,
-			diff_words->file);
+			- diff_words->current_plus, diff_words->current_plus,
+			line_prefix);
+	}
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
 }
 
@@ -1835,7 +1883,7 @@ static void builtin_diff(const char *name_a,
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS)) {
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
-			ecbdata.diff_words->file = o->file;
+			ecbdata.diff_words->opt = o;
 			if (!o->word_regex)
 				o->word_regex = userdiff_word_regex(one);
 			if (!o->word_regex)
-- 
1.7.1.94.gc3269
