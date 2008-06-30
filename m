From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: error out when given any good rev that is not an
 ancestor of the bad rev
Date: Tue, 1 Jul 2008 00:42:11 +0200
Message-ID: <20080701004211.ba9b89c9.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:39:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDS1i-0004EL-W4
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764322AbYF3WiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763763AbYF3WiS
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:38:18 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37202 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763584AbYF3WiR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:38:17 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2C5E11AB2B9;
	Tue,  1 Jul 2008 00:38:15 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 5C09F1AB2BC;
	Tue,  1 Jul 2008 00:38:14 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86951>

Before this patch "git bisect" doesn't really work when it is given
some good revs that are siblings of the bad rev.

For example if there is the following history:

A-B-C-D
   \E-F

and we launch "git bisect start D F" then only C and D will be
considered as possible first bad commit. This is wrong because A, B and
E may be bad too if the bug exists everywhere except in F that fixes it.

Maybe there is a way to make the above work, but for now the purpose of
this patch is to fix the problem by checking that all good revs are
ancestor of the bad rev and by erroring out if this is not the case.

To do that we run "git rev-list ^bad good" and we check that it outputs
nothing.

This check will also catch the case where good and bad have been
mistaken. This means that we can remove the check that was done latter
on the output of "git rev-list --bisect-vars". The downside of that is
that now we can't tell between a mistake and a "siblings" case.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   32 +++++++++++++++-----------------
 t/t6030-bisect-porcelain.sh |   19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 17 deletions(-)

	Maybe we can improve on this patch by trying to tell between
	a mistake and a "siblings" case to give a better error
	message.

diff --git a/git-bisect.sh b/git-bisect.sh
index 991b2ef..90a9d74 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -242,33 +242,18 @@ bisect_auto_next() {
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
@@ -331,6 +316,18 @@ exit_if_skipped_commits () {
 	fi
 }
 
+check_good_are_ancestor_of_bad() {
+	_bad="^$1"
+	_good=$(echo $2 | sed -e 's/\^//g')
+	_side=$(git rev-list $_good $_bad)
+	if test -n "$_side"; then
+		echo >&2 "Some good revs are not ancestor of the bad rev."
+		echo >&2 "git bisect cannot work properly in this case."
+		echo >&2 "Maybe you mistake good and bad revs?"
+		return 1
+	fi
+}
+
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
@@ -345,6 +342,7 @@ bisect_next() {
 	bad=$(git rev-parse --verify refs/bisect/bad) &&
 	good=$(git for-each-ref --format='^%(objectname)' \
 		"refs/bisect/good-*" | tr '\012' ' ') &&
+	check_good_are_ancestor_of_bad "$bad" "$good" &&
 	eval="git rev-list --bisect-vars $BISECT_OPT $good $bad --" &&
 	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
 	eval=$(filter_skipped "$eval" "$skip") &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 0626544..b3f3869 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -350,6 +350,25 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	git branch -D bisect
 '
 
+# This creates a "side" branch to test "siblings" cases.
+test_expect_success 'bisect errors out when good and bad are siblings' '
+	git bisect reset &&
+	git checkout -b side $HASH4 &&
+	add_line_into_file "5(side): first line on a side branch" hello &&
+	SIDE_HASH5=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "6(side): second line on a side branch" hello &&
+	SIDE_HASH6=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "7(side): third line on a side branch" hello &&
+	SIDE_HASH7=$(git rev-parse --verify HEAD) &&
+	test_must_fail git bisect start "$HASH7" "$SIDE_HASH7" &&
+	test_must_fail git bisect start "$SIDE_HASH7" "$HASH7" &&
+	test_must_fail git bisect start "$HASH7" HEAD &&
+	test_must_fail git bisect start "$SIDE_HASH5" "$HASH7" &&
+	test_must_fail test -e .git/BISECT_START &&
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test "$(git rev-parse --verify HEAD)" = "$SIDE_HASH7"
+'
+
 #
 #
 test_done
-- 
1.5.6.7.g5b8fa.dirty
