From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: remove "checkout_done" variable used when checking
 merge bases
Date: Sat, 6 Sep 2008 07:27:03 +0200
Message-ID: <20080906072703.98a0475d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 07:25:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbqHg-000681-Ot
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 07:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbYIFFX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 01:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbYIFFX0
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 01:23:26 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:52799 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbYIFFX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 01:23:26 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 60E1E12B6BD;
	Sat,  6 Sep 2008 07:23:24 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 1058912B6B4;
	Sat,  6 Sep 2008 07:23:23 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95062>

Using return values from the following functions:

- check_merge_bases
- check_good_are_ancestors_of_bad

seems simpler.

While at it, let's add some comments to better document the above
functions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

	> > PS: After thinking about it, I wonder if we should
	> > remove $checkout_done entirely and use the return
	> > value from "check_merge_bases" and
	> > "check_good_are_ancestors_of_bad" to know if a
	> > checkout was done.
	>
	> Yup, that might make more sense. 

	So here is such a patch.

diff --git a/git-bisect.sh b/git-bisect.sh
index 69a9a56..79de701 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -384,6 +384,17 @@ We continue anyway.
 EOF
 }
 
+#
+# "check_merge_bases" checks that merge bases are not "bad".
+#
+# - If one is "good", that's good, we have nothing to do.
+# - If one is "bad", it means the user assumed something wrong
+# and we must exit.
+# - If one is "skipped", we can't know but we should warn.
+# - If we don't know, we should check it out and ask the user to test.
+#
+# In the last case we will return 1, and otherwise 0.
+#
 check_merge_bases() {
 	_bad="$1"
 	_good="$2"
@@ -398,12 +409,20 @@ check_merge_bases() {
 			handle_skipped_merge_base "$_mb" "$_bad" "$_good"
 		else
 			bisect_checkout "$_mb" "a merge base must be tested"
-			checkout_done=1
-			return
+			return 1
 		fi
 	done
+	return 0
 }
 
+#
+# "check_good_are_ancestors_of_bad" checks that all "good" revs are
+# ancestor of the "bad" rev.
+#
+# If that's not the case, we need to check the merge bases.
+# If a merge base must be tested by the user we return 1 and
+# otherwise 0.
+#
 check_good_are_ancestors_of_bad() {
 	test -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
 		return
@@ -417,11 +436,13 @@ check_good_are_ancestors_of_bad() {
 
 	_side=$(git rev-list $_good ^$_bad)
 	if test -n "$_side"; then
+		# Return if a checkout was done
 		check_merge_bases "$_bad" "$_good" "$_skip" || return
-		test "$checkout_done" -eq "1" && return
 	fi
 
 	: > "$GIT_DIR/BISECT_ANCESTORS_OK"
+
+	return 0
 }
 
 bisect_next() {
@@ -437,8 +458,9 @@ bisect_next() {
 		"refs/bisect/skip-*" | tr '\012' ' ') &&
 
 	# Maybe some merge bases must be tested first
-	check_good_are_ancestors_of_bad "$bad" "$good" "$skip" || exit
-	test "$checkout_done" -eq "1" && checkout_done='' && return
+	check_good_are_ancestors_of_bad "$bad" "$good" "$skip"
+	# Return now if a checkout has already been done
+	test "$?" -eq "1" && return
 
 	# Get bisection information
 	BISECT_OPT=''
-- 
1.6.0.1.320.gd5f2f.dirty
