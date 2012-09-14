From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 01/11] grep: teach --debug option to dump the parse tree
Date: Fri, 14 Sep 2012 11:46:33 +0200
Message-ID: <eb5e7055691692e8a60adf8edbb3b8d2aab9d02b.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:46:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUC-0006vD-N2
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583Ab2INJqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:46:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60804 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753518Ab2INJqr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:46:47 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5B6D42087E;
	Fri, 14 Sep 2012 05:46:47 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 14 Sep 2012 05:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Th
	xFvodZFlTpF+zaM/D83xkeTTg=; b=guhKL0mKUgcDYYRGKJ9VJMWCkXtF/LmKmC
	20FIzT42G3M1EcIuovDqvDEer/KBEWA2cbVmk7+R890TBV9U31ZXYE/Uk7eLxj4K
	gFoewzsNNiRwLjTua1LRVIMQeA0ZgLu//2hn2KIZGHTiXeah7nNWHpG77h/ZyOcm
	5WGO1nzlE=
X-Sasl-enc: YY/ZpA2qoJR/GXENNzUdzabfWfzUjxwfFhMc0tBN4QNc 1347616006
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CE8AB8E0175;
	Fri, 14 Sep 2012 05:46:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <cover.1347615361.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205466>

From: Junio C Hamano <gitster@pobox.com>

Our "grep" allows complex boolean expressions to be formed to match
each individual line with operators like --and, '(', ')' and --not.
Introduce the "--debug" option to show the parse tree to help people
who want to debug and enhance it.

Also "log" learns "--debug-grep" option to do the same.  The command
line parser to the log family is a lot more limited than the general
"git grep" parser, but it has special handling for header matching
(e.g. "--author"), and a parse tree is valuable when working on it.

Note that "--all-match" is *not* any individual node in the parse
tree.  It is an instruction to the evaluator to check all the nodes
in the top-level backbone have matched and reject a document as
non-matching otherwise.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/grep.c |  3 ++
 grep.c         | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 grep.h         |  1 +
 revision.c     |  2 ++
 4 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index fe1726f..8aea00c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -772,6 +772,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			   "indicate hit with exit status without output"),
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
+		{ OPTION_SET_INT, 0, "debug", &opt.debug, NULL,
+		  "show parse tree for grep expression",
+		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1 },
 		OPT_GROUP(""),
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
 			"pager", "show matching files in the pager",
diff --git a/grep.c b/grep.c
index 04e3ec6..be15c47 100644
--- a/grep.c
+++ b/grep.c
@@ -332,6 +332,87 @@ static struct grep_expr *compile_pattern_expr(struct grep_pat **list)
 	return compile_pattern_or(list);
 }
 
+static void indent(int in)
+{
+	while (in-- > 0)
+		fputc(' ', stderr);
+}
+
+static void dump_grep_pat(struct grep_pat *p)
+{
+	switch (p->token) {
+	case GREP_AND: fprintf(stderr, "*and*"); break;
+	case GREP_OPEN_PAREN: fprintf(stderr, "*(*"); break;
+	case GREP_CLOSE_PAREN: fprintf(stderr, "*)*"); break;
+	case GREP_NOT: fprintf(stderr, "*not*"); break;
+	case GREP_OR: fprintf(stderr, "*or*"); break;
+
+	case GREP_PATTERN: fprintf(stderr, "pattern"); break;
+	case GREP_PATTERN_HEAD: fprintf(stderr, "pattern_head"); break;
+	case GREP_PATTERN_BODY: fprintf(stderr, "pattern_body"); break;
+	}
+
+	switch (p->token) {
+	default: break;
+	case GREP_PATTERN_HEAD:
+		fprintf(stderr, "<head %d>", p->field); break;
+	case GREP_PATTERN_BODY:
+		fprintf(stderr, "<body>"); break;
+	}
+	switch (p->token) {
+	default: break;
+	case GREP_PATTERN_HEAD:
+	case GREP_PATTERN_BODY:
+	case GREP_PATTERN:
+		fprintf(stderr, "%.*s", (int)p->patternlen, p->pattern);
+		break;
+	}
+	fputc('\n', stderr);
+}
+
+static void dump_grep_expression_1(struct grep_expr *x, int in)
+{
+	indent(in);
+	switch (x->node) {
+	case GREP_NODE_TRUE:
+		fprintf(stderr, "true\n");
+		break;
+	case GREP_NODE_ATOM:
+		dump_grep_pat(x->u.atom);
+		break;
+	case GREP_NODE_NOT:
+		fprintf(stderr, "(not\n");
+		dump_grep_expression_1(x->u.unary, in+1);
+		indent(in);
+		fprintf(stderr, ")\n");
+		break;
+	case GREP_NODE_AND:
+		fprintf(stderr, "(and\n");
+		dump_grep_expression_1(x->u.binary.left, in+1);
+		dump_grep_expression_1(x->u.binary.right, in+1);
+		indent(in);
+		fprintf(stderr, ")\n");
+		break;
+	case GREP_NODE_OR:
+		fprintf(stderr, "(or\n");
+		dump_grep_expression_1(x->u.binary.left, in+1);
+		dump_grep_expression_1(x->u.binary.right, in+1);
+		indent(in);
+		fprintf(stderr, ")\n");
+		break;
+	}
+}
+
+void dump_grep_expression(struct grep_opt *opt)
+{
+	struct grep_expr *x = opt->pattern_expression;
+
+	if (opt->all_match)
+		fprintf(stderr, "[all-match]\n");
+	dump_grep_expression_1(x, 0);
+	fflush(NULL);
+}
+
 static struct grep_expr *grep_true_expr(void)
 {
 	struct grep_expr *z = xcalloc(1, sizeof(*z));
@@ -395,7 +476,7 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 	return header_expr;
 }
 
-void compile_grep_patterns(struct grep_opt *opt)
+static void compile_grep_patterns_real(struct grep_opt *opt)
 {
 	struct grep_pat *p;
 	struct grep_expr *header_expr = prep_header_patterns(opt);
@@ -415,7 +496,7 @@ void compile_grep_patterns(struct grep_opt *opt)
 
 	if (opt->all_match || header_expr)
 		opt->extended = 1;
-	else if (!opt->extended)
+	else if (!opt->extended && !opt->debug)
 		return;
 
 	p = opt->pattern_list;
@@ -435,6 +516,13 @@ void compile_grep_patterns(struct grep_opt *opt)
 	opt->all_match = 1;
 }
 
+void compile_grep_patterns(struct grep_opt *opt)
+{
+	compile_grep_patterns_real(opt);
+	if (opt->debug)
+		dump_grep_expression(opt);
+}
+
 static void free_pattern_expr(struct grep_expr *x)
 {
 	switch (x->node) {
diff --git a/grep.h b/grep.h
index ed7de6b..bf5be5a 100644
--- a/grep.h
+++ b/grep.h
@@ -90,6 +90,7 @@ struct grep_opt {
 	int word_regexp;
 	int fixed;
 	int all_match;
+	int debug;
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
diff --git a/revision.c b/revision.c
index 9a0d9c7..90376e8 100644
--- a/revision.c
+++ b/revision.c
@@ -1578,6 +1578,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("grep", argv, &optarg))) {
 		add_message_grep(revs, optarg);
 		return argcount;
+	} else if (!strcmp(arg, "--grep-debug")) {
+		revs->grep_filter.debug = 1;
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
 		revs->grep_filter.regflags |= REG_EXTENDED;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
-- 
1.7.12.592.g41e7905
