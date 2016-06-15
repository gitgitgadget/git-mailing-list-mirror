From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2 v3] bisect: only check merge bases when needed
Date: Fri, 22 Aug 2008 05:52:29 +0200
Message-ID: <20080822055229.95f9b944.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 05:49:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWNeh-0004iL-2R
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 05:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbYHVDsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 23:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYHVDsh
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 23:48:37 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:58415 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbYHVDsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 23:48:36 -0400
Received: from smtp5-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 992673F6148;
	Fri, 22 Aug 2008 05:48:34 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with SMTP id 089D33F6147;
	Fri, 22 Aug 2008 05:48:33 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93248>

When one good revision is not an ancestor of the bad revision, the
merge bases between the good and the bad revision should be checked
to make sure that they are also good revisions.

A previous patch takes care of that, but it may check the merge bases
more often than really needed. In fact the previous patch did not try
to optimize this as much as possible because it is not so simple. So
this is the purpose of this patch.

One may think that when all the merge bases have been checked then
we can save a flag, so that we don't need to check the merge bases
again during the bisect process.

The problem is that the user may choose to checkout and test
something completely different from what the bisect process
suggested. In this case we have to check the merge bases again,
because there may be new merge bases relevant to the bisect
process.

That's why, in this patch, when we detect that the user tested
something else than what the bisect process suggested, we remove
the flag that says that we don't need to check the merge bases
again.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   48 ++++++++++++++++++++++++++++++------------
 t/t6030-bisect-porcelain.sh |   24 +++++++++++++++++++++
 2 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b314d47..69a9a56 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -172,6 +172,25 @@ bisect_write() {
 	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
+is_expected_rev() {
+	test -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
+	test "$1" = $(cat "$GIT_DIR/BISECT_EXPECTED_REV")
+}
+
+mark_expected_rev() {
+	echo "$1" > "$GIT_DIR/BISECT_EXPECTED_REV"
+}
+
+check_expected_revs() {
+	for _rev in "$@"; do
+		if ! is_expected_rev "$_rev"; then
+			rm -f "$GIT_DIR/BISECT_ANCESTORS_OK"
+			rm -f "$GIT_DIR/BISECT_EXPECTED_REV"
+			return
+		fi
+	done
+}
+
 bisect_state() {
 	bisect_autostart
 	state=$1
@@ -181,7 +200,8 @@ bisect_state() {
 	1,bad|1,good|1,skip)
 		rev=$(git rev-parse --verify HEAD) ||
 			die "Bad rev input: HEAD"
-		bisect_write "$state" "$rev" ;;
+		bisect_write "$state" "$rev"
+		check_expected_revs "$rev" ;;
 	2,bad|*,good|*,skip)
 		shift
 		eval=''
@@ -191,7 +211,8 @@ bisect_state() {
 				die "Bad rev input: $rev"
 			eval="$eval bisect_write '$state' '$sha'; "
 		done
-		eval "$eval" ;;
+		eval "$eval"
+		check_expected_revs "$@" ;;
 	*,bad)
 		die "'git bisect bad' can take only one argument." ;;
 	*)
@@ -321,6 +342,7 @@ bisect_checkout() {
 	_rev="$1"
 	_msg="$2"
 	echo "Bisecting: $_msg"
+	mark_expected_rev "$_rev"
 	git checkout -q "$_rev" || exit
 	git show-branch "$_rev"
 }
@@ -332,18 +354,10 @@ is_among() {
 	return 1
 }
 
-is_testing_merge_base() {
-	grep "^testing $1$" "$GIT_DIR/BISECT_MERGE_BASES" >/dev/null 2>&1
-}
-
-mark_testing_merge_base() {
-	echo "testing $1" >> "$GIT_DIR/BISECT_MERGE_BASES"
-}
-
 handle_bad_merge_base() {
 	_badmb="$1"
 	_good="$2"
-	if is_testing_merge_base "$_badmb"; then
+	if is_expected_rev "$_badmb"; then
 		cat >&2 <<EOF
 The merge base $_badmb is bad.
 This means the bug has been fixed between $_badmb and [$_good].
@@ -383,7 +397,6 @@ check_merge_bases() {
 		elif is_among "$_mb" "$_skip"; then
 			handle_skipped_merge_base "$_mb" "$_bad" "$_good"
 		else
-			mark_testing_merge_base "$_mb"
 			bisect_checkout "$_mb" "a merge base must be tested"
 			checkout_done=1
 			return
@@ -392,6 +405,9 @@ check_merge_bases() {
 }
 
 check_good_are_ancestors_of_bad() {
+	test -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
+		return
+
 	_bad="$1"
 	_good=$(echo $2 | sed -e 's/\^//g')
 	_skip="$3"
@@ -401,8 +417,11 @@ check_good_are_ancestors_of_bad() {
 
 	_side=$(git rev-list $_good ^$_bad)
 	if test -n "$_side"; then
-		check_merge_bases "$_bad" "$_good" "$_skip"
+		check_merge_bases "$_bad" "$_good" "$_skip" || return
+		test "$checkout_done" -eq "1" && return
 	fi
+
+	: > "$GIT_DIR/BISECT_ANCESTORS_OK"
 }
 
 bisect_next() {
@@ -491,7 +510,8 @@ bisect_clean_state() {
 	do
 		git update-ref -d $ref $hash || exit
 	done
-	rm -f "$GIT_DIR/BISECT_MERGE_BASES" &&
+	rm -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
+	rm -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a1ce95c..c163114 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -440,6 +440,30 @@ test_expect_success 'good merge bases when good and bad are siblings' '
 	git bisect reset
 '
 
+check_trace() {
+	grep "$1" "$GIT_TRACE" | grep "\^$2" | grep "$3" >/dev/null
+}
+
+test_expect_success 'optimized merge base checks' '
+	GIT_TRACE="$(pwd)/trace.log" &&
+	export GIT_TRACE &&
+	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
+	grep "merge base must be tested" my_bisect_log.txt &&
+	grep "$HASH4" my_bisect_log.txt &&
+	check_trace "rev-list" "$HASH7" "$SIDE_HASH7" &&
+	git bisect good > my_bisect_log2.txt &&
+	test -f ".git/BISECT_ANCESTORS_OK" &&
+	test "$HASH6" = $(git rev-parse --verify HEAD) &&
+	: > "$GIT_TRACE" &&
+	git bisect bad > my_bisect_log3.txt &&
+	test_must_fail check_trace "rev-list" "$HASH6" "$SIDE_HASH7" &&
+	git bisect good "$A_HASH" > my_bisect_log4.txt &&
+	grep "merge base must be tested" my_bisect_log4.txt &&
+	test_must_fail test -f ".git/BISECT_ANCESTORS_OK" &&
+	check_trace "rev-list" "$HASH6" "$A_HASH" &&
+	unset GIT_TRACE
+'
+
 #
 #
 test_done
-- 
1.6.0.128.g1827
