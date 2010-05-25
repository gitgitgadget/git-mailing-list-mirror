From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 6/6 rebase-version] Make --color-words work well with --graph.
Date: Tue, 25 May 2010 17:02:34 +0800
Message-ID: <1274778154-29976-7-git-send-email-struggleyb.nku@gmail.com>
References: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-2-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-3-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-4-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-5-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-6-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 11:04:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGq3L-0006pk-C7
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230Ab0EYJDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:03:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46547 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab0EYJDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:03:10 -0400
Received: by mail-pv0-f174.google.com with SMTP id 3so456090pvg.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vCLByjqsa0IhMbxI/Cd/8rUONuWrJ8wcizZf8kIjvEA=;
        b=P+00dC+xSBJpb0untdgHtRViUKASLvFVj2kA5O0XV/DR7ia3z7BJP/TCDu1RoXo4lQ
         Qpq+V/dFSz3eEcQfOlvRPZ/eoVyd5xojas1WlfIwPmZ2D8Bg/sIPCAKGkRKRStzYpUl+
         5mqySgfYssuri9fJ3GPgrEuCIGSZa5hj8MCxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bg6Hn4Ezd4eCeIjUi7Jkw89dQ7w2akp01ztJeJKOt1VvhB/LA8Koj0y80dEwsbsWyl
         sBgoER7BhaiYzK8ok6QOmGrmSw/k9fl4wShXLt+O99F7Yhttiv+T6jmi4gY6mr5pTij8
         vKIfzkNXZd78jjwR3KwNlAGNR2lievK194mTo=
Received: by 10.114.49.4 with SMTP id w4mr5902934waw.88.1274778189748;
        Tue, 25 May 2010 02:03:09 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.99])
        by mx.google.com with ESMTPS id d16sm46058650wam.0.2010.05.25.02.03.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 02:03:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274778154-29976-6-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147694>

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
 diff.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 89 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 067260b..0e87dd2 100644
--- a/diff.c
+++ b/diff.c
@@ -624,7 +624,8 @@ struct diff_words_style diff_words_styles[] = {
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	const char *current_plus;
-	FILE *file;
+	int last_minus;
+	struct diff_options *opt;
 	regex_t *word_regex;
 	enum diff_words_type type;
 	struct diff_words_style *style;
@@ -633,10 +634,15 @@ struct diff_words_data {
 static int fn_out_diff_words_write_helper(FILE *fp,
 					  struct diff_words_style_elem *st_el,
 					  const char *newline,
-					  size_t count, const char *buf)
+					  size_t count, const char *buf,
+					  const char *line_prefix)
 {
+	int print = 0;
+
 	while (count) {
 		char *p = memchr(buf, '\n', count);
+		if (print)
+			fputs(line_prefix, fp);
 		if (p != buf) {
 			if (st_el->color && fputs(st_el->color, fp) < 0)
 				return -1;
@@ -654,6 +660,7 @@ static int fn_out_diff_words_write_helper(FILE *fp,
 			return -1;
 		count -= p + 1 - buf;
 		buf = p + 1;
+		print = 1;
 	}
 	return 0;
 }
@@ -664,11 +671,20 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	struct diff_words_style *style = diff_words->style;
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
+		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
+
 	/* POSIX requires that first be decremented by one if len == 0... */
 	if (minus_len) {
 		minus_begin = diff_words->minus.orig[minus_first].begin;
@@ -684,21 +700,57 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	} else
 		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
 
-	if (diff_words->current_plus != plus_begin)
-		fn_out_diff_words_write_helper(diff_words->file,
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
+		fn_out_diff_words_write_helper(diff_words->opt->file,
 				&style->ctx, style->newline,
 				plus_begin - diff_words->current_plus,
-				diff_words->current_plus);
-	if (minus_begin != minus_end)
-		fn_out_diff_words_write_helper(diff_words->file,
+				diff_words->current_plus, line_prefix);
+		if (*(plus_begin - 1) == '\n')
+			fputs(line_prefix, diff_words->opt->file);
+	}
+	if (minus_begin != minus_end) {
+		fn_out_diff_words_write_helper(diff_words->opt->file,
 				&style->old, style->newline,
-				minus_end - minus_begin, minus_begin);
-	if (plus_begin != plus_end)
-		fn_out_diff_words_write_helper(diff_words->file,
+				minus_end - minus_begin, minus_begin,
+				line_prefix);
+	}
+	if (plus_begin != plus_end) {
+		fn_out_diff_words_write_helper(diff_words->opt->file,
 				&style->new, style->newline,
-				plus_end - plus_begin, plus_begin);
+				plus_end - plus_begin, plus_begin,
+				line_prefix);
+	}
 
 	diff_words->current_plus = plus_end;
+	diff_words->last_minus = minus_first;
 }
 
 /* This function starts looking at *begin, and returns 0 iff a word was found. */
@@ -779,16 +831,29 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	mmfile_t minus, plus;
 	struct diff_words_style *style = diff_words->style;
 
+	struct diff_options *opt = diff_words->opt;
+	struct strbuf *msgbuf;
+	char *line_prefix = "";
+
+	assert(opt);
+	if (opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
+
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
-		fn_out_diff_words_write_helper(diff_words->file,
+		fputs(line_prefix, diff_words->opt->file);
+		fn_out_diff_words_write_helper(diff_words->opt->file,
 			&style->old, style->newline,
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
@@ -802,11 +867,18 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	free(minus.ptr);
 	free(plus.ptr);
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
-			diff_words->plus.text.size)
-		fn_out_diff_words_write_helper(diff_words->file,
+			diff_words->plus.text.size) {
+		if ((diff_words->current_plus == diff_words->plus.text.ptr &&
+			diff_words->last_minus == 0) ||
+			(diff_words->current_plus > diff_words->plus.text.ptr &&
+			*(diff_words->current_plus - 1) == '\n'))
+			fputs(line_prefix, diff_words->opt->file);
+		fn_out_diff_words_write_helper(diff_words->opt->file,
 			&style->ctx, style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
-			- diff_words->current_plus, diff_words->current_plus);
+			- diff_words->current_plus, diff_words->current_plus,
+			line_prefix);
+	}
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
 }
 
@@ -1905,8 +1977,8 @@ static void builtin_diff(const char *name_a,
 
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
-			ecbdata.diff_words->file = o->file;
 			ecbdata.diff_words->type = o->word_diff;
+			ecbdata.diff_words->opt = o;
 			if (!o->word_regex)
 				o->word_regex = userdiff_word_regex(one);
 			if (!o->word_regex)
-- 
1.6.0.4
