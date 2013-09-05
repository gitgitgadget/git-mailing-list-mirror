From: Dave Williams <dave@opensourcesolutions.co.uk>
Subject: [PATCH V3] check-ignore: Add option to ignore index contents
Date: Thu, 5 Sep 2013 17:08:01 +0100
Message-ID: <20130905160801.GA22710@opensourcesolutions.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 05 18:08:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHc6S-0001py-OH
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 18:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab3IEQIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 12:08:12 -0400
Received: from 46-65-59-139.zone16.bethere.co.uk ([46.65.59.139]:56331 "EHLO
	loganberry.opensourcesolutions.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754348Ab3IEQIL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 12:08:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by loganberry.opensourcesolutions.co.uk (Postfix) with ESMTP id 156A0EECB3D;
	Thu,  5 Sep 2013 17:08:08 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at loganberry.opensourcesolutions.co.uk
Received: from loganberry.opensourcesolutions.co.uk ([127.0.0.1])
	by localhost (loganberry.opensourcesolutions.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id POtfJfjKw8zX; Thu,  5 Sep 2013 17:08:01 +0100 (BST)
Received: from tangerine (tangerine.opensourcesolutions.co.uk [192.168.149.59])
	by loganberry.opensourcesolutions.co.uk (Postfix) with ESMTP id 75028EEC928;
	Thu,  5 Sep 2013 17:08:01 +0100 (BST)
Received: by tangerine (Postfix, from userid 1000)
	id 6AE8B1002E0; Thu,  5 Sep 2013 17:08:01 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233964>

check-ignore currently shows how .gitignore rules would treat untracked
paths. Tracked paths do not generate useful output.  This prevents
debugging of why a path became tracked unexpectedly unless that path is
first removed from the index with `git rm --cached <path>`.

This option (-i, --no-index) simply by-passes the check for the path
being in the index and hence allows tracked paths to be checked too.

Whilst this behaviour deviates from the characteristics of `git add` and
`git status` its use case is unlikely to cause any user confusion.

Test scripts are augmented to check this option against the standard
ignores to ensure correct behaviour.

Signed-off-by: Dave Williams <dave@opensourcesolutions.co.uk>
---
In V3 I have taken on board comments from Junio Hamano and Eric
Sunshine from V2 ($gmane/233660).

In particlar Junio queried my approach in builtin/git-check-ignores.c
that bypassed the functions that check a path is in the index as well as
avoiding reading the index in the first place.

In my view removing the bypass makes the code slightly less clear,
relies on the_index being initialized and the functions using it to exit
quickly when it has no content. Nevertheless I have bowed to his better
domain knowledge and after undertaking brief analysis to check the
assumptions I have removed the extra conditional steps.  This has
simplified the patch. The revised code appears to have the same
behaviour as before and passes the test script (t/t00009-ignors.sh). 

Regarding the test script I have tidied up the variables containing the
separate option switches so they dont contain leading spaces, instead I
have added spaces as needed when formatting the command line.  This
not only improves my patch but also the existing code which was a little
inconsistent in this respect.

Finally I have rebased from the latest commmit on master to pick up
unrelated recent changes made to builtin/check-ignores.c and updated my
code to be consistent with this.

Hopefully I have put these patch notes in the right place now! Let me
know if not.

Dave


 Documentation/git-check-ignore.txt |  7 ++++
 builtin/check-ignore.c             |  6 ++-
 t/t0008-ignores.sh                 | 75 +++++++++++++++++++++++++++++++++-----
 3 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index d2df487..96c591f 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -45,6 +45,13 @@ OPTIONS
 	not be possible to distinguish between paths which match a
 	pattern and those which don't.
 
+-i, --no-index::
+	Don't look in the index when undertaking the checks. This can
+	be used to debug why a path became tracked by e.g. `git add .`
+	and was not ignored by the rules as expected by the user or when
+	developing patterns including negation to match a path previously
+	added with `git add -f`.
+
 OUTPUT
 ------
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 25aa2a5..f58f384 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -5,7 +5,7 @@
 #include "pathspec.h"
 #include "parse-options.h"
 
-static int quiet, verbose, stdin_paths, show_non_matching;
+static int quiet, verbose, stdin_paths, show_non_matching, no_index;
 static const char * const check_ignore_usage[] = {
 "git check-ignore [options] pathname...",
 "git check-ignore [options] --stdin < <list-of-paths>",
@@ -24,6 +24,8 @@ static const struct option check_ignore_options[] = {
 		 N_("terminate input and output records by a NUL character")),
 	OPT_BOOL('n', "non-matching", &show_non_matching,
 		 N_("show non-matching input paths")),
+	OPT_BOOL('i', "no-index", &no_index,
+		 N_("ignore index when checking")),
 	OPT_END()
 };
 
@@ -157,7 +159,7 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 		die(_("--non-matching is only valid with --verbose"));
 
 	/* read_cache() is only necessary so we can watch out for submodules. */
-	if (read_cache() < 0)
+	if (!no_index && read_cache() < 0)
 		die(_("index file corrupt"));
 
 	memset(&dir, 0, sizeof(dir));
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index c29342d..760c7bf 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -66,11 +66,11 @@ test_check_ignore () {
 
 	init_vars &&
 	rm -f "$HOME/stdout" "$HOME/stderr" "$HOME/cmd" &&
-	echo git $global_args check-ignore $quiet_opt $verbose_opt $non_matching_opt $args \
+	echo git $global_args check-ignore $quiet_opt $verbose_opt $non_matching_opt $no_index_opt $args \
 		>"$HOME/cmd" &&
 	echo "$expect_code" >"$HOME/expected-exit-code" &&
 	test_expect_code "$expect_code" \
-		git $global_args check-ignore $quiet_opt $verbose_opt $non_matching_opt $args \
+		git $global_args check-ignore $quiet_opt $verbose_opt $non_matching_opt $no_index_opt $args \
 		>"$HOME/stdout" 2>"$HOME/stderr" &&
 	test_cmp "$HOME/expected-stdout" "$HOME/stdout" &&
 	stderr_empty_on_success "$expect_code"
@@ -87,6 +87,9 @@ test_check_ignore () {
 # check-ignore --verbose output is the same as normal output except
 # for the extra first column.
 #
+# A parameter is used to determine if the tests are run with the
+# normal case (using the index), or with the -i or --no-index option.
+#
 # Arguments:
 #   - (optional) prereqs for this test, e.g. 'SYMLINKS'
 #   - test name
@@ -94,19 +97,26 @@ test_check_ignore () {
 #     from the other verbosity modes is automatically inferred
 #     from this value)
 #   - code to run (should invoke test_check_ignore)
-test_expect_success_multi () {
+#   - index option: --index, -i or --no-index
+test_expect_success_multiple () {
 	prereq=
-	if test $# -eq 4
+	if test $# -eq 5
 	then
 		prereq=$1
 		shift
 	fi
+	if test "$4" = "--index"
+	then
+		no_index_opt=
+	else
+		no_index_opt=$4
+	fi
 	testname="$1" expect_all="$2" code="$3"
 
 	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
 	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
 
-	test_expect_success $prereq "$testname" '
+	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
 		expect "$expect" &&
 		eval "$code"
 	'
@@ -116,7 +126,8 @@ test_expect_success_multi () {
 	then
 		for quiet_opt in '-q' '--quiet'
 		do
-			test_expect_success $prereq "$testname${quiet_opt:+ with $quiet_opt}" "
+			opts="${no_index_opt:+$no_index_opt }$quiet_opt"
+			test_expect_success $prereq "$testname${opts:+ with $opts}" "
 			expect '' &&
 			$code
 		"
@@ -126,7 +137,7 @@ test_expect_success_multi () {
 
 	for verbose_opt in '-v' '--verbose'
 	do
-		for non_matching_opt in '' ' -n' ' --non-matching'
+		for non_matching_opt in '' '-n' '--non-matching'
 		do
 			if test -n "$non_matching_opt"
 			then
@@ -139,12 +150,24 @@ test_expect_success_multi () {
 				expect '$my_expect' &&
 				$code
 			"
-			opts="$verbose_opt$non_matching_opt"
+			opts="${no_index_opt:+$no_index_opt }$verbose_opt${non_matching_opt:+ $non_matching_opt}"
 			test_expect_success $prereq "$testname${opts:+ with $opts}" "$test_code"
 		done
 	done
 	verbose_opt=
 	non_matching_opt=
+	no_index_opt=
+}
+
+test_expect_success_multi () {
+	test_expect_success_multiple "$@" "--index"
+}
+
+test_expect_success_no_index_multi () {
+	for ni in '-i' '--no-index'
+	do
+		test_expect_success_multiple "$@" "$ni"
+	done
 }
 
 test_expect_success 'setup' '
@@ -288,7 +311,7 @@ test_expect_success_multi 'needs work tree' '' '
 
 # First make sure that the presence of a file in the working tree
 # does not impact results, but that the presence of a file in the
-# index does.
+# index does unless the --no-index option is used.
 
 for subdir in '' 'a/'
 do
@@ -303,22 +326,42 @@ do
 		"::	${subdir}non-existent" \
 		"test_check_ignore '${subdir}non-existent' 1"
 
+	test_expect_success_no_index_multi "non-existent file $where not ignored" \
+		"::	${subdir}non-existent" \
+		"test_check_ignore '${subdir}non-existent' 1"
+
 	test_expect_success_multi "non-existent file $where ignored" \
 		".gitignore:1:one	${subdir}one" \
 		"test_check_ignore '${subdir}one'"
 
+	test_expect_success_no_index_multi "non-existent file $where ignored" \
+		".gitignore:1:one	${subdir}one" \
+		"test_check_ignore '${subdir}one'"
+
 	test_expect_success_multi "existing untracked file $where not ignored" \
 		"::	${subdir}not-ignored" \
 		"test_check_ignore '${subdir}not-ignored' 1"
 
+	test_expect_success_no_index_multi "existing untracked file $where not ignored" \
+		"::	${subdir}not-ignored" \
+		"test_check_ignore '${subdir}not-ignored' 1"
+
 	test_expect_success_multi "existing tracked file $where not ignored" \
 		"::	${subdir}ignored-but-in-index" \
 		"test_check_ignore '${subdir}ignored-but-in-index' 1"
 
+	test_expect_success_no_index_multi "existing tracked file $where shown as ignored" \
+		".gitignore:2:ignored-*	${subdir}ignored-but-in-index" \
+		"test_check_ignore '${subdir}ignored-but-in-index'"
+
 	test_expect_success_multi "existing untracked file $where ignored" \
 		".gitignore:2:ignored-*	${subdir}ignored-and-untracked" \
 		"test_check_ignore '${subdir}ignored-and-untracked'"
 
+	test_expect_success_no_index_multi "existing untracked file $where ignored" \
+		".gitignore:2:ignored-*	${subdir}ignored-and-untracked" \
+		"test_check_ignore '${subdir}ignored-and-untracked'"
+
 	test_expect_success_multi "mix of file types $where" \
 "::	${subdir}non-existent
 .gitignore:1:one	${subdir}one
@@ -332,6 +375,20 @@ do
 			${subdir}ignored-but-in-index
 			${subdir}ignored-and-untracked'
 		"
+
+	test_expect_success_no_index_multi "mix of file types $where" \
+"::	${subdir}non-existent
+.gitignore:1:one	${subdir}one
+::	${subdir}not-ignored
+.gitignore:2:ignored-*	${subdir}ignored-but-in-index
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
-- 
1.8.4.rc3
