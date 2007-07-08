From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] revision: allow selection of commits that do not
 match a pattern
Date: Sun, 8 Jul 2007 15:22:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081519230.4248@racer.site>
References: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071724410.4093@racer.site> <20070707165208.GC1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071831300.4093@racer.site> <20070707184224.GE1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071957370.4093@racer.site> <20070708105719.GH1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 08 16:29:39 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7XlZ-0002eJ-6s
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 16:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbXGHO3f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 10:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbXGHO3e
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 10:29:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:52481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751474AbXGHO3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 10:29:34 -0400
Received: (qmail invoked by alias); 08 Jul 2007 14:29:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 08 Jul 2007 16:29:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jrmYBGwzjhpqJVY95FSzh4Prw4NOAQv4EjDH4A7
	3a+zLYUnnp+dvI
X-X-Sender: gene099@racer.site
In-Reply-To: <20070708105719.GH1528MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51885>

Hi,

just to give you an impression of what I had in mind, here is a WIP.  It 
is not completely thought through, for example I did not make up my mind 
how to handle something like "--not --not-at-all <pattern>".  Oh, and the 
code for non-status_only is not there.  And builtin-grep does not see any 
of this, yet. But you'll get the idea:

---

 grep.c     |   19 +++++++++++++++----
 grep.h     |    3 +++
 revision.c |   13 ++++++++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index f67d671..40a2620 100644
--- a/grep.c
+++ b/grep.c
@@ -66,20 +66,24 @@ static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 
 static struct grep_expr *compile_pattern_not(struct grep_pat **list)
 {
+	const char *what;
 	struct grep_pat *p;
 	struct grep_expr *x;
 
 	p = *list;
 	switch (p->token) {
 	case GREP_NOT:
+	case GREP_NOT_AT_ALL:
+		what = p->token == GREP_NOT ? "--not" : "--not-at-all";
 		if (!p->next)
-			die("--not not followed by pattern expression");
+			die("%s not followed by pattern expression", what);
 		*list = p->next;
 		x = xcalloc(1, sizeof (struct grep_expr));
-		x->node = GREP_NODE_NOT;
+		x->node = p->token == GREP_NOT ?
+			GREP_NODE_NOT : GREP_NODE_NOT_AT_ALL;
 		x->u.unary = compile_pattern_not(list);
 		if (!x->u.unary)
-			die("--not followed by non pattern expression");
+			die("%s followed by non pattern expression", what);
 		return x;
 	default:
 		return compile_pattern_atom(list);
@@ -173,6 +177,7 @@ static void free_pattern_expr(struct grep_expr *x)
 	case GREP_NODE_ATOM:
 		break;
 	case GREP_NODE_NOT:
+	case GREP_NODE_NOT_AT_ALL:
 		free_pattern_expr(x->u.unary);
 		break;
 	case GREP_NODE_AND:
@@ -316,6 +321,10 @@ static int match_expr_eval(struct grep_opt *o,
 	case GREP_NODE_NOT:
 		h = !match_expr_eval(o, x->u.unary, bol, eol, ctx, 0);
 		break;
+	case GREP_NODE_NOT_AT_ALL:
+		if (match_expr_eval(o, x->u.unary, bol, eol, ctx, 0))
+			o->not_at_all = 1;
+		break;
 	case GREP_NODE_AND:
 		if (!collect_hits)
 			return (match_expr_eval(o, x->u.binary.left,
@@ -382,6 +391,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	unsigned count = 0;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 
+	opt->not_at_all = 0;
+
 	if (buffer_is_binary(buf, size)) {
 		switch (opt->binary) {
 		case GREP_BINARY_DEFAULT:
@@ -500,7 +511,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		return 0;
 
 	if (opt->status_only)
-		return 0;
+		return !opt->not_at_all;
 	if (opt->unmatch_name_only) {
 		/* We did not see any hit, so we want to show this */
 		printf("%s\n", name);
diff --git a/grep.h b/grep.h
index d252dd2..f80a1c2 100644
--- a/grep.h
+++ b/grep.h
@@ -10,6 +10,7 @@ enum grep_pat_token {
 	GREP_CLOSE_PAREN,
 	GREP_NOT,
 	GREP_OR,
+	GREP_NOT_AT_ALL,
 };
 
 enum grep_context {
@@ -31,6 +32,7 @@ enum grep_expr_node {
 	GREP_NODE_NOT,
 	GREP_NODE_AND,
 	GREP_NODE_OR,
+	GREP_NODE_NOT_AT_ALL,
 };
 
 struct grep_expr {
@@ -68,6 +70,7 @@ struct grep_opt {
 	unsigned extended:1;
 	unsigned relative:1;
 	unsigned pathname:1;
+	unsigned not_at_all:1; /* is set if the pattern was seen */
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
diff --git a/revision.c b/revision.c
index 5184716..3df8a57 100644
--- a/revision.c
+++ b/revision.c
@@ -823,6 +823,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 
 static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
 {
+	int negate = *ptn == '!';
 	if (!revs->grep_filter) {
 		struct grep_opt *opt = xcalloc(1, sizeof(*opt));
 		opt->status_only = 1;
@@ -830,6 +831,13 @@ static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token
 		opt->regflags = REG_NEWLINE;
 		revs->grep_filter = opt;
 	}
+	if (negate) {
+		revs->grep_filter->extended = 1;
+		append_grep_pattern(revs->grep_filter, ptn,
+				"command line", 0, GREP_NOT_AT_ALL);
+	}
+	if (negate || ( *ptn == '\\' && ptn[1] == '!'))
+		ptn++;
 	append_grep_pattern(revs->grep_filter, ptn,
 			    "command line", 0, what);
 }
@@ -839,7 +847,10 @@ static void add_header_grep(struct rev_info *revs, const char *field, const char
 	char *pat;
 	const char *prefix;
 	int patlen, fldlen;
+	int negate = *pattern == '!';
 
+	if (negate || (*pattern == '\\' && pattern[1] == '!'))
+		pattern++;
 	fldlen = strlen(field);
 	patlen = strlen(pattern);
 	pat = xmalloc(patlen + fldlen + 10);
@@ -848,7 +859,7 @@ static void add_header_grep(struct rev_info *revs, const char *field, const char
 		prefix = "";
 		pattern++;
 	}
-	sprintf(pat, "^%s %s%s", field, prefix, pattern);
+	sprintf(pat, "%s^%s %s%s", negate ? "!" : "", field, prefix, pattern);
 	add_grep(revs, pat, GREP_PATTERN_HEAD);
 }
 
