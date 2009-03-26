From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/10] bisect: use "bisect--helper" and remove
 "filter_skipped" function
Date: Thu, 26 Mar 2009 05:56:02 +0100
Message-ID: <20090326055602.b0fc796f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:58:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmhfr-0003rO-UD
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbZCZE5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbZCZE5H
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:57:07 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:45264 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259AbZCZE5F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:57:05 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 43675E0804A;
	Thu, 26 Mar 2009 05:56:53 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with SMTP id 33E9EE0801A;
	Thu, 26 Mar 2009 05:56:51 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114730>

Use the new "git bisect--helper" builtin. It should be faster and
safer instead of the old "filter_skipped" shell function. And it
is a first step to move more shell code to C.

As the output is a little bit different we have to change the code
that interpret the results. But these changes improve code clarity.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   89 ++++++++-------------------------------------------------
 1 files changed, 12 insertions(+), 77 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index e313bde..0f7590d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -279,76 +279,13 @@ bisect_auto_next() {
 	bisect_next_check && bisect_next || :
 }
 
-filter_skipped() {
+eval_and_string_together() {
 	_eval="$1"
-	_skip="$2"
-
-	if [ -z "$_skip" ]; then
-		eval "$_eval" | {
-			while read line
-			do
-				echo "$line &&"
-			done
-			echo ':'
-		}
-		return
-	fi
 
-	# Let's parse the output of:
-	# "git rev-list --bisect-vars --bisect-all ..."
 	eval "$_eval" | {
-		VARS= FOUND= TRIED=
-		while read hash line
+		while read line
 		do
-			case "$VARS,$FOUND,$TRIED,$hash" in
-			1,*,*,*)
-				# "bisect_foo=bar" read from rev-list output.
-				echo "$hash &&"
-				;;
-			,*,*,---*)
-				# Separator
-				;;
-			,,,bisect_rev*)
-				# We had nothing to search.
-				echo "bisect_rev= &&"
-				VARS=1
-				;;
-			,,*,bisect_rev*)
-				# We did not find a good bisect rev.
-				# This should happen only if the "bad"
-				# commit is also a "skip" commit.
-				echo "bisect_rev='$TRIED' &&"
-				VARS=1
-				;;
-			,,*,*)
-				# We are searching.
-				TRIED="${TRIED:+$TRIED|}$hash"
-				case "$_skip" in
-				*$hash*) ;;
-				*)
-					echo "bisect_rev=$hash &&"
-					echo "bisect_tried='$TRIED' &&"
-					FOUND=1
-					;;
-				esac
-				;;
-			,1,*,bisect_rev*)
-				# We have already found a rev to be tested.
-				VARS=1
-				;;
-			,1,*,*)
-				;;
-			*)
-				# Unexpected input
-				echo "die 'filter_skipped error'"
-				die "filter_skipped error " \
-				    "VARS: '$VARS' " \
-				    "FOUND: '$FOUND' " \
-				    "TRIED: '$TRIED' " \
-				    "hash: '$hash' " \
-				    "line: '$line'"
-				;;
-			esac
+			echo "$line &&"
 		done
 		echo ':'
 	}
@@ -356,10 +293,12 @@ filter_skipped() {
 
 exit_if_skipped_commits () {
 	_tried=$1
-	if expr "$_tried" : ".*[|].*" > /dev/null ; then
+	_bad=$2
+	if test -n "$_tried" ; then
 		echo "There are only 'skip'ped commit left to test."
 		echo "The first bad commit could be any of:"
 		echo "$_tried" | tr '[|]' '[\012]'
+		test -n "$_bad" && echo "$_bad"
 		echo "We cannot bisect more!"
 		exit 2
 	fi
@@ -490,28 +429,24 @@ bisect_next() {
 	test "$?" -eq "1" && return
 
 	# Get bisection information
-	BISECT_OPT=''
-	test -n "$skip" && BISECT_OPT='--bisect-all'
-	eval="git rev-list --bisect-vars $BISECT_OPT $good $bad --" &&
-	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
-	eval=$(filter_skipped "$eval" "$skip") &&
+	eval="git bisect--helper --next-vars" &&
+	eval=$(eval_and_string_together "$eval") &&
 	eval "$eval" || exit
 
 	if [ -z "$bisect_rev" ]; then
+		# We should exit here only if the "bad"
+		# commit is also a "skip" commit (see above).
+		exit_if_skipped_commits "$bisect_tried"
 		echo "$bad was both good and bad"
 		exit 1
 	fi
 	if [ "$bisect_rev" = "$bad" ]; then
-		exit_if_skipped_commits "$bisect_tried"
+		exit_if_skipped_commits "$bisect_tried" "$bad"
 		echo "$bisect_rev is first bad commit"
 		git diff-tree --pretty $bisect_rev
 		exit 0
 	fi
 
-	# We should exit here only if the "bad"
-	# commit is also a "skip" commit (see above).
-	exit_if_skipped_commits "$bisect_rev"
-
 	bisect_checkout "$bisect_rev" "$bisect_nr revisions left to test after this (roughly $bisect_steps steps)"
 }
 
-- 
1.6.2.1.317.g3d804
