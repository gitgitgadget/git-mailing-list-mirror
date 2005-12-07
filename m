From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] git-merge-one: new merge world order.
Date: Wed, 07 Dec 2005 02:01:35 -0800
Message-ID: <7v3bl5usxs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 07 11:03:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejw7K-0006Ms-68
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 11:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVLGKBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 05:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVLGKBj
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 05:01:39 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:27570 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750766AbVLGKBi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 05:01:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207100100.YTBU15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 05:01:00 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13320>

This does two things:

 - Use new --stage=2 option to create the working tree file with
   leading paths and correct permission bits using
   checkout-index, as before.

 - Make sure we do not confuse "merge" program when the file
   being merged has an unfortunate name, '-L'.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-merge-one-file.sh |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

b539c5e8fbd36e38eb8f589e11aa5b136ddce753
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 88a5da9..7dee88a 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -16,14 +16,6 @@
 # been handled already by git-read-tree, but that one doesn't
 # do any merges that might change the tree layout.
 
-verify_path() {
-    file="$1"
-    dir=`dirname "$file"` &&
-    mkdir -p "$dir" &&
-    rm -f -- "$file" &&
-    : >"$file"
-}
-
 case "${1:-.}${2:-.}${3:-.}" in
 #
 # Deleted in both or deleted in one and unchanged in the other
@@ -95,15 +87,16 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
-	# Create the working tree file, with the correct permission bits.
-	# we can not rely on the fact that our tree has the path, because
-	# we allow the merge to be done in an unchecked-out working tree.
-	verify_path "$4" &&
-		git-cat-file blob "$2" >"$4" &&
-		case "$6" in *7??) chmod +x -- "$4" ;; esac &&
-		merge "$4" "$orig" "$src2"
+	# Be careful for funny filename such as "-L" in "$4", which
+	# would confuse "merge" greatly.
+	src1=`git-unpack-file $2`
+	merge "$src1" "$orig" "$src2"
 	ret=$?
-	rm -f -- "$orig" "$src2"
+
+	# Create the working tree file, using "our tree" version from the
+	# index, and then store the result of the merge.
+	git-checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4"
+	rm -f -- "$orig" "$src1" "$src2"
 
 	if [ "$6" != "$7" ]; then
 		echo "ERROR: Permissions conflict: $5->$6,$7."
-- 
0.99.9.GIT
