From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH/RFC 2/4] grep: pass current line number down to match_one_pattern
Date: Mon,  2 May 2011 13:39:11 +0200
Message-ID: <2681b60988c7c4d059f83df368395eca0520012c.1304321122.git.bert.wesarg@googlemail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
 <f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 13:39:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGrTM-0000i5-RF
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 13:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758201Ab1EBLjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 07:39:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33090 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab1EBLjV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 07:39:21 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so4521802bwz.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 04:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=cB7sQi6WxoqpVRh+/Qb1C2uBs3q7a8OECXPxTSNeWUo=;
        b=qVQJzLS6AFEQdk1F2kbYqGyn0Wd87hBtl6bY2+XatyzOER6GyjwHr8go6Mpq3ehz6i
         aDHmunrZk6wfV9/XdycCkEAwHCgJ33ha7k2VVT1O8/4fcyAyipEoWv+DpGWWBTqJR7lo
         nLf3QPxDB1tWliBWW0xXBozTx4f1XT7svubRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h2eqSbn7r9HsRkdXmFVPwkxj1lJJpmOf4tr5Spu2HG2m90XKMJ6vosR4hveaozTsSx
         AFAjaAh8EwdbgOVnxgVi/eZESK3G5NHD1bEiy8VkUo7xMnfAdvMrf2uFDc0Ae04xKT9F
         ShE4p8ipbOqkFmfnK6l8Ts+e1OwkSzpGT/9IE=
Received: by 10.204.81.203 with SMTP id y11mr4411563bkk.124.1304336360532;
        Mon, 02 May 2011 04:39:20 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de [141.30.68.111])
        by mx.google.com with ESMTPS id y22sm3236370bku.20.2011.05.02.04.39.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 04:39:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.349.gfeb1a
In-Reply-To: <f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com>
In-Reply-To: <cover.1304321122.git.bert.wesarg@googlemail.com>
References: <cover.1304321122.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172571>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 grep.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/grep.c b/grep.c
index b8eda9e..f21b022 100644
--- a/grep.c
+++ b/grep.c
@@ -437,7 +437,7 @@ static struct {
 };
 
 static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
-			     enum grep_context ctx,
+			     unsigned lno, enum grep_context ctx,
 			     regmatch_t *pmatch, int eflags)
 {
 	int hit = 0;
@@ -516,7 +516,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 }
 
 static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
-			   enum grep_context ctx, int collect_hits)
+			   unsigned lno, enum grep_context ctx, int collect_hits)
 {
 	int h = 0;
 	regmatch_t match;
@@ -528,25 +528,25 @@ static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
 		h = 1;
 		break;
 	case GREP_NODE_ATOM:
-		h = match_one_pattern(x->u.atom, bol, eol, ctx, &match, 0);
+		h = match_one_pattern(x->u.atom, bol, eol, lno, ctx, &match, 0);
 		break;
 	case GREP_NODE_NOT:
-		h = !match_expr_eval(x->u.unary, bol, eol, ctx, 0);
+		h = !match_expr_eval(x->u.unary, bol, eol, lno, ctx, 0);
 		break;
 	case GREP_NODE_AND:
-		if (!match_expr_eval(x->u.binary.left, bol, eol, ctx, 0))
+		if (!match_expr_eval(x->u.binary.left, bol, eol, lno, ctx, 0))
 			return 0;
-		h = match_expr_eval(x->u.binary.right, bol, eol, ctx, 0);
+		h = match_expr_eval(x->u.binary.right, bol, eol, lno, ctx, 0);
 		break;
 	case GREP_NODE_OR:
 		if (!collect_hits)
 			return (match_expr_eval(x->u.binary.left,
-						bol, eol, ctx, 0) ||
+						bol, eol, lno, ctx, 0) ||
 				match_expr_eval(x->u.binary.right,
-						bol, eol, ctx, 0));
-		h = match_expr_eval(x->u.binary.left, bol, eol, ctx, 0);
+						bol, eol, lno, ctx, 0));
+		h = match_expr_eval(x->u.binary.left, bol, eol, lno, ctx, 0);
 		x->u.binary.left->hit |= h;
-		h |= match_expr_eval(x->u.binary.right, bol, eol, ctx, 1);
+		h |= match_expr_eval(x->u.binary.right, bol, eol, lno, ctx, 1);
 		break;
 	default:
 		die("Unexpected node type (internal error) %d", x->node);
@@ -557,36 +557,36 @@ static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
 }
 
 static int match_expr(struct grep_opt *opt, char *bol, char *eol,
-		      enum grep_context ctx, int collect_hits)
+		      unsigned lno, enum grep_context ctx, int collect_hits)
 {
 	struct grep_expr *x = opt->pattern_expression;
-	return match_expr_eval(x, bol, eol, ctx, collect_hits);
+	return match_expr_eval(x, bol, eol, lno, ctx, collect_hits);
 }
 
 static int match_line(struct grep_opt *opt, char *bol, char *eol,
-		      enum grep_context ctx, int collect_hits)
+		      unsigned lno, enum grep_context ctx, int collect_hits)
 {
 	struct grep_pat *p;
 	regmatch_t match;
 
 	if (opt->extended)
-		return match_expr(opt, bol, eol, ctx, collect_hits);
+		return match_expr(opt, bol, eol, lno, ctx, collect_hits);
 
 	/* we do not call with collect_hits without being extended */
 	for (p = opt->pattern_list; p; p = p->next) {
-		if (match_one_pattern(p, bol, eol, ctx, &match, 0))
+		if (match_one_pattern(p, bol, eol, lno, ctx, &match, 0))
 			return 1;
 	}
 	return 0;
 }
 
 static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
-			      enum grep_context ctx,
+			      unsigned lno, enum grep_context ctx,
 			      regmatch_t *pmatch, int eflags)
 {
 	regmatch_t match;
 
-	if (!match_one_pattern(p, bol, eol, ctx, &match, eflags))
+	if (!match_one_pattern(p, bol, eol, lno, ctx, &match, eflags))
 		return 0;
 	if (match.rm_so < 0 || match.rm_eo < 0)
 		return 0;
@@ -601,7 +601,7 @@ static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
 	return 1;
 }
 
-static int next_match(struct grep_opt *opt, char *bol, char *eol,
+static int next_match(struct grep_opt *opt, char *bol, char *eol, unsigned lno,
 		      enum grep_context ctx, regmatch_t *pmatch, int eflags)
 {
 	struct grep_pat *p;
@@ -614,7 +614,7 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 			case GREP_PATTERN: /* atom */
 			case GREP_PATTERN_HEAD:
 			case GREP_PATTERN_BODY:
-				hit |= match_next_pattern(p, bol, eol, ctx,
+				hit |= match_next_pattern(p, bol, eol, lno, ctx,
 							  pmatch, eflags);
 				break;
 			default:
@@ -667,7 +667,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		else if (sign == '=')
 			line_color = opt->color_function;
 		*eol = '\0';
-		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
+		while (next_match(opt, bol, eol, lno, ctx, &match, eflags)) {
 			if (match.rm_so == match.rm_eo)
 				break;
 
@@ -911,7 +911,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		if ((ctx == GREP_CONTEXT_HEAD) && (eol == bol))
 			ctx = GREP_CONTEXT_BODY;
 
-		hit = match_line(opt, bol, eol, ctx, collect_hits);
+		hit = match_line(opt, bol, eol, lno, ctx, collect_hits);
 		*eol = ch;
 
 		if (collect_hits)
-- 
1.7.5.349.gfeb1a
