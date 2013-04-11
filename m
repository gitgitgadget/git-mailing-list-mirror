From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 5/5] check-ignore: add -n / --non-matching option
Date: Thu, 11 Apr 2013 02:59:35 +0100
Message-ID: <1365645575-11428-5-git-send-email-git@adamspiers.org>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 03:59:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ6nq-0007W4-BS
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 03:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962Ab3DKB7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 21:59:43 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:58204 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933295Ab3DKB7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 21:59:40 -0400
Received: from localhost (5.c.4.3.a.a.9.7.2.0.8.9.d.e.c.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:bced:9802:79aa:34c5])
	by coral.adamspiers.org (Postfix) with ESMTPSA id AC9922EAD6
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 02:59:39 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.347.g37e0606
In-Reply-To: <1365645575-11428-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220804>

If `-n` or `--non-matching` are specified, non-matching pathnames will
also be output, in which case all fields in each output record except
for <pathname> will be empty.  This can be useful when running
check-ignore as a background process, so that files can be
incrementally streamed to STDIN, and for each of these files, STDOUT
will indicate whether that file matched a pattern or not.  (Without
this option, it would be impossible to tell whether the absence of
output for a given file meant that it didn't match any pattern, or
that the result simply hadn't been flushed to STDOUT yet.)

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/git-check-ignore.txt |  15 +++++
 builtin/check-ignore.c             |  46 ++++++++------
 t/t0008-ignores.sh                 | 122 +++++++++++++++++++++++++++----------
 3 files changed, 134 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 4014d28..8e1f7ab 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -39,6 +39,12 @@ OPTIONS
 	below).  If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
 
+-n, --non-matching::
+	Show given paths which don't match any pattern.	 This only
+	makes sense when `--verbose` is enabled, otherwise it would
+	not be possible to distinguish between paths which match a
+	pattern and those which don't.
+
 OUTPUT
 ------
 
@@ -65,6 +71,15 @@ are also used instead of colons and hard tabs:
 
 <source> <NULL> <linenum> <NULL> <pattern> <NULL> <pathname> <NULL>
 
+If `-n` or `--non-matching` are specified, non-matching pathnames will
+also be output, in which case all fields in each output record except
+for <pathname> will be empty.  This can be useful when running
+non-interactively, so that files can be incrementally streamed to
+STDIN of a long-running check-ignore process, and for each of these
+files, STDOUT will indicate whether that file matched a pattern or
+not.  (Without this option, it would be impossible to tell whether the
+absence of output for a given file meant that it didn't match any
+pattern, or that the output hadn't been generated yet.)
 
 Buffering happens as documented under the `GIT_FLUSH` option in
 linkgit:git[1].  The caller is responsible for avoiding deadlocks
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index ce4b1ad..03ddada 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -5,7 +5,7 @@
 #include "pathspec.h"
 #include "parse-options.h"
 
-static int quiet, verbose, stdin_paths;
+static int quiet, verbose, stdin_paths, show_non_matching;
 static const char * const check_ignore_usage[] = {
 "git check-ignore [options] pathname...",
 "git check-ignore [options] --stdin < <list-of-paths>",
@@ -22,21 +22,28 @@ static const struct option check_ignore_options[] = {
 		    N_("read file names from stdin")),
 	OPT_BOOLEAN('z', NULL, &null_term_line,
 		    N_("input paths are terminated by a null character")),
+	OPT_BOOLEAN('n', "non-matching", &show_non_matching,
+		    N_("show non-matching input paths")),
 	OPT_END()
 };
 
 static void output_exclude(const char *path, struct exclude *exclude)
 {
-	char *bang  = exclude->flags & EXC_FLAG_NEGATIVE  ? "!" : "";
-	char *slash = exclude->flags & EXC_FLAG_MUSTBEDIR ? "/" : "";
+	char *bang  = (exclude && exclude->flags & EXC_FLAG_NEGATIVE)  ? "!" : "";
+	char *slash = (exclude && exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
 	if (!null_term_line) {
 		if (!verbose) {
 			write_name_quoted(path, stdout, '\n');
 		} else {
-			quote_c_style(exclude->el->src, NULL, stdout, 0);
-			printf(":%d:%s%s%s\t",
-			       exclude->srcpos,
-			       bang, exclude->pattern, slash);
+			if (exclude) {
+				quote_c_style(exclude->el->src, NULL, stdout, 0);
+				printf(":%d:%s%s%s\t",
+				       exclude->srcpos,
+				       bang, exclude->pattern, slash);
+			}
+			else {
+				printf("::\t");
+			}
 			quote_c_style(path, NULL, stdout, 0);
 			fputc('\n', stdout);
 		}
@@ -44,11 +51,14 @@ static void output_exclude(const char *path, struct exclude *exclude)
 		if (!verbose) {
 			printf("%s%c", path, '\0');
 		} else {
-			printf("%s%c%d%c%s%s%s%c%s%c",
-			       exclude->el->src, '\0',
-			       exclude->srcpos, '\0',
-			       bang, exclude->pattern, slash, '\0',
-			       path, '\0');
+			if (exclude)
+				printf("%s%c%d%c%s%s%s%c%s%c",
+				       exclude->el->src, '\0',
+				       exclude->srcpos, '\0',
+				       bang, exclude->pattern, slash, '\0',
+				       path, '\0');
+			else
+				printf("%c%c%c%s%c", '\0', '\0', '\0', path, '\0');
 		}
 	}
 }
@@ -79,15 +89,15 @@ static int check_ignore(struct path_exclude_check check,
 					? strlen(prefix) : 0, path);
 		full_path = check_path_for_gitlink(full_path);
 		die_if_path_beyond_symlink(full_path, prefix);
+		exclude = NULL;
 		if (!seen[i]) {
 			exclude = last_exclude_matching_path(&check, full_path,
 							     -1, &dtype);
-			if (exclude) {
-				if (!quiet)
-					output_exclude(path, exclude);
-				num_ignored++;
-			}
 		}
+		if (!quiet && (exclude || show_non_matching))
+			output_exclude(path, exclude);
+		if (exclude)
+			num_ignored++;
 	}
 	free(seen);
 
@@ -146,6 +156,8 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 		if (verbose)
 			die(_("cannot have both --quiet and --verbose"));
 	}
+	if (show_non_matching && !verbose)
+		die(_("--non-matching is only valid with --verbose"));
 
 	/* read_cache() is only necessary so we can watch out for submodules. */
 	if (read_cache() < 0)
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 80b731a..86b8bf8 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -66,16 +66,23 @@ test_check_ignore () {
 
 	init_vars &&
 	rm -f "$HOME/stdout" "$HOME/stderr" "$HOME/cmd" &&
-	echo git $global_args check-ignore $quiet_opt $verbose_opt $args \
+	echo git $global_args check-ignore $quiet_opt $verbose_opt $non_matching_opt $args \
 		>"$HOME/cmd" &&
+	echo "$expect_code" >"$HOME/expected-exit-code" &&
 	test_expect_code "$expect_code" \
-		git $global_args check-ignore $quiet_opt $verbose_opt $args \
+		git $global_args check-ignore $quiet_opt $verbose_opt $non_matching_opt $args \
 		>"$HOME/stdout" 2>"$HOME/stderr" &&
 	test_cmp "$HOME/expected-stdout" "$HOME/stdout" &&
 	stderr_empty_on_success "$expect_code"
 }
 
-# Runs the same code with 3 different levels of output verbosity,
+# Runs the same code with 4 different levels of output verbosity:
+#
+#   1. with -q / --quiet
+#   2. with default verbosity
+#   3. with -v / --verbose
+#   4. with -v / --verbose, *and* -n / --non-matching
+#
 # expecting success each time.  Takes advantage of the fact that
 # check-ignore --verbose output is the same as normal output except
 # for the extra first column.
@@ -83,7 +90,9 @@ test_check_ignore () {
 # Arguments:
 #   - (optional) prereqs for this test, e.g. 'SYMLINKS'
 #   - test name
-#   - output to expect from -v / --verbose mode
+#   - output to expect from the fourth verbosity mode (the output
+#     from the other verbosity modes is automatically inferred
+#     from this value)
 #   - code to run (should invoke test_check_ignore)
 test_expect_success_multi () {
 	prereq=
@@ -92,8 +101,9 @@ test_expect_success_multi () {
 		prereq=$1
 		shift
 	fi
-	testname="$1" expect_verbose="$2" code="$3"
+	testname="$1" expect_all="$2" code="$3"
 
+	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
 	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
 
 	test_expect_success $prereq "$testname" '
@@ -101,23 +111,40 @@ test_expect_success_multi () {
 		eval "$code"
 	'
 
-	for quiet_opt in '-q' '--quiet'
-	do
-		test_expect_success $prereq "$testname${quiet_opt:+ with $quiet_opt}" "
+	# --quiet is only valid when a single pattern is passed
+	if test $( echo "$expect_all" | wc -l ) = 1
+	then
+		for quiet_opt in '-q' '--quiet'
+		do
+			test_expect_success $prereq "$testname${quiet_opt:+ with $quiet_opt}" "
 			expect '' &&
 			$code
 		"
-	done
-	quiet_opt=
+		done
+		quiet_opt=
+	fi
 
 	for verbose_opt in '-v' '--verbose'
 	do
-		test_expect_success $prereq "$testname${verbose_opt:+ with $verbose_opt}" "
-			expect '$expect_verbose' &&
-			$code
-		"
+		for non_matching_opt in '' ' -n' ' --non-matching'
+		do
+			if test -n "$non_matching_opt"
+			then
+				my_expect="$expect_all"
+			else
+				my_expect="$expect_verbose"
+			fi
+
+			test_code="
+				expect '$my_expect' &&
+				$code
+			"
+			opts="$verbose_opt$non_matching_opt"
+			test_expect_success $prereq "$testname${opts:+ with $opts}" "$test_code"
+		done
 	done
 	verbose_opt=
+	non_matching_opt=
 }
 
 test_expect_success 'setup' '
@@ -178,7 +205,7 @@ test_expect_success 'setup' '
 #
 # test invalid inputs
 
-test_expect_success_multi '. corner-case' '' '
+test_expect_success_multi '. corner-case' '::	.' '
 	test_check_ignore . 1
 '
 
@@ -272,27 +299,39 @@ do
 		where="in subdir $subdir"
 	fi
 
-	test_expect_success_multi "non-existent file $where not ignored" '' "
-		test_check_ignore '${subdir}non-existent' 1
-	"
+	test_expect_success_multi "non-existent file $where not ignored" \
+		"::	${subdir}non-existent" \
+		"test_check_ignore '${subdir}non-existent' 1"
 
 	test_expect_success_multi "non-existent file $where ignored" \
-		".gitignore:1:one	${subdir}one" "
-		test_check_ignore '${subdir}one'
-	"
+		".gitignore:1:one	${subdir}one" \
+		"test_check_ignore '${subdir}one'"
 
-	test_expect_success_multi "existing untracked file $where not ignored" '' "
-		test_check_ignore '${subdir}not-ignored' 1
-	"
+	test_expect_success_multi "existing untracked file $where not ignored" \
+		"::	${subdir}not-ignored" \
+		"test_check_ignore '${subdir}not-ignored' 1"
 
-	test_expect_success_multi "existing tracked file $where not ignored" '' "
-		test_check_ignore '${subdir}ignored-but-in-index' 1
-	"
+	test_expect_success_multi "existing tracked file $where not ignored" \
+		"::	${subdir}ignored-but-in-index" \
+		"test_check_ignore '${subdir}ignored-but-in-index' 1"
 
 	test_expect_success_multi "existing untracked file $where ignored" \
-		".gitignore:2:ignored-*	${subdir}ignored-and-untracked" "
-		test_check_ignore '${subdir}ignored-and-untracked'
-	"
+		".gitignore:2:ignored-*	${subdir}ignored-and-untracked" \
+		"test_check_ignore '${subdir}ignored-and-untracked'"
+
+	test_expect_success_multi "mix of file types $where" \
+"::	${subdir}non-existent
+.gitignore:1:one	${subdir}one
+::	${subdir}not-ignored
+::	${subdir}ignored-but-in-index
+.gitignore:2:ignored-*	${subdir}ignored-and-untracked" \
+		"test_check_ignore '
+			${subdir}non-existent
+			${subdir}one
+			${subdir}not-ignored
+			${subdir}ignored-but-in-index
+			${subdir}ignored-and-untracked'
+		"
 done
 
 # Having established the above, from now on we mostly test against
@@ -387,7 +426,7 @@ test_expect_success 'cd to ignored sub-directory with -v' '
 #
 # test handling of symlinks
 
-test_expect_success_multi SYMLINKS 'symlink' '' '
+test_expect_success_multi SYMLINKS 'symlink' '::	a/symlink' '
 	test_check_ignore "a/symlink" 1
 '
 
@@ -570,22 +609,33 @@ cat <<-\EOF >stdin
 	globaltwo
 	b/globaltwo
 	../b/globaltwo
+	c/not-ignored
 EOF
-cat <<-EOF >expected-verbose
+# N.B. we deliberately end STDIN with a non-matching pattern in order
+# to test that the exit code indicates that one or more of the
+# provided paths is ignored - in other words, that it represents an
+# aggregation of all the results, not just the final result.
+
+cat <<-EOF >expected-all
 	.gitignore:1:one	../one
+	::	../not-ignored
 	.gitignore:1:one	one
+	::	not-ignored
 	a/b/.gitignore:8:!on*	b/on
 	a/b/.gitignore:8:!on*	b/one
 	a/b/.gitignore:8:!on*	b/one one
 	a/b/.gitignore:8:!on*	b/one two
 	a/b/.gitignore:8:!on*	"b/one\"three"
 	a/b/.gitignore:9:!two	b/two
+	::	b/not-ignored
 	a/.gitignore:1:two*	b/twooo
 	$global_excludes:2:!globaltwo	../globaltwo
 	$global_excludes:2:!globaltwo	globaltwo
 	$global_excludes:2:!globaltwo	b/globaltwo
 	$global_excludes:2:!globaltwo	../b/globaltwo
+	::	c/not-ignored
 EOF
+grep -v '^::	' expected-all >expected-verbose
 sed -e 's/.*	//' expected-verbose >expected-default
 
 sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
@@ -611,6 +661,14 @@ test_expect_success '--stdin from subdirectory with -v' '
 	)
 '
 
+test_expect_success '--stdin from subdirectory with -v -n' '
+	expect_from_stdin <expected-all &&
+	(
+		cd a &&
+		test_check_ignore "--stdin -v -n" <../stdin
+	)
+'
+
 for opts in '--stdin -z' '-z --stdin'
 do
 	test_expect_success "$opts from subdirectory" '
-- 
1.8.2.1.347.g37e0606
