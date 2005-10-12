From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH]: Use ARGS, not positional arguments
Date: Wed, 12 Oct 2005 01:57:28 -0400
Message-ID: <1129096648.2427.47.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 12 07:58:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPZcb-0006h0-1K
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 07:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVJLF5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 01:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVJLF5d
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 01:57:33 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:61608 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932468AbVJLF5d
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 01:57:33 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EPZcJ-00080W-Kj
	for git@vger.kernel.org; Wed, 12 Oct 2005 01:57:31 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EPZcG-00088X-DT; Wed, 12 Oct 2005 01:57:28 -0400
To: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10009>

Some scripts need to be fixed to use ARGS properly.

Positional arguments are no longer preserved in cg-Xlib, so they may not
be used.  cg-export uses standard option parsing now.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-admin-lsobj b/cg-admin-lsobj
index 8899037..bf3413f 100755
--- a/cg-admin-lsobj
+++ b/cg-admin-lsobj
@@ -39,7 +39,7 @@ USAGE="cg-admin-lsobj [OBJECT_TYPE]"
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
-target=$1
+target=${ARGS[0]}
 
 
 subdir=$_git_objects
diff --git a/cg-branch-add b/cg-branch-add
index eb20598..c5462cf 100755
--- a/cg-branch-add
+++ b/cg-branch-add
@@ -63,8 +63,8 @@ USAGE="cg-branch-add BRANCH_NAME LOCATIO
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
-name=$1
-location=$2
+name=${ARGS[0]}
+location=${ARGS[1]}
 
 ([ "$name" ] && [ "$location" ]) || usage
 (echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
diff --git a/cg-branch-chg b/cg-branch-chg
index 6ac8d15..9c98f6b 100755
--- a/cg-branch-chg
+++ b/cg-branch-chg
@@ -9,8 +9,8 @@ USAGE="cg-branch-chg BRANCH_NAME NEW_LOC
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
-name=$1
-location=$2
+name=${ARGS[0]}
+location=${ARGS[1]}
 ([ "$name" ] && [ "$location" ]) || usage
 
 [ -s "$_git/branches/$name" ] || die "branch does not exist"
diff --git a/cg-export b/cg-export
index 594e225..ef9e7cc 100755
--- a/cg-export
+++ b/cg-export
@@ -15,17 +15,22 @@ _git_requires_root=1
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
-if [ "$1" = "-r" ]; then
-	shift
-	# We do not resolve to tree id since git-tar-tree can utilize some commit
-	# information.
-	id="$(cg-object-id -c "$1" 2>/dev/null)" || id="$1"
-	shift
-else
+id=
+while optparse; do
+	if optparse -r=; then
+		# We do not resolve to tree id since git-tar-tree can
+		# utilize some commit information.
+		id="$(cg-object-id -c "$OPTARG" 2>/dev/null)" || id="$OPTARG"
+	else
+		optfail
+	fi
+done
+
+if [ -z "$id" ]; then
 	id="$(cg-object-id -c)"
 fi
 
-dest=$1
+dest=${ARGS[0]}
 
 ([ "$dest" ] && [ "$id" ]) || usage
 
diff --git a/cg-patch b/cg-patch
index 2aecd1a..153376e 100755
--- a/cg-patch
+++ b/cg-patch
@@ -70,7 +70,7 @@ redzone_border()
 
 
 reverse=
-if [ "$1" = "-R" ]; then
+if [ "${ARGS[0]}" = "-R" ]; then
 	reverse=1
 	shift
 fi
diff --git a/cg-reset b/cg-reset
index dbd69c6..38b7361 100755
--- a/cg-reset
+++ b/cg-reset
@@ -20,7 +20,7 @@ _git_requires_root=1
 . ${COGITO_LIB}cg-Xlib || exit 1
 deprecated_alias cg-reset cg-cancel
 
-[ "$1" ] && die "this command takes no parameters; use cg-restore to restore individual files"
+[ "${ARGS[0]}" ] && die "this command takes no parameters; use cg-restore to restore individual files"
 
 if ! [ -s $_git/HEAD ]; then
 	rm -f $_git/HEAD
diff --git a/cg-seek b/cg-seek
index f07b90c..d2aeb0a 100755
--- a/cg-seek
+++ b/cg-seek
@@ -24,7 +24,7 @@ _git_requires_root=1
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
-dstcommit=$1
+dstcommit=${ARGS[0]}
 
 
 [ -s $_git/blocked ] && grep -vq '^seeked from ' $_git/blocked && die "action blocked: $(cat $_git/blocked)"


-- 
Regards,
Pavel Roskin
