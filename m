From: J Smith <dark.panda@gmail.com>
Subject: [PATCH/RFC] grep: add a grep.patternType configuration setting
Date: Wed,  1 Aug 2012 14:29:41 -0400
Message-ID: <1343845781-69246-1-git-send-email-dark.panda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 20:29:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swdg7-0005zV-Al
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 20:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab2HAS3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 14:29:45 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45674 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab2HAS3o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 14:29:44 -0400
Received: by vcbfk26 with SMTP id fk26so7348123vcb.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=1iU81gGMmVOrXkq0hW5IN+o7QwIfovPzUSmgfvzXrHo=;
        b=Niqug4iezOdzAKBduM1BiumrZWu/uKNkc7/fN4s6qxGa/09ib1hs5tTzlxwR4zxLOz
         N9956Tu8r7MCcY0sY/ulAi9rn8+Gw2vALX8zd0v5HPJVYthN+tO+Mi5zpdaBFSKzncoG
         Pzc9rAazvbKG/XCO9W4ABOBZrBM9qFay2iboMRNdjIphs9fFOUfbALWny2TeKB0NTRAh
         QFtnAew7NzSRucEzgz6qZwixt3MGoA3OgPOpUilPtHQPcWOBVhoKBkrNgy2rorA5w7U1
         orBT+KKGF9phm58kCRYfmgCB2ejXMmpJR9/VEODQbhbTV5+KcXYD9ZdgKxZ24mZOmFTm
         WmqA==
Received: by 10.52.98.3 with SMTP id ee3mr10451487vdb.127.1343845783246;
        Wed, 01 Aug 2012 11:29:43 -0700 (PDT)
Received: from localhost.localdomain (surf3.net.rss.rogers.com. [24.114.255.3])
        by mx.google.com with ESMTPS id bj6sm3395990vdc.12.2012.08.01.11.29.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2012 11:29:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202718>

Adds the grep.patternType configuration setting which sets the default
pattern matching behavior. The values "basic", "extended", "fixed", and
"perl" can be used to set "--basic-regexp", "--extended-regexp",
"--fixed-strings", and "--perl-regexp" options by default respectively.

A value of true is equivalent to "extended" as with grep.extendedRegexp,
and a value of false leaves the pattern type as unspecified and follows
the default grep behavior.

This setting overrides the value set in grep.extendedRegexp which will
be ignored completely if grep.patternType is set.
---
 Documentation/config.txt   |  11 ++-
 Documentation/git-grep.txt |  11 ++-
 builtin/grep.c             | 106 ++++++++++++++++---------
 grep.h                     |   9 +++
 t/t7810-grep.sh            | 187 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 284 insertions(+), 40 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a95e5a4..38d56d8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1210,8 +1210,17 @@ gitweb.snapshot::
 grep.lineNumber::
 	If set to true, enable '-n' option by default.

+grep.patternType::
+	Sets the default matching behavior. This option can be set to a
+	boolean value or one of 'basic', 'extended', 'fixed', or 'perl'
+	which will enable the '--basic-regexp', '--extended-regexp',
+	'--fixed-strings' or '--perl-regexp' options accordingly. The value
+	of true is equivalent to 'extended' while false leaves the
+	settings in their default state.
+
 grep.extendedRegexp::
-	If set to true, enable '--extended-regexp' option by default.
+	If set to true, enable '--extended-regexp' option by default. This
+	option is ignored when the 'grep.patternType' option is set.

 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3bec036..f56f67f 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -42,8 +42,17 @@ CONFIGURATION
 grep.lineNumber::
 	If set to true, enable '-n' option by default.

+grep.patternType::
+	Sets the default matching behavior. This option can be set to a
+	boolean value or one of 'basic', 'extended', 'fixed', or 'perl'
+	which will enable the '--basic-regexp', '--extended-regexp',
+	'--fixed-strings' or '--perl-regexp' options accordingly. The value
+	of true is equivalent to 'extended' while false leaves the
+	settings in their default state.
+
 grep.extendedRegexp::
-	If set to true, enable '--extended-regexp' option by default.
+	If set to true, enable '--extended-regexp' option by default. This
+	option is ignored when the 'grep.patternType' option is set.


 OPTIONS
diff --git a/builtin/grep.c b/builtin/grep.c
index 29adb0a..1de7e76 100644
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
+static void grep_pattern_type_options(const int pattern_type, struct grep_opt *opt)
+{
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
+			opt->regflags &= ~REG_EXTENDED;
+			break;
+
+		case GREP_PATTERN_TYPE_PCRE:
+			opt->fixed = 0;
+			opt->pcre = 1;
+			opt->regflags &= ~REG_EXTENDED;
+			break;
+	}
+}
+
 static int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
@@ -269,13 +318,21 @@ static int grep_config(const char *var, const char *value, void *cb)
 		return -1;

 	if (!strcmp(var, "grep.extendedregexp")) {
-		if (git_config_bool(var, value))
-			opt->regflags |= REG_EXTENDED;
-		else
-			opt->regflags &= ~REG_EXTENDED;
+		if (!opt->pattern_type_used) {
+			if (git_config_bool(var, value))
+				opt->regflags |= REG_EXTENDED;
+			else
+				opt->regflags &= ~REG_EXTENDED;
+		}
 		return 0;
 	}

+	if (!strcmp(var, "grep.patterntype")) {
+		grep_pattern_type_options(parse_pattern_type_arg(var, value), opt);
+		opt->pattern_type_used = 1;
+		return 0;
+  }
+
 	if (!strcmp(var, "grep.linenumber")) {
 		opt->linenum = git_config_bool(var, value);
 		return 0;
@@ -669,14 +726,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
@@ -705,16 +755,16 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
@@ -824,28 +874,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
index ed7de6b..9a6cdde 100644
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
@@ -103,6 +111,7 @@ struct grep_opt {
 	int max_depth;
 	int funcname;
 	int funcbody;
+	int pattern_type_used;
 	char color_context[COLOR_MAXLEN];
 	char color_filename[COLOR_MAXLEN];
 	char color_function[COLOR_MAXLEN];
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 523d041..4fa24b4 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -245,11 +245,41 @@ do
 		test_cmp expected actual
 	'

+	test_expect_success "grep $L with grep.patternType=false" '
+		echo "ab:a+bc" >expected &&
+		git -c grep.patternType=false grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L with grep.extendedRegexp=true" '
 		echo "ab:abc" >expected &&
 		git -c grep.extendedRegexp=true grep "a+b*c" ab >actual &&
 		test_cmp expected actual
 	'
+
+	test_expect_success "grep $L with grep.patternType=true" '
+		echo "ab:abc" >expected &&
+		git -c grep.patternType=true grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.patternType=false and grep.extendedRegexp=true" '
+		echo "ab:a+bc" >expected &&
+		git \
+			-c grep.patternType=false \
+			-c grep.extendedRegexp=true \
+			grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.patternType=true and grep.extendedRegexp=false" '
+		echo "ab:abc" >expected &&
+		git \
+			-c grep.patternType=true \
+			-c grep.extendedRegexp=false \
+			grep "a+b*c" ab >actual &&
+		test_cmp expected actual
+	'
 done

 cat >expected <<EOF
@@ -725,12 +755,43 @@ test_expect_success 'grep pattern with grep.extendedRegexp=true' '
 	test_cmp empty actual
 '

+test_expect_success 'grep pattern with grep.patternType=true' '
+	>empty &&
+	test_must_fail git -c grep.patternType=true \
+		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'grep pattern with grep.patternType=basic and grep.extendedRegexp=true' '
+	>empty &&
+	test_must_fail git \
+		-c grep.patterntype=basic \
+		-c grep.extendedregexp=true \
+		grep "a?" hello.c >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'grep pattern with grep.patternType=false and grep.extendedRegexp=true' '
+	>empty &&
+	test_must_fail git \
+		-c grep.patterntype=false \
+		-c grep.extendedregexp=true \
+		grep "a?" hello.c >actual &&
+	test_cmp empty actual
+'
+
 test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=true' '
 	git -c grep.extendedregexp=true \
 		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '

+test_expect_success LIBPCRE 'grep pattern with grep.patternType=perl' '
+	git -c grep.patternType=perl \
+		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success LIBPCRE 'grep -P -v pattern' '
 	{
 		echo "ab:a+b*c"
@@ -761,44 +822,170 @@ test_expect_success 'grep -G invalidpattern properly dies ' '
 	test_must_fail git grep -G "a["
 '

+test_expect_success 'grep invalidpattern properly dies with grep.patternType=basic' '
+	test_must_fail git -c patterntype=basic grep "a["
+'
+
 test_expect_success 'grep -E invalidpattern properly dies ' '
 	test_must_fail git grep -E "a["
 '

+test_expect_success 'grep invalidpattern properly dies with grep.patternType=extended' '
+	test_must_fail git -c patterntype=extended grep "a["
+'
+
 test_expect_success LIBPCRE 'grep -P invalidpattern properly dies ' '
 	test_must_fail git grep -P "a["
 '

+test_expect_success LIBPCRE 'grep invalidpattern properly dies with grep.patternType=perl' '
+	test_must_fail git -c patterntype=perl grep "a["
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
+test_expect_success LIBPCRE 'grep -P pattern with grep.patternType=fixed, =basic, =extended' '
+	echo "ab:a+b*c" >expected &&
+	git \
+		-c grep.patterntype=fixed \
+		-c grep.patterntype=basic \
+		-c grep.patterntype=extended \
+		-c grep.patterntype=perl \
+		grep -P "a\x{2b}b\x{2a}c" ab >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -F pattern with grep.patternType=fixed, =basic, =extended, =perl' '
+	echo "ab:a+b*c" >expected &&
+	git \
+		-c grep.patterntype=fixed \
+		-c grep.patterntype=basic \
+		-c grep.patterntype=extended \
+		-c grep.patterntype=perl \
+		grep -F "*c" ab >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -G pattern with grep.patternType=fixed, =basic, =extended, =perl' '
+	{
+		echo "ab:a+b*c"
+		echo "ab:a+bc"
+	} >expected &&
+	git \
+		-c grep.patterntype=fixed \
+		-c grep.patterntype=basic \
+		-c grep.patterntype=extended \
+		-c grep.patterntype=perl \
+		grep -G "a+b" ab >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -E pattern with grep.patternType=fixed, =basic, =extended, =perl' '
+	{
+		echo "ab:a+b*c"
+		echo "ab:a+bc"
+		echo "ab:abc"
+	} >expected &&
+	git \
+		-c grep.patterntype=fixed \
+		-c grep.patterntype=basic \
+		-c grep.patterntype=extended \
+		-c grep.patterntype=perl \
+		grep -E "a+" ab >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep pattern with grep.patternType=extended and grep.extendedRegexp=false' '
+	cat >expected <<-EOF
+	hello.c:int main(int argc, const char **argv)
+	EOF
+	git \
+		-c grep.patterntype=extended \
+		-c grep.extendedregexp=false \
+		grep "con?st" hello.c >actual &&
+	test_cmp expected actual
+'
+
 test_config() {
 	git config "$1" "$2" &&
 	test_when_finished "git config --unset $1"
--
1.7.11.3
