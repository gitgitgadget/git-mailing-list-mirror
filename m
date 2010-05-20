From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 6/6 v2] Make --color-words work well with --graph.
Date: Thu, 20 May 2010 03:25:38 -0700
Message-ID: <1274351138-11813-7-git-send-email-struggleyb.nku@gmail.com>
References: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-2-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-3-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-4-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-5-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-6-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 12:33:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF347-00016D-Bq
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 12:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab0ETKdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 06:33:18 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55747 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab0ETKdR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 06:33:17 -0400
Received: by pva18 with SMTP id 18so1450433pva.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/Hk+aWXoZyv3HayP9GJcPipnEaah61Ywx7LsoYyzKhs=;
        b=iuxajbxI8J/HO8pjEUXDSX3p1lXq4JcwPeumEMokq06jcCRjmbdUPH8CSkrVzV2yJB
         l48ZC3YKich3SToVUBD1NqEAfHYyaDO+GNJvx12+5hLCMytHUYS06cmt3BCQaUhz9vL4
         mBdHPjbh9xTfKV8itlJSIdGWfJAu0QDzYHCZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wGQeBJyGBetztaI+RVJKCctqCI7E5AKYnOrbqqt5DymbATL4im6CnU4GUt1GQ2K5AG
         iasEkHuNtBII8Vpy4oK9TwUVVoN0Y55znea6wM26r8mawOv5csEVobTWKYiB8jEUX3Nw
         0rvemCOldTRvaVwBoJYWik+sEsgglIr3x9MM8=
Received: by 10.115.39.29 with SMTP id r29mr708902waj.22.1274351162587;
        Thu, 20 May 2010 03:26:02 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n32sm76160636wae.22.2010.05.20.03.25.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 03:26:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274351138-11813-6-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147379>

'--color-words' algorithm can be described as:

1. collect a the minus/plus lines of a diff hunk, divided into minus-lines and plus-lines;
2. break both minus-lines and plus-lines into words and place them into two
   mmfile_t with one word for each line;
3. use xdiff to run diff on the two mmfile_t to get the words level diff;

And for the common parts of the both file, we output the plus side text.
diff_words->current_plus is used to trace the current position of the plus file
which printed. diff_words->last_minus is used to trace the last minus word
printed.

For '--graph' to work with '--color-words', we need to output the graph prefix
on each line of color words output. Generally, there are two conditions on
which we should output the prefix.
1. diff_words->last_minus == 0 && diff_words->current_plus == diff_words->plus.text.ptr
   that is: the plus text must start as a new line, and if there is no minus
   word printed, a graph prefix must be printed.
2. diff_words->current_plus > diff_words->plus.text.ptr && *(diff_words->current_plus - 1) == '\n'
   that is: a graph prefix must be printed following a '\n'

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 color.c |   21 +++++++++----
 color.h |    3 +-
 diff.c  |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 97 insertions(+), 25 deletions(-)

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
index 69c15a6..3a1e05a 100644
--- a/diff.c
+++ b/diff.c
@@ -603,7 +603,8 @@ static void diff_words_append(char *line, unsigned long len,
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	const char *current_plus;
-	FILE *file;
+	int last_minus;
+	struct diff_options *opt;
 	regex_t *word_regex;
 };
 
@@ -612,11 +613,20 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	struct diff_words_data *diff_words = priv;
 	int minus_first, minus_len, plus_first, plus_len;
 	const char *minus_begin, *minus_end, *plus_begin, *plus_end;
+	struct diff_options *opt = diff_words->opt;
+	struct strbuf *msgbuf;
+	char *line_prefix = "";
 
 	if (line[0] != '@' || parse_hunk_header(line, len,
 			&minus_first, &minus_len, &plus_first, &plus_len))
 		return;
 
+	assert(opt);
+	if (opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt->file, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
+
 	/* POSIX requires that first be decremented by one if len == 0... */
 	if (minus_len) {
 		minus_begin = diff_words->minus.orig[minus_first].begin;
@@ -632,20 +642,54 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	} else
 		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
 
-	if (diff_words->current_plus != plus_begin)
-		fwrite(diff_words->current_plus,
-				plus_begin - diff_words->current_plus, 1,
-				diff_words->file);
-	if (minus_begin != minus_end)
-		color_fwrite_lines(diff_words->file,
+	/*
+	 * '--color-words' algorithm can be described as:
+	 *
+	 * 1. collect a the minus/plus lines of a diff hunk, divided into minus-lines and plus-lines;
+	 * 2. break both minus-lines and plus-lines into words and place them into two
+	 *    mmfile_t with one word for each line;
+	 * 3. use xdiff to run diff on the two mmfile_t to get the words level diff;
+	 *
+	 * And for the common parts of the both file, we output the plus side text.
+	 * diff_words->current_plus is used to trace the current position of the plus file
+	 * which printed. diff_words->last_minus is used to trace the last minus word
+	 * printed.
+	 *
+	 * For '--graph' to work with '--color-words', we need to output the graph prefix
+	 * on each line of color words output. Generally, there are two conditions on
+	 * which we should output the prefix.
+	 * 1. diff_words->last_minus == 0 && diff_words->current_plus == diff_words->plus.text.ptr
+	 *    that is: the plus text must start as a new line, and if there is no minus
+	 *    word printed, a graph prefix must be printed.
+	 * 2. diff_words->current_plus > diff_words->plus.text.ptr && *(diff_words->current_plus - 1) == '\n'
+	 *    that is: a graph prefix must be printed following a '\n'
+	 */
+	if ((diff_words->last_minus == 0 &&
+		diff_words->current_plus == diff_words->plus.text.ptr) ||
+		(diff_words->current_plus > diff_words->plus.text.ptr &&
+		*(diff_words->current_plus - 1) == '\n')) {
+		fputs(line_prefix, diff_words->opt->file);
+	}
+	if (diff_words->current_plus != plus_begin) {
+		color_fwrite_lines(diff_words->opt->file, "",
+				plus_begin - diff_words->current_plus,
+				diff_words->current_plus, line_prefix);
+		if (*(plus_begin - 1) == '\n')
+			fputs(line_prefix, diff_words->opt->file);
+	}
+	if (minus_begin != minus_end) {
+		color_fwrite_lines(diff_words->opt->file,
 				diff_get_color(1, DIFF_FILE_OLD),
-				minus_end - minus_begin, minus_begin);
-	if (plus_begin != plus_end)
-		color_fwrite_lines(diff_words->file,
+				minus_end - minus_begin, minus_begin, line_prefix);
+	}
+	if (plus_begin != plus_end) {
+		color_fwrite_lines(diff_words->opt->file,
 				diff_get_color(1, DIFF_FILE_NEW),
-				plus_end - plus_begin, plus_begin);
+				plus_end - plus_begin, plus_begin, line_prefix);
+	}
 
 	diff_words->current_plus = plus_end;
+	diff_words->last_minus = minus_first;
 }
 
 /* This function starts looking at *begin, and returns 0 iff a word was found. */
@@ -724,17 +768,29 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	mmfile_t minus, plus;
+	struct diff_options *opt = diff_words->opt;
+	struct strbuf *msgbuf;
+	char *line_prefix = "";
+
+	assert(opt);
+	if (opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt->file, opt->output_prefix_data);
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
@@ -748,11 +804,17 @@ static void diff_words_show(struct diff_words_data *diff_words)
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
 
@@ -1841,7 +1903,7 @@ static void builtin_diff(const char *name_a,
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS)) {
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
-			ecbdata.diff_words->file = o->file;
+			ecbdata.diff_words->opt = o;
 			if (!o->word_regex)
 				o->word_regex = userdiff_word_regex(one);
 			if (!o->word_regex)
-- 
1.6.0.4
