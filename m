From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH/RFC 3/4] grep: introduce pattern which matches at line number
Date: Mon,  2 May 2011 13:39:12 +0200
Message-ID: <f85d783d43bfe7f9e9f23a10e72e8a2a83033cac.1304321122.git.bert.wesarg@googlemail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
 <f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com>
 <2681b60988c7c4d059f83df368395eca0520012c.1304321122.git.bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 13:39:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGrTN-0000i5-HU
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 13:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758264Ab1EBLjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 07:39:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33090 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758214Ab1EBLjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 07:39:23 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so4521802bwz.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=ze/qeLuTHgX/3va7AtXDbTIyQ5yTDHH4D6v8C894ZCo=;
        b=JX81X3i2kXsOKHZEwQEtXGiB/qKp+0yOWq+bPn0+rfvnYnWyIRvPb4HiATU4d/FHHe
         W4yU9jVbhwAvag5A3nKfPefdfqWp/zq0/zVfrtTnbIVi9Ar/LQE5/B14bG+T1xAJRq6o
         VvxE1/OgtaQSKHU0wBoya0WqaLM7Vgw0KMx/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LfE0GTXSHGm2omeJGRpYLIV+YJYm3ZrfRoJVitpBK7R4Zxt6vx7nGNI6vru92hcc3N
         Kepf6JuhRe7MbDPXpQJMTXYRXd4abdvcZT9disHQEjPO9LO+1mOVWAUfhbXUUA7Hu7kt
         9DVpuwSydKZ0uGczF77CKg8EMfHpiHWQSy33A=
Received: by 10.204.20.65 with SMTP id e1mr3259501bkb.149.1304336362299;
        Mon, 02 May 2011 04:39:22 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de [141.30.68.111])
        by mx.google.com with ESMTPS id 16sm3236971bkm.18.2011.05.02.04.39.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 04:39:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.349.gfeb1a
In-Reply-To: <2681b60988c7c4d059f83df368395eca0520012c.1304321122.git.bert.wesarg@googlemail.com>
In-Reply-To: <cover.1304321122.git.bert.wesarg@googlemail.com>
References: <cover.1304321122.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172572>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 grep.c |   33 +++++++++++++++++++++++++++++++++
 grep.h |    7 +++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index f21b022..cbb3757 100644
--- a/grep.c
+++ b/grep.c
@@ -87,6 +87,15 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	}
 }
 
+static void parse_lno(struct grep_pat *p, struct grep_opt *opt)
+{
+	char *eon;
+
+	p->u.lno = strtoul(p->pattern, &eon, 10);
+	if (*eon || p->u.lno == 0)
+		die("'%s': Invalid number for line match", p->pattern);
+}
+
 static struct grep_expr *compile_pattern_or(struct grep_pat **);
 static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 {
@@ -100,6 +109,7 @@ static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 	case GREP_PATTERN: /* atom */
 	case GREP_PATTERN_HEAD:
 	case GREP_PATTERN_BODY:
+	case GREP_LNO:
 		x = xcalloc(1, sizeof (struct grep_expr));
 		x->node = GREP_NODE_ATOM;
 		x->u.atom = p;
@@ -264,6 +274,9 @@ void compile_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN_BODY:
 			compile_regexp(p, opt);
 			break;
+		case GREP_LNO:
+			parse_lno(p, opt);
+			break;
 		default:
 			opt->extended = 1;
 			break;
@@ -297,6 +310,7 @@ static void free_pattern_expr(struct grep_expr *x)
 	switch (x->node) {
 	case GREP_NODE_TRUE:
 	case GREP_NODE_ATOM:
+	case GREP_NODE_LNO:
 		break;
 	case GREP_NODE_NOT:
 		free_pattern_expr(x->u.unary);
@@ -436,6 +450,21 @@ static struct {
 	{ "committer ", 10 },
 };
 
+static int match_lno(struct grep_pat *p, char *bol, char *eol, unsigned lno,
+		     regmatch_t *pmatch)
+{
+	if (p->u.lno == lno) {
+		/*
+		 * because coloring will stop at so == eo, match at the end
+		 * of line, so that the whole line can be colored
+		 */
+		pmatch->rm_so = eol - bol;
+		pmatch->rm_eo = eol - bol;
+		return 1;
+	}
+	return 0;
+}
+
 static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 			     unsigned lno, enum grep_context ctx,
 			     regmatch_t *pmatch, int eflags)
@@ -444,6 +473,9 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	int saved_ch = 0;
 	const char *start = bol;
 
+	if (p->token == GREP_LNO)
+		return match_lno(p, bol, eol, lno, pmatch);
+
 	if ((p->token != GREP_PATTERN) &&
 	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)))
 		return 0;
@@ -614,6 +646,7 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol, unsigned lno,
 			case GREP_PATTERN: /* atom */
 			case GREP_PATTERN_HEAD:
 			case GREP_PATTERN_BODY:
+			case GREP_LNO:
 				hit |= match_next_pattern(p, bol, eol, lno, ctx,
 							  pmatch, eflags);
 				break;
diff --git a/grep.h b/grep.h
index 9912c11..41821f3 100644
--- a/grep.h
+++ b/grep.h
@@ -10,7 +10,8 @@ enum grep_pat_token {
 	GREP_OPEN_PAREN,
 	GREP_CLOSE_PAREN,
 	GREP_NOT,
-	GREP_OR
+	GREP_OR,
+	GREP_LNO
 };
 
 enum grep_context {
@@ -34,6 +35,7 @@ struct grep_pat {
 	enum grep_header_field field;
 	union {
 		regex_t regexp;
+		unsigned lno;
 	} u;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
@@ -45,7 +47,8 @@ enum grep_expr_node {
 	GREP_NODE_NOT,
 	GREP_NODE_AND,
 	GREP_NODE_TRUE,
-	GREP_NODE_OR
+	GREP_NODE_OR,
+	GREP_NODE_LNO
 };
 
 struct grep_expr {
-- 
1.7.5.349.gfeb1a
