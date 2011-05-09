From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 3/6] git-grep: Learn PCRE
Date: Mon,  9 May 2011 23:52:05 +0200
Message-ID: <1304977928-7142-4-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 23:53:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYO7-0000Ry-6R
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 23:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab1EIVwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 17:52:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43749 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab1EIVwm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 17:52:42 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so6215970wwa.1
        for <git@vger.kernel.org>; Mon, 09 May 2011 14:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=LQjCak8sKTNNzxd2jZpgzU4l5z/LDZw5mIBUNIQFHyg=;
        b=ioGTH8CLjDrZYkRGPiyXvpwmc0XWyIX6SbWtjZCo8/quVhGuaX64eAxglsGWuUQj2J
         o6ekgj64DBL/UJt4n52iuh/sdEtwGzYEywTlLaDOAfhRcERhnWLNZvJJLP0CoWgp22pq
         R/lcV5lUyDzd64Kf9BMWBX443ZaEOumEV6//U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aG6N6TtzCOv9wuVFTmGkWjZWpwhSKjPOkq16p/caUwcofCj/THqPcHbaEJ8HPlMzUw
         otprAFtuHUf1f/TaDlaE53z3Id2Tzxht753JkRVs0v+ELGaauKzjsH9pJahM7oiucZkT
         wbj2J4uDxv2cYUqjMVXS0GT1IzXrIB7fze95E=
Received: by 10.227.198.133 with SMTP id eo5mr7670116wbb.38.1304977961313;
        Mon, 09 May 2011 14:52:41 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id o6sm4019850wbo.20.2011.05.09.14.52.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 14:52:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173261>

This patch teaches git-grep the --perl-regexp/-P options (naming
borrowed from GNU grep) in order to allow specifying PCRE regexes on th=
e
command line.

PCRE has a number of features which make them more handy to use than
POSIX regexes, like consistent escaping rules, extended character
classes, ungreedy matching etc.

git isn't build with PCRE support automatically. USE_LIBPCRE environmen=
t
variable must be enabled (like `make USE_LIBPCRE=3DYesPlease`).

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 Documentation/git-grep.txt             |    6 +++
 Makefile                               |   15 ++++++
 builtin/grep.c                         |    2 +
 contrib/completion/git-completion.bash |    1 +
 grep.c                                 |   75 ++++++++++++++++++++++++=
+++++++-
 grep.h                                 |    9 ++++
 6 files changed, 107 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a58378..e150c77 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git grep' [-a | --text] [-I] [-i | --ignore-case] [-w | --word-regexp=
]
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
+	   [-P | --perl-regexp]
 	   [-F | --fixed-strings] [-n | --line-number]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
@@ -97,6 +98,11 @@ OPTIONS
 	Use POSIX extended/basic regexp for patterns.  Default
 	is to use basic regexp.
=20
+-P::
+--perl-regexp::
+	Use Perl-compatible regexp for patterns. Requires libpcre to be
+	compiled in.
+
 -F::
 --fixed-strings::
 	Use fixed strings for patterns (don't interpret pattern
diff --git a/Makefile b/Makefile
index 3a1fe20..717a47c 100644
--- a/Makefile
+++ b/Makefile
@@ -24,6 +24,12 @@ all::
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies BLK_SHA1.
 #
+# Define USE_LIBPCRE if you have and want to use libpcre. git-grep wil=
l be
+# able to use Perl-compatible regular expressions.
+#
+# Define LIBPCREDIR=3D/foo/bar if your libpcre header and library file=
s are in
+# /foo/bar/include and /foo/bar/lib directories.
+#
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull =
and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
@@ -1251,6 +1257,15 @@ ifdef NO_LIBGEN_H
 	COMPAT_OBJS +=3D compat/basename.o
 endif
=20
+ifdef USE_LIBPCRE
+	BASIC_CFLAGS +=3D -DUSE_LIBPCRE
+	ifdef LIBPCREDIR
+		BASIC_CFLAGS +=3D -I$(LIBPCREDIR)/include
+		EXTLIBS +=3D -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(=
lib)
+	endif
+	EXTLIBS +=3D -lpcre
+endif
+
 ifdef NO_CURL
 	BASIC_CFLAGS +=3D -DNO_CURL
 	REMOTE_CURL_PRIMARY =3D
diff --git a/builtin/grep.c b/builtin/grep.c
index 10a1f65..6831975 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -781,6 +781,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			REG_EXTENDED),
 		OPT_BOOLEAN('F', "fixed-strings", &opt.fixed,
 			"interpret patterns as fixed strings"),
+		OPT_BOOLEAN('P', "perl-regexp", &opt.pcre,
+				"use Perl-compatible regular expressions"),
 		OPT_GROUP(""),
 		OPT_BOOLEAN('n', "line-number", &opt.linenum, "show line numbers"),
 		OPT_NEGBIT('h', NULL, &opt.pathname, "don't show filenames", 1),
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 4b2654d..95790a1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1487,6 +1487,7 @@ _git_grep ()
 			--text --ignore-case --word-regexp --invert-match
 			--full-name --line-number
 			--extended-regexp --basic-regexp --fixed-strings
+			--perl-regexp
 			--files-with-matches --name-only
 			--files-without-match
 			--max-depth
diff --git a/grep.c b/grep.c
index 870d10c..d03d9e2 100644
--- a/grep.c
+++ b/grep.c
@@ -74,6 +74,69 @@ static NORETURN void compile_regexp_failed(const str=
uct grep_pat *p,
 	die("%s'%s': %s", where, p->pattern, error);
 }
=20
+#ifdef USE_LIBPCRE
+static void compile_pcre_regexp(struct grep_pat *p, const struct grep_=
opt *opt)
+{
+	const char *error;
+	int erroffset;
+	int options =3D 0;
+
+	if (opt->ignore_case)
+		options |=3D PCRE_CASELESS;
+
+	p->pcre_regexp =3D pcre_compile(p->pattern, options, &error, &erroffs=
et,
+			NULL);
+	if (!p->pcre_regexp)
+		compile_regexp_failed(p, error);
+
+	p->pcre_extra_info =3D pcre_study(p->pcre_regexp, 0, &error);
+	if (!p->pcre_extra_info && error)
+		die("%s", error);
+}
+
+static int pcrematch(struct grep_pat *p, const char *line, const char =
*eol,
+		regmatch_t *match, int eflags)
+{
+	int ovector[30], ret, flags =3D 0;
+
+	if (eflags & REG_NOTBOL)
+		flags |=3D PCRE_NOTBOL;
+
+	ret =3D pcre_exec(p->pcre_regexp, p->pcre_extra_info, line, eol - lin=
e,
+			0, flags, ovector, ARRAY_SIZE(ovector));
+	if (ret < 0 && ret !=3D PCRE_ERROR_NOMATCH)
+		die("pcre_exec failed with error code %d", ret);
+	if (ret > 0) {
+		ret =3D 0;
+		match->rm_so =3D ovector[0];
+		match->rm_eo =3D ovector[1];
+	}
+
+	return ret;
+}
+
+static void free_pcre_regexp(struct grep_pat *p)
+{
+	pcre_free(p->pcre_regexp);
+	pcre_free(p->pcre_extra_info);
+}
+#else /* !USE_LIBPCRE */
+static void compile_pcre_regexp(struct grep_pat *p, const struct grep_=
opt *opt)
+{
+	die("cannot use Perl-compatible regexes when not compiled with USE_LI=
BPCRE");
+}
+
+static int pcrematch(struct grep_pat *p, const char *line, const char =
*eol,
+		regmatch_t *match, int eflags)
+{
+	return 1;
+}
+
+static void free_pcre_regexp(struct grep_pat *p)
+{
+}
+#endif /* !USE_LIBPCRE */
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err;
@@ -85,6 +148,11 @@ static void compile_regexp(struct grep_pat *p, stru=
ct grep_opt *opt)
 	if (p->fixed)
 		return;
=20
+	if (opt->pcre) {
+		compile_pcre_regexp(p, opt);
+		return;
+	}
+
 	err =3D regcomp(&p->regexp, p->pattern, opt->regflags);
 	if (err) {
 		char errbuf[1024];
@@ -327,7 +395,10 @@ void free_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN: /* atom */
 		case GREP_PATTERN_HEAD:
 		case GREP_PATTERN_BODY:
-			regfree(&p->regexp);
+			if (p->pcre_regexp)
+				free_pcre_regexp(p);
+			else
+				regfree(&p->regexp);
 			break;
 		default:
 			break;
@@ -426,6 +497,8 @@ static int patmatch(struct grep_pat *p, char *line,=
 char *eol,
=20
 	if (p->fixed)
 		hit =3D !fixmatch(p, line, eol, match);
+	else if (p->pcre_regexp)
+		hit =3D !pcrematch(p, line, eol, match, eflags);
 	else
 		hit =3D !regmatch(&p->regexp, line, eol, match, eflags);
=20
diff --git a/grep.h b/grep.h
index 06621fe..cd055cd 100644
--- a/grep.h
+++ b/grep.h
@@ -1,6 +1,12 @@
 #ifndef GREP_H
 #define GREP_H
 #include "color.h"
+#ifdef USE_LIBPCRE
+#include <pcre.h>
+#else
+typedef int pcre;
+typedef int pcre_extra;
+#endif
=20
 enum grep_pat_token {
 	GREP_PATTERN,
@@ -33,6 +39,8 @@ struct grep_pat {
 	size_t patternlen;
 	enum grep_header_field field;
 	regex_t regexp;
+	pcre *pcre_regexp;
+	pcre_extra *pcre_extra_info;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
 	unsigned word_regexp:1;
@@ -83,6 +91,7 @@ struct grep_opt {
 #define GREP_BINARY_TEXT	2
 	int binary;
 	int extended;
+	int pcre;
 	int relative;
 	int pathname;
 	int null_following_name;
--=20
1.7.3.4
