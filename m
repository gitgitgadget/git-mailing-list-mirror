From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep
 for fixed-strings
Date: Mon, 16 Nov 2009 11:25:33 -0500
Message-ID: <20091116162533.GA30737@coredump.intra.peff.net>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
 <20091116195050.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brian Collins <bricollins@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 17:25:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA4Of-0004ib-Lf
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 17:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbZKPQZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 11:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbZKPQZc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 11:25:32 -0500
Received: from peff.net ([208.65.91.99]:34598 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbZKPQZb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 11:25:31 -0500
Received: (qmail 17147 invoked by uid 107); 16 Nov 2009 16:29:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Nov 2009 11:29:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Nov 2009 11:25:33 -0500
Content-Disposition: inline
In-Reply-To: <20091116195050.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133014>

On Mon, Nov 16, 2009 at 07:50:50PM +0900, Nanako Shiraishi wrote:

> Quoting Brian Collins <bricollins@gmail.com>
> 
> > You will have to excuse me, this is my first patch and I don't know if
> > this is the right place to post this. Apologies in advance if I'm in
> > the wrong place.
> >
> > git-grep currently throws an error when you combine the -F and -i
> > flags. This isn't in line with how GNU grep handles it. This patch
> > allows the simultaneous use of those flags.
> 
> Junio, may I ask what happened to this patch?

I think I owed it another review.

I just looked it over and the idea and implementation look sane to me.
There were a few minor problems with the submission:

  1. The patch was line-wrapped; I had to de-munge it manually to apply.

  2. The original submission had cover-letter material mixed in with the
     commit message. The follow-up version had no commit message at all.

  3. No signed-off-by. Brian, can you please acknowledge the DCO with a
     signoff?

  4. The patch introduced some stray trailing whitespace.

  5. There were a few style fixups, like omitting braces for a
     single-line conditional.

To save Junio time, here is a version that fixes all of those things. I
think it's probably worth applying to 'next'.

-- >8 --
From: Brian Collins <bricollins@gmail.com>
Date: Fri, 6 Nov 2009 01:22:35 -0800
Subject: [PATCH] RFC Allow case insensitive search flag with git-grep for fixed-strings

git-grep currently throws an error when you combine the -F
and -i flags.  This isn't in line with how GNU grep handles
it. This patch allows the simultaneous use of those flags.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-grep.c  |    8 +++++---
 grep.c          |   13 ++++++++++---
 grep.h          |    2 ++
 t/t7002-grep.sh |    9 +++++++++
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 1df25b0..a2616fc 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -367,7 +367,7 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 		push_arg("-h");
 	if (opt->regflags & REG_EXTENDED)
 		push_arg("-E");
-	if (opt->regflags & REG_ICASE)
+	if (opt->caseless)
 		push_arg("-i");
 	if (opt->binary == GREP_BINARY_NOMATCH)
 		push_arg("-I");
@@ -706,8 +706,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_BOOLEAN('v', "invert-match", &opt.invert,
 			"show non-matching lines"),
-		OPT_BIT('i', "ignore-case", &opt.regflags,
-			"case insensitive matching", REG_ICASE),
+		OPT_BOOLEAN('i', "ignore-case", &opt.caseless,
+			"case insensitive matching"),
 		OPT_BOOLEAN('w', "word-regexp", &opt.word_regexp,
 			"match patterns only at word boundaries"),
 		OPT_SET_INT('a', "text", &opt.binary,
@@ -830,6 +830,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		external_grep_allowed = 0;
 	if (!opt.pattern_list)
 		die("no pattern given.");
+	if (!opt.fixed && opt.caseless)
+		opt.regflags |= REG_ICASE;
 	if ((opt.regflags != REG_NEWLINE) && opt.fixed)
 		die("cannot mix --fixed-strings and regexp");
 	compile_grep_patterns(&opt);
diff --git a/grep.c b/grep.c
index 5d162da..bbb0d18 100644
--- a/grep.c
+++ b/grep.c
@@ -41,6 +41,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	int err;
 
 	p->word_regexp = opt->word_regexp;
+	p->caseless = opt->caseless;
 
 	if (opt->fixed || is_fixed(p->pattern))
 		p->fixed = 1;
@@ -262,9 +263,15 @@ static void show_name(struct grep_opt *opt, const char *name)
 	printf("%s%c", name, opt->null_following_name ? '\0' : '\n');
 }
 
-static int fixmatch(const char *pattern, char *line, regmatch_t *match)
+
+static int fixmatch(const char *pattern, char *line, int caseless, regmatch_t *match)
 {
-	char *hit = strstr(line, pattern);
+	char *hit;
+	if (caseless)
+		hit = strcasestr(line, pattern);
+	else
+		hit = strstr(line, pattern);
+
 	if (!hit) {
 		match->rm_so = match->rm_eo = -1;
 		return REG_NOMATCH;
@@ -326,7 +333,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 
  again:
 	if (p->fixed)
-		hit = !fixmatch(p->pattern, bol, pmatch);
+		hit = !fixmatch(p->pattern, bol, p->caseless, pmatch);
 	else
 		hit = !regexec(&p->regexp, bol, 1, pmatch, eflags);
 
diff --git a/grep.h b/grep.h
index f6eecc6..24b7d44 100644
--- a/grep.h
+++ b/grep.h
@@ -32,6 +32,7 @@ struct grep_pat {
 	enum grep_header_field field;
 	regex_t regexp;
 	unsigned fixed:1;
+	unsigned caseless:1;
 	unsigned word_regexp:1;
 };
 
@@ -64,6 +65,7 @@ struct grep_opt {
 	regex_t regexp;
 	int linenum;
 	int invert;
+	int caseless;
 	int status_only;
 	int name_only;
 	int unmatch_name_only;
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index ae5290a..24a9445 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -411,4 +411,13 @@ test_expect_success 'grep from a subdirectory to search wider area (2)' '
 	)
 '
 
+cat >expected <<EOF
+hello.c:	return 0;
+EOF
+
+test_expect_success 'grep -Fi' '
+	git grep -Fi rEtUrN >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.6.5.2.187.g29317
