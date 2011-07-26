From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/19] git-check-attr: Add an --all option to show all attributes
Date: Tue, 26 Jul 2011 16:12:59 +0200
Message-ID: <1311689582-3116-17-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:36:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlikD-000737-Nv
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab1GZOgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:36:22 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40511 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab1GZOgU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:36:20 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-TM; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177888>

Add new usage patterns

    git check-attr --all [--] pathname...
    git check-attr --stdin --all < <list-of-paths>

which display all attributes associated with the specified file(s).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

One non-obvious design choice is that if --all is specified but not
'--', then all of the arguments are interpreted as pathnames.

 Documentation/git-check-attr.txt |   16 ++++++++++-
 builtin/check-attr.c             |   52 ++++++++++++++++++++++++++-----------
 t/t0003-attributes.sh            |   24 +++++++++++++++++
 3 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 30eca6c..3afa9b1 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -9,8 +9,8 @@ git-check-attr - Display gitattributes information
 SYNOPSIS
 --------
 [verse]
-'git check-attr' attr... [--] pathname...
-'git check-attr' --stdin [-z] attr... < <list-of-paths>
+'git check-attr' [--all | attr...] [--] pathname...
+'git check-attr' --stdin [-z] [--all | attr...] < <list-of-paths>
 
 DESCRIPTION
 -----------
@@ -19,6 +19,11 @@ For every pathname, this command will list if each attribute is 'unspecified',
 
 OPTIONS
 -------
+--all::
+	List all attributes that are associated with the specified
+	paths.  If this option is used, then 'unspecified' attributes
+	will not be included in the output.
+
 --stdin::
 	Read file names from stdin instead of from the command-line.
 
@@ -69,6 +74,13 @@ org/example/MyClass.java: diff: java
 org/example/MyClass.java: myAttr: set
 ---------------
 
+* Listing all attributes for a file:
+---------------
+$ git check-attr --all -- org/example/MyClass.java
+org/example/MyClass.java: diff: java
+org/example/MyClass.java: myAttr: set
+---------------
+
 * Listing an attribute for multiple files:
 ---------------
 $ git check-attr myAttr -- org/example/MyClass.java org/example/NoMyAttr.java
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 6cf6421..ecf420f 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -4,16 +4,18 @@
 #include "quote.h"
 #include "parse-options.h"
 
+static int all_attrs;
 static int stdin_paths;
 static const char * const check_attr_usage[] = {
-"git check-attr attr... [--] pathname...",
-"git check-attr --stdin attr... < <list-of-paths>",
+"git check-attr [--all | attr...] [--] pathname...",
+"git check-attr --stdin [--all | attr...] < <list-of-paths>",
 NULL
 };
 
 static int null_term_line;
 
 static const struct option check_attr_options[] = {
+	OPT_BOOLEAN('a', "all", &all_attrs, "report all attributes set on file"),
 	OPT_BOOLEAN(0 , "stdin", &stdin_paths, "read file names from stdin"),
 	OPT_BOOLEAN('z', NULL, &null_term_line,
 		"input paths are terminated by a null character"),
@@ -42,9 +44,16 @@ static void output_attr(int cnt, struct git_attr_check *check,
 static void check_attr(int cnt, struct git_attr_check *check,
 	const char *file)
 {
-	if (git_checkattr(file, cnt, check))
-		die("git_checkattr died");
-	output_attr(cnt, check, file);
+	if (check != NULL) {
+		if (git_checkattr(file, cnt, check))
+			die("git_checkattr died");
+		output_attr(cnt, check, file);
+	} else {
+		if (git_allattrs(file, &cnt, &check))
+			die("git_allattrs died");
+		output_attr(cnt, check, file);
+		free(check);
+	}
 }
 
 static void check_attr_stdin_paths(int cnt, struct git_attr_check *check)
@@ -92,8 +101,14 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			doubledash = i;
 	}
 
-	/* Check attribute argument(s): */
-	if (doubledash == 0) {
+	/* Process --all and/or attribute arguments: */
+	if (all_attrs) {
+		if (doubledash >= 1)
+			error_with_usage("Attributes and --all both specified");
+
+		cnt = 0;
+		filei = doubledash + 1;
+	} else if (doubledash == 0) {
 		error_with_usage("No attribute specified");
 	} else if (doubledash < 0) {
 		/*
@@ -119,15 +134,20 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			error_with_usage("No file specified");
 	}
 
-	check = xcalloc(cnt, sizeof(*check));
-	for (i = 0; i < cnt; i++) {
-		const char *name;
-		struct git_attr *a;
-		name = argv[i];
-		a = git_attr(name);
-		if (!a)
-			return error("%s: not a valid attribute name", name);
-		check[i].attr = a;
+	if (all_attrs) {
+		check = NULL;
+	} else {
+		check = xcalloc(cnt, sizeof(*check));
+		for (i = 0; i < cnt; i++) {
+			const char *name;
+			struct git_attr *a;
+			name = argv[i];
+			a = git_attr(name);
+			if (!a)
+				return error("%s: not a valid attribute name",
+					name);
+			check[i].attr = a;
+		}
 	}
 
 	if (stdin_paths)
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 2254005..8892ba3 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -107,6 +107,30 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'attribute test: --all option' '
+
+	cat <<EOF > all &&
+f: test: f
+a/f: test: f
+a/c/f: test: f
+a/g: test: a/g
+a/b/g: test: a/b/g
+b/g: test: unspecified
+a/b/h: test: a/b/h
+a/b/d/g: test: a/b/d/*
+onoff: test: unset
+offon: test: set
+no: notest: set
+a/b/d/no: test: a/b/d/*
+a/b/d/no: notest: set
+a/b/d/yes: notest: set
+EOF
+
+	grep -v unspecified < all | sort > expect &&
+	sed -e "s/:.*//" < all | uniq | git check-attr --stdin --all | sort > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'root subdir attribute test' '
 
 	attr_check a/i a/i &&
-- 
1.7.6.8.gd2879
