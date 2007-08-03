From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Thu, 2 Aug 2007 22:37:18 -0700
Message-ID: <20070803053717.GA16379@midwinter.com>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site> <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site> <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 07:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGpqy-0004l1-3G
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 07:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbXHCFhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 01:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbXHCFhU
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 01:37:20 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:37218 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753361AbXHCFhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 01:37:19 -0400
Received: (qmail 16999 invoked by uid 1001); 3 Aug 2007 05:37:18 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708021614420.14781@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54668>

The default is now to not show the diff --git header line if the file's
timestamp has changed but the contents and/or file mode haven't.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

	Okay, enough arguing about whether the empty diff lines are
	useful or not -- here's a patch to get rid of them.

	This passes all the existing "diff" tests, with one minor tweak
	to the symlink test (since it expected the old behavior.)
	If someone can find a case where this will spit out an actual
	diff but not the "diff --git" line, please tell me how to make
	that happen. The code *looks* like it has such a path, but I was
	unable to make it happen in my ad-hoc testing and it doesn't
	happen in any of the existing diff test cases.

	Personally I'm in favor of doing away with the option altogether
	and having the code always work the way it works by default with
	this patch, but if some people find the old behavior useful they
	can still get at it with the new option.

	My xmalloc() call allocates a few more bytes than strictly
	needed, but I found it was less readable to subtract out the
	space taken by the "%s" tokens in the format string.

 Documentation/diff-options.txt |    4 ++
 diff.c                         |   46 ++++++++++++++++++++++++++----
 diff.h                         |    3 +-
 t/t4011-diff-symlink.sh        |    2 +-
 t/t4021-diff-untouched.sh      |   61 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 8 deletions(-)
 create mode 100755 t/t4021-diff-untouched.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 228ccaf..12ad048 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -185,5 +185,9 @@
 --no-ext-diff::
 	Disallow external diff drivers.
 
+--show-touched::
+	Display the "diff --git" message for files whose modification
+	timestamps have changed, even if the contents don't differ.
+
 For more detailed explanation on these common options, see also
 link:diffcore.html[diffcore documentation].
diff --git a/diff.c b/diff.c
index a5fc56b..e1112e5 100644
--- a/diff.c
+++ b/diff.c
@@ -1260,6 +1260,9 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 	return NULL;
 }
 
+/* The message that gets printed at the top of a file's diffs */
+#define DIFF_MESSAGE_FORMAT_STRING "%sdiff --git %s %s%s\n"
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -1268,6 +1271,7 @@ static void builtin_diff(const char *name_a,
 			 struct diff_options *o,
 			 int complete_rewrite)
 {
+	char *diff_message;
 	mmfile_t mf1, mf2;
 	const char *lbl[2];
 	char *a_one, *b_two;
@@ -1278,25 +1282,50 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two("b/", name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+
+	/*
+	 * Generate the "diff --git" status message. By default we only
+	 * show it if we have a difference to display, but the user can
+	 * optionally choose to show it for all files that we examine for
+	 * content differences (e.g. because their timestamps have changed.)
+	 */
+	diff_message = xmalloc(strlen(set) + strlen(reset) +
+			       strlen(a_one) + strlen(b_two) +
+			       sizeof(DIFF_MESSAGE_FORMAT_STRING));
+	sprintf(diff_message, DIFF_MESSAGE_FORMAT_STRING,
+	        set, a_one, b_two, reset);
+	if (o->show_touched) {
+		fputs(diff_message, stdout);
+		*diff_message = '\0';
+	}
+
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
-		printf("%snew file mode %06o%s\n", set, two->mode, reset);
+		printf("%s%snew file mode %06o%s\n",
+		       diff_message, set, two->mode, reset);
+		*diff_message = '\0';
 		if (xfrm_msg && xfrm_msg[0])
 			printf("%s%s%s\n", set, xfrm_msg, reset);
 	}
 	else if (lbl[1][0] == '/') {
-		printf("%sdeleted file mode %06o%s\n", set, one->mode, reset);
+		printf("%s%sdeleted file mode %06o%s\n",
+		       diff_message, set, one->mode, reset);
+		*diff_message = '\0';
 		if (xfrm_msg && xfrm_msg[0])
 			printf("%s%s%s\n", set, xfrm_msg, reset);
 	}
 	else {
 		if (one->mode != two->mode) {
-			printf("%sold mode %06o%s\n", set, one->mode, reset);
+			printf("%s%sold mode %06o%s\n",
+			       diff_message, set, one->mode, reset);
 			printf("%snew mode %06o%s\n", set, two->mode, reset);
+			*diff_message = '\0';
+		}
+		if (xfrm_msg && xfrm_msg[0]) {
+			printf("%s%s%s%s\n",
+			       diff_message, set, xfrm_msg, reset);
+			*diff_message = '\0';
 		}
-		if (xfrm_msg && xfrm_msg[0])
-			printf("%s%s%s\n", set, xfrm_msg, reset);
 		/*
 		 * we do not run diff between different kind
 		 * of objects.
@@ -1304,6 +1333,8 @@ static void builtin_diff(const char *name_a,
 		if ((one->mode ^ two->mode) & S_IFMT)
 			goto free_ab_and_return;
 		if (complete_rewrite) {
+			fputs(diff_message, stdout);
+			*diff_message = '\0';
 			emit_rewrite_diff(name_a, name_b, one, two,
 					o->color_diff);
 			o->found_changes = 1;
@@ -1372,6 +1403,7 @@ static void builtin_diff(const char *name_a,
 	diff_free_filespec_data(two);
 	free(a_one);
 	free(b_two);
+	free(diff_message);
 	return;
 }
 
@@ -2381,6 +2413,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->allow_external = 1;
 	else if (!strcmp(arg, "--no-ext-diff"))
 		options->allow_external = 0;
+	else if (!strcmp(arg, "--show-touched"))
+		options->show_touched = 1;
 	else
 		return 0;
 	return 1;
diff --git a/diff.h b/diff.h
index 9fd6d44..e172ecf 100644
--- a/diff.h
+++ b/diff.h
@@ -61,7 +61,8 @@ struct diff_options {
 		 has_changes:1,
 		 quiet:1,
 		 allow_external:1,
-		 exit_with_status:1;
+		 exit_with_status:1,
+		 show_touched:1;
 	int context;
 	int break_opt;
 	int detect_rename;
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index c6d1369..910c6cc 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -60,7 +60,7 @@ test_expect_success \
     'diff identical, but newly created symlink' \
     'sleep 3 &&
     ln -s xyzzy frotz &&
-    git diff-index -M -p $tree > current &&
+    git diff-index --show-touched -M -p $tree > current &&
     compare_diff_patch current expected'
 
 cat > expected << EOF
diff --git a/t/t4021-diff-untouched.sh b/t/t4021-diff-untouched.sh
new file mode 100755
index 0000000..a8153e0
--- /dev/null
+++ b/t/t4021-diff-untouched.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Johannes Schindelin
+#
+
+test_description='Test display and suppression of unmodified files.
+
+'
+. ./test-lib.sh
+. ../diff-lib.sh
+
+touch empty
+
+test_expect_success 'no output when no changes' '
+
+	echo foobar > file1 &&
+	chmod 644 file1 &&
+	git add file1 &&
+	git commit -m "initial commit" &&
+	git diff > current &&
+	compare_diff_patch current empty
+'
+
+test_expect_success 'no output when file touched' '
+
+	sleep 1 &&
+	touch file1 &&
+	git diff > current &&
+	compare_diff_patch current empty
+'
+
+cat > expected << EOF
+diff --git a/file1 b/file1
+EOF
+
+test_expect_success 'output when --show-touched is used' '
+
+	git diff --show-touched > current &&
+	compare_diff_patch current expected
+'
+
+test_expect_success 'no output when index updated with touched file' '
+
+	git add file1 &&
+	git diff --cached > current &&
+	compare_diff_patch current empty
+'
+
+cat > expected << EOF
+diff --git a/file1 b/file1
+old mode 100644
+new mode 100755
+EOF
+
+test_expect_success 'output when mode is changed' '
+
+	chmod 755 file1 &&
+	git diff > current &&
+	compare_diff_patch current expected
+'
+test_done
-- 
1.5.3.rc2.4.g726f9
