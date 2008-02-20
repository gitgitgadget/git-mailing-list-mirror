From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-clone.sh: properly configure remote even if remote's
	head is dangling
Date: Wed, 20 Feb 2008 15:10:17 +0000
Message-ID: <20080220151017.17840.qmail@767a223c93e1c8.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 16:10:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRqaj-00044m-JP
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 16:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbYBTPKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 10:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbYBTPJ7
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 10:09:59 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:53937 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751988AbYBTPJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 10:09:59 -0500
Received: (qmail 17841 invoked by uid 1000); 20 Feb 2008 15:10:17 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74516>

When cloning a remote repository which's HEAD refers to a nonexistent
ref, git-clone cloned all existing refs, but failed to write the
configuration for 'remote'.  Now it detects the dangling remote HEAD,
refuses to checkout any local branch since HEAD refers to nowhere, but
properly writes the configuration for 'remote', so that subsequent
'git fetch's don't fail.

The problem was reported by Daniel Jacobowitz through
 http://bugs.debian.org/466581

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-clone.sh           |   18 +++++++++++++-----
 t/t5701-clone-local.sh |    8 ++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index b4e858c..0d686c3 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -409,11 +409,12 @@ else
 	cd "$D" || exit
 fi
 
-if test -z "$bare" && test -f "$GIT_DIR/REMOTE_HEAD"
+if test -z "$bare"
 then
 	# a non-bare repository is always in separate-remote layout
 	remote_top="refs/remotes/$origin"
-	head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
+	head_sha1=
+	test ! -r "$GIT_DIR/REMOTE_HEAD" || head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
 	case "$head_sha1" in
 	'ref: refs/'*)
 		# Uh-oh, the remote told us (http transport done against
@@ -470,9 +471,16 @@ then
 		git config branch."$head_points_at".merge "refs/heads/$head_points_at"
 		;;
 	'')
-		# Source had detached HEAD pointing nowhere
-		git update-ref --no-deref HEAD "$head_sha1" &&
-		rm -f "refs/remotes/$origin/HEAD"
+		if test -z "$head_sha1"
+		then
+			# Source had nonexistent ref in HEAD
+			echo >&2 "Warning: Remote HEAD refers to nonexistent ref, unable to checkout."
+			no_checkout=t
+		else
+			# Source had detached HEAD pointing nowhere
+			git update-ref --no-deref HEAD "$head_sha1" &&
+			rm -f "refs/remotes/$origin/HEAD"
+		fi
 		;;
 	esac
 
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 822ac8c..59a165a 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -63,4 +63,12 @@ test_expect_success 'Even without -l, local will make a hardlink' '
 	test 0 = $copied
 '
 
+test_expect_success 'local clone of repo with nonexistent ref in HEAD' '
+	cd "$D" &&
+	echo "ref: refs/heads/nonexistent" > a.git/HEAD &&
+	git clone a d &&
+	cd d &&
+	git fetch &&
+	test ! -e .git/refs/remotes/origin/HEAD'
+
 test_done
-- 
1.5.4.2
