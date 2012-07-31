From: J Smith <dark.panda@gmail.com>
Subject: [PATCH/RFC 1/2] grep: add "basic", "extended", "fixed", and "perl" to grep.extendedRegexp
Date: Tue, 31 Jul 2012 18:53:28 -0400
Message-ID: <1343775209-56505-1-git-send-email-dark.panda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 00:53:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwLJr-0005kF-Et
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 00:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab2GaWxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 18:53:33 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38890 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab2GaWxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 18:53:31 -0400
Received: by vcbfk26 with SMTP id fk26so6433580vcb.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=5XPfhnP75Y0CM26/AsqW3IwYymk8/5dG3YJAzH8DGs8=;
        b=e1XbD+npZZu6VoEfRFEUxDQXotGDmLpsZRibyQq5xta6a8Fb4e6ayrfQa/RTkGqPgf
         N0Zy/MW9LWlb2c5ObyuRje/DU2TKg9x/JD+HnKRuxknqGDCYf4cZZoOzL1AAGMKo/a6D
         UVUGO3MEFW4/i4FdUkk4aIcUfUwWVCu3++hCwIRD1uOPIdSsfp11ZlbJ5Ue5VtPESYu3
         lEr6AVCTok82paou71Jd2zh8hStDcI8gvuZHjosBJZYi6/7iBEeI3uV9SiYBRFU2mrmZ
         QSgv0XJllJF5SQqHgIkoa7e0UEAz4Z4Q8SWbG0IRfRPDUBUmSGqk8auba9Vq+cplwSVS
         mevg==
Received: by 10.220.149.130 with SMTP id t2mr15402823vcv.8.1343775211188;
        Tue, 31 Jul 2012 15:53:31 -0700 (PDT)
Received: from localhost.localdomain (surf3.net.rss.rogers.com. [24.114.255.3])
        by mx.google.com with ESMTPS id l9sm1324261vdw.14.2012.07.31.15.53.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2012 15:53:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202690>

Adds "basic", "extended", "fixed", and "perl" settings to the
grep.extendedRegexp configuration option which set "--basic-regexp",
"--extended-regexp", "--fixed-strings", and "--perl-regexp" options by
default respectively. For the purposes of backwards compatibility,
"extended" is equivalent to "true".
---
 Documentation/config.txt   |   6 ++-
 Documentation/git-grep.txt |   6 ++-
 builtin/grep.c             |  95 ++++++++++++++++++++++++----------------
 grep.h                     |   8 ++++
 t/t7810-grep.sh            | 105 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 180 insertions(+), 40 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a95e5a4..67d9f24 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1211,7 +1211,11 @@ grep.lineNumber::
 	If set to true, enable '-n' option by default.

 grep.extendedRegexp::
-	If set to true, enable '--extended-regexp' option by default.
+	Sets the default matching behavior. This option can be set to a
+	boolean value or one of 'basic', 'extended', 'fixed', or 'perl'
+	which will enable the '--basic-regexp', '--extended-regexp',
+	'--fixed-strings' or '--perl-regexp' options accordingly. The value
+	of 'true' is equivalent to 'extended'.

 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3bec036..100328f 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -43,7 +43,11 @@ grep.lineNumber::
 	If set to true, enable '-n' option by default.

 grep.extendedRegexp::
-	If set to true, enable '--extended-regexp' option by default.
+	Sets the default matching behavior. This option can be set to a
+	boolean value or one of 'basic', 'extended', 'fixed', or 'perl'
+	which will enable the '--basic-regexp', '--extended-regexp',
+	'--fixed-strings' or '--perl-regexp' options accordingly. The value
+	of 'true' is equivalent to 'extended'.


 OPTIONS
diff --git a/builtin/grep.c b/builtin/grep.c
index 29adb0a..249fc7d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -260,6 +260,55 @@ static int wait_all(void)
 }
 #endif

+static int parse_pattern_type_arg(const char *opt, const char *arg)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		return GREP_PATTERN_TYPE_ERE;
+	case 0:
+		return GREP_PATTERN_TYPE_UNSPECIFIED;
+	default:
+		if (!strcmp(arg, "basic"))
+			return GREP_PATTERN_TYPE_BRE;
+		else if (!strcmp(arg, "extended"))
+			return GREP_PATTERN_TYPE_ERE;
+		else if (!strcmp(arg, "fixed"))
+			return GREP_PATTERN_TYPE_FIXED;
+		else if (!strcmp(arg, "perl"))
+			return GREP_PATTERN_TYPE_PCRE;
+		die("bad %s argument: %s", opt, arg);
+	}
+}
+
+static void grep_pattern_type_options(const int pattern_type, void *cb)
+{
+	struct grep_opt *opt = cb;
+
+	switch (pattern_type) {
+		case GREP_PATTERN_TYPE_BRE:
+			opt->fixed = 0;
+			opt->pcre = 0;
+			opt->regflags &= ~REG_EXTENDED;
+			break;
+
+		case GREP_PATTERN_TYPE_ERE:
+			opt->fixed = 0;
+			opt->pcre = 0;
+			opt->regflags |= REG_EXTENDED;
+			break;
+
+		case GREP_PATTERN_TYPE_FIXED:
+			opt->fixed = 1;
+			opt->pcre = 0;
+			break;
+
+		case GREP_PATTERN_TYPE_PCRE:
+			opt->fixed = 0;
+			opt->pcre = 1;
+			break;
+	}
+}
+
 static int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
@@ -269,10 +318,7 @@ static int grep_config(const char *var, const char *value, void *cb)
 		return -1;

 	if (!strcmp(var, "grep.extendedregexp")) {
-		if (git_config_bool(var, value))
-			opt->regflags |= REG_EXTENDED;
-		else
-			opt->regflags &= ~REG_EXTENDED;
+		grep_pattern_type_options(parse_pattern_type_arg(var, value), opt);
 		return 0;
 	}

@@ -669,14 +715,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int i;
 	int dummy;
 	int use_index = 1;
-	enum {
-		pattern_type_unspecified = 0,
-		pattern_type_bre,
-		pattern_type_ere,
-		pattern_type_fixed,
-		pattern_type_pcre,
-	};
-	int pattern_type = pattern_type_unspecified;
+	int pattern_type = GREP_PATTERN_TYPE_UNSPECIFIED;

 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
@@ -705,16 +744,16 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_SET_INT('E', "extended-regexp", &pattern_type,
 			    "use extended POSIX regular expressions",
-			    pattern_type_ere),
+			    GREP_PATTERN_TYPE_ERE),
 		OPT_SET_INT('G', "basic-regexp", &pattern_type,
 			    "use basic POSIX regular expressions (default)",
-			    pattern_type_bre),
+			    GREP_PATTERN_TYPE_BRE),
 		OPT_SET_INT('F', "fixed-strings", &pattern_type,
 			    "interpret patterns as fixed strings",
-			    pattern_type_fixed),
+			    GREP_PATTERN_TYPE_FIXED),
 		OPT_SET_INT('P', "perl-regexp", &pattern_type,
 			    "use Perl-compatible regular expressions",
-			    pattern_type_pcre),
+			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOLEAN('n', "line-number", &opt.linenum, "show line numbers"),
 		OPT_NEGBIT('h', NULL, &opt.pathname, "don't show filenames", 1),
@@ -824,28 +863,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
-	switch (pattern_type) {
-	case pattern_type_fixed:
-		opt.fixed = 1;
-		opt.pcre = 0;
-		break;
-	case pattern_type_bre:
-		opt.fixed = 0;
-		opt.pcre = 0;
-		opt.regflags &= ~REG_EXTENDED;
-		break;
-	case pattern_type_ere:
-		opt.fixed = 0;
-		opt.pcre = 0;
-		opt.regflags |= REG_EXTENDED;
-		break;
-	case pattern_type_pcre:
-		opt.fixed = 0;
-		opt.pcre = 1;
-		break;
-	default:
-		break; /* nothing */
-	}
+
+	grep_pattern_type_options(pattern_type, &opt);

 	if (use_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
diff --git a/grep.h b/grep.h
index ed7de6b..eb844a0 100644
--- a/grep.h
+++ b/grep.h
@@ -58,6 +58,14 @@ enum grep_expr_node {
 	GREP_NODE_OR
 };

+enum grep_pattern_type {
+	GREP_PATTERN_TYPE_UNSPECIFIED = 0,
+	GREP_PATTERN_TYPE_BRE,
+	GREP_PATTERN_TYPE_ERE,
+	GREP_PATTERN_TYPE_FIXED,
+	GREP_PATTERN_TYPE_PCRE
+};
+
 struct grep_expr {
 	enum grep_expr_node node;
 	unsigned hit;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 523d041..c21cd61 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -250,6 +250,36 @@ do
 		git -c grep.extendedRegexp=true grep "a+b*c" ab >actual &&
 		test_cmp expected actual
 	'
+
+	test_expect_success "grep $L with grep.extendedRegexp=extended" '
+		echo "ab:abc" >expected &&
+		git -c grep.extendedregexp=extended grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp=fixed" '
+		echo "ab:abc" >expected &&
+		git -c grep.extendedregexp=fixed grep "ab" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with a valid regexp and grep.extendedRegexp=fixed " '
+		test_must_fail git -c grep.extendedregexp=fixed grep "a*" ab
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp=basic" '
+		{
+			echo "ab:a+b*c"
+			echo "ab:a+bc"
+			echo "ab:abc"
+		} >expected &&
+		git -c grep.extendedregexp=basic grep "a*" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with a valid regexp and grep.extendedRegexp=basic " '
+		test_must_fail git -c grep.extendedregexp=basic grep "a?" ab
+	'
 done

 cat >expected <<EOF
@@ -731,6 +761,81 @@ test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=true' '
 	test_cmp expected actual
 '

+test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=basic' '
+	git -c grep.extendedregexp=basic \
+		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=extended' '
+	git -c grep.extendedregexp=extended \
+		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=fixed' '
+	git -c grep.extendedregexp=fixed \
+		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep pattern with grep.extendedRegexp=perl' '
+	git -c grep.extendedregexp=perl \
+		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -E pattern with grep.extendedRegexp=perl' '
+	test_must_fail git -c grep.extendedregexp=perl \
+		grep -E "\p{Ps}.*?\p{Pe}" hello.c
+'
+
+test_expect_success 'grep -G pattern with grep.extendedRegexp=perl' '
+	test_must_fail git -c grep.extendedregexp=perl \
+		grep -G "\p{Ps}.*?\p{Pe}" hello.c
+'
+
+test_expect_success 'grep pattern with grep.extendedRegexp=fixed' '
+	>empty &&
+	test_must_fail git -c grep.extendedregexp=fixed \
+		grep ".*" ab >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'grep -E pattern with grep.extendedRegexp=basic' '
+	{
+		echo "ab:a+b*c"
+		echo "ab:a+bc"
+		echo "ab:abc"
+	} >expected &&
+	git -c grep.extendedregexp=basic \
+		grep -E ".?" ab >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -E pattern with grep.extendedRegexp=fixed' '
+	{
+		echo "ab:a+b*c"
+		echo "ab:a+bc"
+		echo "ab:abc"
+	} >expected &&
+	git -c grep.extendedregexp=fixed \
+		grep -E ".?" ab >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -G pattern with grep.extendedRegexp=fixed' '
+	>empty &&
+	test_must_fail git -c grep.extendedregexp=fixed \
+		grep -G ".?" ab >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'grep with grep.extendedRegexp=nonsense properly dies' '
+	test_must_fail git -c grep.extendedregexp=nonsense \
+		grep "\p{Ps}.*?\p{Pe}" hello.c
+'
+
 test_expect_success LIBPCRE 'grep -P -v pattern' '
 	{
 		echo "ab:a+b*c"
--
1.7.11.3
