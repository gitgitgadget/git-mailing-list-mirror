From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix argument processing for cg-Xmergefile.
Date: Sat, 15 Oct 2005 00:27:45 -0400
Message-ID: <1129350465.11437.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 15 06:29:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQdeY-000551-MM
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 06:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVJOE1x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 00:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVJOE1x
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 00:27:53 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:40378 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751070AbVJOE1x
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 00:27:53 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EQde9-0003vV-8C
	for git@vger.kernel.org; Sat, 15 Oct 2005 00:27:49 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EQde5-0002zb-T5; Sat, 15 Oct 2005 00:27:45 -0400
To: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10125>

Positional arguments are no longer available.  Use ARGS array instead.
Use variables with distinctive names for every argument.
Improve message for the cases cg-Xmergefile cannot handle.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cg-Xmergefile |   61 ++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 34 insertions(+), 27 deletions(-)

applies-to: f12b3dd9b47f28842943471719e7f5d24727b178
546a93bdec1cd37516daf21137ed6fa3572b50cb
diff --git a/cg-Xmergefile b/cg-Xmergefile
index 16a2f69..5bff254 100755
--- a/cg-Xmergefile
+++ b/cg-Xmergefile
@@ -24,6 +24,13 @@
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
+id0="${ARGS[0]}"
+id1="${ARGS[1]}"
+id2="${ARGS[2]}"
+file="${ARGS[3]}"
+mode0="${ARGS[4]}"
+mode1="${ARGS[5]}"
+mode2="${ARGS[6]}"
 
 error()
 {
@@ -37,37 +44,37 @@ warning()
 }
 
 
-case "${1:-.}${2:-.}${3:-.}" in
+case "${id0:-.}${id1:-.}${id2:-.}" in
 #
 # Deleted in both or deleted in one and unchanged in the other
 #
-"$1.." | "$1.$1" | "$1$1.")
-	#echo "Removing $4"
-	if test -f "$4"; then
-		rm -f -- "$4"
+"$id0.." | "$id0.$id0" | "$id0$id0.")
+	#echo "Removing $file"
+	if test -f "$file"; then
+		rm -f -- "$file"
 	fi &&
-		exec git-update-index --remove -- "$4"
+		exec git-update-index --remove -- "$file"
 	;;
 
 #
 # Added in one.
 #
-".$2." | "..$3" )
-	#echo "Adding $4"
-	git-update-index --add --cacheinfo "$6$7" "$2$3" "$4" &&
-		exec git-checkout-index -u -f -- "$4"
+".$id1." | "..$id2" )
+	#echo "Adding $file"
+	git-update-index --add --cacheinfo "$mode1$mode2" "$id1$id2" "$file" &&
+		exec git-checkout-index -u -f -- "$file"
 	;;
 
 #
 # Added in both (check for same permissions).
 #
-".$3$2")
-	#echo "Adding $4"
-	git-update-index --add --cacheinfo "$6" "$2" "$4" &&
-		git-checkout-index -u -f -- "$4"
+".$id2$id1")
+	#echo "Adding $file"
+	git-update-index --add --cacheinfo "$mode1" "$id1" "$file" &&
+		git-checkout-index -u -f -- "$file"
 	ret=$?
-	if [ "$6" != "$7" ]; then
-		error "$4: added in both branches, permissions conflict $6->$7"
+	if [ "$mode1" != "$mode2" ]; then
+		error "$file: added in both branches, permissions conflict $mode1->$mode2"
 		exit 1
 	fi
 	exit $ret
@@ -76,21 +83,21 @@ case "${1:-.}${2:-.}${3:-.}" in
 #
 # Modified in both, but differently.
 #
-"$1$2$3")
-	echo "... Auto-merging $4"
-	orig=$(git-unpack-file $1)
-	src2=$(git-unpack-file $3)
+"$id0$id1$id2")
+	echo "... Auto-merging $file"
+	orig=$(git-unpack-file $id0)
+	src2=$(git-unpack-file $id2)
 
 	# We reset the index to the first branch, making
 	# git-diff-file useful
-	git-update-index --add --cacheinfo "$6" "$2" "$4"
-		git-checkout-index -u -f -- "$4" &&
-		merge "$4" "$orig" "$src2"
+	git-update-index --add --cacheinfo "$mode1" "$id1" "$file"
+		git-checkout-index -u -f -- "$file" &&
+		merge "$file" "$orig" "$src2"
 	ret=$?
 	rm -f -- "$orig" "$src2"
 
-	if [ "$6" != "$7" ]; then
-		error "Permissions conflict: $5->$6,$7."
+	if [ "$mode1" != "$mode2" ]; then
+		error "Permissions conflict: $mode0->$mode1,$mode2."
 		ret=1
 	fi
 
@@ -100,11 +107,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 		#error "Auto-merge failed"
 		exit 1
 	fi
-	exec git-update-index -- "$4"
+	exec git-update-index -- "$file"
 	;;
 
 *)
-	error "$4: Not handling case $1 -> $2 -> $3"
+	error "$file: Not handling case: ${id0:-empty} -> ${id1:-empty} -> ${id2:-empty}"
 	;;
 esac
 exit 1
---
0.99.8.GIT


-- 
Regards,
Pavel Roskin
