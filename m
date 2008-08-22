From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2 v3] bisect: test merge base if good rev is not an
 ancestor of bad rev
Date: Fri, 22 Aug 2008 05:52:22 +0200
Message-ID: <20080822055222.69a740f1.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 05:49:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWNeX-0004eJ-9m
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 05:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbYHVDs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 23:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbYHVDs3
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 23:48:29 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:44442 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752250AbYHVDs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 23:48:28 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 7BC2A19729;
	Fri, 22 Aug 2008 05:48:27 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id ABF2B19704;
	Fri, 22 Aug 2008 05:48:26 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93247>

Before this patch, "git bisect", when it was given some good revs that
are not ancestor of the bad rev, didn't check if the merge bases were
good. "git bisect" just supposed that the user knew what he was doing,
and that, when he said the revs were good, he knew that it meant that
all the revs in the history leading to the good revs were also
considered good.

But in pratice, the user may not know that a good rev is not an
ancestor of the bad rev, or he may not know/remember that all revs
leading to the good rev will be considered good. So he may give a good
rev that is a sibling, instead of an ancestor, of the bad rev, when in
fact there can be one rev becoming good in the branch of the good rev
(because the bug was already fixed there for example) instead of one
rev becoming bad in the branch of the bad rev.

For example, if there is the following history:

A-B-C-D
   \E-F

and we launch "git bisect start D F" then only C and D would have been
considered as possible first bad commit before this patch. This may be
wrong because A, B and E may be bad too if the bug exists everywhere
except in F that fixes it.

The purpose of this patch is to detect when "git bisect" is passed
some good revs that are not ancestor of the bad rev, and then to first
ask the user to test the merge bases between the good and bad revs.

If the merge bases are good then all is fine, we can continue
bisecting. Otherwise, if one merge base is bad, it means that the
assumption that all revs leading to the good one are good too is
wrong and we error out. In the case where one merge base is skipped we
issue a warning and then continue bisecting anyway.

These checks will also catch the case where good and bad have been
mistaken. This means that we can remove the check that was done latter
on the output of "git rev-list --bisect-vars".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |  127 ++++++++++++++++++++++++++++++++++---------
 t/t6030-bisect-porcelain.sh |   90 ++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+), 25 deletions(-)

	Changes since the previous version are the following:

	- the series as been simplified to use "git merge-base" with
	more than 2 arguments; this means that it should be applied on
	top of next, 
	- both patches pass their own tests; sorry for the previous
	mistake in the first patch.

	Thanks,
	Christian.

diff --git a/git-bisect.sh b/git-bisect.sh
index 97ac600..b314d47 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -243,33 +243,18 @@ bisect_auto_next() {
 	bisect_next_check && bisect_next || :
 }
 
-eval_rev_list() {
-	_eval="$1"
-
-	eval $_eval
-	res=$?
-
-	if [ $res -ne 0 ]; then
-		echo >&2 "'git rev-list --bisect-vars' failed:"
-		echo >&2 "maybe you mistake good and bad revs?"
-		exit $res
-	fi
-
-	return $res
-}
-
 filter_skipped() {
 	_eval="$1"
 	_skip="$2"
 
 	if [ -z "$_skip" ]; then
-		eval_rev_list "$_eval"
+		eval "$_eval"
 		return
 	fi
 
 	# Let's parse the output of:
 	# "git rev-list --bisect-vars --bisect-all ..."
-	eval_rev_list "$_eval" | while read hash line
+	eval "$_eval" | while read hash line
 	do
 		case "$VARS,$FOUND,$TRIED,$hash" in
 			# We display some vars.
@@ -332,20 +317,113 @@ exit_if_skipped_commits () {
 	fi
 }
 
+bisect_checkout() {
+	_rev="$1"
+	_msg="$2"
+	echo "Bisecting: $_msg"
+	git checkout -q "$_rev" || exit
+	git show-branch "$_rev"
+}
+
+is_among() {
+	_rev="$1"
+	_list="$2"
+	case "$_list" in *$_rev*) return 0 ;; esac
+	return 1
+}
+
+is_testing_merge_base() {
+	grep "^testing $1$" "$GIT_DIR/BISECT_MERGE_BASES" >/dev/null 2>&1
+}
+
+mark_testing_merge_base() {
+	echo "testing $1" >> "$GIT_DIR/BISECT_MERGE_BASES"
+}
+
+handle_bad_merge_base() {
+	_badmb="$1"
+	_good="$2"
+	if is_testing_merge_base "$_badmb"; then
+		cat >&2 <<EOF
+The merge base $_badmb is bad.
+This means the bug has been fixed between $_badmb and [$_good].
+EOF
+		exit 3
+	else
+		cat >&2 <<EOF
+Some good revs are not ancestor of the bad rev.
+git bisect cannot work properly in this case.
+Maybe you mistake good and bad revs?
+EOF
+		exit 1
+	fi
+}
+
+handle_skipped_merge_base() {
+	_mb="$1"
+	_bad="$2"
+	_good="$3"
+	cat >&2 <<EOF
+Warning: the merge base between $_bad and [$_good] must be skipped.
+So we cannot be sure the first bad commit is between $_mb and $_bad.
+We continue anyway.
+EOF
+}
+
+check_merge_bases() {
+	_bad="$1"
+	_good="$2"
+	_skip="$3"
+	for _mb in $(git merge-base --all $_bad $_good)
+	do
+		if is_among "$_mb" "$_good"; then
+			continue
+		elif test "$_mb" = "$_bad"; then
+			handle_bad_merge_base "$_bad" "$_good"
+		elif is_among "$_mb" "$_skip"; then
+			handle_skipped_merge_base "$_mb" "$_bad" "$_good"
+		else
+			mark_testing_merge_base "$_mb"
+			bisect_checkout "$_mb" "a merge base must be tested"
+			checkout_done=1
+			return
+		fi
+	done
+}
+
+check_good_are_ancestors_of_bad() {
+	_bad="$1"
+	_good=$(echo $2 | sed -e 's/\^//g')
+	_skip="$3"
+
+	# Bisecting with no good rev is ok
+	test -z "$_good" && return
+
+	_side=$(git rev-list $_good ^$_bad)
+	if test -n "$_side"; then
+		check_merge_bases "$_bad" "$_good" "$_skip"
+	fi
+}
+
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
 	bisect_next_check good
 
+	# Get bad, good and skipped revs
+	bad=$(git rev-parse --verify refs/bisect/bad) &&
+	good=$(git for-each-ref --format='^%(objectname)' \
+		"refs/bisect/good-*" | tr '\012' ' ') &&
 	skip=$(git for-each-ref --format='%(objectname)' \
-		"refs/bisect/skip-*" | tr '\012' ' ') || exit
+		"refs/bisect/skip-*" | tr '\012' ' ') &&
 
+	# Maybe some merge bases must be tested first
+	check_good_are_ancestors_of_bad "$bad" "$good" "$skip" || exit
+	test "$checkout_done" -eq "1" && checkout_done='' && return
+
+	# Get bisection information
 	BISECT_OPT=''
 	test -n "$skip" && BISECT_OPT='--bisect-all'
-
-	bad=$(git rev-parse --verify refs/bisect/bad) &&
-	good=$(git for-each-ref --format='^%(objectname)' \
-		"refs/bisect/good-*" | tr '\012' ' ') &&
 	eval="git rev-list --bisect-vars $BISECT_OPT $good $bad --" &&
 	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
 	eval=$(filter_skipped "$eval" "$skip") &&
@@ -366,9 +444,7 @@ bisect_next() {
 	# commit is also a "skip" commit (see above).
 	exit_if_skipped_commits "$bisect_rev"
 
-	echo "Bisecting: $bisect_nr revisions left to test after this"
-	git checkout -q "$bisect_rev" || exit
-	git show-branch "$bisect_rev"
+	bisect_checkout "$bisect_rev" "$bisect_nr revisions left to test after this"
 }
 
 bisect_visualize() {
@@ -415,6 +491,7 @@ bisect_clean_state() {
 	do
 		git update-ref -d $ref $hash || exit
 	done
+	rm -f "$GIT_DIR/BISECT_MERGE_BASES" &&
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 244fda6..a1ce95c 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -350,6 +350,96 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	git branch -D bisect
 '
 
+# This creates a "side" branch to test "siblings" cases.
+#
+# H1-H2-H3-H4-H5-H6-H7  <--other
+#            \
+#             S5-S6-S7  <--side
+#
+test_expect_success 'side branch creation' '
+	git bisect reset &&
+	git checkout -b side $HASH4 &&
+	add_line_into_file "5(side): first line on a side branch" hello2 &&
+	SIDE_HASH5=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "6(side): second line on a side branch" hello2 &&
+	SIDE_HASH6=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "7(side): third line on a side branch" hello2 &&
+	SIDE_HASH7=$(git rev-parse --verify HEAD)
+'
+
+test_expect_success 'good merge base when good and bad are siblings' '
+	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
+	grep "merge base must be tested" my_bisect_log.txt &&
+	grep $HASH4 my_bisect_log.txt &&
+	git bisect good > my_bisect_log.txt &&
+	test_must_fail grep "merge base must be tested" my_bisect_log.txt &&
+	grep $HASH6 my_bisect_log.txt &&
+	git bisect reset
+'
+test_expect_success 'skipped merge base when good and bad are siblings' '
+	git bisect start "$SIDE_HASH7" "$HASH7" > my_bisect_log.txt &&
+	grep "merge base must be tested" my_bisect_log.txt &&
+	grep $HASH4 my_bisect_log.txt &&
+	git bisect skip > my_bisect_log.txt 2>&1 &&
+	grep "Warning" my_bisect_log.txt &&
+	grep $SIDE_HASH6 my_bisect_log.txt &&
+	git bisect reset
+'
+
+test_expect_success 'bad merge base when good and bad are siblings' '
+	git bisect start "$HASH7" HEAD > my_bisect_log.txt &&
+	grep "merge base must be tested" my_bisect_log.txt &&
+	grep $HASH4 my_bisect_log.txt &&
+	test_must_fail git bisect bad > my_bisect_log.txt 2>&1 &&
+	grep "merge base $HASH4 is bad" my_bisect_log.txt &&
+	grep "fixed between $HASH4 and \[$SIDE_HASH7\]" my_bisect_log.txt &&
+	git bisect reset
+'
+
+# This creates a few more commits (A and B) to test "siblings" cases
+# when a good and a bad rev have many merge bases.
+#
+# We should have the following:
+#
+# H1-H2-H3-H4-H5-H6-H7
+#            \  \     \
+#             S5-A     \
+#              \        \
+#               S6-S7----B
+#
+# And there A and B have 2 merge bases (S5 and H5) that should be
+# reported by "git merge-base --all A B".
+#
+test_expect_success 'many merge bases creation' '
+	git checkout "$SIDE_HASH5" &&
+	git merge -m "merge HASH5 and SIDE_HASH5" "$HASH5" &&
+	A_HASH=$(git rev-parse --verify HEAD) &&
+	git checkout side &&
+	git merge -m "merge HASH7 and SIDE_HASH7" "$HASH7" &&
+	B_HASH=$(git rev-parse --verify HEAD) &&
+	git merge-base --all "$A_HASH" "$B_HASH" > merge_bases.txt &&
+	test $(wc -l < merge_bases.txt) = "2" &&
+	grep "$HASH5" merge_bases.txt &&
+	grep "$SIDE_HASH5" merge_bases.txt
+'
+
+test_expect_success 'good merge bases when good and bad are siblings' '
+	git bisect start "$B_HASH" "$A_HASH" > my_bisect_log.txt &&
+	grep "merge base must be tested" my_bisect_log.txt &&
+	git bisect good > my_bisect_log2.txt &&
+	grep "merge base must be tested" my_bisect_log2.txt &&
+	{
+		{
+			grep "$SIDE_HASH5" my_bisect_log.txt &&
+			grep "$HASH5" my_bisect_log2.txt
+		} || {
+			grep "$SIDE_HASH5" my_bisect_log2.txt &&
+			grep "$HASH5" my_bisect_log.txt
+		}
+	} &&
+	git bisect reset
+'
+
 #
 #
 test_done
-- 
1.6.0.128.g1827
