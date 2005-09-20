From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 6/8] cogito: Don't ever assume object type in cg-object-id
Date: Mon, 19 Sep 2005 22:25:20 -0400
Message-ID: <1127183120.31115.34.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 04:26:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXp3-0006yN-QW
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVITCZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVITCZZ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:25:25 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:4268 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964843AbVITCZY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:25:24 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHXox-0006Jb-QW
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:25:23 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHXou-0001iI-Kf
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:25:20 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8958>

Don't ever assume object type in cg-object-id.

If type is unknown in normalize_id(), make it empty so it's checked
later.  Check parent ID that it's a commit.

diff --git a/cg-object-id b/cg-object-id
--- a/cg-object-id
+++ b/cg-object-id
@@ -24,22 +24,22 @@
 USAGE="cg-object-id [-p] [-t] [OBJECT_ID]"
 
 . ${COGITO_LIB}cg-Xlib
 
 
-# Normalize argument.  The normalized SHA1 ID is put to $normid,
-# type is put to $type.
+# Normalize argument.  The normalized SHA1 ID is put to $normid.
+# If type is known, it's put to $type.
 normalize_id()
 {
 	local id="$1"
+	local type=
 
 	if [ "${id:(-1):1}" = "^" ]; then
 		# find first parent
 		normalize_id "${id%^}"
 		normid=$(git-cat-file commit "$normid" | \
 			 awk '/^parent/{print $2; exit};/^$/{exit}') || exit 1
-		type="commit"
 		return
 	fi
 
 	if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
 		read id < "$_git/HEAD"
@@ -118,31 +118,33 @@ if [ "$show_parent" -a "$show_tree" ]; t
 	exit 1
 fi
 
 id="${ARGS[0]}"
 normalize_id "$id"
+[ "$type" ] || type=$(git-cat-file -t "$normid")
+
+if [ -z "$show_tree" ]; then
+	if [ "$type" != "commit" ]; then
+		echo "Invalid commit id: $normid" >&2
+		exit 1
+	fi
+fi
 
 if [ "$show_parent" ]; then
 	git-cat-file commit "$normid" | awk '/^parent/{print $2};/^$/{exit}'
 	exit 0
 fi
 
-[ "$type" ] || type=$(git-cat-file -t "$normid")
 if [ "$show_tree" ]; then
 	if [ "$type" = "commit" ]; then
 		normid=$(git-cat-file commit "$normid" | sed -e 's/tree //;q')
 		type=$(git-cat-file -t "$normid")
 	fi
 
 	if [ "$type" != "tree" ]; then
 		echo "Invalid tree id: $normid" >&2
 		exit 1
 	fi
-else
-	if [ "$type" != "commit" ]; then
-		echo "Invalid commit id: $normid" >&2
-		exit 1
-	fi
 fi
 
 echo $normid
 

-- 
Regards,
Pavel Roskin
