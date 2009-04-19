From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/5] bisect: use "git bisect--helper --next-exit" in
 "git-bisect.sh"
Date: Sun, 19 Apr 2009 11:56:16 +0200
Message-ID: <20090419115616.3f4f6762.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 11:59:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvTnr-0002ON-KV
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 11:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028AbZDSJ5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 05:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756018AbZDSJ5d
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 05:57:33 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:44360 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755692AbZDSJ5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 05:57:32 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1355994001E;
	Sun, 19 Apr 2009 11:57:25 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id 0E6CB94013C;
	Sun, 19 Apr 2009 11:57:23 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116891>

instead of "git bisect--helper --next-vars".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   39 +++++++++------------------------------
 1 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 24712ff..e1f300b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -279,19 +279,6 @@ bisect_auto_next() {
 	bisect_next_check && bisect_next || :
 }
 
-exit_if_skipped_commits () {
-	_tried=$1
-	_bad=$2
-	if test -n "$_tried" ; then
-		echo "There are only 'skip'ped commit left to test."
-		echo "The first bad commit could be any of:"
-		echo "$_tried" | tr '[|]' '[\012]'
-		test -n "$_bad" && echo "$_bad"
-		echo "We cannot bisect more!"
-		exit 2
-	fi
-}
-
 bisect_checkout() {
 	_rev="$1"
 	_msg="$2"
@@ -416,25 +403,17 @@ bisect_next() {
 	# Return now if a checkout has already been done
 	test "$?" -eq "1" && return
 
-	# Get bisection information
-	eval=$(eval "git bisect--helper --next-vars") &&
-	eval "$eval" || exit
+	# Perform bisection computation, display and checkout
+	git bisect--helper --next-exit
+	res=$?
 
-	if [ -z "$bisect_rev" ]; then
-		# We should exit here only if the "bad"
-		# commit is also a "skip" commit (see above).
-		exit_if_skipped_commits "$bisect_tried"
-		echo "$bad was both good and bad"
-		exit 1
-	fi
-	if [ "$bisect_rev" = "$bad" ]; then
-		exit_if_skipped_commits "$bisect_tried" "$bad"
-		echo "$bisect_rev is first bad commit"
-		git diff-tree --pretty $bisect_rev
-		exit 0
-	fi
+        # Check if we should exit because bisection is finished
+	test $res -eq 10 && exit 0
 
-	bisect_checkout "$bisect_rev" "$bisect_nr revisions left to test after this (roughly $bisect_steps steps)"
+	# Check for an error in the bisection process
+	test $res -ne 0 && exit $res
+
+	return 0
 }
 
 bisect_visualize() {
-- 
1.6.2.2.537.g3b83b
