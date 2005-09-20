From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 7/8] cogito: Fix cg-tag to use cg-object-id
Date: Mon, 19 Sep 2005 22:27:42 -0400
Message-ID: <1127183262.31115.38.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 04:28:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXrH-0007Je-DR
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVITC1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVITC1p
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:27:45 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:28076 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964844AbVITC1o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:27:44 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHXrD-0006NU-Nm
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:27:43 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHXrC-0001iW-My
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:27:42 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8959>

Fix cg-tag to use cg-object-id

Add new option -n (normalize only) to cg-object-id.  Mark all options
as mutually exclusive and check it.  Call 'cg-object-id -n' from cg-tag.

diff --git a/cg-object-id b/cg-object-id
--- a/cg-object-id
+++ b/cg-object-id
@@ -8,10 +8,13 @@
 # If the ID is not provided, HEAD is used.  The default behavior is to
 # show the commit ID.
 #
 # OPTIONS
 # -------
+# -n::
+#	Normalize only - don't check the object type.
+#
 # -p::
 #	Get ID of parent commit(s) to a given revision or HEAD.
 #	NOTE: Multiple SHA1s separated by newlines will be returned for
 #	commits with multiple parents.
 #
@@ -19,11 +22,11 @@
 #	Get ID of tree associated with given commit or HEAD.
 #
 # OBJECT_ID::
 #	An ID resolving to a commit.
 
-USAGE="cg-object-id [-p] [-t] [OBJECT_ID]"
+USAGE="cg-object-id [-n | -p | -t] [OBJECT_ID]"
 
 . ${COGITO_LIB}cg-Xlib
 
 
 # Normalize argument.  The normalized SHA1 ID is put to $normid.
@@ -95,12 +98,15 @@ normalize_id()
 
 
 
 show_parent=
 show_tree=
+normalize_only=
 while optparse; do
-	if optparse -p; then
+	if optparse -n; then
+		normalize_only=1
+	elif optparse -p; then
 		show_parent=1
 	elif optparse -t; then
 		show_tree=1
 	else
 		optfail
@@ -111,17 +117,22 @@ done
 case $_cg_cmd in
 	*parent*) show_parent=1;;
 	*tree*) show_tree=1;;
 esac
 
-if [ "$show_parent" -a "$show_tree" ]; then
-	echo "Cannot show parent and tree ID at the same time." >&2
-	exit 1
-fi
+case "$show_parent$show_tree$normalize_only" in
+	11*)	usage;;
+esac
 
 id="${ARGS[0]}"
 normalize_id "$id"
+
+if [ "$normalize_only" ]; then
+	echo $normid
+	exit 0
+fi
+
 [ "$type" ] || type=$(git-cat-file -t "$normid")
 
 if [ -z "$show_tree" ]; then
 	if [ "$type" != "commit" ]; then
 		echo "Invalid commit id: $normid" >&2
diff --git a/cg-tag b/cg-tag
--- a/cg-tag
+++ b/cg-tag
@@ -45,12 +45,12 @@ done
 name="${ARGS[0]}"
 id="${ARGS[1]}"
 
 [ "$name" ] || usage
 
-id=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
-type=${id#* }; [ "$type" ] || type=$(git-cat-file -t "$id")
+id=$(cg-object-id -n "$id") || exit 1
+type=$(git-cat-file -t "$id")
 id=${id% *}
 
 (echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
 	die "name contains invalid characters"
 

-- 
Regards,
Pavel Roskin
