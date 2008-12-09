From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] diff: respect textconv in rewrite diffs
Date: Tue, 9 Dec 2008 03:13:21 -0500
Message-ID: <20081209081321.GA19707@coredump.intra.peff.net>
References: <20081209081227.GA19626@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 09:14:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9xjt-0000r4-QS
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 09:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbYLIINY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 03:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbYLIINY
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 03:13:24 -0500
Received: from peff.net ([208.65.91.99]:4280 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbYLIINX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 03:13:23 -0500
Received: (qmail 1097 invoked by uid 111); 9 Dec 2008 08:13:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Dec 2008 03:13:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2008 03:13:21 -0500
Content-Disposition: inline
In-Reply-To: <20081209081227.GA19626@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102606>

Currently we just skip rewrite diffs for binary files; this
patch makes an exception for files which will be textconv'd,
and actually performs the textconv before generating the
diff.

Conceptually, rewrite diffs should be in the exact same
format as the a non-rewrite diff, except that we refuse to
share any context. Thus it makes very little sense for "git
diff" to show a textconv'd diff, but for "git diff -B" to
show "Binary files differ".

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                         |   48 ++++++++++++++++++++++++++++++----------
 t/t4031-diff-rewrite-binary.sh |   21 ++++++++++++++++-
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index ea958a2..6dc19bc 100644
--- a/diff.c
+++ b/diff.c
@@ -229,6 +229,8 @@ static void emit_rewrite_diff(const char *name_a,
 			      const char *name_b,
 			      struct diff_filespec *one,
 			      struct diff_filespec *two,
+			      const char *textconv_one,
+			      const char *textconv_two,
 			      struct diff_options *o)
 {
 	int lc_a, lc_b;
@@ -241,6 +243,8 @@ static void emit_rewrite_diff(const char *name_a,
 	const char *reset = diff_get_color(color_diff, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
 	const char *a_prefix, *b_prefix;
+	const char *data_one, *data_two;
+	size_t size_one, size_two;
 
 	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -262,8 +266,27 @@ static void emit_rewrite_diff(const char *name_a,
 
 	diff_populate_filespec(one, 0);
 	diff_populate_filespec(two, 0);
-	lc_a = count_lines(one->data, one->size);
-	lc_b = count_lines(two->data, two->size);
+	if (textconv_one) {
+		data_one = run_textconv(textconv_one, one, &size_one);
+		if (!data_one)
+			die("unable to read files to diff");
+	}
+	else {
+		data_one = one->data;
+		size_one = one->size;
+	}
+	if (textconv_two) {
+		data_two = run_textconv(textconv_two, two, &size_two);
+		if (!data_two)
+			die("unable to read files to diff");
+	}
+	else {
+		data_two = two->data;
+		size_two = two->size;
+	}
+
+	lc_a = count_lines(data_one, size_one);
+	lc_b = count_lines(data_two, size_two);
 	fprintf(o->file,
 		"%s--- %s%s%s\n%s+++ %s%s%s\n%s@@ -",
 		metainfo, a_name.buf, name_a_tab, reset,
@@ -273,9 +296,9 @@ static void emit_rewrite_diff(const char *name_a,
 	print_line_count(o->file, lc_b);
 	fprintf(o->file, " @@%s\n", reset);
 	if (lc_a)
-		copy_file_with_prefix(o->file, '-', one->data, one->size, old, reset);
+		copy_file_with_prefix(o->file, '-', data_one, size_one, old, reset);
 	if (lc_b)
-		copy_file_with_prefix(o->file, '+', two->data, two->size, new, reset);
+		copy_file_with_prefix(o->file, '+', data_two, size_two, new, reset);
 }
 
 static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
@@ -1334,6 +1357,11 @@ static void builtin_diff(const char *name_a,
 	const char *a_prefix, *b_prefix;
 	const char *textconv_one = NULL, *textconv_two = NULL;
 
+	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+		textconv_one = get_textconv(one);
+		textconv_two = get_textconv(two);
+	}
+
 	diff_set_mnemonic_prefix(o, "a/", "b/");
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -1377,9 +1405,10 @@ static void builtin_diff(const char *name_a,
 		if ((one->mode ^ two->mode) & S_IFMT)
 			goto free_ab_and_return;
 		if (complete_rewrite &&
-		    !diff_filespec_is_binary(one) &&
-		    !diff_filespec_is_binary(two)) {
-			emit_rewrite_diff(name_a, name_b, one, two, o);
+		    (textconv_one || !diff_filespec_is_binary(one)) &&
+		    (textconv_two || !diff_filespec_is_binary(two))) {
+			emit_rewrite_diff(name_a, name_b, one, two,
+						textconv_one, textconv_two, o);
 			o->found_changes = 1;
 			goto free_ab_and_return;
 		}
@@ -1388,11 +1417,6 @@ static void builtin_diff(const char *name_a,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
-		textconv_one = get_textconv(one);
-		textconv_two = get_textconv(two);
-	}
-
 	if (!DIFF_OPT_TST(o, TEXT) &&
 	    ( (diff_filespec_is_binary(one) && !textconv_one) ||
 	      (diff_filespec_is_binary(two) && !textconv_two) )) {
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index 4b522f7..72e5bfd 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -7,13 +7,15 @@ test_description='rewrite diff on binary file'
 # We must be large enough to meet the MINIMUM_BREAK_SIZE
 # requirement.
 make_file() {
+	# common first line to help identify rewrite versus regular diff
+	printf "=\n" >file
 	for i in 1 2 3 4 5 6 7 8 9 10; do
 		for j in 1 2 3 4 5 6 7 9 10; do
 			for k in 1 2 3 4 5; do
 				printf "$1\n"
 			done
 		done
-	done >file
+	done >>file
 }
 
 test_expect_success 'create binary file with changes' '
@@ -39,4 +41,21 @@ test_expect_success 'rewrite diff can show binary patch' '
 	grep "GIT binary patch" diff
 '
 
+cat >dump <<'EOF'
+#!/bin/sh
+perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
+EOF
+chmod +x dump
+test_expect_success 'setup textconv' '
+	echo file diff=foo >.gitattributes &&
+	git config diff.foo.textconv "$PWD"/dump
+'
+
+test_expect_success 'rewrite diff respects textconv' '
+	git diff -B >diff &&
+	grep "dissimilarity index" diff &&
+	grep "^-61" diff &&
+	grep "^-0" diff
+'
+
 test_done
-- 
1.6.1.rc2.1.g8f945.dirty
