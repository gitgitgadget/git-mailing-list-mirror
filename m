From: Brian Collins <bricollins@gmail.com>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep for 
	fixed-strings
Date: Fri, 6 Nov 2009 01:22:35 -0800
Message-ID: <d1c0fbfa0911060122u3ffc85e7pf60a689cdfd85850@mail.gmail.com>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
	 <20091106084855.GA20964@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 10:22:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6L1q-00046x-2n
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 10:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbZKFJWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 04:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbZKFJWd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 04:22:33 -0500
Received: from mail-px0-f179.google.com ([209.85.216.179]:50761 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbZKFJWa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 04:22:30 -0500
Received: by pxi9 with SMTP id 9so591614pxi.4
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 01:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zOaBkLYlSKQQpQHqBUGdK1zFKHXNiAi0uCqeEpz04g0=;
        b=wAU4GY2Kc681eCklKoQQcrJZnGZ6xM3h2lKdXiI7gHoUvnsS4oqQkG0iCiw55E3mGv
         dYmZeKUcefLD6pfwtUx34czW59G6BFf2djF52p69Z+nuQbbzZKT46lOHP5N7gp9+pe4x
         yUqiXh5c/e6iXd4RBY8aWzOAkkuGlC9XR4uVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Si3Sh8v3SB0bBH8LsGZnPFsH7bWoJc7Sk5NnnDwn86WF8frPS4cZUKIO5lPxbmYL1U
         R4Jfd37PVYS7NQfFXeQr8VEROVeytZV7JjnPT9vyqT4sj0GZVKpVDcpzRKDL3UEssgNT
         gRKxARK49eIgcFJJLJOBVKoupV+mw9kTUG5fQ=
Received: by 10.114.6.28 with SMTP id 28mr6487193waf.115.1257499355622; Fri, 
	06 Nov 2009 01:22:35 -0800 (PST)
In-Reply-To: <20091106084855.GA20964@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132290>

2009/11/6 Jeff King <peff@peff.net>:
> You're in the right place (though judging from the response, nobody
> seemed to find your patch all that interesting...).

Heh, yeah it is a bit of a boring edge case but a TextMate plugin I am writing
requires this functionality.

> Tests? They help prove to us that your feature works, and also prevent
> us from accidentally breaking your feature in the future.

Ah yes that is what I was forgetting. Please see the amended patch including
test.
Thanks for your help


---
 builtin-grep.c  |    8 +++++---
 grep.c          |   16 ++++++++++++----
 grep.h          |    2 ++
 t/t7002-grep.sh |    9 +++++++++
 4 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 761799d..c73f05b 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -367,7 +367,7 @@ static int external_grep(struct grep_opt *opt,
const char **paths, int cached)
 		push_arg("-h");
 	if (opt->regflags & REG_EXTENDED)
 		push_arg("-E");
-	if (opt->regflags & REG_ICASE)
+	if (opt->caseless)
 		push_arg("-i");
 	if (opt->binary == GREP_BINARY_NOMATCH)
 		push_arg("-I");
@@ -706,8 +706,8 @@ int cmd_grep(int argc, const char **argv, const
char *prefix)
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
@@ -830,6 +830,8 @@ int cmd_grep(int argc, const char **argv, const
char *prefix)
 		external_grep_allowed = 0;
 	if (!opt.pattern_list)
 		die("no pattern given.");
+	if (!opt.fixed && opt.caseless)
+		opt.regflags |= REG_ICASE;
 	if ((opt.regflags != REG_NEWLINE) && opt.fixed)
 		die("cannot mix --fixed-strings and regexp");
 	compile_grep_patterns(&opt);
diff --git a/grep.c b/grep.c
index 5d162da..d8f14be 100644
--- a/grep.c
+++ b/grep.c
@@ -41,7 +41,8 @@ static void compile_regexp(struct grep_pat *p,
struct grep_opt *opt)
 	int err;

 	p->word_regexp = opt->word_regexp;
-
+	p->caseless = opt->caseless;
+	
 	if (opt->fixed || is_fixed(p->pattern))
 		p->fixed = 1;
 	if (opt->regflags & REG_ICASE)
@@ -262,9 +263,16 @@ static void show_name(struct grep_opt *opt, const
char *name)
 	printf("%s%c", name, opt->null_following_name ? '\0' : '\n');
 }

-static int fixmatch(const char *pattern, char *line, regmatch_t *match)
+
+static int fixmatch(const char *pattern, char *line, int caseless,
regmatch_t *match)
 {
-	char *hit = strstr(line, pattern);
+	char *hit;
+	if (caseless) {
+		hit = strcasestr(line, pattern);
+	} else {
+		hit = strstr(line, pattern);
+	}
+	
 	if (!hit) {
 		match->rm_so = match->rm_eo = -1;
 		return REG_NOMATCH;
@@ -326,7 +334,7 @@ static int match_one_pattern(struct grep_pat *p,
char *bol, char *eol,

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
index ae56a36..87b47dd 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -345,4 +345,13 @@ test_expect_success 'grep from a subdirectory to
search wider area (2)' '
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
1.6.4.4
