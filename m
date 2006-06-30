From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-grep: boolean expression on pattern matching.
Date: Fri, 30 Jun 2006 03:08:02 -0700
Message-ID: <7vsllnj6rh.fsf_-_@assigned-by-dhcp.cox.net>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx>
	<20060625184757.f8273820.tihirvon@gmail.com>
	<E1FuX8l-0001H5-2z@moooo.ath.cx>
	<Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<E1FueYh-0004XE-Fg@moooo.ath.cx>
	<20060629222009.GA9310@cip.informatik.uni-erlangen.de>
	<7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
	<E1Fw8hS-00023y-FY@moooo.ath.cx>
	<7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
	<E1FwDiI-0007Xp-2s@moooo.ath.cx>
	<7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 12:08:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwFv7-0004Ee-MB
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 12:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWF3KIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 06:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWF3KIF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 06:08:05 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:11904 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750748AbWF3KID (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 06:08:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630100803.EZAI16011.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 06:08:03 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 30 Jun 2006 00:56:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22976>

This extends the behaviour of git-grep when multiple -e options
are given.  So far, we allowed multiple -e to behave just like
regular grep with multiple -e, i.e. the patterns are OR'ed
together.

With this change, you can also have multiple patterns AND'ed
together, or form boolean expressions, like this (the
parentheses are quoted from the shell in this example):

	$ git grep -e _PATTERN --and \( -e atom -e token \)

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * OR'ing together, admittably, can be done easily by saying
   something like -e 'atom\|token', so being able to say --and
   as you argued is of more practical importance, and doing
   boolean expression like this might be too much frill.

   Only very lightly tested; it is obviously not slated for
   1.4.1.

 builtin-grep.c |  378 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 327 insertions(+), 51 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 2e7986c..70b1fd2 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -82,17 +82,47 @@ static int pathspec_matches(const char *
 	return 0;
 }
 
+enum grep_pat_token {
+	GREP_PATTERN,
+	GREP_AND,
+	GREP_OPEN_PAREN,
+	GREP_CLOSE_PAREN,
+	GREP_NOT,
+	GREP_OR,
+};
+
 struct grep_pat {
 	struct grep_pat *next;
 	const char *origin;
 	int no;
+	enum grep_pat_token token;
 	const char *pattern;
 	regex_t regexp;
 };
 
+enum grep_expr_node {
+	GREP_NODE_ATOM,
+	GREP_NODE_NOT,
+	GREP_NODE_AND,
+	GREP_NODE_OR,
+};
+
+struct grep_expr {
+	enum grep_expr_node node;
+	union {
+		struct grep_pat *atom;
+		struct grep_expr *unary;
+		struct {
+			struct grep_expr *left;
+			struct grep_expr *right;
+		} binary;
+	} u;
+};
+
 struct grep_opt {
 	struct grep_pat *pattern_list;
 	struct grep_pat **pattern_tail;
+	struct grep_expr *pattern_expression;
 	regex_t regexp;
 	unsigned linenum:1;
 	unsigned invert:1;
@@ -105,43 +135,224 @@ #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
 	unsigned binary:2;
+	unsigned extended:1;
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
 };
 
 static void add_pattern(struct grep_opt *opt, const char *pat,
-			const char *origin, int no)
+			const char *origin, int no, enum grep_pat_token t)
 {
 	struct grep_pat *p = xcalloc(1, sizeof(*p));
 	p->pattern = pat;
 	p->origin = origin;
 	p->no = no;
+	p->token = t;
 	*opt->pattern_tail = p;
 	opt->pattern_tail = &p->next;
 	p->next = NULL;
 }
 
+static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
+{
+	int err = regcomp(&p->regexp, p->pattern, opt->regflags);
+	if (err) {
+		char errbuf[1024];
+		char where[1024];
+		if (p->no)
+			sprintf(where, "In '%s' at %d, ",
+				p->origin, p->no);
+		else if (p->origin)
+			sprintf(where, "%s, ", p->origin);
+		else
+			where[0] = 0;
+		regerror(err, &p->regexp, errbuf, 1024);
+		regfree(&p->regexp);
+		die("%s'%s': %s", where, p->pattern, errbuf);
+	}
+}
+
+#if DEBUG
+static inline void indent(int in)
+{
+	int i;
+	for (i = 0; i < in; i++) putchar(' ');
+}
+
+static void dump_pattern_exp(struct grep_expr *x, int in)
+{
+	switch (x->node) {
+	case GREP_NODE_ATOM:
+		indent(in);
+		puts(x->u.atom->pattern);
+		break;
+	case GREP_NODE_NOT:
+		indent(in);
+		puts("--not");
+		dump_pattern_exp(x->u.unary, in+1);
+		break;
+	case GREP_NODE_AND:
+		dump_pattern_exp(x->u.binary.left, in+1);
+		indent(in);
+		puts("--and");
+		dump_pattern_exp(x->u.binary.right, in+1);
+		break;
+	case GREP_NODE_OR:
+		dump_pattern_exp(x->u.binary.left, in+1);
+		indent(in);
+		puts("--or");
+		dump_pattern_exp(x->u.binary.right, in+1);
+		break;
+	}
+}
+
+static void looking_at(const char *msg, struct grep_pat **list)
+{
+	struct grep_pat *p = *list;
+	fprintf(stderr, "%s: looking at ", msg);
+	if (!p)
+		fprintf(stderr, "empty\n");
+	else
+		fprintf(stderr, "<%s>\n", p->pattern);
+}
+#else
+#define looking_at(a,b) do {} while(0)
+#endif
+
+static struct grep_expr *compile_pattern_expr(struct grep_pat **);
+static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
+{
+	struct grep_pat *p;
+	struct grep_expr *x;
+
+	looking_at("atom", list);
+
+	p = *list;
+	switch (p->token) {
+	case GREP_PATTERN: /* atom */
+		x = xcalloc(1, sizeof (struct grep_expr));
+		x->node = GREP_NODE_ATOM;
+		x->u.atom = p;
+		*list = p->next;
+		return x;
+	case GREP_OPEN_PAREN:
+		*list = p->next;
+		x = compile_pattern_expr(list);
+		if (!x)
+			return NULL;
+		if (!*list || (*list)->token != GREP_CLOSE_PAREN)
+			die("unmatched parenthesis");
+		*list = (*list)->next;
+		return x;
+	default:
+		return NULL;
+	}
+}
+
+static struct grep_expr *compile_pattern_not(struct grep_pat **list)
+{
+	struct grep_pat *p;
+	struct grep_expr *x;
+
+	looking_at("not", list);
+
+	p = *list;
+	switch (p->token) {
+	case GREP_NOT:
+		if (!p->next)
+			die("--not not followed by pattern expression");
+		*list = p->next;
+		x = xcalloc(1, sizeof (struct grep_expr));
+		x->node = GREP_NODE_NOT;
+		x->u.unary = compile_pattern_not(list);
+		if (!x->u.unary)
+			die("--not followed by non pattern expression");
+		return x;
+	default:
+		return compile_pattern_atom(list);
+	}
+}
+
+static struct grep_expr *compile_pattern_and(struct grep_pat **list)
+{
+	struct grep_pat *p;
+	struct grep_expr *x, *y, *z;
+
+	looking_at("and", list);
+
+	x = compile_pattern_not(list);
+	p = *list;
+	if (p && p->token == GREP_AND) {
+		if (!p->next)
+			die("--and not followed by pattern expression");
+		*list = p->next;
+		y = compile_pattern_and(list);
+		if (!y)
+			die("--and not followed by pattern expression");
+		z = xcalloc(1, sizeof (struct grep_expr));
+		z->node = GREP_NODE_AND;
+		z->u.binary.left = x;
+		z->u.binary.right = y;
+		return z;
+	}
+	return x;
+}
+
+static struct grep_expr *compile_pattern_or(struct grep_pat **list)
+{
+	struct grep_pat *p;
+	struct grep_expr *x, *y, *z;
+
+	looking_at("or", list);
+
+	x = compile_pattern_and(list);
+	p = *list;
+	if (x && p && p->token != GREP_CLOSE_PAREN) {
+		y = compile_pattern_or(list);
+		if (!y)
+			die("not a pattern expression %s", p->pattern);
+		z = xcalloc(1, sizeof (struct grep_expr));
+		z->node = GREP_NODE_OR;
+		z->u.binary.left = x;
+		z->u.binary.right = y;
+		return z;
+	}
+	return x;
+}
+
+static struct grep_expr *compile_pattern_expr(struct grep_pat **list)
+{
+	looking_at("expr", list);
+
+	return compile_pattern_or(list);
+}
+
 static void compile_patterns(struct grep_opt *opt)
 {
 	struct grep_pat *p;
+
+	/* First compile regexps */
 	for (p = opt->pattern_list; p; p = p->next) {
-		int err = regcomp(&p->regexp, p->pattern, opt->regflags);
-		if (err) {
-			char errbuf[1024];
-			char where[1024];
-			if (p->no)
-				sprintf(where, "In '%s' at %d, ",
-					p->origin, p->no);
-			else if (p->origin)
-				sprintf(where, "%s, ", p->origin);
-			else
-				where[0] = 0;
-			regerror(err, &p->regexp, errbuf, 1024);
-			regfree(&p->regexp);
-			die("%s'%s': %s", where, p->pattern, errbuf);
-		}
+		if (p->token == GREP_PATTERN)
+			compile_regexp(p, opt);
+		else
+			opt->extended = 1;
 	}
+
+	if (!opt->extended)
+		return;
+
+	/* Then bundle them up in an expression.
+	 * A classic recursive descent parser would do.
+	 */
+	p = opt->pattern_list;
+	opt->pattern_expression = compile_pattern_expr(&p);
+#if DEBUG
+	dump_pattern_exp(opt->pattern_expression, 0);
+#endif
+	if (p)
+		die("incomplete pattern expression: %s", p->pattern);
 }
 
 static char *end_of_line(char *cp, unsigned long *left)
@@ -196,6 +407,79 @@ static int fixmatch(const char *pattern,
 	}
 }
 
+static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol, char *eol)
+{
+	int hit = 0;
+	regmatch_t pmatch[10];
+
+	if (!opt->fixed) {
+		regex_t *exp = &p->regexp;
+		hit = !regexec(exp, bol, ARRAY_SIZE(pmatch),
+			       pmatch, 0);
+	}
+	else {
+		hit = !fixmatch(p->pattern, bol, pmatch);
+	}
+
+	if (hit && opt->word_regexp) {
+		/* Match beginning must be either
+		 * beginning of the line, or at word
+		 * boundary (i.e. the last char must
+		 * not be alnum or underscore).
+		 */
+		if ((pmatch[0].rm_so < 0) ||
+		    (eol - bol) <= pmatch[0].rm_so ||
+		    (pmatch[0].rm_eo < 0) ||
+		    (eol - bol) < pmatch[0].rm_eo)
+			die("regexp returned nonsense");
+		if (pmatch[0].rm_so != 0 &&
+		    word_char(bol[pmatch[0].rm_so-1]))
+			hit = 0;
+		if (pmatch[0].rm_eo != (eol-bol) &&
+		    word_char(bol[pmatch[0].rm_eo]))
+			hit = 0;
+	}
+	return hit;
+}
+
+static int match_expr_eval(struct grep_opt *opt,
+			   struct grep_expr *x,
+			   char *bol, char *eol)
+{
+	switch (x->node) {
+	case GREP_NODE_ATOM:
+		return match_one_pattern(opt, x->u.atom, bol, eol);
+		break;
+	case GREP_NODE_NOT:
+		return !match_expr_eval(opt, x->u.unary, bol, eol);
+	case GREP_NODE_AND:
+		return (match_expr_eval(opt, x->u.binary.left, bol, eol) &&
+			match_expr_eval(opt, x->u.binary.right, bol, eol));
+	case GREP_NODE_OR:
+		return (match_expr_eval(opt, x->u.binary.left, bol, eol) ||
+			match_expr_eval(opt, x->u.binary.right, bol, eol));
+	}
+	die("Unexpected node type (internal error) %d\n", x->node);
+}
+
+static int match_expr(struct grep_opt *opt, char *bol, char *eol)
+{
+	struct grep_expr *x = opt->pattern_expression;
+	return match_expr_eval(opt, x, bol, eol);
+}
+
+static int match_line(struct grep_opt *opt, char *bol, char *eol)
+{
+	struct grep_pat *p;
+	if (opt->extended)
+		return match_expr(opt, bol, eol);
+	for (p = opt->pattern_list; p; p = p->next) {
+		if (match_one_pattern(opt, p, bol, eol))
+			return 1;
+	}
+	return 0;
+}
+
 static int grep_buffer(struct grep_opt *opt, const char *name,
 		       char *buf, unsigned long size)
 {
@@ -231,46 +515,15 @@ static int grep_buffer(struct grep_opt *
 		hunk_mark = "--\n";
 
 	while (left) {
-		regmatch_t pmatch[10];
 		char *eol, ch;
 		int hit = 0;
-		struct grep_pat *p;
 
 		eol = end_of_line(bol, &left);
 		ch = *eol;
 		*eol = 0;
 
-		for (p = opt->pattern_list; p; p = p->next) {
-			if (!opt->fixed) {
-				regex_t *exp = &p->regexp;
-				hit = !regexec(exp, bol, ARRAY_SIZE(pmatch),
-					       pmatch, 0);
-			}
-			else {
-				hit = !fixmatch(p->pattern, bol, pmatch);
-			}
+		hit = match_line(opt, bol, eol);
 
-			if (hit && opt->word_regexp) {
-				/* Match beginning must be either
-				 * beginning of the line, or at word
-				 * boundary (i.e. the last char must
-				 * not be alnum or underscore).
-				 */
-				if ((pmatch[0].rm_so < 0) ||
-				    (eol - bol) <= pmatch[0].rm_so ||
-				    (pmatch[0].rm_eo < 0) ||
-				    (eol - bol) < pmatch[0].rm_eo)
-					die("regexp returned nonsense");
-				if (pmatch[0].rm_so != 0 &&
-				    word_char(bol[pmatch[0].rm_so-1]))
-					hit = 0;
-				if (pmatch[0].rm_eo != (eol-bol) &&
-				    word_char(bol[pmatch[0].rm_eo]))
-					hit = 0;
-			}
-			if (hit)
-				break;
-		}
 		/* "grep -v -e foo -e bla" should list lines
 		 * that do not have either, so inversion should
 		 * be done outside.
@@ -452,6 +705,8 @@ static int external_grep(struct grep_opt
 	char *argptr = randarg;
 	struct grep_pat *p;
 
+	if (opt->extended)
+		return -1;
 	len = nr = 0;
 	push_arg("grep");
 	if (opt->fixed)
@@ -801,16 +1056,36 @@ int cmd_grep(int argc, const char **argv
 				/* ignore empty line like grep does */
 				if (!buf[0])
 					continue;
-				add_pattern(&opt, strdup(buf), argv[1], ++lno);
+				add_pattern(&opt, strdup(buf), argv[1], ++lno,
+					    GREP_PATTERN);
 			}
 			fclose(patterns);
 			argv++;
 			argc--;
 			continue;
 		}
+		if (!strcmp("--not", arg)) {
+			add_pattern(&opt, arg, "command line", 0, GREP_NOT);
+			continue;
+		}
+		if (!strcmp("--and", arg)) {
+			add_pattern(&opt, arg, "command line", 0, GREP_AND);
+			continue;
+		}
+		if (!strcmp("--or", arg))
+			continue; /* no-op */
+		if (!strcmp("(", arg)) {
+			add_pattern(&opt, arg, "command line", 0, GREP_OPEN_PAREN);
+			continue;
+		}
+		if (!strcmp(")", arg)) {
+			add_pattern(&opt, arg, "command line", 0, GREP_CLOSE_PAREN);
+			continue;
+		}
 		if (!strcmp("-e", arg)) {
 			if (1 < argc) {
-				add_pattern(&opt, argv[1], "-e option", 0);
+				add_pattern(&opt, argv[1], "-e option", 0,
+					    GREP_PATTERN);
 				argv++;
 				argc--;
 				continue;
@@ -824,7 +1099,8 @@ int cmd_grep(int argc, const char **argv
 
 		/* First unrecognized non-option token */
 		if (!opt.pattern_list) {
-			add_pattern(&opt, arg, "command line", 0);
+			add_pattern(&opt, arg, "command line", 0,
+				    GREP_PATTERN);
 			break;
 		}
 		else {
-- 
1.4.1.rc2.gfff62
