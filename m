From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 8/8] grep: support NUL chars in search strings for -F
Date: Sat, 22 May 2010 23:43:43 +0200
Message-ID: <4BF8500F.70205@lsrfire.ath.cx>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <4BF84B9E.7060009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 23:44:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFwUS-0007V3-Ro
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 23:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758982Ab0EVVn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 17:43:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:52453 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758808Ab0EVVn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 17:43:57 -0400
Received: from [10.0.1.100] (p57B7F4C3.dip.t-dialin.net [87.183.244.195])
	by india601.server4you.de (Postfix) with ESMTPSA id 81C612F8069;
	Sat, 22 May 2010 23:43:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BF84B9E.7060009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147550>

Search patterns in a file specified with -f can contain NUL characters.
The current code ignores all characters on a line after a NUL.

Pass the actual length of the line all the way from the pattern file to
fixmatch() and use it for case-sensitive fixed string matching.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Support for -F was easy, but in order to be able to search for NULs
with -Fi, -G and -E, we'd need a different case-insensitive fixed
string search function (memcasemem?) and a different regex library, or
at least use a different (non-POSIX) entry point.

How badly do we need this feature?  If the new regex lib is faster or
improves multi-platform support then NUL support would be a nice side
effect, I think, but this feature alone doesn't justify a switch in my
eyes.


 builtin/grep.c         |    8 ++++++--
 grep.c                 |   33 ++++++++++++++++++++-------------
 grep.h                 |    2 ++
 t/t7008-grep-binary.sh |   30 ++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index b194ea3..d0a73da 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -724,11 +724,15 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 	if (!patterns)
 		die_errno("cannot open '%s'", arg);
 	while (strbuf_getline(&sb, patterns, '\n') == 0) {
+		char *s;
+		size_t len;
+
 		/* ignore empty line like grep does */
 		if (sb.len == 0)
 			continue;
-		append_grep_pattern(grep_opt, strbuf_detach(&sb, NULL), arg,
-				    ++lno, GREP_PATTERN);
+
+		s = strbuf_detach(&sb, &len);
+		append_grep_pat(grep_opt, s, len, arg, ++lno, GREP_PATTERN);
 	}
 	fclose(patterns);
 	strbuf_release(&sb);
diff --git a/grep.c b/grep.c
index 70a776f..82fb349 100644
--- a/grep.c
+++ b/grep.c
@@ -7,6 +7,7 @@ void append_header_grep_pattern(struct grep_opt *opt, enum grep_header_field fie
 {
 	struct grep_pat *p = xcalloc(1, sizeof(*p));
 	p->pattern = pat;
+	p->patternlen = strlen(pat);
 	p->origin = "header";
 	p->no = 0;
 	p->token = GREP_PATTERN_HEAD;
@@ -19,8 +20,15 @@ void append_header_grep_pattern(struct grep_opt *opt, enum grep_header_field fie
 void append_grep_pattern(struct grep_opt *opt, const char *pat,
 			 const char *origin, int no, enum grep_pat_token t)
 {
+	append_grep_pat(opt, pat, strlen(pat), origin, no, t);
+}
+
+void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen,
+		     const char *origin, int no, enum grep_pat_token t)
+{
 	struct grep_pat *p = xcalloc(1, sizeof(*p));
 	p->pattern = pat;
+	p->patternlen = patlen;
 	p->origin = origin;
 	p->no = no;
 	p->token = t;
@@ -44,8 +52,8 @@ struct grep_opt *grep_opt_dup(const struct grep_opt *opt)
 			append_header_grep_pattern(ret, pat->field,
 						   pat->pattern);
 		else
-			append_grep_pattern(ret, pat->pattern, pat->origin,
-					    pat->no, pat->token);
+			append_grep_pat(ret, pat->pattern, pat->patternlen,
+					pat->origin, pat->no, pat->token);
 	}
 
 	return ret;
@@ -329,21 +337,21 @@ static void show_name(struct grep_opt *opt, const char *name)
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
-static int fixmatch(const char *pattern, char *line, char *eol,
-		    int ignore_case, regmatch_t *match)
+static int fixmatch(struct grep_pat *p, char *line, char *eol,
+		    regmatch_t *match)
 {
 	char *hit;
 
-	if (ignore_case) {
+	if (p->ignore_case) {
 		char *s = line;
 		do {
-			hit = strcasestr(s, pattern);
+			hit = strcasestr(s, p->pattern);
 			if (hit)
 				break;
 			s += strlen(s) + 1;
 		} while (s < eol);
 	} else
-		hit = memmem(line, eol - line, pattern, strlen(pattern));
+		hit = memmem(line, eol - line, p->pattern, p->patternlen);
 
 	if (!hit) {
 		match->rm_so = match->rm_eo = -1;
@@ -351,7 +359,7 @@ static int fixmatch(const char *pattern, char *line, char *eol,
 	}
 	else {
 		match->rm_so = hit - line;
-		match->rm_eo = match->rm_so + strlen(pattern);
+		match->rm_eo = match->rm_so + p->patternlen;
 		return 0;
 	}
 }
@@ -417,7 +425,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 
  again:
 	if (p->fixed)
-		hit = !fixmatch(p->pattern, bol, eol, p->ignore_case, pmatch);
+		hit = !fixmatch(p, bol, eol, pmatch);
 	else
 		hit = !regmatch(&p->regexp, bol, eol, pmatch, eflags);
 
@@ -743,10 +751,9 @@ static int look_ahead(struct grep_opt *opt,
 		int hit;
 		regmatch_t m;
 
-		if (p->fixed) {
-			hit = !fixmatch(p->pattern, bol, bol + *left_p,
-					p->ignore_case, &m);
-		} else
+		if (p->fixed)
+			hit = !fixmatch(p, bol, bol + *left_p, &m);
+		else
 			hit = !regmatch(&p->regexp, bol, bol + *left_p, &m, 0);
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
 			continue;
diff --git a/grep.h b/grep.h
index 89342e5..0aebebd 100644
--- a/grep.h
+++ b/grep.h
@@ -29,6 +29,7 @@ struct grep_pat {
 	int no;
 	enum grep_pat_token token;
 	const char *pattern;
+	size_t patternlen;
 	enum grep_header_field field;
 	regex_t regexp;
 	unsigned fixed:1;
@@ -104,6 +105,7 @@ struct grep_opt {
 	void *output_priv;
 };
 
+extern void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
 extern void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const char *);
 extern void compile_grep_patterns(struct grep_opt *opt);
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 4f5e74f..eb8ca88 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -69,4 +69,34 @@ test_expect_failure 'git grep .fi a' '
 	git grep .fi a
 '
 
+test_expect_success 'git grep -F y<NUL>f a' "
+	printf 'y\000f' >f &&
+	git grep -f f -F a
+"
+
+test_expect_success 'git grep -F y<NUL>x a' "
+	printf 'y\000x' >f &&
+	test_must_fail git grep -f f -F a
+"
+
+test_expect_success 'git grep -Fi Y<NUL>f a' "
+	printf 'Y\000f' >f &&
+	git grep -f f -Fi a
+"
+
+test_expect_failure 'git grep -Fi Y<NUL>x a' "
+	printf 'Y\000x' >f &&
+	test_must_fail git grep -f f -Fi a
+"
+
+test_expect_success 'git grep y<NUL>f a' "
+	printf 'y\000f' >f &&
+	git grep -f f a
+"
+
+test_expect_failure 'git grep y<NUL>x a' "
+	printf 'y\000x' >f &&
+	test_must_fail git grep -f f a
+"
+
 test_done
-- 
1.7.1
