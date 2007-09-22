From: Bart Trojanowski <bart@jukie.net>
Subject: [RFC] Add git-rev-list --not-(author|committer|grep)!=pattern
Date: Fri, 21 Sep 2007 21:38:34 -0400
Message-ID: <20070922013834.GU12076@jukie.net>
References: <20070919202615.GK3076@jukie.net> <Pine.LNX.4.64.0709201132381.28395@racer.site> <20070920123849.GD12076@jukie.net> <Pine.LNX.4.64.0709201403540.28395@racer.site> <7vtzppj9d1.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709202252570.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 22 03:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYtxP-0004ni-Jx
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 03:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbXIVBip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 21:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbXIVBip
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 21:38:45 -0400
Received: from tachyon.jukie.net ([205.150.199.214]:58379 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754888AbXIVBio convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2007 21:38:44 -0400
Received: from tau.jukie.net ([10.10.10.211]:39688)
	by jukie.net with esmtp (Exim 4.50)
	id 1IYtx5-0003vH-DN; Fri, 21 Sep 2007 21:38:35 -0400
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 0C83FA777E9; Fri, 21 Sep 2007 21:38:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709202252570.28395@racer.site>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58909>

Hi Johannes, Junio,

I have worked out what I would like to see for git-log and friends.  It
addresses one of the requirements which was raised by Johannes.

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [070920 06:34]:
> IMHO this is only half a solution.  Some of us want to say "git log 
> --grep=this --but-not-(in-the-whole-message) --grep=that".

The way in which you get that information is:

        git-log --all-match \
                --grep=Merge \
                --not-committer=gitster \
                --author!=Shawn

I have tested it with and without --all-match and seems to work as I
would expect.  git-grep -v is still broken, but I will submit that in
another patch.

I plan on removing opt->invert_final_result unless you guys thing it can
be used for something else.

This is my first crack at it, and I would like to get some feedback on
the direction I've taken.  I plan on adding test cases before I submit
the final patch.

Thanks for reviewing.

-Bart

   ----8<----

>From e584ed4399e24bcd21991d1a9edc5e33f22a4f0c Mon Sep 17 00:00:00 2001
From: Bart Trojanowski <bart@jukie.net>
Date: Fri, 21 Sep 2007 11:24:37 -0400
Subject: [PATCH] Add git-rev-list --not-(author|committer|grep)!=pattern

This patch adds the concept of negative grep patterns, which only
generate a grepping hit when the pattern did not match any lines
in the whole file (or buffer).

This makes it possible to run

        git-rev-list --grep=foo --not-committer=bar
        git-rev-list --all-match --grep=foo --not-author=bar

As with regular git-rev-list filtering, the default is an inclusive
filter.  So the first line matches those revisions that either have
foo in the message, or do not have bar as the comitter.  The second
form locates all revisions that contain foo in the message, but not
bar as the author.

The --not-* options have short forms:

        git-rev-list --grep!=bar
        git-rev-list --committer!=bar
        git-rev-list --author!=bar

...which is provided by a invertible_prefix_cmp() util function which
could be used for other --not-*=<arg> options in the future.

Signed-off-by: Bart Trojanowski <bart@jukie.net>
---
 Documentation/git-rev-list.txt |   20 ++++++++++++
 builtin-grep.c                 |   16 +++++-----
 git-compat-util.h              |   42 +++++++++++++++++++++++++
 grep.c                         |   65 +++++++++++++++++++++++++++++++++++----
 grep.h                         |   10 +++++-
 revision.c                     |   36 +++++++++++++++-------
 6 files changed, 160 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 7cd0e89..326495d 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -27,6 +27,8 @@ SYNOPSIS
 	     [ \--cherry-pick ]
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
+	     [ \--not-(author|committer|grep)=<pattern> ]
+	     [ \--all-match ]
 	     [ \--regexp-ignore-case | \-i ]
 	     [ \--extended-regexp | \-E ]
 	     [ \--date={local|relative|default|iso|rfc|short} ]
@@ -229,6 +231,18 @@ limiting may be applied.
 	Limit the commits output to ones with log message that
 	matches the specified pattern (regular expression).
 
+--not-author='pattern', --not-committer='pattern', --not-grep='pattern'::
+
+	When filtering the commits based on log message (`--not-grep`)
+	or people (`--not-author` and `--not-committer`), show commits that
+	do not match the criteria specified.
+
+--all-match::
+
+	Display commits which match all criteria; default is to show
+	commits that match at least one of `--grep`, `--committer`, and
+	`--author`.
+
 -i, --regexp-ignore-case::
 
 	Match the regexp limiting patterns without regard to letters case.
@@ -238,6 +252,12 @@ limiting may be applied.
 	Consider the limiting patterns to be extended regular expressions
 	instead of the default basic regular expressions.
 
+--invert-match::
+
+	When filtering the commits based on log message (`--grep`) or people
+	(`--author` and `--committer`), show commits that do not match the
+	criteria.
+
 --remove-empty::
 
 	Stop when a given path disappears from the tree.
diff --git a/builtin-grep.c b/builtin-grep.c
index c7b45c4..90bc6f8 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -547,7 +547,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp("-v", arg) ||
 		    !strcmp("--invert-match", arg)) {
-			opt.invert = 1;
+			opt.invert_line_match = 1;
 			continue;
 		}
 		if (!strcmp("-E", arg) ||
@@ -651,7 +651,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 					continue;
 				append_grep_pattern(&opt, xstrdup(buf),
 						    argv[1], ++lno,
-						    GREP_PATTERN);
+						    GREP_PATTERN, 0);
 			}
 			fclose(patterns);
 			argv++;
@@ -660,24 +660,24 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp("--not", arg)) {
 			append_grep_pattern(&opt, arg, "command line", 0,
-					    GREP_NOT);
+					    GREP_NOT, 0);
 			continue;
 		}
 		if (!strcmp("--and", arg)) {
 			append_grep_pattern(&opt, arg, "command line", 0,
-					    GREP_AND);
+					    GREP_AND, 0);
 			continue;
 		}
 		if (!strcmp("--or", arg))
 			continue; /* no-op */
 		if (!strcmp("(", arg)) {
 			append_grep_pattern(&opt, arg, "command line", 0,
-					    GREP_OPEN_PAREN);
+					    GREP_OPEN_PAREN, 0);
 			continue;
 		}
 		if (!strcmp(")", arg)) {
 			append_grep_pattern(&opt, arg, "command line", 0,
-					    GREP_CLOSE_PAREN);
+					    GREP_CLOSE_PAREN, 0);
 			continue;
 		}
 		if (!strcmp("--all-match", arg)) {
@@ -688,7 +688,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			if (1 < argc) {
 				append_grep_pattern(&opt, argv[1],
 						    "-e option", 0,
-						    GREP_PATTERN);
+						    GREP_PATTERN, 0);
 				argv++;
 				argc--;
 				continue;
@@ -711,7 +711,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		/* First unrecognized non-option token */
 		if (!opt.pattern_list) {
 			append_grep_pattern(&opt, arg, "command line", 0,
-					    GREP_PATTERN);
+					    GREP_PATTERN, 0);
 			break;
 		}
 		else {
diff --git a/git-compat-util.h b/git-compat-util.h
index 1bfbdeb..db1c9d4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -362,6 +362,48 @@ static inline int prefixcmp(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix));
 }
 
+static inline int invertible_prefix_cmp(const char *str, const char *prefix,
+		const char **pattern, int *inverted)
+{
+	int prefix_len = strlen(prefix);
+	int rc;
+
+	*inverted = 0;
+	*pattern = str + prefix_len;
+
+	rc = strncmp(str, prefix, prefix_len-1);
+	if (rc)
+		goto try_alternate_form;
+
+	if (prefix[prefix_len-1] != '=')
+		return strncmp(str, prefix, strlen(prefix));
+
+	if (str[prefix_len-1] == '=')
+		return 0;
+
+	if (str[prefix_len-1] != '!'
+			|| str[prefix_len] != '=')
+		return 1;
+
+	*inverted = 1;
+	(*pattern) ++;
+	return 0;
+
+try_alternate_form:
+	if (prefix[0]!='-' || prefix[1]!='-')
+		return rc;
+
+	if (strncmp (str, "--not-", 6))
+		return rc;
+
+	if (strncmp (str+6, prefix+2, prefix_len-2))
+		return rc;
+
+	*inverted = 1;
+	(*pattern) += 4;
+	return 0;
+}
+
 static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 {
 	unsigned long ul;
diff --git a/grep.c b/grep.c
index f67d671..877f0ed 100644
--- a/grep.c
+++ b/grep.c
@@ -3,12 +3,16 @@
 #include "xdiff-interface.h"
 
 void append_grep_pattern(struct grep_opt *opt, const char *pat,
-			 const char *origin, int no, enum grep_pat_token t)
+			 const char *origin, int no, enum grep_pat_token t,
+			 int is_negative)
 {
 	struct grep_pat *p = xcalloc(1, sizeof(*p));
 	p->pattern = pat;
 	p->origin = origin;
 	p->no = no;
+	p->is_negative = !!is_negative;
+	if (p->is_negative)
+		opt->extended = 1;
 	p->token = t;
 	*opt->pattern_tail = p;
 	opt->pattern_tail = &p->next;
@@ -253,10 +257,30 @@ static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol
 	int at_true_bol = 1;
 	regmatch_t pmatch[10];
 
+	if (ctx == GREP_CONTEXT_FINALIZE)
+		return p->is_negative
+			? !p->did_match
+			: p->did_match;
+
+	if (ctx == GREP_CONTEXT_INITIALIZE) {
+		p->did_match = 0;
+		return 0;
+	}
+
 	if ((p->token != GREP_PATTERN) &&
 	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)))
 		return 0;
 
+	/* Shallow searches can stop matching lines early and just reuse the
+	 * previous match result because we are only interested if there was
+	 * at least one match.  For positive matches, we return 1 because once
+	 * we match the result will always be successful; conversely, for
+	 * negative matches once the base patter was found the result will
+	 * always be 0.
+	 */
+	if (opt->shallow && p->did_match)
+		return !p->is_negative;
+
  again:
 	if (!opt->fixed) {
 		regex_t *exp = &p->regexp;
@@ -298,6 +322,15 @@ static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol
 			goto again;
 		}
 	}
+
+	if (hit)
+		p->did_match = 1;
+
+	/* a negative pattern cannot match until the very end when we know
+	 * there have been no matches on any of the lines */
+	if (p->is_negative)
+		return 0;
+
 	return hit;
 }
 
@@ -382,6 +415,10 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	unsigned count = 0;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 
+	/* Reset flags in all grep_pat objects
+	 */
+	match_line (opt, NULL, NULL, GREP_CONTEXT_INITIALIZE, collect_hits);
+
 	if (buffer_is_binary(buf, size)) {
 		switch (opt->binary) {
 		case GREP_BINARY_DEFAULT:
@@ -414,6 +451,14 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		hit = match_line(opt, bol, eol, ctx, collect_hits);
 		*eol = ch;
 
+		/* on the last line we can determine the hit of negative
+		 * patterns
+		 */
+		if (left < 2) {
+			hit = match_line (opt, NULL, NULL, GREP_CONTEXT_FINALIZE, collect_hits);
+		}
+
+
 		if (collect_hits)
 			goto next_line;
 
@@ -421,7 +466,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		 * that do not have either, so inversion should
 		 * be done outside.
 		 */
-		if (opt->invert)
+		if (opt->invert_line_match)
 			hit = !hit;
 		if (opt->unmatch_name_only) {
 			if (hit)
@@ -545,12 +590,16 @@ static int chk_hit_marker(struct grep_expr *x)
 
 int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size)
 {
+	int result;
+
 	/*
 	 * we do not have to do the two-pass grep when we do not check
 	 * buffer-wide "all-match".
 	 */
-	if (!opt->all_match)
-		return grep_buffer_1(opt, name, buf, size, 0);
+	if (!opt->all_match) {
+		result = grep_buffer_1(opt, name, buf, size, 0);
+		goto done;
+	}
 
 	/* Otherwise the toplevel "or" terms hit a bit differently.
 	 * We first clear hit markers from them.
@@ -558,8 +607,10 @@ int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long
 	clr_hit_marker(opt->pattern_expression);
 	grep_buffer_1(opt, name, buf, size, 1);
 
-	if (!chk_hit_marker(opt->pattern_expression))
-		return 0;
+	result = 0;
+	if (chk_hit_marker(opt->pattern_expression))
+		result = grep_buffer_1(opt, name, buf, size, 0);
 
-	return grep_buffer_1(opt, name, buf, size, 0);
+done:
+	return opt->invert_final_result ? !result : result;
 }
diff --git a/grep.h b/grep.h
index d252dd2..adb5b94 100644
--- a/grep.h
+++ b/grep.h
@@ -13,14 +13,18 @@ enum grep_pat_token {
 };
 
 enum grep_context {
+	GREP_CONTEXT_INITIALIZE,
 	GREP_CONTEXT_HEAD,
 	GREP_CONTEXT_BODY,
+	GREP_CONTEXT_FINALIZE,
 };
 
 struct grep_pat {
 	struct grep_pat *next;
 	const char *origin;
 	int no;
+	unsigned is_negative:1;
+	unsigned did_match:1;
 	enum grep_pat_token token;
 	const char *pattern;
 	regex_t regexp;
@@ -53,8 +57,10 @@ struct grep_opt {
 	int prefix_length;
 	regex_t regexp;
 	unsigned linenum:1;
-	unsigned invert:1;
+	unsigned invert_line_match:1;
+	unsigned invert_final_result:1;
 	unsigned status_only:1;
+	unsigned shallow:1;		// stop testing patterns after hit
 	unsigned name_only:1;
 	unsigned unmatch_name_only:1;
 	unsigned count:1;
@@ -73,7 +79,7 @@ struct grep_opt {
 	unsigned post_context;
 };
 
-extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
+extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t, int is_negative);
 extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
 extern int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size);
diff --git a/revision.c b/revision.c
index 33d092c..721ef52 100644
--- a/revision.c
+++ b/revision.c
@@ -827,20 +827,23 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	return 0;
 }
 
-static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
+static void add_grep(struct rev_info *revs, const char *ptn, int is_negative,
+		enum grep_pat_token what)
 {
 	if (!revs->grep_filter) {
 		struct grep_opt *opt = xcalloc(1, sizeof(*opt));
 		opt->status_only = 1;
+		opt->shallow = 1;
 		opt->pattern_tail = &(opt->pattern_list);
 		opt->regflags = REG_NEWLINE;
 		revs->grep_filter = opt;
 	}
 	append_grep_pattern(revs->grep_filter, ptn,
-			    "command line", 0, what);
+			    "command line", 0, what, is_negative);
 }
 
-static void add_header_grep(struct rev_info *revs, const char *field, const char *pattern)
+static void add_header_grep(struct rev_info *revs, const char *field,
+		const char *pattern, int is_negative)
 {
 	char *pat;
 	const char *prefix;
@@ -855,12 +858,13 @@ static void add_header_grep(struct rev_info *revs, const char *field, const char
 		pattern++;
 	}
 	sprintf(pat, "^%s %s%s", field, prefix, pattern);
-	add_grep(revs, pat, GREP_PATTERN_HEAD);
+	add_grep(revs, pat, is_negative, GREP_PATTERN_HEAD);
 }
 
-static void add_message_grep(struct rev_info *revs, const char *pattern)
+static void add_message_grep(struct rev_info *revs, const char *pattern,
+		int is_negative)
 {
-	add_grep(revs, pattern, GREP_PATTERN_BODY);
+	add_grep(revs, pattern, is_negative, GREP_PATTERN_BODY);
 }
 
 static void add_ignore_packed(struct rev_info *revs, const char *name)
@@ -887,6 +891,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	int left = 1;
 	int all_match = 0;
 	int regflags = 0;
+	int inverted;
+	const char *pattern;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1160,16 +1166,21 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			/*
 			 * Grepping the commit log
 			 */
-			if (!prefixcmp(arg, "--author=")) {
-				add_header_grep(revs, "author", arg+9);
+			if (!invertible_prefix_cmp(arg, "--author=",
+						&pattern, &inverted)) {
+				add_header_grep(revs, "author", pattern,
+						inverted);
 				continue;
 			}
-			if (!prefixcmp(arg, "--committer=")) {
-				add_header_grep(revs, "committer", arg+12);
+			if (!invertible_prefix_cmp(arg, "--committer=",
+						&pattern, &inverted)) {
+				add_header_grep(revs, "committer", pattern,
+						inverted);
 				continue;
 			}
-			if (!prefixcmp(arg, "--grep=")) {
-				add_message_grep(revs, arg+7);
+			if (!invertible_prefix_cmp (arg, "--grep=",
+						&pattern, &inverted)) {
+				add_message_grep(revs, pattern, inverted);
 				continue;
 			}
 			if (!strcmp(arg, "--extended-regexp") ||
@@ -1385,6 +1396,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	if (!opt->grep_filter)
 		return 1;
+
 	return grep_buffer(opt->grep_filter,
 			   NULL, /* we say nothing, not even filename */
 			   commit->buffer, strlen(commit->buffer));
-- 
1.5.3.1.154.g734e65
