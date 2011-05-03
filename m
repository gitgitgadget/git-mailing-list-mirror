From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [RFC PATCH 3/3] git-grep: Learn PCRE
Date: Tue,  3 May 2011 23:35:57 +0200
Message-ID: <1304458557-25629-3-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304458557-25629-1-git-send-email-michal.kiedrowicz@gmail.com>
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 23:36:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHNGa-0000rB-5h
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 23:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab1ECVgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 17:36:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64590 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab1ECVgS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 17:36:18 -0400
Received: by wya21 with SMTP id 21so407985wya.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=8DdnSLYrth/khhDrn5ceV1XIOJTVFmKf9jwh66W8xSM=;
        b=TvCE7u5bndgPbfpk7EL5qkNWlB9xyvQB8uprwxPElGx4pbx21Sici/ALpe4T2QuLuQ
         YmltqhCgtB/bM7CRuDCT64tnrFbtd1p/euSnFKZ2YjU0DV2/sGGrAqODOylvl4tHkRpz
         E0CLXpuRha9QK1q6+WUT+DfoF7U3j1Y0oYnPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=occY1QfiMGlD6DnZ2uJSh4MYxA/+gQSojTDpCHWW744lWb46ZpAVKxtfdqgRCbwT4g
         R8Jk5nKH6YFEs7ie1Dh/I9TSULLWpwhjjzAtLmXdGdFmyJQNsjYvQJLuQF49be0kNe5X
         kyJpMAc944hHBbmjY0PVvrf4GUXWPzpys/3dQ=
Received: by 10.227.39.66 with SMTP id f2mr366897wbe.2.1304458577003;
        Tue, 03 May 2011 14:36:17 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id b20sm305256wbb.50.2011.05.03.14.36.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2011 14:36:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304458557-25629-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172697>

This is quite minimal (I hope) patch that teaches git-grep the
--perl-regexp/-P options in order to allow specifying PCRE regexes on
the command line.

PCRE has a number of features which make them more handy to use than
POSIX regexes, like consistent escaping rules, extended character
classes, ungreedy matching etc.

Here are some implementation notes:

Names of command line options are borrowed from GNU grep.

Makefile changes are based on curl handing.

The configure script wasn't updated.

This patch lacks tests.

AFAIK grep.c is a part of libgit.a, so libpcre is linked with the git
itself, which bloats it. I don't like it, especially because it makes
'make test' take:

	real    6m27.558s
	user    1m34.392s
	sys     2m11.029s

instead of

	real    3m41.322s
	user    1m44.005s
	sys     2m32.403s

on my PC.
---
 Documentation/git-grep.txt |    6 ++++
 Makefile                   |   16 ++++++++++++
 builtin/grep.c             |    2 +
 grep.c                     |   57 ++++++++++++++++++++++++++++++++++++++++++++
 grep.h                     |    8 ++++++
 5 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a58378..e150c77 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git grep' [-a | --text] [-I] [-i | --ignore-case] [-w | --word-regexp]
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
+	   [-P | --perl-regexp]
 	   [-F | --fixed-strings] [-n | --line-number]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
@@ -97,6 +98,11 @@ OPTIONS
 	Use POSIX extended/basic regexp for patterns.  Default
 	is to use basic regexp.
 
+-P::
+--perl-regexp::
+	Use Perl-compatible regexp for patterns. Requires libpcre to be
+	compiled in.
+
 -F::
 --fixed-strings::
 	Use fixed strings for patterns (don't interpret pattern
diff --git a/Makefile b/Makefile
index 3a1fe20..98841dc 100644
--- a/Makefile
+++ b/Makefile
@@ -24,6 +24,12 @@ all::
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies BLK_SHA1.
 #
+# Define NO_LIBPCRE if you do not have libpcre installed.  git-grep cannot use
+# Perl-compatible regexes.
+#
+# Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
+# /foo/bar/include and /foo/bar/lib directories.
+#
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
@@ -1251,6 +1257,16 @@ ifdef NO_LIBGEN_H
 	COMPAT_OBJS += compat/basename.o
 endif
 
+ifdef NO_LIBPCRE
+	BASIC_CFLAGS += -DNO_LIBPCRE
+else
+	ifdef LIBPCREDIR
+		BASIC_CFLAGS += -I$(LIBPCREDIR)/include
+		EXTLIBS += -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib)
+	endif
+	EXTLIBS += -lpcre
+endif
+
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 	REMOTE_CURL_PRIMARY =
diff --git a/builtin/grep.c b/builtin/grep.c
index 10a1f65..6831975 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -781,6 +781,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			REG_EXTENDED),
 		OPT_BOOLEAN('F', "fixed-strings", &opt.fixed,
 			"interpret patterns as fixed strings"),
+		OPT_BOOLEAN('P', "perl-regexp", &opt.pcre,
+				"use Perl-compatible regular expressions"),
 		OPT_GROUP(""),
 		OPT_BOOLEAN('n', "line-number", &opt.linenum, "show line numbers"),
 		OPT_NEGBIT('h', NULL, &opt.pathname, "don't show filenames", 1),
diff --git a/grep.c b/grep.c
index d67baf9..4f5fcbb 100644
--- a/grep.c
+++ b/grep.c
@@ -70,6 +70,30 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	if (p->fixed)
 		return;
 
+	if (opt->pcre) {
+#ifdef NO_LIBPCRE
+		die("cannot use Perl-compatible regexes when libpcre is not compiled in");
+#else
+		const char *error;
+		int erroffset;
+		int options = 0;
+
+		if (opt->ignore_case)
+			options |= PCRE_CASELESS;
+
+		p->re = pcre_compile(p->pattern, options, &error,
+				&erroffset, NULL);
+		if (!p->re)
+			die("'%s': %s", p->pattern, error);
+
+		p->extra = pcre_study(p->re, 0, &error);
+		if (!p->extra && error)
+			die("%s", error);
+
+		return;
+#endif
+	}
+
 	err = regcomp(&p->regexp, p->pattern, opt->regflags);
 	if (err) {
 		char errbuf[1024];
@@ -320,7 +344,16 @@ void free_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN: /* atom */
 		case GREP_PATTERN_HEAD:
 		case GREP_PATTERN_BODY:
+#ifndef NO_LIBPCRE
+			if (p->re) {
+				pcre_free(p->re);
+				pcre_free(p->extra);
+			} else {
+				regfree(&p->regexp);
+			}
+#else
 			regfree(&p->regexp);
+#endif
 			break;
 		default:
 			break;
@@ -401,6 +434,26 @@ static int fixmatch(struct grep_pat *p, char *line, char *eol,
 	}
 }
 
+#ifndef NO_LIBPCRE
+static int pcrematch(const pcre *re, const pcre_extra *extra, char *line,
+		char *eol, regmatch_t *match)
+{
+	int ovector[30], ret;
+
+	ret = pcre_exec(re, NULL, line, eol - line, 0, 0, ovector,
+			ARRAY_SIZE(ovector));
+	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
+		die("pcre_exec failed with error code %d", ret);
+	if (ret > 0) {
+		ret = 0;
+		match->rm_so = ovector[0];
+		match->rm_eo = ovector[1];
+	}
+
+	return ret;
+}
+#endif /* NO_LIBPCRE */
+
 static int regmatch(const regex_t *preg, char *line, char *eol,
 		    regmatch_t *match, int eflags)
 {
@@ -419,6 +472,10 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 
 	if (p->fixed)
 		hit = !fixmatch(p, line, eol, match);
+#ifndef NO_LIBPCRE
+	else if (p->re)
+		hit = !pcrematch(p->re, p->extra, line, eol, match);
+#endif /* NO_LIBPCRE */
 	else
 		hit = !regmatch(&p->regexp, line, eol, match, eflags);
 
diff --git a/grep.h b/grep.h
index 06621fe..cd202a9 100644
--- a/grep.h
+++ b/grep.h
@@ -1,6 +1,9 @@
 #ifndef GREP_H
 #define GREP_H
 #include "color.h"
+#ifndef NO_LIBPCRE
+#include <pcre.h>
+#endif /* NO_LIBPCRE */
 
 enum grep_pat_token {
 	GREP_PATTERN,
@@ -33,6 +36,10 @@ struct grep_pat {
 	size_t patternlen;
 	enum grep_header_field field;
 	regex_t regexp;
+#ifndef NO_LIBPCRE
+	pcre *re;
+	pcre_extra *extra;
+#endif /* NO_LIBPCRE */
 	unsigned fixed:1;
 	unsigned ignore_case:1;
 	unsigned word_regexp:1;
@@ -83,6 +90,7 @@ struct grep_opt {
 #define GREP_BINARY_TEXT	2
 	int binary;
 	int extended;
+	int pcre;
 	int relative;
 	int pathname;
 	int null_following_name;
-- 
1.7.3.4
