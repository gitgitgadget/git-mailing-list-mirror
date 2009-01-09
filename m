From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] grep: don't call regexec() for fixed strings
Date: Sat, 10 Jan 2009 00:18:34 +0100
Message-ID: <4967DB4A.2000702@lsrfire.ath.cx>
References: <4967D8F8.9070508@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 10 00:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLQfc-0004qp-3f
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 00:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164AbZAIXSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 18:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757062AbZAIXSr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 18:18:47 -0500
Received: from india601.server4you.de ([85.25.151.105]:34976 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304AbZAIXSh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 18:18:37 -0500
Received: from [10.0.1.101] (p57B7F734.dip.t-dialin.net [87.183.247.52])
	by india601.server4you.de (Postfix) with ESMTPSA id 2A4C62F8042;
	Sat, 10 Jan 2009 00:18:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <4967D8F8.9070508@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105045>

Add the new flag "fixed" to struct grep_pat and set it if the pattern
is doesn't contain any regex control characters in addition to if the
flag -F/--fixed-strings was specified.

This gives a nice speed up on msysgit, where regexec() seems to be
extra slow.  Before (best of five runs):

	$ time git grep grep v1.6.1 >/dev/null

	real    0m0.552s
	user    0m0.000s
	sys     0m0.000s

	$ time git grep -F grep v1.6.1 >/dev/null

	real    0m0.170s
	user    0m0.000s
	sys     0m0.015s

With the patch:

	$ time git grep grep v1.6.1 >/dev/null

	real    0m0.173s
	user    0m0.000s
	sys     0m0.000s

The difference is much smaller on Linux, but still measurable.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |   29 +++++++++++++++++++++++++----
 grep.h |    1 +
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 394703b..a1092df 100644
--- a/grep.c
+++ b/grep.c
@@ -28,9 +28,31 @@ void append_grep_pattern(struct grep_opt *opt, const char *pat,
 	p->next = NULL;
 }
 
+static int isregexspecial(int c)
+{
+	return isspecial(c) || c == '$' || c == '(' || c == ')' || c == '+' ||
+			       c == '.' || c == '^' || c == '{' || c == '|';
+}
+
+static int is_fixed(const char *s)
+{
+	while (!isregexspecial(*s))
+		s++;
+	return !*s;
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
-	int err = regcomp(&p->regexp, p->pattern, opt->regflags);
+	int err;
+
+	if (opt->fixed || is_fixed(p->pattern))
+		p->fixed = 1;
+	if (opt->regflags & REG_ICASE)
+		p->fixed = 0;
+	if (p->fixed)
+		return;
+
+	err = regcomp(&p->regexp, p->pattern, opt->regflags);
 	if (err) {
 		char errbuf[1024];
 		char where[1024];
@@ -159,8 +181,7 @@ void compile_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN: /* atom */
 		case GREP_PATTERN_HEAD:
 		case GREP_PATTERN_BODY:
-			if (!opt->fixed)
-				compile_regexp(p, opt);
+			compile_regexp(p, opt);
 			break;
 		default:
 			opt->extended = 1;
@@ -314,7 +335,7 @@ static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol
 	}
 
  again:
-	if (!opt->fixed) {
+	if (!p->fixed) {
 		regex_t *exp = &p->regexp;
 		hit = !regexec(exp, bol, ARRAY_SIZE(pmatch),
 			       pmatch, 0);
diff --git a/grep.h b/grep.h
index 45a222d..5102ce3 100644
--- a/grep.h
+++ b/grep.h
@@ -30,6 +30,7 @@ struct grep_pat {
 	const char *pattern;
 	enum grep_header_field field;
 	regex_t regexp;
+	unsigned fixed:1;
 };
 
 enum grep_expr_node {
-- 
1.6.1
