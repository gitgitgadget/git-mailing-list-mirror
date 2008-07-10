From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: test merge base if good rev is not an ancestor of
 bad rev
Date: Thu, 10 Jul 2008 05:41:52 +0200
Message-ID: <20080710054152.b051989c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 05:39:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGmzl-00076x-Te
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 05:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbYGJDiE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2008 23:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYGJDiD
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 23:38:03 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:53645 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbYGJDiB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2008 23:38:01 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5740C1AB2BF;
	Thu, 10 Jul 2008 05:37:58 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 99C1F1AB2BC;
	Thu, 10 Jul 2008 05:37:57 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87937>

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

=46or example, if there is the following history:

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

In the current implementation though, only one merge base between a
good and a bad rev is tested.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |  137 +++++++++++++++++++++++++++++++++++=
--------
 t/t6030-bisect-porcelain.sh |   41 +++++++++++++
 2 files changed, 153 insertions(+), 25 deletions(-)

	Le mardi 1 juillet 2008, Junio C Hamano a =E9crit :
	> Aside from the "test a trial merge" idea I floated in the other mess=
age,
	> when we detect such a fork, perhaps we can suggest testing the merge=
 base
	> version (B in your picture) first?  We would immediately know as the=
 user
	> would say "B is bad" if the topology is problematic.
	>
	> Then, we can suggest the user that breakage at D may not be a regres=
sion
	> but a longstanding bug that was recently fixed somewhere between B a=
nd F.

	Here is a patch to do that.

diff --git a/git-bisect.sh b/git-bisect.sh
index 991b2ef..50f912f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -242,33 +242,18 @@ bisect_auto_next() {
 	bisect_next_check && bisect_next || :
 }
=20
-eval_rev_list() {
-	_eval=3D"$1"
-
-	eval $_eval
-	res=3D$?
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
 	_eval=3D"$1"
 	_skip=3D"$2"
=20
 	if [ -z "$_skip" ]; then
-		eval_rev_list "$_eval"
+		eval "$_eval"
 		return
 	fi
=20
 	# Let's parse the output of:
 	# "git rev-list --bisect-vars --bisect-all ..."
-	eval_rev_list "$_eval" | while read hash line
+	eval "$_eval" | while read hash line
 	do
 		case "$VARS,$FOUND,$TRIED,$hash" in
 			# We display some vars.
@@ -331,20 +316,122 @@ exit_if_skipped_commits () {
 	fi
 }
=20
+checkout() {
+	_rev=3D"$1"
+	_msg=3D"$2"
+	echo "Bisecting: $_msg"
+	git checkout -q "$_rev" || exit
+	git show-branch "$_rev"
+}
+
+is_among() {
+	_rev=3D"$1"
+	_list=3D"$2"
+	case "$_list" in *$_rev*) return 0 ;; esac
+	return 1
+}
+
+is_merge_base_ok() {
+	grep "^$1 $2 ok$" "$GIT_DIR/BISECT_MERGE_BASES" >/dev/null 2>&1
+}
+
+mark_merge_base_ok() {
+	echo "$1 $2 ok" >> "$GIT_DIR/BISECT_MERGE_BASES"
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
+	_badmb=3D"$1"
+	_g=3D"$2"
+	if is_testing_merge_base "$_badmb"; then
+		cat >&2 <<EOF
+The merge base $_badmb is bad.
+This means the bug has been fixed between $_badmb and $_g.
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
+	_bad=3D"$1"
+	_g=3D"$2"
+	_mb=3D"$3"
+	cat >&2 <<EOF
+Warning: the merge base between $_bad and $_g must be skipped.
+So we cannot be sure the first bad commit is between $_mb and $_bad.
+We continue anyway.
+EOF
+	mark_merge_base_ok "$_bad" "$_g"
+}
+
+check_merge_bases() {
+	_bad=3D"$1"
+	_good=3D"$2"
+	_skip=3D"$3"
+	for _g in $_good; do
+		is_merge_base_ok "$_bad" "$_g" && continue
+		_mb=3D$(git merge-base $_g $_bad)
+		if test "$_mb" =3D "$_g" || is_among "$_mb" "$_good"; then
+			mark_merge_base_ok "$_bad" "$_g"
+		elif test "$_mb" =3D "$_bad"; then
+			handle_bad_merge_base "$_bad" "$_g"
+		elif is_among "$_mb" "$_skip"; then
+			handle_skipped_merge_base "$_bad" "$_g" "_mb"
+		else
+			mark_testing_merge_base "$_mb"
+			checkout "$_mb" "a merge base must be tested"
+			checkout_done=3D1
+			break
+		fi
+	done
+}
+
+check_good_are_ancestors_of_bad() {
+	test -f "$GIT_DIR/BISECT_ANCESTORS_OK" && return
+	_bad=3D"$1"
+	_good=3D$(echo $2 | sed -e 's/\^//g')
+	_skip=3D"$3"
+	_side=3D$(git rev-list $_good ^$_bad)
+	if test -n "$_side"; then
+		check_merge_bases "$_bad" "$_good" "$_skip" || return
+		test "$checkout_done" -eq "1" && return
+	fi
+	: > "$GIT_DIR/BISECT_ANCESTORS_OK"
+}
+
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
 	bisect_next_check good
=20
+	# Get bad, good and skipped revs
+	bad=3D$(git rev-parse --verify refs/bisect/bad) &&
+	good=3D$(git for-each-ref --format=3D'^%(objectname)' \
+		"refs/bisect/good-*" | tr '\012' ' ') &&
 	skip=3D$(git for-each-ref --format=3D'%(objectname)' \
-		"refs/bisect/skip-*" | tr '\012' ' ') || exit
+		"refs/bisect/skip-*" | tr '\012' ' ') &&
=20
+	# Maybe some merge bases must be tested first
+	check_good_are_ancestors_of_bad "$bad" "$good" "$skip" || exit
+	test "$checkout_done" -eq "1" && checkout_done=3D'' && return
+
+	# Get bisection information
 	BISECT_OPT=3D''
 	test -n "$skip" && BISECT_OPT=3D'--bisect-all'
-
-	bad=3D$(git rev-parse --verify refs/bisect/bad) &&
-	good=3D$(git for-each-ref --format=3D'^%(objectname)' \
-		"refs/bisect/good-*" | tr '\012' ' ') &&
 	eval=3D"git rev-list --bisect-vars $BISECT_OPT $good $bad --" &&
 	eval=3D"$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
 	eval=3D$(filter_skipped "$eval" "$skip") &&
@@ -365,9 +452,7 @@ bisect_next() {
 	# commit is also a "skip" commit (see above).
 	exit_if_skipped_commits "$bisect_rev"
=20
-	echo "Bisecting: $bisect_nr revisions left to test after this"
-	git checkout -q "$bisect_rev" || exit
-	git show-branch "$bisect_rev"
+	checkout "$bisect_rev" "$bisect_nr revisions left to test after this"
 }
=20
 bisect_visualize() {
@@ -414,6 +499,8 @@ bisect_clean_state() {
 	do
 		git update-ref -d $ref $hash || exit
 	done
+	rm -f "$GIT_DIR/BISECT_MERGE_BASES" &&
+	rm -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 0626544..bf24b9a 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -350,6 +350,47 @@ test_expect_success 'bisect does not create a "bis=
ect" branch' '
 	git branch -D bisect
 '
=20
+# This creates a "side" branch to test "siblings" cases.
+test_expect_success 'side branch creation' '
+	git bisect reset &&
+	git checkout -b side $HASH4 &&
+	add_line_into_file "5(side): first line on a side branch" hello &&
+	SIDE_HASH5=3D$(git rev-parse --verify HEAD) &&
+	add_line_into_file "6(side): second line on a side branch" hello &&
+	SIDE_HASH6=3D$(git rev-parse --verify HEAD) &&
+	add_line_into_file "7(side): third line on a side branch" hello &&
+	SIDE_HASH7=3D$(git rev-parse --verify HEAD)
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
+test_expect_success 'skipped merge base when good and bad are siblings=
' '
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
+	grep "fixed between $HASH4 and $SIDE_HASH7" my_bisect_log.txt &&
+	git bisect reset
+'
+
 #
 #
 test_done
--=20
1.5.6.2.221.g6ad9a
