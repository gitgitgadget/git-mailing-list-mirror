From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/22] Change check_refname_format() to reject unnormalized refnames
Date: Thu, 15 Sep 2011 23:10:30 +0200
Message-ID: <1316121043-29367-10-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:11:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JDX-00066p-Dq
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934979Ab1IOVLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:11:11 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40106 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934975Ab1IOVLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:11:10 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8p-00019o-Gd; Thu, 15 Sep 2011 23:06:39 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181500>

Since much of the infrastructure does not work correctly with
unnormalized refnames, change check_refname_format() to reject them.

Similarly, change "git check-ref-format" to reject unnormalized
refnames by default.  But add an option --normalize, which causes "git
check-ref-format" to normalize the refname before checking its format,
and print the normalized refname.  This is exactly the behavior of the
old --print option, which is retained but deprecated.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-check-ref-format.txt |   26 ++++++++++++++++++--------
 builtin/check-ref-format.c             |   15 +++++++--------
 refs.c                                 |    3 ---
 refs.h                                 |    2 +-
 t/t1402-check-ref-format.sh            |   31 +++++++++++++++++++++++--------
 5 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 9114751..103e7b1 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -8,8 +8,9 @@ git-check-ref-format - Ensures that a reference name is well formed
 SYNOPSIS
 --------
 [verse]
-'git check-ref-format' [--print]
-       [--[no-]allow-onelevel] [--refspec-pattern] <refname>
+'git check-ref-format' [--normalize]
+       [--[no-]allow-onelevel] [--refspec-pattern]
+       <refname>
 'git check-ref-format' --branch <branchname-shorthand>
 
 DESCRIPTION
@@ -45,7 +46,11 @@ git imposes the following rules on how references are named:
   bracket `[` anywhere.  See the `--refspec-pattern` option below for
   an exception to this rule.
 
-. They cannot end with a slash `/` nor a dot `.`.
+. They cannot begin or end with a slash `/` or contain multiple
+  consecutive slashes (see the `--normalize` option below for an
+  exception to this rule)
+
+. They cannot end with a dot `.`.
 
 . They cannot contain a sequence `@{`.
 
@@ -70,10 +75,6 @@ reference name expressions (see linkgit:gitrevisions[7]):
 
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
-With the `--print` option, if 'refname' is acceptable, it prints the
-canonicalized name of a hypothetical reference with that name.  That is,
-it prints 'refname' with any extra `/` characters removed.
-
 With the `--branch` option, it expands the ``previous branch syntax''
 `@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
 were on.  This option should be used by porcelains to accept this
@@ -95,6 +96,15 @@ OPTIONS
 	in place of a one full pathname component (e.g.,
 	`foo/{asterisk}/bar` but not `foo/bar{asterisk}`).
 
+--normalize::
+	Normalize 'refname' by removing any leading slash (`/`)
+	characters and collapsing runs of adjacent slashes between
+	name components into a single slash.  Iff the normalized
+	refname is valid then print it to standard output and exit
+	with a status of 0.  (`--print` is a deprecated way to spell
+	`--normalize`.)
+
+
 EXAMPLES
 --------
 
@@ -107,7 +117,7 @@ $ git check-ref-format --branch @{-1}
 * Determine the reference name to use for a new branch:
 +
 ------------
-$ ref=$(git check-ref-format --print "refs/heads/$newbranch") ||
+$ ref=$(git check-ref-format --normalize "refs/heads/$newbranch") ||
 die "we do not like '$newbranch' as a branch name."
 ------------
 
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index f5df9aa..28a7320 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static const char builtin_check_ref_format_usage[] =
-"git check-ref-format [--print] [options] <refname>\n"
+"git check-ref-format [--normalize] [options] <refname>\n"
 "   or: git check-ref-format --branch <branchname-shorthand>";
 
 /*
@@ -51,7 +51,7 @@ static int check_ref_format_branch(const char *arg)
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int print = 0;
+	int normalize = 0;
 	int flags = 0;
 	const char *refname;
 
@@ -62,8 +62,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 		return check_ref_format_branch(argv[2]);
 
 	for (i = 1; i < argc && argv[i][0] == '-'; i++) {
-		if (!strcmp(argv[i], "--print"))
-			print = 1;
+		if (!strcmp(argv[i], "--normalize") || !strcmp(argv[i], "--print"))
+			normalize = 1;
 		else if (!strcmp(argv[i], "--allow-onelevel"))
 			flags |= REFNAME_ALLOW_ONELEVEL;
 		else if (!strcmp(argv[i], "--no-allow-onelevel"))
@@ -77,13 +77,12 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 		usage(builtin_check_ref_format_usage);
 
 	refname = argv[i];
+	if (normalize)
+		refname = collapse_slashes(refname);
 	if (check_refname_format(refname, flags))
 		return 1;
-
-	if (print) {
-		refname = collapse_slashes(refname);
+	if (normalize)
 		printf("%s\n", refname);
-	}
 
 	return 0;
 }
diff --git a/refs.c b/refs.c
index 5a0bd0f..d2aac24 100644
--- a/refs.c
+++ b/refs.c
@@ -908,9 +908,6 @@ int check_refname_format(const char *ref, int flags)
 	int component_len, component_count = 0;
 
 	while (1) {
-		while (*ref == '/')
-			ref++; /* tolerate leading and repeated slashes */
-
 		/* We are at the start of a path component. */
 		component_len = check_refname_component(ref);
 		if (component_len < 0) {
diff --git a/refs.h b/refs.h
index 48540c0..b0da5fc 100644
--- a/refs.h
+++ b/refs.h
@@ -106,7 +106,7 @@ extern int for_each_reflog(each_ref_fn, void *);
  * REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
  * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
  * allow a "*" wildcard character in place of one of the name
- * components.
+ * components.  No leading or repeated slashes are accepted.
  */
 extern int check_refname_format(const char *ref, int flags);
 
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 419788f..710fcca 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -28,11 +28,17 @@ invalid_ref() {
 invalid_ref ''
 invalid_ref '/'
 invalid_ref '/' --allow-onelevel
+invalid_ref '/' --normalize
+invalid_ref '/' '--allow-onelevel --normalize'
 valid_ref 'foo/bar/baz'
-valid_ref 'refs///heads/foo'
+valid_ref 'foo/bar/baz' --normalize
+invalid_ref 'refs///heads/foo'
+valid_ref 'refs///heads/foo' --normalize
 invalid_ref 'heads/foo/'
-valid_ref '/heads/foo'
-valid_ref '///heads/foo'
+invalid_ref '/heads/foo'
+valid_ref '/heads/foo' --normalize
+invalid_ref '///heads/foo'
+valid_ref '///heads/foo' --normalize
 invalid_ref './foo'
 invalid_ref './foo/bar'
 invalid_ref 'foo/./bar'
@@ -60,12 +66,15 @@ invalid_ref "$ref"
 valid_ref "$ref" --allow-onelevel
 invalid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+invalid_ref "$ref" --normalize
+valid_ref "$ref" '--allow-onelevel --normalize'
 
 ref='foo/bar'
 valid_ref "$ref"
 valid_ref "$ref" --allow-onelevel
 valid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+valid_ref "$ref" --normalize
 
 ref='foo/*'
 invalid_ref "$ref"
@@ -78,6 +87,8 @@ invalid_ref "$ref"
 invalid_ref "$ref" --allow-onelevel
 valid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+invalid_ref "$ref" --normalize
+valid_ref "$ref" '--refspec-pattern --normalize'
 
 ref='foo/*/bar'
 invalid_ref "$ref"
@@ -105,9 +116,13 @@ invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
 
 ref='/foo'
 invalid_ref "$ref"
-valid_ref "$ref" --allow-onelevel
+invalid_ref "$ref" --allow-onelevel
 invalid_ref "$ref" --refspec-pattern
-valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
+invalid_ref "$ref" --normalize
+valid_ref "$ref" '--allow-onelevel --normalize'
+invalid_ref "$ref" '--refspec-pattern --normalize'
+valid_ref "$ref" '--refspec-pattern --allow-onelevel --normalize'
 
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
@@ -141,12 +156,12 @@ test_expect_success 'check-ref-format --branch from subdir' '
 
 valid_ref_normalized() {
 	test_expect_success "ref name '$1' simplifies to '$2'" "
-		refname=\$(git check-ref-format --print '$1') &&
+		refname=\$(git check-ref-format --normalize '$1') &&
 		test \"\$refname\" = '$2'"
 }
 invalid_ref_normalized() {
-	test_expect_success "check-ref-format --print rejects '$1'" "
-		test_must_fail git check-ref-format --print '$1'"
+	test_expect_success "check-ref-format --normalize rejects '$1'" "
+		test_must_fail git check-ref-format --normalize '$1'"
 }
 
 valid_ref_normalized 'heads/foo' 'heads/foo'
-- 
1.7.6.8.gd2879
