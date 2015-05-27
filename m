From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] showing existing ws breakage
Date: Wed, 27 May 2015 16:48:46 -0400
Message-ID: <20150527204846.GF14309@peff.net>
References: <1432669584-342-1-git-send-email-gitster@pobox.com>
 <1432708232-29892-1-git-send-email-gitster@pobox.com>
 <20150527072218.GB6898@peff.net>
 <xmqqa8wpn910.fsf@gitster.dls.corp.google.com>
 <20150527203648.GE14309@peff.net>
 <xmqqpp5lkau5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:48:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxiFy-0006kM-7x
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbbE0Ust (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:48:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:36869 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751389AbbE0Uss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:48:48 -0400
Received: (qmail 13316 invoked by uid 102); 27 May 2015 20:48:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 15:48:48 -0500
Received: (qmail 10463 invoked by uid 107); 27 May 2015 20:48:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:48:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 16:48:46 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp5lkau5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270092>

On Wed, May 27, 2015 at 01:46:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Do you want me to also eradicate PLAIN from the code itself? It's a
> > rather simple change, but it does touch a lot of places.
> 
> Nah, that is not user-facing.  We do not do s/cache/index/ in the
> code, either.
> 
> Besides, I actually find plain much easier to type than context ;-)

OK. I just did it while our emails were in flight, so here it is just
for reference.

-- >8 --
Subject: diff.h: rename DIFF_PLAIN color slot to DIFF_CONTEXT

The latter is a much more descriptive name (and we support
"color.diff.context" now). This also updates the name of any
local variables which were used to store the color.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c |  6 +++---
 diff.c         | 26 +++++++++++++-------------
 diff.h         |  2 +-
 line-log.c     |  6 +++---
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 8eb7278..30c7eb6 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -730,7 +730,7 @@ static void dump_sline(struct sline *sline, const char *line_prefix,
 	const char *c_func = diff_get_color(use_color, DIFF_FUNCINFO);
 	const char *c_new = diff_get_color(use_color, DIFF_FILE_NEW);
 	const char *c_old = diff_get_color(use_color, DIFF_FILE_OLD);
-	const char *c_plain = diff_get_color(use_color, DIFF_PLAIN);
+	const char *c_context = diff_get_color(use_color, DIFF_CONTEXT);
 	const char *c_reset = diff_get_color(use_color, DIFF_RESET);
 
 	if (result_deleted)
@@ -793,7 +793,7 @@ static void dump_sline(struct sline *sline, const char *line_prefix,
 			}
 			if (comment_end)
 				printf("%s%s %s%s", c_reset,
-						    c_plain, c_reset,
+						    c_context, c_reset,
 						    c_func);
 			for (i = 0; i < comment_end; i++)
 				putchar(hunk_comment[i]);
@@ -828,7 +828,7 @@ static void dump_sline(struct sline *sline, const char *line_prefix,
 				 */
 				if (!context)
 					continue;
-				fputs(c_plain, stdout);
+				fputs(c_context, stdout);
 			}
 			else
 				fputs(c_new, stdout);
diff --git a/diff.c b/diff.c
index 27bd371..100773f 100644
--- a/diff.c
+++ b/diff.c
@@ -42,7 +42,7 @@ static long diff_algorithm;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
-	GIT_COLOR_NORMAL,	/* PLAIN */
+	GIT_COLOR_NORMAL,	/* CONTEXT */
 	GIT_COLOR_BOLD,		/* METAINFO */
 	GIT_COLOR_CYAN,		/* FRAGINFO */
 	GIT_COLOR_RED,		/* OLD */
@@ -55,7 +55,7 @@ static char diff_colors[][COLOR_MAXLEN] = {
 static int parse_diff_color_slot(const char *var)
 {
 	if (!strcasecmp(var, "context") || !strcasecmp(var, "plain"))
-		return DIFF_PLAIN;
+		return DIFF_CONTEXT;
 	if (!strcasecmp(var, "meta"))
 		return DIFF_METAINFO;
 	if (!strcasecmp(var, "frag"))
@@ -501,7 +501,7 @@ static void emit_add_line(const char *reset,
 static void emit_hunk_header(struct emit_callback *ecbdata,
 			     const char *line, int len)
 {
-	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
+	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
 	const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
 	const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
@@ -518,7 +518,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, plain, reset, line, len);
+		emit_line(ecbdata->opt, context, reset, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
@@ -540,7 +540,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 		if (*ep != ' ' && *ep != '\t')
 			break;
 	if (ep != cp) {
-		strbuf_addstr(&msgbuf, plain);
+		strbuf_addstr(&msgbuf, context);
 		strbuf_add(&msgbuf, cp, ep - cp);
 		strbuf_addstr(&msgbuf, reset);
 	}
@@ -623,10 +623,10 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		data += len;
 	}
 	if (!endp) {
-		const char *plain = diff_get_color(ecb->color_diff,
-						   DIFF_PLAIN);
+		const char *context = diff_get_color(ecb->color_diff,
+						     DIFF_CONTEXT);
 		putc('\n', ecb->opt->file);
-		emit_line_0(ecb->opt, plain, reset, '\\',
+		emit_line_0(ecb->opt, context, reset, '\\',
 			    nneof, strlen(nneof));
 	}
 }
@@ -1086,7 +1086,7 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 		struct diff_words_style *st = ecbdata->diff_words->style;
 		st->old.color = diff_get_color_opt(o, DIFF_FILE_OLD);
 		st->new.color = diff_get_color_opt(o, DIFF_FILE_NEW);
-		st->ctx.color = diff_get_color_opt(o, DIFF_PLAIN);
+		st->ctx.color = diff_get_color_opt(o, DIFF_CONTEXT);
 	}
 }
 
@@ -1162,7 +1162,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata = priv;
 	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
-	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
+	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
 	const char *line_prefix = diff_line_prefix(o);
@@ -1233,7 +1233,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		}
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
-			emit_line(ecbdata->opt, plain, reset, line, len);
+			emit_line(ecbdata->opt, context, reset, line, len);
 			fputs("~\n", ecbdata->opt->file);
 		} else {
 			/*
@@ -1245,7 +1245,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			      line++;
 			      len--;
 			}
-			emit_line(ecbdata->opt, plain, reset, line, len);
+			emit_line(ecbdata->opt, context, reset, line, len);
 		}
 		return;
 	}
@@ -1253,7 +1253,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	if (line[0] != '+') {
 		const char *color =
 			diff_get_color(ecbdata->color_diff,
-				       line[0] == '-' ? DIFF_FILE_OLD : DIFF_PLAIN);
+				       line[0] == '-' ? DIFF_FILE_OLD : DIFF_CONTEXT);
 		ecbdata->lno_in_preimage++;
 		if (line[0] == ' ')
 			ecbdata->lno_in_postimage++;
diff --git a/diff.h b/diff.h
index f6fdf49..6115fcb 100644
--- a/diff.h
+++ b/diff.h
@@ -176,7 +176,7 @@ struct diff_options {
 
 enum color_diff {
 	DIFF_RESET = 0,
-	DIFF_PLAIN = 1,
+	DIFF_CONTEXT = 1,
 	DIFF_METAINFO = 2,
 	DIFF_FRAGINFO = 3,
 	DIFF_FILE_OLD = 4,
diff --git a/line-log.c b/line-log.c
index a5ed9e3..c12c69f 100644
--- a/line-log.c
+++ b/line-log.c
@@ -893,7 +893,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 	const char *c_meta = diff_get_color(opt->use_color, DIFF_METAINFO);
 	const char *c_old = diff_get_color(opt->use_color, DIFF_FILE_OLD);
 	const char *c_new = diff_get_color(opt->use_color, DIFF_FILE_NEW);
-	const char *c_plain = diff_get_color(opt->use_color, DIFF_PLAIN);
+	const char *c_context = diff_get_color(opt->use_color, DIFF_CONTEXT);
 
 	if (!pair || !diff)
 		return;
@@ -957,7 +957,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 			int k;
 			for (; t_cur < diff->target.ranges[j].start; t_cur++)
 				print_line(prefix, ' ', t_cur, t_ends, pair->two->data,
-					   c_plain, c_reset);
+					   c_context, c_reset);
 			for (k = diff->parent.ranges[j].start; k < diff->parent.ranges[j].end; k++)
 				print_line(prefix, '-', k, p_ends, pair->one->data,
 					   c_old, c_reset);
@@ -968,7 +968,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 		}
 		for (; t_cur < t_end; t_cur++)
 			print_line(prefix, ' ', t_cur, t_ends, pair->two->data,
-				   c_plain, c_reset);
+				   c_context, c_reset);
 	}
 
 	free(p_ends);
-- 
2.4.2.668.gc3b1ade.dirty
