From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/6] git check-ref-format: add options --onelevel-ok and --refname-pattern
Date: Fri,  9 Sep 2011 13:46:14 +0200
Message-ID: <1315568778-3592-3-git-send-email-mhagger@alum.mit.edu>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 13:47:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1zXw-0005nF-2j
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 13:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933557Ab1IILqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 07:46:55 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:46244 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758765Ab1IILql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 07:46:41 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R1zTY-0002Qy-AP; Fri, 09 Sep 2011 13:42:28 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181053>

Also add tests of the new options.  (Actually, one big reason to add
the new options is to make it easy to test check_ref_format(), though
the options should also be useful to other scripts.)

Interpret the result of check_ref_format() based on which types of
refnames are allowed.  However, because check_ref_format() can only
return a single value, one test case is still broken.  Specifically,
the case "git check-ref-format --onelevel '*'" incorrectly succeeds
because check_ref_format() returns CHECK_REF_FORMAT_ONELEVEL for this
refname even though the refname is also CHECK_REF_FORMAT_WILDCARD.
The type of check that leads to this failure is used elsewhere in
"real" code and could lead to bugs; it will be fixed over the next few
commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

The failing test is expressed awkwardly in
t/t1402-check-ref-format.sh, but since it will be fixed in the next
commit it doesn't seem worth investing any work in it.

 Documentation/git-check-ref-format.txt |   29 +++++++++--
 builtin/check-ref-format.c             |   56 +++++++++++++++++---
 t/t1402-check-ref-format.sh            |   87 +++++++++++++++++++++++++++++---
 3 files changed, 151 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index c9fdf84..3ab22b9 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -8,8 +8,8 @@ git-check-ref-format - Ensures that a reference name is well formed
 SYNOPSIS
 --------
 [verse]
-'git check-ref-format' <refname>
-'git check-ref-format' --print <refname>
+'git check-ref-format' [--print]
+       [--[no-]allow-onelevel] [--refspec-pattern] <refname>
 'git check-ref-format' --branch <branchname-shorthand>
 
 DESCRIPTION
@@ -32,14 +32,18 @@ git imposes the following rules on how references are named:
 
 . They must contain at least one `/`. This enforces the presence of a
   category like `heads/`, `tags/` etc. but the actual names are not
-  restricted.
+  restricted.  If the `--allow-onelevel` option is used, this rule
+  is waived.
 
 . They cannot have two consecutive dots `..` anywhere.
 
 . They cannot have ASCII control characters (i.e. bytes whose
   values are lower than \040, or \177 `DEL`), space, tilde `~`,
-  caret `{caret}`, colon `:`, question-mark `?`, asterisk `*`,
-  or open bracket `[` anywhere.
+  caret `{caret}`, or colon `:` anywhere.
+
+. They cannot have question-mark `?`, asterisk `*`, or open bracket
+  `[` anywhere.  See the `--refspec-pattern` option below for an
+  exception to this rule.
 
 . They cannot end with a slash `/` nor a dot `.`.
 
@@ -78,6 +82,21 @@ were on.  This option should be used by porcelains to accept this
 syntax anywhere a branch name is expected, so they can act as if you
 typed the branch name.
 
+OPTIONS
+-------
+--allow-onelevel::
+--no-allow-onelevel::
+	Controls whether one-level refnames are accepted (i.e.,
+	refnames that do not contain multiple `/`-separated
+	components).  The default is `--no-allow-onelevel`.
+
+--refspec-pattern::
+	Interpret <refname> as a reference name pattern for a refspec
+	(as used with remote repositories).  If this option is
+	enabled, <refname> is allowed to contain a single `*` in place
+	of a one full pathname component (e.g., `foo/*/bar` but not
+	`foo/bar*`).
+
 EXAMPLES
 --------
 
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 0723cf2..6bb9377 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static const char builtin_check_ref_format_usage[] =
-"git check-ref-format [--print] <refname>\n"
+"git check-ref-format [--print] [options] <refname>\n"
 "   or: git check-ref-format --branch <branchname-shorthand>";
 
 /*
@@ -45,27 +45,65 @@ static int check_ref_format_branch(const char *arg)
 	return 0;
 }
 
-static int check_ref_format_print(const char *arg)
+static void refname_format_print(const char *arg)
 {
 	char *refname = xmalloc(strlen(arg) + 1);
 
-	if (check_ref_format(arg))
-		return 1;
 	collapse_slashes(refname, arg);
 	printf("%s\n", refname);
-	return 0;
 }
 
+#define REFNAME_ALLOW_ONELEVEL 1
+#define REFNAME_REFSPEC_PATTERN 2
+
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
+	int i;
+	int print = 0;
+	int flags = 0;
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_check_ref_format_usage);
 
 	if (argc == 3 && !strcmp(argv[1], "--branch"))
 		return check_ref_format_branch(argv[2]);
-	if (argc == 3 && !strcmp(argv[1], "--print"))
-		return check_ref_format_print(argv[2]);
-	if (argc != 2)
+
+	for (i = 1; i < argc && argv[i][0] == '-'; ++i) {
+		if (!strcmp(argv[i], "--print"))
+			print = 1;
+		else if (!strcmp(argv[i], "--allow-onelevel"))
+			flags |= REFNAME_ALLOW_ONELEVEL;
+		else if (!strcmp(argv[i], "--no-allow-onelevel"))
+			flags &= ~REFNAME_ALLOW_ONELEVEL;
+		else if (!strcmp(argv[i], "--refspec-pattern"))
+			flags |= REFNAME_REFSPEC_PATTERN;
+		else
+			usage(builtin_check_ref_format_usage);
+	}
+	if (! (i == argc - 1))
 		usage(builtin_check_ref_format_usage);
-	return !!check_ref_format(argv[1]);
+
+	switch (check_ref_format(argv[i])) {
+	case CHECK_REF_FORMAT_OK:
+		break;
+	case CHECK_REF_FORMAT_ERROR:
+		return 1;
+	case CHECK_REF_FORMAT_ONELEVEL:
+		if (!(flags & REFNAME_ALLOW_ONELEVEL))
+			return 1;
+		else
+			break;
+	case CHECK_REF_FORMAT_WILDCARD:
+		if (!(flags & REFNAME_REFSPEC_PATTERN))
+			return 1;
+		else
+			break;
+	default:
+		die("internal error: unexpected value from check_ref_format()");
+	}
+
+	if (print)
+		refname_format_print(argv[i]);
+
+	return 0;
 }
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index ed4275a..95dcd31 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -5,23 +5,35 @@ test_description='Test git check-ref-format'
 . ./test-lib.sh
 
 valid_ref() {
-	test_expect_success "ref name '$1' is valid" \
-		"git check-ref-format '$1'"
+	if test "$#" = 1
+	then
+		test_expect_success "ref name '$1' is valid" \
+			"git check-ref-format '$1'"
+	else
+		test_expect_success "ref name '$1' is valid with options $2" \
+			"git check-ref-format $2 '$1'"
+	fi
 }
 invalid_ref() {
-	test_expect_success "ref name '$1' is not valid" \
-		"test_must_fail git check-ref-format '$1'"
+	if test "$#" = 1
+	then
+		test_expect_success "ref name '$1' is invalid" \
+			"test_must_fail git check-ref-format '$1'"
+	else
+		test_expect_success "ref name '$1' is invalid with options $2" \
+			"test_must_fail git check-ref-format $2 '$1'"
+	fi
 }
 
-valid_ref 'heads/foo'
-invalid_ref 'foo'
 valid_ref 'foo/bar/baz'
 valid_ref 'refs///heads/foo'
 invalid_ref 'heads/foo/'
 valid_ref '/heads/foo'
 valid_ref '///heads/foo'
-invalid_ref '/foo'
 invalid_ref './foo'
+invalid_ref './foo/bar'
+invalid_ref 'foo/./bar'
+invalid_ref 'foo/bar/.'
 invalid_ref '.refs/foo'
 invalid_ref 'heads/foo..bar'
 invalid_ref 'heads/foo?bar'
@@ -33,6 +45,67 @@ invalid_ref 'heads/foo\bar'
 invalid_ref "$(printf 'heads/foo\t')"
 invalid_ref "$(printf 'heads/foo\177')"
 valid_ref "$(printf 'heads/fu\303\237')"
+invalid_ref 'heads/*foo/bar' --refspec-pattern
+invalid_ref 'heads/foo*/bar' --refspec-pattern
+invalid_ref 'heads/f*o/bar' --refspec-pattern
+
+ref='foo'
+invalid_ref "$ref"
+valid_ref "$ref" --allow-onelevel
+invalid_ref "$ref" --refspec-pattern
+valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+
+ref='foo/bar'
+valid_ref "$ref"
+valid_ref "$ref" --allow-onelevel
+valid_ref "$ref" --refspec-pattern
+valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+
+ref='foo/*'
+invalid_ref "$ref"
+invalid_ref "$ref" --allow-onelevel
+valid_ref "$ref" --refspec-pattern
+valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+
+ref='*/foo'
+invalid_ref "$ref"
+invalid_ref "$ref" --allow-onelevel
+valid_ref "$ref" --refspec-pattern
+valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+
+ref='foo/*/bar'
+invalid_ref "$ref"
+invalid_ref "$ref" --allow-onelevel
+valid_ref "$ref" --refspec-pattern
+valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+
+ref='*'
+invalid_ref "$ref"
+
+#invalid_ref "$ref" --allow-onelevel
+test_expect_failure "ref name '$ref' is invalid with options --allow-onelevel" \
+	"test_must_fail git check-ref-format --allow-onelevel '$ref'"
+
+invalid_ref "$ref" --refspec-pattern
+valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+
+ref='foo/*/*'
+invalid_ref "$ref" --refspec-pattern
+invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
+
+ref='*/foo/*'
+invalid_ref "$ref" --refspec-pattern
+invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
+
+ref='*/*/foo'
+invalid_ref "$ref" --refspec-pattern
+invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
+
+ref='/foo'
+invalid_ref "$ref"
+valid_ref "$ref" --allow-onelevel
+invalid_ref "$ref" --refspec-pattern
+valid_ref "$ref" '--refspec-pattern --allow-onelevel'
 
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
-- 
1.7.6.8.gd2879
