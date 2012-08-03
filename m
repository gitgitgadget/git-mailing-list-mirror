From: J Smith <dark.panda@gmail.com>
Subject: [PATCH/RFC] grep: add a grep.patternType configuration setting
Date: Fri,  3 Aug 2012 10:53:50 -0400
Message-ID: <1344005630-6541-1-git-send-email-dark.panda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 16:54:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxJGK-0005IM-2s
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 16:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab2HCOxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 10:53:54 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50121 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab2HCOxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 10:53:53 -0400
Received: by qcro28 with SMTP id o28so445396qcr.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=G0/2dnw5wlD3yhNmcyl6dTYxjNEmqBjhmU6zWtP7u/A=;
        b=zRBMyIYujoqleenbgc/PbLlZgCB3yQb/w6e1aOBDSjeHeFPK1pi0hYVGOsAaasXNz8
         tgA3JZBSVDdeVO86IX9goB/LnhN/ynuHc9LIyUIqRNWipxp8EdIBpsiu9GeL8gsV3NXk
         /LMAJxWLBma1lup/U08cfk7T7V3OAa/i+Us6SYiHlTFUuuZeVkua6Pej0HDUzwE10+Ux
         RdOBbb/Ru405Y/DRVLlhXbzwhMP8EnjaeRxF3zVL1v55tj/A3Bvh2g7ScbDkbUL3z4G/
         kCoUaUwse+z0DQbTf1Uf9GoKDqPrzm2/R+O1t6KMn6SmTnCH37gp6hAMTm2e7AL9f4du
         zc3g==
Received: by 10.224.76.211 with SMTP id d19mr3253289qak.29.1344005632577;
        Fri, 03 Aug 2012 07:53:52 -0700 (PDT)
Received: from gobstopper.rogers.com ([173.209.148.66])
        by mx.google.com with ESMTPS id ga2sm7494496qab.17.2012.08.03.07.53.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 07:53:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202837>

The grep.extendedRegexp configuration setting enables the -E flag on grep
by default but there are no equivalents for the -G, -F and -P flags.

Rather than adding an additional setting for grep.fooRegexp for current
and future pattern matching options, add a grep.patternType setting that
can accept appropriate values for modifying the default grep pattern
matching behavior. The current values are "basic", "extended", "fixed",
"perl" and "default" for setting -G, -E, -F, -P and the default behavior
respectively.

When grep.patternType is set to a value other than "default", the
grep.extendedRegexp setting is ignored. The value of "default" restores
the current default behavior, including the grep.extendedRegexp
behavior.

Signed-off-by: J Smith <dark.panda@gmail.com>
---
 Documentation/config.txt   |  10 ++-
 Documentation/git-grep.txt |  10 ++-
 builtin/grep.c             | 112 ++++++++++++++++++----------
 grep.h                     |  10 +++
 t/t7810-grep.sh            | 181 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 282 insertions(+), 41 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a95e5a4..6416cae 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1210,8 +1210,16 @@ gitweb.snapshot::
 grep.lineNumber::
 	If set to true, enable '-n' option by default.

+grep.patternType::
+	Set the default matching behavior. Using a value of 'basic', 'extended',
+	'fixed', or 'perl' will enable the '--basic-regexp', '--extended-regexp',
+	'--fixed-strings', or '--perl-regexp' option accordingly, while the
+	value 'default' will return to the default matching behavior.
+
 grep.extendedRegexp::
-	If set to true, enable '--extended-regexp' option by default.
+	If set to true, enable '--extended-regexp' option by default. This
+	option is ignored when the 'grep.patternType' option is set to a value
+	other than 'default'.

 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3bec036..cfecf84 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -42,8 +42,16 @@ CONFIGURATION
 grep.lineNumber::
 	If set to true, enable '-n' option by default.

+grep.patternType::
+	Set the default matching behavior. Using a value of 'basic', 'extended',
+	'fixed', or 'perl' will enable the '--basic-regexp', '--extended-regexp',
+	'--fixed-strings', or '--perl-regexp' option accordingly, while the
+	value 'default' will return to the default matching behavior.
+
 grep.extendedRegexp::
-	If set to true, enable '--extended-regexp' option by default.
+	If set to true, enable '--extended-regexp' option by default. This
+	option is ignored when the 'grep.patternType' option is set to a value
+	other than 'default'.


 OPTIONS
diff --git a/builtin/grep.c b/builtin/grep.c
index 29adb0a..7ff64da 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -260,6 +260,53 @@ static int wait_all(void)
 }
 #endif

+static int parse_pattern_type_arg(const char *opt, const char *arg)
+{
+	if (!strcmp(arg, "default"))
+		return GREP_PATTERN_TYPE_UNSPECIFIED;
+	else if (!strcmp(arg, "basic"))
+		return GREP_PATTERN_TYPE_BRE;
+	else if (!strcmp(arg, "extended"))
+		return GREP_PATTERN_TYPE_ERE;
+	else if (!strcmp(arg, "fixed"))
+		return GREP_PATTERN_TYPE_FIXED;
+	else if (!strcmp(arg, "perl"))
+		return GREP_PATTERN_TYPE_PCRE;
+	die("bad %s argument: %s", opt, arg);
+}
+
+static void grep_pattern_type_options(const int pattern_type, struct grep_opt *opt)
+{
+	switch (pattern_type) {
+	case GREP_PATTERN_TYPE_UNSPECIFIED:
+		/* fall through */
+
+	case GREP_PATTERN_TYPE_BRE:
+		opt->fixed = 0;
+		opt->pcre = 0;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_ERE:
+		opt->fixed = 0;
+		opt->pcre = 0;
+		opt->regflags |= REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_FIXED:
+		opt->fixed = 1;
+		opt->pcre = 0;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_PCRE:
+		opt->fixed = 0;
+		opt->pcre = 1;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+	}
+}
+
 static int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
@@ -270,12 +317,17 @@ static int grep_config(const char *var, const char *value, void *cb)

 	if (!strcmp(var, "grep.extendedregexp")) {
 		if (git_config_bool(var, value))
-			opt->regflags |= REG_EXTENDED;
+			opt->extended_regexp_option = 1;
 		else
-			opt->regflags &= ~REG_EXTENDED;
+			opt->extended_regexp_option = 0;
 		return 0;
 	}

+	if (!strcmp(var, "grep.patterntype")) {
+		opt->pattern_type_option = parse_pattern_type_arg(var, value);
+		return 0;
+  }
+
 	if (!strcmp(var, "grep.linenumber")) {
 		opt->linenum = git_config_bool(var, value);
 		return 0;
@@ -669,14 +721,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
+	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;

 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
@@ -703,18 +748,18 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			"descend at most <depth> levels", PARSE_OPT_NONEG,
 			NULL, 1 },
 		OPT_GROUP(""),
-		OPT_SET_INT('E', "extended-regexp", &pattern_type,
+		OPT_SET_INT('E', "extended-regexp", &pattern_type_arg,
 			    "use extended POSIX regular expressions",
-			    pattern_type_ere),
-		OPT_SET_INT('G', "basic-regexp", &pattern_type,
+			    GREP_PATTERN_TYPE_ERE),
+		OPT_SET_INT('G', "basic-regexp", &pattern_type_arg,
 			    "use basic POSIX regular expressions (default)",
-			    pattern_type_bre),
-		OPT_SET_INT('F', "fixed-strings", &pattern_type,
+			    GREP_PATTERN_TYPE_BRE),
+		OPT_SET_INT('F', "fixed-strings", &pattern_type_arg,
 			    "interpret patterns as fixed strings",
-			    pattern_type_fixed),
-		OPT_SET_INT('P', "perl-regexp", &pattern_type,
+			    GREP_PATTERN_TYPE_FIXED),
+		OPT_SET_INT('P', "perl-regexp", &pattern_type_arg,
 			    "use Perl-compatible regular expressions",
-			    pattern_type_pcre),
+			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOLEAN('n', "line-number", &opt.linenum, "show line numbers"),
 		OPT_NEGBIT('h', NULL, &opt.pathname, "don't show filenames", 1),
@@ -799,6 +844,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	opt.header_tail = &opt.header_list;
 	opt.regflags = REG_NEWLINE;
 	opt.max_depth = -1;
+	opt.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
+	opt.extended_regexp_option = 0;

 	strcpy(opt.color_context, "");
 	strcpy(opt.color_filename, "");
@@ -824,27 +871,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
+
+	if (pattern_type_arg > GREP_PATTERN_TYPE_UNSPECIFIED)
+		grep_pattern_type_options(pattern_type_arg, &opt);
+	else {
+		if (opt.pattern_type_option > GREP_PATTERN_TYPE_UNSPECIFIED)
+			grep_pattern_type_options(opt.pattern_type_option, &opt);
+		else if (opt.extended_regexp_option)
+			grep_pattern_type_options(GREP_PATTERN_TYPE_ERE, &opt);
 	}

 	if (use_index && !startup_info->have_repository)
diff --git a/grep.h b/grep.h
index ed7de6b..75afb7b 100644
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
@@ -103,6 +111,8 @@ struct grep_opt {
 	int max_depth;
 	int funcname;
 	int funcbody;
+	int extended_regexp_option;
+	int pattern_type_option;
 	char color_context[COLOR_MAXLEN];
 	char color_filename[COLOR_MAXLEN];
 	char color_function[COLOR_MAXLEN];
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 523d041..35d357d 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -250,6 +250,84 @@ do
 		git -c grep.extendedRegexp=true grep "a+b*c" ab >actual &&
 		test_cmp expected actual
 	'
+
+	test_expect_success "grep $L with grep.patterntype=basic" '
+		echo "ab:a+bc" >expected &&
+		git -c grep.patterntype=basic grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.patterntype=extended" '
+		echo "ab:abc" >expected &&
+		git -c grep.patterntype=extended grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.patterntype=fixed" '
+		echo "ab:a+b*c" >expected &&
+		git -c grep.patterntype=fixed grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success LIBPCRE "grep $L with grep.patterntype=perl" '
+		echo "ab:a+b*c" >expected &&
+		git -c grep.patterntype=perl grep "a\x{2b}b\x{2a}c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.patternType=default and grep.extendedRegexp=true" '
+		echo "ab:abc" >expected &&
+		git \
+			-c grep.patternType=default \
+			-c grep.extendedRegexp=true \
+			grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp=true and grep.patternType=default" '
+		echo "ab:abc" >expected &&
+		git \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=default \
+			grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success 'grep $L with grep.patternType=extended and grep.extendedRegexp=false' '
+		echo "ab:abc" >expected &&
+		git \
+			-c grep.patternType=extended \
+			-c grep.extendedRegexp=false \
+			grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success 'grep $L with grep.patternType=basic and grep.extendedRegexp=true' '
+		echo "ab:a+bc" >expected &&
+		git \
+			-c grep.patternType=basic \
+			-c grep.extendedRegexp=true \
+			grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success 'grep $L with grep.extendedRegexp=false and grep.patternType=extended' '
+		echo "ab:abc" >expected &&
+		git \
+			-c grep.extendedRegexp=false \
+			-c grep.patternType=extended \
+			grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success 'grep $L with grep.extendedRegexp=true and grep.patternType=basic' '
+		echo "ab:a+bc" >expected &&
+		git \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=basic \
+			grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
 done

 cat >expected <<EOF
@@ -761,44 +839,147 @@ test_expect_success 'grep -G invalidpattern properly dies ' '
 	test_must_fail git grep -G "a["
 '

+test_expect_success 'grep invalidpattern properly dies with grep.patternType=basic' '
+	test_must_fail git -c grep.patterntype=basic grep "a["
+'
+
 test_expect_success 'grep -E invalidpattern properly dies ' '
 	test_must_fail git grep -E "a["
 '

+test_expect_success 'grep invalidpattern properly dies with grep.patternType=extended' '
+	test_must_fail git -c grep.patterntype=extended grep "a["
+'
+
 test_expect_success LIBPCRE 'grep -P invalidpattern properly dies ' '
 	test_must_fail git grep -P "a["
 '

+test_expect_success LIBPCRE 'grep invalidpattern properly dies with grep.patternType=perl' '
+	test_must_fail git -c grep.patterntype=perl grep "a["
+'
+
 test_expect_success 'grep -G -E -F pattern' '
 	echo "ab:a+b*c" >expected &&
 	git grep -G -E -F "a+b*c" ab >actual &&
 	test_cmp expected actual
 '

+test_expect_success 'grep pattern with grep.patternType=basic, =extended, =fixed' '
+	echo "ab:a+b*c" >expected &&
+	git \
+		-c grep.patterntype=basic \
+		-c grep.patterntype=extended \
+		-c grep.patterntype=fixed \
+		grep "a+b*c" ab >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'grep -E -F -G pattern' '
 	echo "ab:a+bc" >expected &&
 	git grep -E -F -G "a+b*c" ab >actual &&
 	test_cmp expected actual
 '

+test_expect_success 'grep pattern with grep.patternType=extended, =fixed, =basic' '
+	echo "ab:a+bc" >expected &&
+	git \
+		-c grep.patterntype=extended \
+		-c grep.patterntype=fixed \
+		-c grep.patterntype=basic \
+		grep "a+b*c" ab >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'grep -F -G -E pattern' '
 	echo "ab:abc" >expected &&
 	git grep -F -G -E "a+b*c" ab >actual &&
 	test_cmp expected actual
 '

+test_expect_success 'grep pattern with grep.patternType=fixed, =basic, =extended' '
+	echo "ab:abc" >expected &&
+	git \
+		-c grep.patterntype=fixed \
+		-c grep.patterntype=basic \
+		-c grep.patterntype=extended \
+		grep "a+b*c" ab >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'grep -G -F -P -E pattern' '
 	>empty &&
 	test_must_fail git grep -G -F -P -E "a\x{2b}b\x{2a}c" ab >actual &&
 	test_cmp empty actual
 '

+test_expect_success 'grep pattern with grep.patternType=fixed, =basic, =perl, =extended' '
+	>empty &&
+	test_must_fail git \
+		-c grep.patterntype=fixed \
+		-c grep.patterntype=basic \
+		-c grep.patterntype=perl \
+		-c grep.patterntype=extended \
+		grep "a\x{2b}b\x{2a}c" ab >actual &&
+	test_cmp empty actual
+'
+
 test_expect_success LIBPCRE 'grep -G -F -E -P pattern' '
 	echo "ab:a+b*c" >expected &&
 	git grep -G -F -E -P "a\x{2b}b\x{2a}c" ab >actual &&
 	test_cmp expected actual
 '

+test_expect_success LIBPCRE 'grep pattern with grep.patternType=fixed, =basic, =extended, =perl' '
+	echo "ab:a+b*c" >expected &&
+	git \
+		-c grep.patterntype=fixed \
+		-c grep.patterntype=basic \
+		-c grep.patterntype=extended \
+		-c grep.patterntype=perl \
+		grep "a\x{2b}b\x{2a}c" ab >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep -P pattern with grep.patternType=fixed' '
+	echo "ab:a+b*c" >expected &&
+	git \
+		-c grep.patterntype=fixed \
+		grep -P "a\x{2b}b\x{2a}c" ab >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -F pattern with grep.patternType=basic' '
+	echo "ab:a+b*c" >expected &&
+	git \
+		-c grep.patterntype=basic \
+		grep -F "*c" ab >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -G pattern with grep.patternType=fixed' '
+	{
+		echo "ab:a+b*c"
+		echo "ab:a+bc"
+	} >expected &&
+	git \
+		-c grep.patterntype=fixed \
+		grep -G "a+b" ab >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -E pattern with grep.patternType=fixed' '
+	{
+		echo "ab:a+b*c"
+		echo "ab:a+bc"
+		echo "ab:abc"
+	} >expected &&
+	git \
+		-c grep.patterntype=fixed \
+		grep -E "a+" ab >actual &&
+	test_cmp expected actual
+'
+
 test_config() {
 	git config "$1" "$2" &&
 	test_when_finished "git config --unset $1"
--
1.7.11.3
