From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] diff: unified diff with colored words, step 1, unified diff only
Date: Thu, 31 Dec 2015 19:37:35 +0700
Message-ID: <1451565457-18756-6-git-send-email-pclouds@gmail.com>
References: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 13:38:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEcUn-0001cZ-MB
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 13:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbbLaMiQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 07:38:16 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36505 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbbLaMiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 07:38:15 -0500
Received: by mail-pa0-f44.google.com with SMTP id yy13so59483503pab.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 04:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WrBN7w9t+OpzGLTWC0eDE5Yb2Lao7rAjzAoISClVwYs=;
        b=UEjwiICfAZw7SpbvcTnOxIh2r1QkeyRFLIWh7R+ZmwLSZ8t6JgsCWXi8GcZOTVEobX
         pahLkfYYw2yTtswhXcmI/HZN85nMuCZTu+hYHMLeiXqTLVZYXGzbux3SRMIXMCvL1SGs
         oew4diDhulRo5IgZutS71yjgjZ1AJYsWu402WBfd5eMt1+9491kYtfGy1m01I7MsEr4o
         gxFhJsKgISjPF+8KRQeyCEla7Os8/WGYYYEYJ5FjhBPV/LMiNYrJDOqj91moMzR5Mvsv
         V/++v43sGnC5fOOK6n/BkqmqR23M92bzstvghJwYgR60oH4DC63NTDiE+4e5JBq4N7Co
         P+tg==
X-Received: by 10.66.252.102 with SMTP id zr6mr15160738pac.66.1451565494473;
        Thu, 31 Dec 2015 04:38:14 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id oj9sm18667189pab.8.2015.12.31.04.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 04:38:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Dec 2015 19:38:11 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283241>

The goal is to produce a unified diff, but with changed words colored
differently. A new diff-words mode is added that can keep track of both
lines and words of each chunk. The marks then are post processed and
each line is output in unified format. The actual word coloring comes i=
n
the next patch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 256 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 diff.h |   3 +-
 2 files changed, 255 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 8a9e42f..3b7317e 100644
--- a/diff.c
+++ b/diff.c
@@ -440,6 +440,23 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfi=
le_t *mf2,
 	ecbdata->blank_at_eof_in_postimage =3D (at - l2) + 1;
 }
=20
+#define TAG_BEGIN_WORD(tag) \
+	((tag) =3D=3D TAG_BEGIN_OLD_WORD || \
+	 (tag) =3D=3D TAG_BEGIN_NEW_WORD)
+
+enum pointer_tag { /* order is important because it's used in sorting =
*/
+	TAG_END_WORD,
+	TAG_END_LINE,
+	TAG_BEGIN_LINE,
+	TAG_BEGIN_OLD_WORD,
+	TAG_BEGIN_NEW_WORD
+};
+
+struct tagged_pointer {
+	const char *str;
+	enum pointer_tag tag;
+};
+
 static void emit_line_0(struct diff_options *o, const char *set, const=
 char *reset,
 			int first, const char *line, int len)
 {
@@ -757,6 +774,10 @@ struct diff_words_buffer {
 		const char *begin, *end;
 	} *orig;
 	int orig_nr, orig_alloc;
+	unsigned long *line;
+	int line_nr, line_alloc;
+	struct tagged_pointer *mark;
+	int mark_nr, mark_alloc;
 };
=20
 struct diff_words_style_elem {
@@ -772,6 +793,8 @@ struct diff_words_style {
 	const char *newline;
 };
=20
+static struct diff_words_style diff_words_unified_style;
+
 static struct diff_words_style diff_words_styles[] =3D {
 	{ DIFF_WORDS_PORCELAIN, {"+", "\n"}, {"-", "\n"}, {" ", "\n"}, "~\n" =
},
 	{ DIFF_WORDS_PLAIN, {"{+", "+}"}, {"[-", "-]"}, {"", ""}, "\n" },
@@ -803,6 +826,13 @@ static void diff_words_append(struct diff_words_da=
ta *diff_words,
 	line++;
 	len--;
 	memcpy(buffer->text.ptr + buffer->text.size, line, len);
+	if (diff_words->type =3D=3D DIFF_WORDS_UNIFIED) {
+		unsigned long *l;
+		ALLOC_GROW(buffer->line, (buffer->line_nr + 1) * 2, buffer->line_all=
oc);
+		l =3D buffer->line + (buffer->line_nr++) * 2;
+		l[0] =3D buffer->text.size;
+		l[1] =3D l[0] + len;
+	}
 	buffer->text.size +=3D len;
 	buffer->text.ptr[buffer->text.size] =3D '\0';
 }
@@ -816,6 +846,40 @@ static int fn_out_diff_words_write_helper(struct d=
iff_words_data *dw,
 	FILE *fp =3D dw->opt->file;
 	int print =3D 0;
=20
+	if (dw->type =3D=3D DIFF_WORDS_UNIFIED) {
+		struct diff_words_style *st =3D &diff_words_unified_style;
+		struct diff_words_buffer *b;
+		enum pointer_tag tag;
+		struct tagged_pointer *tp;
+
+		if (st_el =3D=3D &st->ctx)
+			return 0;
+		else if (st_el =3D=3D &st->old)
+			tag =3D TAG_BEGIN_OLD_WORD;
+		else if (st_el =3D=3D &st->new)
+			tag =3D TAG_BEGIN_NEW_WORD;
+		else
+			return -1;
+
+		if (buf >=3D dw->minus.text.ptr &&
+		    buf < dw->minus.text.ptr + dw->minus.text.size)
+			b =3D &dw->minus;
+		else if (buf >=3D dw->plus.text.ptr &&
+			 buf < dw->plus.text.ptr + dw->plus.text.size)
+			b =3D &dw->plus;
+		else
+			return -1;
+
+		ALLOC_GROW(b->mark, b->mark_nr + 2, b->mark_alloc);
+		tp =3D b->mark + b->mark_nr;
+		tp[0].str =3D buf;
+		tp[0].tag =3D tag;
+		tp[1].str =3D buf + count;
+		tp[1].tag =3D TAG_END_WORD;
+		b->mark_nr +=3D 2;
+		return 0;
+	}
+
 	while (count) {
 		char *p =3D memchr(buf, '\n', count);
 		if (print)
@@ -1014,6 +1078,23 @@ static void diff_words_fill(struct diff_words_bu=
ffer *buffer, mmfile_t *out,
 	}
 }
=20
+static void diff_words_add_line(struct diff_words_buffer *buffer)
+{
+	int i;
+
+	ALLOC_GROW(buffer->mark, buffer->line_nr * 2, buffer->mark_alloc);
+	for (i =3D 0; i < buffer->line_nr; i++) {
+		struct tagged_pointer *tp =3D buffer->mark + buffer->mark_nr;
+		tp->str =3D buffer->text.ptr + buffer->line[i * 2];
+		tp->tag =3D TAG_BEGIN_LINE;
+		tp++;
+		tp->str =3D buffer->text.ptr + buffer->line[i * 2 + 1];
+		tp->tag =3D TAG_END_LINE;
+		buffer->mark_nr +=3D 2;
+	}
+	buffer->line_nr =3D 0;
+}
+
 /* this executes the word diff on the accumulated buffers */
 static void diff_words_show(struct diff_words_data *diff_words)
 {
@@ -1025,6 +1106,16 @@ static void diff_words_show(struct diff_words_da=
ta *diff_words)
 	struct diff_options *opt =3D diff_words->opt;
 	const char *line_prefix;
=20
+	if (diff_words->type =3D=3D DIFF_WORDS_UNIFIED) {
+		/*
+		 * line marks are collected in line[] array as offsets
+		 * because the "text" buffer can be reallocated. Now
+		 * it's safe to convert line[] to mark[].
+		 */
+		diff_words_add_line(&diff_words->minus);
+		diff_words_add_line(&diff_words->plus);
+	}
+
 	assert(opt);
 	line_prefix =3D diff_line_prefix(opt);
=20
@@ -1077,12 +1168,152 @@ static void diff_words_show(struct diff_words_=
data *diff_words)
 	diff_words->minus.text.size =3D diff_words->plus.text.size =3D 0;
 }
=20
+static int tagptrcmp(const void *a_, const void *b_)
+{
+	const struct tagged_pointer *a =3D a_;
+	const struct tagged_pointer *b =3D b_;
+	return a->str =3D=3D b->str ? a->tag > b->tag : a->str > b->str;
+}
+
+static void diff_words_buffer_finalize_marks(struct diff_words_buffer =
*b)
+{
+	struct tagged_pointer *dst, *src, *next, *end, *cur_word;
+	int i, dst_nr, dst_alloc;
+
+	/* Join consecutive same-type words */
+	end =3D b->mark + b->mark_nr;
+	for (src =3D b->mark; src < end; src++) {
+		next =3D src + 2;
+		while (next + 2 <=3D end &&
+		       TAG_BEGIN_WORD(src[0].tag) &&
+		       TAG_BEGIN_WORD(next[0].tag) &&
+		       src[0].tag =3D=3D next[0].tag &&
+		       src[1].tag =3D=3D TAG_END_WORD &&
+		       next[1].tag =3D=3D TAG_END_WORD &&
+		       src[1].str =3D=3D next[0].str) {
+			src[1] =3D next[1];
+			memcpy(next, next + 2, sizeof(*next) * (end - next - 2));
+			end -=3D 2;
+		}
+	}
+	b->mark_nr =3D end - b->mark;
+
+	/*
+	 * Simplify one-word chunks. Not that at this point we have
+	 * all line marks (in correct order), then all word marks.
+	 */
+	if (b->mark_nr >=3D 4 &&
+	    b->mark[0].tag =3D=3D TAG_BEGIN_LINE &&
+	    TAG_BEGIN_WORD(b->mark[b->mark_nr - 2].tag) &&
+	    b->mark[0].str =3D=3D b->mark[b->mark_nr - 2].str &&
+	    b->mark[b->mark_nr - 1].tag =3D=3D TAG_END_WORD &&
+	    b->mark[b->mark_nr - 3].tag =3D=3D TAG_END_LINE &&
+	    b->mark[b->mark_nr - 1].str =3D=3D b->mark[b->mark_nr - 3].str) {
+		b->mark_nr -=3D 2;
+		return;
+	}
+
+	/* Move words into lines */
+	qsort(b->mark, b->mark_nr, sizeof(*b->mark), tagptrcmp);
+
+	/* Split words that span across lines */
+	cur_word =3D NULL;
+	dst =3D NULL;
+	dst_nr =3D 0;
+	dst_alloc =3D 0;
+	ALLOC_GROW(dst, b->mark_nr, dst_alloc);
+	for (i =3D 0; i < b->mark_nr; i++) {
+		struct tagged_pointer *src =3D b->mark + i;
+
+		switch (src->tag) {
+		case TAG_BEGIN_OLD_WORD:
+		case TAG_BEGIN_NEW_WORD:
+			ALLOC_GROW(dst, dst_nr + 1, dst_alloc);
+			dst[dst_nr++] =3D *src;
+			cur_word =3D src;
+			break;
+
+		case TAG_END_WORD:
+			ALLOC_GROW(dst, dst_nr + 1, dst_alloc);
+			dst[dst_nr++] =3D *src;
+			cur_word =3D NULL;
+			break;
+
+		case TAG_BEGIN_LINE:
+			ALLOC_GROW(dst, dst_nr + 2, dst_alloc);
+			dst[dst_nr++] =3D *src;
+			if (cur_word) {
+				dst[dst_nr].tag =3D cur_word->tag;
+				dst[dst_nr].str =3D src->str;
+				dst_nr++;
+			}
+			break;
+
+		case TAG_END_LINE:
+			ALLOC_GROW(dst, dst_nr + 2, dst_alloc);
+			if (cur_word) {
+				dst[dst_nr].tag =3D TAG_END_WORD;
+				dst[dst_nr].str =3D src->str;
+				dst_nr++;
+			}
+			dst[dst_nr++] =3D *src;
+			break;
+		}
+	}
+
+	free(b->mark);
+	b->mark =3D dst;
+	b->mark_nr =3D dst_nr;
+	b->mark_alloc =3D dst_alloc;
+}
+
+static void diff_words_flush_unified(struct emit_callback *ecb,
+				     enum color_diff color,
+				     unsigned ws_error_highlight,
+				     char sign)
+{
+	const char *reset =3D diff_get_color(ecb->color_diff, DIFF_RESET);
+	struct diff_words_data *dw =3D ecb->diff_words;
+	struct diff_words_buffer *b;
+	struct tagged_pointer *begin_line, *end, *end_line;
+
+	switch (sign) {
+	case '-':
+		b =3D &dw->minus;
+		break;
+	case '+':
+		b =3D &dw->plus;
+		break;
+	default:
+		return;
+	}
+
+	if (!b->mark_nr)
+		return;
+
+	diff_words_buffer_finalize_marks(b);
+	end =3D b->mark + b->mark_nr;
+	for (begin_line =3D b->mark; begin_line < end; begin_line =3D end_lin=
e + 1) {
+		assert(begin_line->tag =3D=3D TAG_BEGIN_LINE);
+		end_line =3D begin_line;
+		while (end_line < end && end_line->tag !=3D TAG_END_LINE)
+			end_line++;
+		assert(end_line->tag =3D=3D TAG_END_LINE);
+		emit_line_checked(reset, ecb, begin_line->str,
+				  end_line->str - begin_line->str,
+				  color, ws_error_highlight, sign);
+	}
+	b->mark_nr =3D 0;
+}
+
 /* In "color-words" mode, show word-diff of words accumulated in the b=
uffer */
 static void diff_words_flush(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words->minus.text.size ||
 	    ecbdata->diff_words->plus.text.size)
 		diff_words_show(ecbdata->diff_words);
+	diff_words_flush_unified(ecbdata, DIFF_FILE_OLD, WSEH_OLD, '-');
+	diff_words_flush_unified(ecbdata, DIFF_FILE_NEW, WSEH_NEW, '+');
 }
=20
 static void diff_filespec_load_driver(struct diff_filespec *one)
@@ -1133,6 +1364,10 @@ static void init_diff_words_data(struct emit_cal=
lback *ecbdata,
 			die ("Invalid regular expression: %s",
 			     o->word_regex);
 	}
+	if (o->word_diff =3D=3D DIFF_WORDS_UNIFIED) {
+		ecbdata->diff_words->style =3D &diff_words_unified_style;
+		return;
+	}
 	for (i =3D 0; i < ARRAY_SIZE(diff_words_styles); i++) {
 		if (o->word_diff =3D=3D diff_words_styles[i].type) {
 			ecbdata->diff_words->style =3D
@@ -1155,8 +1390,12 @@ static void free_diff_words_data(struct emit_cal=
lback *ecbdata)
 		free (ecbdata->diff_words->opt);
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->minus.orig);
+		free (ecbdata->diff_words->minus.line);
+		free (ecbdata->diff_words->minus.mark);
 		free (ecbdata->diff_words->plus.text.ptr);
 		free (ecbdata->diff_words->plus.orig);
+		free (ecbdata->diff_words->plus.line);
+		free (ecbdata->diff_words->plus.mark);
 		if (ecbdata->diff_words->word_regex) {
 			regfree(ecbdata->diff_words->word_regex);
 			free(ecbdata->diff_words->word_regex);
@@ -1274,7 +1513,8 @@ static void fn_out_consume(void *priv, char *line=
, unsigned long len)
 		if (line[0] =3D=3D '-' || line[0] =3D=3D '+') {
 			diff_words_append(ecbdata->diff_words, line, len);
 			return;
-		} else if (starts_with(line, "\\ ")) {
+		} else if (ecbdata->diff_words->type !=3D DIFF_WORDS_UNIFIED &&
+			   starts_with(line, "\\ ")) {
 			/*
 			 * Eat the "no newline at eof" marker as if we
 			 * saw a "+" or "-" line with nothing on it,
@@ -1288,7 +1528,8 @@ static void fn_out_consume(void *priv, char *line=
, unsigned long len)
 		if (ecbdata->diff_words->type =3D=3D DIFF_WORDS_PORCELAIN) {
 			emit_line(ecbdata->opt, context, reset, line, len);
 			fputs("~\n", ecbdata->opt->file);
-		} else {
+			return;
+		} else if (ecbdata->diff_words->type !=3D DIFF_WORDS_UNIFIED) {
 			/*
 			 * Skip the prefix character, if any.  With
 			 * diff_suppress_blank_empty, there may be
@@ -1299,8 +1540,8 @@ static void fn_out_consume(void *priv, char *line=
, unsigned long len)
 			      len--;
 			}
 			emit_line(ecbdata->opt, context, reset, line, len);
+			return;
 		}
-		return;
 	}
=20
 	switch (line[0]) {
@@ -3859,6 +4100,15 @@ int diff_opt_parse(struct diff_options *options,=
 const char **av, int ac)
 		options->word_diff =3D DIFF_WORDS_COLOR;
 		options->word_regex =3D arg;
 	}
+	else if (!strcmp(arg, "--highlight-words")) {
+		options->use_color =3D 1;
+		options->word_diff =3D DIFF_WORDS_UNIFIED;
+	}
+	else if (skip_prefix(arg, "--highlight-words=3D", &arg)) {
+		options->use_color =3D 1;
+		options->word_diff =3D DIFF_WORDS_UNIFIED;
+		options->word_regex =3D arg;
+	}
 	else if (!strcmp(arg, "--word-diff")) {
 		if (options->word_diff =3D=3D DIFF_WORDS_NONE)
 			options->word_diff =3D DIFF_WORDS_PLAIN;
diff --git a/diff.h b/diff.h
index f7208ad..85c469b 100644
--- a/diff.h
+++ b/diff.h
@@ -107,7 +107,8 @@ enum diff_words_type {
 	DIFF_WORDS_NONE =3D 0,
 	DIFF_WORDS_PORCELAIN,
 	DIFF_WORDS_PLAIN,
-	DIFF_WORDS_COLOR
+	DIFF_WORDS_COLOR,
+	DIFF_WORDS_UNIFIED
 };
=20
 struct diff_options {
--=20
2.3.0.rc1.137.g477eb31
