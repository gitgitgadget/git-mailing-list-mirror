From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/5] grep: remove grep_opt argument from match_expr_eval()
Date: Sat, 07 Mar 2009 13:28:40 +0100
Message-ID: <1236428920.6486.45.camel@ubuntu.ubuntu-domain>
References: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Thiago Alves <thiago.salves@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 13:30:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfvfR-00006E-C8
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 13:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbZCGM2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 07:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbZCGM2p
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 07:28:45 -0500
Received: from india601.server4you.de ([85.25.151.105]:39321 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbZCGM2o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 07:28:44 -0500
Received: from [10.0.1.101] (p57B7BF05.dip.t-dialin.net [87.183.191.5])
	by india601.server4you.de (Postfix) with ESMTPSA id 40A432F8057;
	Sat,  7 Mar 2009 13:28:41 +0100 (CET)
In-Reply-To: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112531>

The only use of the struct grep_opt argument of match_expr_eval()
is to pass the option word_regexp to match_one_pattern().  By adding
a pattern flag for it we can reduce the number of function arguments
of these two functions, as a cleanup and preparation for adding more
in the next patch.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |   34 +++++++++++++++++-----------------
 grep.h |    1 +
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/grep.c b/grep.c
index db341b6..f455182 100644
--- a/grep.c
+++ b/grep.c
@@ -39,6 +39,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err;
 
+	p->word_regexp = opt->word_regexp;
+
 	if (opt->fixed || is_fixed(p->pattern))
 		p->fixed = 1;
 	if (opt->regflags & REG_ICASE)
@@ -306,7 +308,8 @@ static struct {
 	{ "committer ", 10 },
 };
 
-static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol, char *eol, enum grep_context ctx)
+static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
+			     enum grep_context ctx)
 {
 	int hit = 0;
 	int saved_ch = 0;
@@ -338,7 +341,7 @@ static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol
 		hit = !fixmatch(p->pattern, bol, pmatch);
 	}
 
-	if (hit && opt->word_regexp) {
+	if (hit && p->word_regexp) {
 		if ((pmatch[0].rm_so < 0) ||
 		    (eol - bol) <= pmatch[0].rm_so ||
 		    (pmatch[0].rm_eo < 0) ||
@@ -378,35 +381,32 @@ static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol
 	return hit;
 }
 
-static int match_expr_eval(struct grep_opt *o,
-			   struct grep_expr *x,
-			   char *bol, char *eol,
-			   enum grep_context ctx,
-			   int collect_hits)
+static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
+			   enum grep_context ctx, int collect_hits)
 {
 	int h = 0;
 
 	switch (x->node) {
 	case GREP_NODE_ATOM:
-		h = match_one_pattern(o, x->u.atom, bol, eol, ctx);
+		h = match_one_pattern(x->u.atom, bol, eol, ctx);
 		break;
 	case GREP_NODE_NOT:
-		h = !match_expr_eval(o, x->u.unary, bol, eol, ctx, 0);
+		h = !match_expr_eval(x->u.unary, bol, eol, ctx, 0);
 		break;
 	case GREP_NODE_AND:
-		if (!match_expr_eval(o, x->u.binary.left, bol, eol, ctx, 0))
+		if (!match_expr_eval(x->u.binary.left, bol, eol, ctx, 0))
 			return 0;
-		h = match_expr_eval(o, x->u.binary.right, bol, eol, ctx, 0);
+		h = match_expr_eval(x->u.binary.right, bol, eol, ctx, 0);
 		break;
 	case GREP_NODE_OR:
 		if (!collect_hits)
-			return (match_expr_eval(o, x->u.binary.left,
+			return (match_expr_eval(x->u.binary.left,
 						bol, eol, ctx, 0) ||
-				match_expr_eval(o, x->u.binary.right,
+				match_expr_eval(x->u.binary.right,
 						bol, eol, ctx, 0));
-		h = match_expr_eval(o, x->u.binary.left, bol, eol, ctx, 0);
+		h = match_expr_eval(x->u.binary.left, bol, eol, ctx, 0);
 		x->u.binary.left->hit |= h;
-		h |= match_expr_eval(o, x->u.binary.right, bol, eol, ctx, 1);
+		h |= match_expr_eval(x->u.binary.right, bol, eol, ctx, 1);
 		break;
 	default:
 		die("Unexpected node type (internal error) %d", x->node);
@@ -420,7 +420,7 @@ static int match_expr(struct grep_opt *opt, char *bol, char *eol,
 		      enum grep_context ctx, int collect_hits)
 {
 	struct grep_expr *x = opt->pattern_expression;
-	return match_expr_eval(opt, x, bol, eol, ctx, collect_hits);
+	return match_expr_eval(x, bol, eol, ctx, collect_hits);
 }
 
 static int match_line(struct grep_opt *opt, char *bol, char *eol,
@@ -432,7 +432,7 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 
 	/* we do not call with collect_hits without being extended */
 	for (p = opt->pattern_list; p; p = p->next) {
-		if (match_one_pattern(opt, p, bol, eol, ctx))
+		if (match_one_pattern(p, bol, eol, ctx))
 			return 1;
 	}
 	return 0;
diff --git a/grep.h b/grep.h
index 5102ce3..d2a8674 100644
--- a/grep.h
+++ b/grep.h
@@ -31,6 +31,7 @@ struct grep_pat {
 	enum grep_header_field field;
 	regex_t regexp;
 	unsigned fixed:1;
+	unsigned word_regexp:1;
 };
 
 enum grep_expr_node {
-- 
1.6.2
