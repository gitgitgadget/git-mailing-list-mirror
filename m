From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] builtin-grep: make pieces of it available as library.
Date: Sun, 17 Sep 2006 17:42:24 -0700
Message-ID: <7vfyeqyphr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kai Blin <kai.blin@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 18 02:42:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP7DU-0000pg-0W
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 02:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWIRAm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 20:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbWIRAm1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 20:42:27 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:59328 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965174AbWIRAm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 20:42:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918004225.LHZP13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 20:42:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PciC1V00K1kojtg0000000
	Sun, 17 Sep 2006 20:42:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27215>

This makes three functions and associated option structures from
builtin-grep available from other parts of the system.

 * options to drive built-in grep engine is stored in struct
   grep_opt;

 * pattern strings and extended grep expressions are added to
   struct grep_opt with append_grep_pattern();

 * when finished calling append_grep_pattern(), call
   compile_grep_patterns() to prepare for execution;

 * call grep_buffer() to find matches in the in-core buffer.

This also adds an internal option "status_only" to grep_opt,
which suppresses any output from grep_buffer().  Callers of the
function as library can use it to check if there is a match
without producing any output.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile       |    2 
 builtin-grep.c |  522 ++------------------------------------------------------
 grep.c         |  440 +++++++++++++++++++++++++++++++++++++++++++++++
 grep.h         |   71 ++++++++
 4 files changed, 530 insertions(+), 505 deletions(-)

diff --git a/Makefile b/Makefile
index b987450..b8e679e 100644
--- a/Makefile
+++ b/Makefile
@@ -252,7 +252,7 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
-	write_or_die.o trace.o \
+	write_or_die.o trace.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS)
 
 BUILTIN_OBJS = \
diff --git a/builtin-grep.c b/builtin-grep.c
index ed87a55..6718788 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -11,6 +11,7 @@ #include "tag.h"
 #include "tree-walk.h"
 #include "builtin.h"
 #include <regex.h>
+#include "grep.h"
 #include <fnmatch.h>
 #include <sys/wait.h>
 
@@ -82,498 +83,6 @@ static int pathspec_matches(const char *
 	return 0;
 }
 
-enum grep_pat_token {
-	GREP_PATTERN,
-	GREP_AND,
-	GREP_OPEN_PAREN,
-	GREP_CLOSE_PAREN,
-	GREP_NOT,
-	GREP_OR,
-};
-
-struct grep_pat {
-	struct grep_pat *next;
-	const char *origin;
-	int no;
-	enum grep_pat_token token;
-	const char *pattern;
-	regex_t regexp;
-};
-
-enum grep_expr_node {
-	GREP_NODE_ATOM,
-	GREP_NODE_NOT,
-	GREP_NODE_AND,
-	GREP_NODE_OR,
-};
-
-struct grep_expr {
-	enum grep_expr_node node;
-	union {
-		struct grep_pat *atom;
-		struct grep_expr *unary;
-		struct {
-			struct grep_expr *left;
-			struct grep_expr *right;
-		} binary;
-	} u;
-};
-
-struct grep_opt {
-	struct grep_pat *pattern_list;
-	struct grep_pat **pattern_tail;
-	struct grep_expr *pattern_expression;
-	int prefix_length;
-	regex_t regexp;
-	unsigned linenum:1;
-	unsigned invert:1;
-	unsigned name_only:1;
-	unsigned unmatch_name_only:1;
-	unsigned count:1;
-	unsigned word_regexp:1;
-	unsigned fixed:1;
-#define GREP_BINARY_DEFAULT	0
-#define GREP_BINARY_NOMATCH	1
-#define GREP_BINARY_TEXT	2
-	unsigned binary:2;
-	unsigned extended:1;
-	unsigned relative:1;
-	unsigned pathname:1;
-	int regflags;
-	unsigned pre_context;
-	unsigned post_context;
-};
-
-static void add_pattern(struct grep_opt *opt, const char *pat,
-			const char *origin, int no, enum grep_pat_token t)
-{
-	struct grep_pat *p = xcalloc(1, sizeof(*p));
-	p->pattern = pat;
-	p->origin = origin;
-	p->no = no;
-	p->token = t;
-	*opt->pattern_tail = p;
-	opt->pattern_tail = &p->next;
-	p->next = NULL;
-}
-
-static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
-{
-	int err = regcomp(&p->regexp, p->pattern, opt->regflags);
-	if (err) {
-		char errbuf[1024];
-		char where[1024];
-		if (p->no)
-			sprintf(where, "In '%s' at %d, ",
-				p->origin, p->no);
-		else if (p->origin)
-			sprintf(where, "%s, ", p->origin);
-		else
-			where[0] = 0;
-		regerror(err, &p->regexp, errbuf, 1024);
-		regfree(&p->regexp);
-		die("%s'%s': %s", where, p->pattern, errbuf);
-	}
-}
-
-static struct grep_expr *compile_pattern_expr(struct grep_pat **);
-static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
-{
-	struct grep_pat *p;
-	struct grep_expr *x;
-
-	p = *list;
-	switch (p->token) {
-	case GREP_PATTERN: /* atom */
-		x = xcalloc(1, sizeof (struct grep_expr));
-		x->node = GREP_NODE_ATOM;
-		x->u.atom = p;
-		*list = p->next;
-		return x;
-	case GREP_OPEN_PAREN:
-		*list = p->next;
-		x = compile_pattern_expr(list);
-		if (!x)
-			return NULL;
-		if (!*list || (*list)->token != GREP_CLOSE_PAREN)
-			die("unmatched parenthesis");
-		*list = (*list)->next;
-		return x;
-	default:
-		return NULL;
-	}
-}
-
-static struct grep_expr *compile_pattern_not(struct grep_pat **list)
-{
-	struct grep_pat *p;
-	struct grep_expr *x;
-
-	p = *list;
-	switch (p->token) {
-	case GREP_NOT:
-		if (!p->next)
-			die("--not not followed by pattern expression");
-		*list = p->next;
-		x = xcalloc(1, sizeof (struct grep_expr));
-		x->node = GREP_NODE_NOT;
-		x->u.unary = compile_pattern_not(list);
-		if (!x->u.unary)
-			die("--not followed by non pattern expression");
-		return x;
-	default:
-		return compile_pattern_atom(list);
-	}
-}
-
-static struct grep_expr *compile_pattern_and(struct grep_pat **list)
-{
-	struct grep_pat *p;
-	struct grep_expr *x, *y, *z;
-
-	x = compile_pattern_not(list);
-	p = *list;
-	if (p && p->token == GREP_AND) {
-		if (!p->next)
-			die("--and not followed by pattern expression");
-		*list = p->next;
-		y = compile_pattern_and(list);
-		if (!y)
-			die("--and not followed by pattern expression");
-		z = xcalloc(1, sizeof (struct grep_expr));
-		z->node = GREP_NODE_AND;
-		z->u.binary.left = x;
-		z->u.binary.right = y;
-		return z;
-	}
-	return x;
-}
-
-static struct grep_expr *compile_pattern_or(struct grep_pat **list)
-{
-	struct grep_pat *p;
-	struct grep_expr *x, *y, *z;
-
-	x = compile_pattern_and(list);
-	p = *list;
-	if (x && p && p->token != GREP_CLOSE_PAREN) {
-		y = compile_pattern_or(list);
-		if (!y)
-			die("not a pattern expression %s", p->pattern);
-		z = xcalloc(1, sizeof (struct grep_expr));
-		z->node = GREP_NODE_OR;
-		z->u.binary.left = x;
-		z->u.binary.right = y;
-		return z;
-	}
-	return x;
-}
-
-static struct grep_expr *compile_pattern_expr(struct grep_pat **list)
-{
-	return compile_pattern_or(list);
-}
-
-static void compile_patterns(struct grep_opt *opt)
-{
-	struct grep_pat *p;
-
-	/* First compile regexps */
-	for (p = opt->pattern_list; p; p = p->next) {
-		if (p->token == GREP_PATTERN)
-			compile_regexp(p, opt);
-		else
-			opt->extended = 1;
-	}
-
-	if (!opt->extended)
-		return;
-
-	/* Then bundle them up in an expression.
-	 * A classic recursive descent parser would do.
-	 */
-	p = opt->pattern_list;
-	opt->pattern_expression = compile_pattern_expr(&p);
-	if (p)
-		die("incomplete pattern expression: %s", p->pattern);
-}
-
-static char *end_of_line(char *cp, unsigned long *left)
-{
-	unsigned long l = *left;
-	while (l && *cp != '\n') {
-		l--;
-		cp++;
-	}
-	*left = l;
-	return cp;
-}
-
-static int word_char(char ch)
-{
-	return isalnum(ch) || ch == '_';
-}
-
-static void show_line(struct grep_opt *opt, const char *bol, const char *eol,
-		      const char *name, unsigned lno, char sign)
-{
-	if (opt->pathname)
-		printf("%s%c", name, sign);
-	if (opt->linenum)
-		printf("%d%c", lno, sign);
-	printf("%.*s\n", (int)(eol-bol), bol);
-}
-
-/*
- * NEEDSWORK: share code with diff.c
- */
-#define FIRST_FEW_BYTES 8000
-static int buffer_is_binary(const char *ptr, unsigned long size)
-{
-	if (FIRST_FEW_BYTES < size)
-		size = FIRST_FEW_BYTES;
-	return !!memchr(ptr, 0, size);
-}
-
-static int fixmatch(const char *pattern, char *line, regmatch_t *match)
-{
-	char *hit = strstr(line, pattern);
-	if (!hit) {
-		match->rm_so = match->rm_eo = -1;
-		return REG_NOMATCH;
-	}
-	else {
-		match->rm_so = hit - line;
-		match->rm_eo = match->rm_so + strlen(pattern);
-		return 0;
-	}
-}
-
-static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol, char *eol)
-{
-	int hit = 0;
-	int at_true_bol = 1;
-	regmatch_t pmatch[10];
-
- again:
-	if (!opt->fixed) {
-		regex_t *exp = &p->regexp;
-		hit = !regexec(exp, bol, ARRAY_SIZE(pmatch),
-			       pmatch, 0);
-	}
-	else {
-		hit = !fixmatch(p->pattern, bol, pmatch);
-	}
-
-	if (hit && opt->word_regexp) {
-		if ((pmatch[0].rm_so < 0) ||
-		    (eol - bol) <= pmatch[0].rm_so ||
-		    (pmatch[0].rm_eo < 0) ||
-		    (eol - bol) < pmatch[0].rm_eo)
-			die("regexp returned nonsense");
-
-		/* Match beginning must be either beginning of the
-		 * line, or at word boundary (i.e. the last char must
-		 * not be a word char).  Similarly, match end must be
-		 * either end of the line, or at word boundary
-		 * (i.e. the next char must not be a word char).
-		 */
-		if ( ((pmatch[0].rm_so == 0 && at_true_bol) ||
-		      !word_char(bol[pmatch[0].rm_so-1])) &&
-		     ((pmatch[0].rm_eo == (eol-bol)) ||
-		      !word_char(bol[pmatch[0].rm_eo])) )
-			;
-		else
-			hit = 0;
-
-		if (!hit && pmatch[0].rm_so + bol + 1 < eol) {
-			/* There could be more than one match on the
-			 * line, and the first match might not be
-			 * strict word match.  But later ones could be!
-			 */
-			bol = pmatch[0].rm_so + bol + 1;
-			at_true_bol = 0;
-			goto again;
-		}
-	}
-	return hit;
-}
-
-static int match_expr_eval(struct grep_opt *opt,
-			   struct grep_expr *x,
-			   char *bol, char *eol)
-{
-	switch (x->node) {
-	case GREP_NODE_ATOM:
-		return match_one_pattern(opt, x->u.atom, bol, eol);
-		break;
-	case GREP_NODE_NOT:
-		return !match_expr_eval(opt, x->u.unary, bol, eol);
-	case GREP_NODE_AND:
-		return (match_expr_eval(opt, x->u.binary.left, bol, eol) &&
-			match_expr_eval(opt, x->u.binary.right, bol, eol));
-	case GREP_NODE_OR:
-		return (match_expr_eval(opt, x->u.binary.left, bol, eol) ||
-			match_expr_eval(opt, x->u.binary.right, bol, eol));
-	}
-	die("Unexpected node type (internal error) %d\n", x->node);
-}
-
-static int match_expr(struct grep_opt *opt, char *bol, char *eol)
-{
-	struct grep_expr *x = opt->pattern_expression;
-	return match_expr_eval(opt, x, bol, eol);
-}
-
-static int match_line(struct grep_opt *opt, char *bol, char *eol)
-{
-	struct grep_pat *p;
-	if (opt->extended)
-		return match_expr(opt, bol, eol);
-	for (p = opt->pattern_list; p; p = p->next) {
-		if (match_one_pattern(opt, p, bol, eol))
-			return 1;
-	}
-	return 0;
-}
-
-static int grep_buffer(struct grep_opt *opt, const char *name,
-		       char *buf, unsigned long size)
-{
-	char *bol = buf;
-	unsigned long left = size;
-	unsigned lno = 1;
-	struct pre_context_line {
-		char *bol;
-		char *eol;
-	} *prev = NULL, *pcl;
-	unsigned last_hit = 0;
-	unsigned last_shown = 0;
-	int binary_match_only = 0;
-	const char *hunk_mark = "";
-	unsigned count = 0;
-
-	if (buffer_is_binary(buf, size)) {
-		switch (opt->binary) {
-		case GREP_BINARY_DEFAULT:
-			binary_match_only = 1;
-			break;
-		case GREP_BINARY_NOMATCH:
-			return 0; /* Assume unmatch */
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (opt->pre_context)
-		prev = xcalloc(opt->pre_context, sizeof(*prev));
-	if (opt->pre_context || opt->post_context)
-		hunk_mark = "--\n";
-
-	while (left) {
-		char *eol, ch;
-		int hit = 0;
-
-		eol = end_of_line(bol, &left);
-		ch = *eol;
-		*eol = 0;
-
-		hit = match_line(opt, bol, eol);
-
-		/* "grep -v -e foo -e bla" should list lines
-		 * that do not have either, so inversion should
-		 * be done outside.
-		 */
-		if (opt->invert)
-			hit = !hit;
-		if (opt->unmatch_name_only) {
-			if (hit)
-				return 0;
-			goto next_line;
-		}
-		if (hit) {
-			count++;
-			if (binary_match_only) {
-				printf("Binary file %s matches\n", name);
-				return 1;
-			}
-			if (opt->name_only) {
-				printf("%s\n", name);
-				return 1;
-			}
-			/* Hit at this line.  If we haven't shown the
-			 * pre-context lines, we would need to show them.
-			 * When asked to do "count", this still show
-			 * the context which is nonsense, but the user
-			 * deserves to get that ;-).
-			 */
-			if (opt->pre_context) {
-				unsigned from;
-				if (opt->pre_context < lno)
-					from = lno - opt->pre_context;
-				else
-					from = 1;
-				if (from <= last_shown)
-					from = last_shown + 1;
-				if (last_shown && from != last_shown + 1)
-					printf(hunk_mark);
-				while (from < lno) {
-					pcl = &prev[lno-from-1];
-					show_line(opt, pcl->bol, pcl->eol,
-						  name, from, '-');
-					from++;
-				}
-				last_shown = lno-1;
-			}
-			if (last_shown && lno != last_shown + 1)
-				printf(hunk_mark);
-			if (!opt->count)
-				show_line(opt, bol, eol, name, lno, ':');
-			last_shown = last_hit = lno;
-		}
-		else if (last_hit &&
-			 lno <= last_hit + opt->post_context) {
-			/* If the last hit is within the post context,
-			 * we need to show this line.
-			 */
-			if (last_shown && lno != last_shown + 1)
-				printf(hunk_mark);
-			show_line(opt, bol, eol, name, lno, '-');
-			last_shown = lno;
-		}
-		if (opt->pre_context) {
-			memmove(prev+1, prev,
-				(opt->pre_context-1) * sizeof(*prev));
-			prev->bol = bol;
-			prev->eol = eol;
-		}
-
-	next_line:
-		*eol = ch;
-		bol = eol + 1;
-		if (!left)
-			break;
-		left--;
-		lno++;
-	}
-
-	if (opt->unmatch_name_only) {
-		/* We did not see any hit, so we want to show this */
-		printf("%s\n", name);
-		return 1;
-	}
-
-	/* NEEDSWORK:
-	 * The real "grep -c foo *.c" gives many "bar.c:0" lines,
-	 * which feels mostly useless but sometimes useful.  Maybe
-	 * make it another option?  For now suppress them.
-	 */
-	if (opt->count && count)
-		printf("%s:%u\n", name, count);
-	return !!last_hit;
-}
-
 static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char *name, int tree_name_len)
 {
 	unsigned long size;
@@ -1055,8 +564,9 @@ int cmd_grep(int argc, const char **argv
 				/* ignore empty line like grep does */
 				if (!buf[0])
 					continue;
-				add_pattern(&opt, xstrdup(buf), argv[1], ++lno,
-					    GREP_PATTERN);
+				append_grep_pattern(&opt, xstrdup(buf),
+						    argv[1], ++lno,
+						    GREP_PATTERN);
 			}
 			fclose(patterns);
 			argv++;
@@ -1064,27 +574,32 @@ int cmd_grep(int argc, const char **argv
 			continue;
 		}
 		if (!strcmp("--not", arg)) {
-			add_pattern(&opt, arg, "command line", 0, GREP_NOT);
+			append_grep_pattern(&opt, arg, "command line", 0,
+					    GREP_NOT);
 			continue;
 		}
 		if (!strcmp("--and", arg)) {
-			add_pattern(&opt, arg, "command line", 0, GREP_AND);
+			append_grep_pattern(&opt, arg, "command line", 0,
+					    GREP_AND);
 			continue;
 		}
 		if (!strcmp("--or", arg))
 			continue; /* no-op */
 		if (!strcmp("(", arg)) {
-			add_pattern(&opt, arg, "command line", 0, GREP_OPEN_PAREN);
+			append_grep_pattern(&opt, arg, "command line", 0,
+					    GREP_OPEN_PAREN);
 			continue;
 		}
 		if (!strcmp(")", arg)) {
-			add_pattern(&opt, arg, "command line", 0, GREP_CLOSE_PAREN);
+			append_grep_pattern(&opt, arg, "command line", 0,
+					    GREP_CLOSE_PAREN);
 			continue;
 		}
 		if (!strcmp("-e", arg)) {
 			if (1 < argc) {
-				add_pattern(&opt, argv[1], "-e option", 0,
-					    GREP_PATTERN);
+				append_grep_pattern(&opt, argv[1],
+						    "-e option", 0,
+						    GREP_PATTERN);
 				argv++;
 				argc--;
 				continue;
@@ -1106,8 +621,8 @@ int cmd_grep(int argc, const char **argv
 
 		/* First unrecognized non-option token */
 		if (!opt.pattern_list) {
-			add_pattern(&opt, arg, "command line", 0,
-				    GREP_PATTERN);
+			append_grep_pattern(&opt, arg, "command line", 0,
+					    GREP_PATTERN);
 			break;
 		}
 		else {
@@ -1124,8 +639,7 @@ int cmd_grep(int argc, const char **argv
 		die("no pattern given.");
 	if ((opt.regflags != REG_NEWLINE) && opt.fixed)
 		die("cannot mix --fixed-strings and regexp");
-	if (!opt.fixed)
-		compile_patterns(&opt);
+	compile_grep_patterns(&opt);
 
 	/* Check revs and then paths */
 	for (i = 1; i < argc; i++) {
diff --git a/grep.c b/grep.c
new file mode 100644
index 0000000..61db6e1
--- /dev/null
+++ b/grep.c
@@ -0,0 +1,440 @@
+#include "cache.h"
+#include <regex.h>
+#include "grep.h"
+
+void append_grep_pattern(struct grep_opt *opt, const char *pat,
+			 const char *origin, int no, enum grep_pat_token t)
+{
+	struct grep_pat *p = xcalloc(1, sizeof(*p));
+	p->pattern = pat;
+	p->origin = origin;
+	p->no = no;
+	p->token = t;
+	*opt->pattern_tail = p;
+	opt->pattern_tail = &p->next;
+	p->next = NULL;
+}
+
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
+static struct grep_expr *compile_pattern_expr(struct grep_pat **);
+static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
+{
+	struct grep_pat *p;
+	struct grep_expr *x;
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
+	return compile_pattern_or(list);
+}
+
+void compile_grep_patterns(struct grep_opt *opt)
+{
+	struct grep_pat *p;
+
+	if (opt->fixed)
+		return;
+
+	/* First compile regexps */
+	for (p = opt->pattern_list; p; p = p->next) {
+		if (p->token == GREP_PATTERN)
+			compile_regexp(p, opt);
+		else
+			opt->extended = 1;
+	}
+
+	if (!opt->extended)
+		return;
+
+	/* Then bundle them up in an expression.
+	 * A classic recursive descent parser would do.
+	 */
+	p = opt->pattern_list;
+	opt->pattern_expression = compile_pattern_expr(&p);
+	if (p)
+		die("incomplete pattern expression: %s", p->pattern);
+}
+
+static char *end_of_line(char *cp, unsigned long *left)
+{
+	unsigned long l = *left;
+	while (l && *cp != '\n') {
+		l--;
+		cp++;
+	}
+	*left = l;
+	return cp;
+}
+
+static int word_char(char ch)
+{
+	return isalnum(ch) || ch == '_';
+}
+
+static void show_line(struct grep_opt *opt, const char *bol, const char *eol,
+		      const char *name, unsigned lno, char sign)
+{
+	if (opt->pathname)
+		printf("%s%c", name, sign);
+	if (opt->linenum)
+		printf("%d%c", lno, sign);
+	printf("%.*s\n", (int)(eol-bol), bol);
+}
+
+/*
+ * NEEDSWORK: share code with diff.c
+ */
+#define FIRST_FEW_BYTES 8000
+static int buffer_is_binary(const char *ptr, unsigned long size)
+{
+	if (FIRST_FEW_BYTES < size)
+		size = FIRST_FEW_BYTES;
+	return !!memchr(ptr, 0, size);
+}
+
+static int fixmatch(const char *pattern, char *line, regmatch_t *match)
+{
+	char *hit = strstr(line, pattern);
+	if (!hit) {
+		match->rm_so = match->rm_eo = -1;
+		return REG_NOMATCH;
+	}
+	else {
+		match->rm_so = hit - line;
+		match->rm_eo = match->rm_so + strlen(pattern);
+		return 0;
+	}
+}
+
+static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol, char *eol)
+{
+	int hit = 0;
+	int at_true_bol = 1;
+	regmatch_t pmatch[10];
+
+ again:
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
+		if ((pmatch[0].rm_so < 0) ||
+		    (eol - bol) <= pmatch[0].rm_so ||
+		    (pmatch[0].rm_eo < 0) ||
+		    (eol - bol) < pmatch[0].rm_eo)
+			die("regexp returned nonsense");
+
+		/* Match beginning must be either beginning of the
+		 * line, or at word boundary (i.e. the last char must
+		 * not be a word char).  Similarly, match end must be
+		 * either end of the line, or at word boundary
+		 * (i.e. the next char must not be a word char).
+		 */
+		if ( ((pmatch[0].rm_so == 0 && at_true_bol) ||
+		      !word_char(bol[pmatch[0].rm_so-1])) &&
+		     ((pmatch[0].rm_eo == (eol-bol)) ||
+		      !word_char(bol[pmatch[0].rm_eo])) )
+			;
+		else
+			hit = 0;
+
+		if (!hit && pmatch[0].rm_so + bol + 1 < eol) {
+			/* There could be more than one match on the
+			 * line, and the first match might not be
+			 * strict word match.  But later ones could be!
+			 */
+			bol = pmatch[0].rm_so + bol + 1;
+			at_true_bol = 0;
+			goto again;
+		}
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
+int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size)
+{
+	char *bol = buf;
+	unsigned long left = size;
+	unsigned lno = 1;
+	struct pre_context_line {
+		char *bol;
+		char *eol;
+	} *prev = NULL, *pcl;
+	unsigned last_hit = 0;
+	unsigned last_shown = 0;
+	int binary_match_only = 0;
+	const char *hunk_mark = "";
+	unsigned count = 0;
+
+	if (buffer_is_binary(buf, size)) {
+		switch (opt->binary) {
+		case GREP_BINARY_DEFAULT:
+			binary_match_only = 1;
+			break;
+		case GREP_BINARY_NOMATCH:
+			return 0; /* Assume unmatch */
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (opt->pre_context)
+		prev = xcalloc(opt->pre_context, sizeof(*prev));
+	if (opt->pre_context || opt->post_context)
+		hunk_mark = "--\n";
+
+	while (left) {
+		char *eol, ch;
+		int hit = 0;
+
+		eol = end_of_line(bol, &left);
+		ch = *eol;
+		*eol = 0;
+
+		hit = match_line(opt, bol, eol);
+		*eol = ch;
+
+		/* "grep -v -e foo -e bla" should list lines
+		 * that do not have either, so inversion should
+		 * be done outside.
+		 */
+		if (opt->invert)
+			hit = !hit;
+		if (opt->unmatch_name_only) {
+			if (hit)
+				return 0;
+			goto next_line;
+		}
+		if (hit) {
+			count++;
+			if (opt->status_only)
+				return 1;
+			if (binary_match_only) {
+				printf("Binary file %s matches\n", name);
+				return 1;
+			}
+			if (opt->name_only) {
+				printf("%s\n", name);
+				return 1;
+			}
+			/* Hit at this line.  If we haven't shown the
+			 * pre-context lines, we would need to show them.
+			 * When asked to do "count", this still show
+			 * the context which is nonsense, but the user
+			 * deserves to get that ;-).
+			 */
+			if (opt->pre_context) {
+				unsigned from;
+				if (opt->pre_context < lno)
+					from = lno - opt->pre_context;
+				else
+					from = 1;
+				if (from <= last_shown)
+					from = last_shown + 1;
+				if (last_shown && from != last_shown + 1)
+					printf(hunk_mark);
+				while (from < lno) {
+					pcl = &prev[lno-from-1];
+					show_line(opt, pcl->bol, pcl->eol,
+						  name, from, '-');
+					from++;
+				}
+				last_shown = lno-1;
+			}
+			if (last_shown && lno != last_shown + 1)
+				printf(hunk_mark);
+			if (!opt->count)
+				show_line(opt, bol, eol, name, lno, ':');
+			last_shown = last_hit = lno;
+		}
+		else if (last_hit &&
+			 lno <= last_hit + opt->post_context) {
+			/* If the last hit is within the post context,
+			 * we need to show this line.
+			 */
+			if (last_shown && lno != last_shown + 1)
+				printf(hunk_mark);
+			show_line(opt, bol, eol, name, lno, '-');
+			last_shown = lno;
+		}
+		if (opt->pre_context) {
+			memmove(prev+1, prev,
+				(opt->pre_context-1) * sizeof(*prev));
+			prev->bol = bol;
+			prev->eol = eol;
+		}
+
+	next_line:
+		bol = eol + 1;
+		if (!left)
+			break;
+		left--;
+		lno++;
+	}
+
+	if (opt->status_only)
+		return 0;
+	if (opt->unmatch_name_only) {
+		/* We did not see any hit, so we want to show this */
+		printf("%s\n", name);
+		return 1;
+	}
+
+	/* NEEDSWORK:
+	 * The real "grep -c foo *.c" gives many "bar.c:0" lines,
+	 * which feels mostly useless but sometimes useful.  Maybe
+	 * make it another option?  For now suppress them.
+	 */
+	if (opt->count && count)
+		printf("%s:%u\n", name, count);
+	return !!last_hit;
+}
+
diff --git a/grep.h b/grep.h
new file mode 100644
index 0000000..80122b0
--- /dev/null
+++ b/grep.h
@@ -0,0 +1,71 @@
+#ifndef GREP_H
+#define GREP_H
+
+enum grep_pat_token {
+	GREP_PATTERN,
+	GREP_AND,
+	GREP_OPEN_PAREN,
+	GREP_CLOSE_PAREN,
+	GREP_NOT,
+	GREP_OR,
+};
+
+struct grep_pat {
+	struct grep_pat *next;
+	const char *origin;
+	int no;
+	enum grep_pat_token token;
+	const char *pattern;
+	regex_t regexp;
+};
+
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
+struct grep_opt {
+	struct grep_pat *pattern_list;
+	struct grep_pat **pattern_tail;
+	struct grep_expr *pattern_expression;
+	int prefix_length;
+	regex_t regexp;
+	unsigned linenum:1;
+	unsigned invert:1;
+	unsigned status_only:1;
+	unsigned name_only:1;
+	unsigned unmatch_name_only:1;
+	unsigned count:1;
+	unsigned word_regexp:1;
+	unsigned fixed:1;
+#define GREP_BINARY_DEFAULT	0
+#define GREP_BINARY_NOMATCH	1
+#define GREP_BINARY_TEXT	2
+	unsigned binary:2;
+	unsigned extended:1;
+	unsigned relative:1;
+	unsigned pathname:1;
+	int regflags;
+	unsigned pre_context;
+	unsigned post_context;
+};
+
+extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
+extern void compile_grep_patterns(struct grep_opt *opt);
+extern int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size);
+
+#endif
-- 
1.4.2.1.g414e5
