From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/10] bisect: make "git bisect" use new "--next-all"
	bisect-helper function
Date: Sat, 09 May 2009 17:55:47 +0200
Message-ID: <20090509155548.5387.83292.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:05:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p2f-0006Vt-4e
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbZEIQD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754425AbZEIQDz
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:55 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:37248 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbZEIQDm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:42 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 587C5D4813B;
	Sat,  9 May 2009 18:03:36 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 5291ED480AD;
	Sat,  9 May 2009 18:03:34 +0200 (CEST)
X-git-sha1: 8ee20989941a1b30cce73dfb1e26ad440a3b5f18 
X-Mailer: git-mail-commits v0.4.0
In-Reply-To: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118669>

This patch replace the "--next-exit" option of "git bisect--helper"
with a "--next-all" option that does merge base checking using
the "check_good_are_ancestors_of_bad" function implemented in
"bisect.c" in a former patch.

The new "--next-all" option is then used in "git-bisect.sh" instead
of the "--next-exit" option, and all the shell functions in
"git-bisect.sh" that are now unused are removed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c                 |    4 +-
 bisect.h                 |    2 +-
 builtin-bisect--helper.c |   14 +++---
 git-bisect.sh            |  127 +---------------------------------------------
 4 files changed, 13 insertions(+), 134 deletions(-)

diff --git a/bisect.c b/bisect.c
index 09102da..f57b62c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -830,7 +830,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix)
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
  */
-int bisect_next_exit(const char *prefix)
+int bisect_next_all(const char *prefix)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
@@ -841,6 +841,8 @@ int bisect_next_exit(const char *prefix)
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
+	check_good_are_ancestors_of_bad(prefix);
+
 	bisect_rev_setup(&revs, prefix);
 
 	bisect_common(&revs, &reaches, &all);
diff --git a/bisect.h b/bisect.h
index 0b5d122..fb744fd 100644
--- a/bisect.h
+++ b/bisect.h
@@ -27,7 +27,7 @@ struct rev_list_info {
 
 extern int show_bisect_vars(struct rev_list_info *info, int reaches, int all);
 
-extern int bisect_next_exit(const char *prefix);
+extern int bisect_next_all(const char *prefix);
 
 extern int estimate_bisect_steps(int all);
 
diff --git a/builtin-bisect--helper.c b/builtin-bisect--helper.c
index aca7018..cb3e155 100644
--- a/builtin-bisect--helper.c
+++ b/builtin-bisect--helper.c
@@ -4,24 +4,24 @@
 #include "bisect.h"
 
 static const char * const git_bisect_helper_usage[] = {
-	"git bisect--helper --next-exit",
+	"git bisect--helper --next-all",
 	NULL
 };
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	int next_exit = 0;
+	int next_all = 0;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "next-exit", &next_exit,
-			    "output bisect result and exit instuctions"),
+		OPT_BOOLEAN(0, "next-all", &next_all,
+			    "perform 'git bisect next'"),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, options, git_bisect_helper_usage, 0);
 
-	if (!next_exit)
+	if (!next_all)
 		usage_with_options(git_bisect_helper_usage, options);
 
-	/* next-exit */
-	return bisect_next_exit(prefix);
+	/* next-all */
+	return bisect_next_all(prefix);
 }
diff --git a/git-bisect.sh b/git-bisect.sh
index 786b7b9..8969553 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -167,10 +167,6 @@ is_expected_rev() {
 	test "$1" = $(cat "$GIT_DIR/BISECT_EXPECTED_REV")
 }
 
-mark_expected_rev() {
-	echo "$1" > "$GIT_DIR/BISECT_EXPECTED_REV"
-}
-
 check_expected_revs() {
 	for _rev in "$@"; do
 		if ! is_expected_rev "$_rev"; then
@@ -269,132 +265,13 @@ bisect_auto_next() {
 	bisect_next_check && bisect_next || :
 }
 
-bisect_checkout() {
-	_rev="$1"
-	_msg="$2"
-	echo "Bisecting: $_msg"
-	mark_expected_rev "$_rev"
-	git checkout -q "$_rev" -- || exit
-	git show-branch "$_rev"
-}
-
-is_among() {
-	_rev="$1"
-	_list="$2"
-	case "$_list" in *$_rev*) return 0 ;; esac
-	return 1
-}
-
-handle_bad_merge_base() {
-	_badmb="$1"
-	_good="$2"
-	if is_expected_rev "$_badmb"; then
-		cat >&2 <<EOF
-The merge base $_badmb is bad.
-This means the bug has been fixed between $_badmb and [$_good].
-EOF
-		exit 3
-	else
-		cat >&2 <<EOF
-Some good revs are not ancestor of the bad rev.
-git bisect cannot work properly in this case.
-Maybe you mistake good and bad revs?
-EOF
-		exit 1
-	fi
-}
-
-handle_skipped_merge_base() {
-	_mb="$1"
-	_bad="$2"
-	_good="$3"
-	cat >&2 <<EOF
-Warning: the merge base between $_bad and [$_good] must be skipped.
-So we cannot be sure the first bad commit is between $_mb and $_bad.
-We continue anyway.
-EOF
-}
-
-#
-# "check_merge_bases" checks that merge bases are not "bad".
-#
-# - If one is "good", that's good, we have nothing to do.
-# - If one is "bad", it means the user assumed something wrong
-# and we must exit.
-# - If one is "skipped", we can't know but we should warn.
-# - If we don't know, we should check it out and ask the user to test.
-#
-# In the last case we will return 1, and otherwise 0.
-#
-check_merge_bases() {
-	_bad="$1"
-	_good="$2"
-	_skip="$3"
-	for _mb in $(git merge-base --all $_bad $_good)
-	do
-		if is_among "$_mb" "$_good"; then
-			continue
-		elif test "$_mb" = "$_bad"; then
-			handle_bad_merge_base "$_bad" "$_good"
-		elif is_among "$_mb" "$_skip"; then
-			handle_skipped_merge_base "$_mb" "$_bad" "$_good"
-		else
-			bisect_checkout "$_mb" "a merge base must be tested"
-			return 1
-		fi
-	done
-	return 0
-}
-
-#
-# "check_good_are_ancestors_of_bad" checks that all "good" revs are
-# ancestor of the "bad" rev.
-#
-# If that's not the case, we need to check the merge bases.
-# If a merge base must be tested by the user we return 1 and
-# otherwise 0.
-#
-check_good_are_ancestors_of_bad() {
-	test -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
-		return
-
-	_bad="$1"
-	_good=$(echo $2 | sed -e 's/\^//g')
-	_skip="$3"
-
-	# Bisecting with no good rev is ok
-	test -z "$_good" && return
-
-	_side=$(git rev-list $_good ^$_bad)
-	if test -n "$_side"; then
-		# Return if a checkout was done
-		check_merge_bases "$_bad" "$_good" "$_skip" || return
-	fi
-
-	: > "$GIT_DIR/BISECT_ANCESTORS_OK"
-
-	return 0
-}
-
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
 	bisect_next_check good
 
-	# Get bad, good and skipped revs
-	bad=$(git rev-parse --verify refs/bisect/bad) &&
-	good=$(git for-each-ref --format='^%(objectname)' \
-		"refs/bisect/good-*" | tr '\012' ' ') &&
-	skip=$(git for-each-ref --format='%(objectname)' \
-		"refs/bisect/skip-*" | tr '\012' ' ') || exit
-
-	# Maybe some merge bases must be tested first
-	check_good_are_ancestors_of_bad "$bad" "$good" "$skip"
-	# Return now if a checkout has already been done
-	test "$?" -eq "1" && return
-
-	# Perform bisection computation, display and checkout
-	git bisect--helper --next-exit
+	# Perform all bisection computation, display and checkout
+	git bisect--helper --next-all
 	res=$?
 
         # Check if we should exit because bisection is finished
-- 
1.6.3.rc1.112.g17e25
