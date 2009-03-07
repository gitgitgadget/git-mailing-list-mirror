From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/5] grep: add pmatch and eflags arguments to
 match_one_pattern()
Date: Sat, 07 Mar 2009 13:30:27 +0100
Message-ID: <1236429027.6486.47.camel@ubuntu.ubuntu-domain>
References: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Thiago Alves <thiago.salves@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 13:32:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfvh8-0000bR-SW
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 13:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbZCGMac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 07:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbZCGMab
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 07:30:31 -0500
Received: from india601.server4you.de ([85.25.151.105]:39327 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbZCGMaa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 07:30:30 -0500
Received: from [10.0.1.101] (p57B7BF05.dip.t-dialin.net [87.183.191.5])
	by india601.server4you.de (Postfix) with ESMTPSA id 30CEC2F8057;
	Sat,  7 Mar 2009 13:30:28 +0100 (CET)
In-Reply-To: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112532>

Push pmatch and eflags to the callers of match_one_pattern(), which
allows them to specify regex execution flags and to get the location
of a match.

Since we only use the first element of the matches array and aren't
interested in submatches, no provision is made for callers to
provide a larger array.

eflags are ignored for fixed patterns, but that's OK, since they
only have a meaning in connection with regular expressions
containing ^ or $.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/grep.c b/grep.c
index f455182..bdcff7b 100644
--- a/grep.c
+++ b/grep.c
@@ -309,11 +309,11 @@ static struct {
 };
 
 static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
-			     enum grep_context ctx)
+			     enum grep_context ctx,
+			     regmatch_t *pmatch, int eflags)
 {
 	int hit = 0;
 	int saved_ch = 0;
-	regmatch_t pmatch[10];
 
 	if ((p->token != GREP_PATTERN) &&
 	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)))
@@ -332,14 +332,10 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	}
 
  again:
-	if (!p->fixed) {
-		regex_t *exp = &p->regexp;
-		hit = !regexec(exp, bol, ARRAY_SIZE(pmatch),
-			       pmatch, 0);
-	}
-	else {
+	if (p->fixed)
 		hit = !fixmatch(p->pattern, bol, pmatch);
-	}
+	else
+		hit = !regexec(&p->regexp, bol, 1, pmatch, eflags);
 
 	if (hit && p->word_regexp) {
 		if ((pmatch[0].rm_so < 0) ||
@@ -385,10 +381,11 @@ static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
 			   enum grep_context ctx, int collect_hits)
 {
 	int h = 0;
+	regmatch_t match;
 
 	switch (x->node) {
 	case GREP_NODE_ATOM:
-		h = match_one_pattern(x->u.atom, bol, eol, ctx);
+		h = match_one_pattern(x->u.atom, bol, eol, ctx, &match, 0);
 		break;
 	case GREP_NODE_NOT:
 		h = !match_expr_eval(x->u.unary, bol, eol, ctx, 0);
@@ -427,12 +424,14 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 		      enum grep_context ctx, int collect_hits)
 {
 	struct grep_pat *p;
+	regmatch_t match;
+
 	if (opt->extended)
 		return match_expr(opt, bol, eol, ctx, collect_hits);
 
 	/* we do not call with collect_hits without being extended */
 	for (p = opt->pattern_list; p; p = p->next) {
-		if (match_one_pattern(p, bol, eol, ctx))
+		if (match_one_pattern(p, bol, eol, ctx, &match, 0))
 			return 1;
 	}
 	return 0;
-- 
1.6.2
