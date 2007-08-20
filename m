From: Jeff King <peff@peff.net>
Subject: [RFC] git-mergetool: show original branch names when possible
Date: Mon, 20 Aug 2007 03:53:18 -0400
Message-ID: <20070820075318.GA12478@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Ts'o <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 09:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN24q-00059s-6f
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 09:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbXHTHxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 03:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbXHTHxZ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 03:53:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2931 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbXHTHxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 03:53:24 -0400
Received: (qmail 17909 invoked by uid 111); 20 Aug 2007 07:53:34 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Aug 2007 03:53:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2007 03:53:18 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56186>

The actual branch names are used when naming temporary files
and when presenting the files to the user, instead of
calling them "local" and "remote".

The "local" branch name is gathered by dereferencing HEAD.

The "remote" branch name is placed in MERGE_HEAD by
git-merge.

Signed-off-by: Jeff King <peff@peff.net>
---
I have several uncertainties in the implementation:

1. Is it OK to place the extra branch name information in MERGE_HEAD
after the SHA1?

2. It looks like doing an anonymous 'git-pull' leaves GITHEAD_* as the
commit sha1, which means you will end up with that sha1 rather than
'REMOTE', which is less nice than the current behavior. However, I think
that is fixable at the 'git-merge' level to produce a nicer name for the
remote.

3. This is meant to work similar to the GITHEAD_* feature, but needs to
work without using the environment. Many other scripts use GITHEAD_*,
but not MERGE_HEAD, so perhaps MERGE_HEAD is not the best place for
this.

It would be _really_ convenient in this case if we had a "git is in the
middle of something" file, which has been discussed before. Clearly
there are some operations that persist across multiple command
invocations, and it would be nice rather than every command knowing
about every other command's implementation patterns ("Oh, you have a
.dotest file? You must be in the middle of...") to have a single place
with something like:

  $ cat .git/STATE
  operation: merge
  remote: git://git.kernel.org/pub/scm/git/git.git
  branch: master
  branch: octopus

  $ cat .git/STATE
  operation: rebase
  upstream: origin/master
  onto: HEAD~20

where you could have arbitrary keys through which to communicate. Most
command would just look at 'operation' (e.g., if operation == merge,
don't start a new merge), but some could use the information (which
would otherwise be lost) to work more usefully (e.g., git-mergetool
understands remote and branch keys created by git-merge).

Thoughts?

 git-merge.sh     |    2 +-
 git-mergetool.sh |   24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 5ccf282..e899801 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -477,7 +477,7 @@ then
 else
 	for remote
 	do
-		echo $remote
+		echo $remote $(eval echo \$GITHEAD_$remote)
 	done >"$GIT_DIR/MERGE_HEAD"
 	printf '%s\n' "$merge_msg" >"$GIT_DIR/MERGE_MSG"
 fi
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 47a8055..8bc0a66 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -151,8 +151,16 @@ merge_file () {
     fi
 
     BACKUP="$path.BACKUP.$$"
-    LOCAL="$path.LOCAL.$$"
-    REMOTE="$path.REMOTE.$$"
+    local_branch=$(
+      git-symbolic-ref HEAD 2>/dev/null \
+        | sed -e 's#^refs/[^/]*/##' \
+        | sed -e 's/[^A-Za-z0-9]/-/g')
+    LOCAL="$path.${local_branch:-HEAD}.$$"
+    remote_branch=$(
+      sed -ne '1s/^[0-9a-f]* //p' \
+        <"$GIT_DIR/MERGE_HEAD" \
+        | sed -e 's/[^A-Za-z0-9]/-/g')
+    REMOTE="$path.${remote_branch:-REMOTE}.$$"
     BASE="$path.BASE.$$"
 
     mv -- "$path" "$BACKUP"
@@ -168,23 +176,23 @@ merge_file () {
 
     if test -z "$local_mode" -o -z "$remote_mode"; then
 	echo "Deleted merge conflict for '$path':"
-	describe_file "$local_mode" "local" "$LOCAL"
-	describe_file "$remote_mode" "remote" "$REMOTE"
+	describe_file "$local_mode" "${local_branch:-HEAD}" "$LOCAL"
+	describe_file "$remote_mode" "${remote_branch:-remote}" "$REMOTE"
 	resolve_deleted_merge
 	return
     fi
 
     if is_symlink "$local_mode" || is_symlink "$remote_mode"; then
 	echo "Symbolic link merge conflict for '$path':"
-	describe_file "$local_mode" "local" "$LOCAL"
-	describe_file "$remote_mode" "remote" "$REMOTE"
+	describe_file "$local_mode" "${local_branch:-HEAD}" "$LOCAL"
+	describe_file "$remote_mode" "${remote_branch:-remote}" "$REMOTE"
 	resolve_symlink_merge
 	return
     fi
 
     echo "Normal merge conflict for '$path':"
-    describe_file "$local_mode" "local" "$LOCAL"
-    describe_file "$remote_mode" "remote" "$REMOTE"
+    describe_file "$local_mode" "${local_branch:-HEAD}" "$LOCAL"
+    describe_file "$remote_mode" "${remote_branch:-remote}" "$REMOTE"
     printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
     read ans
 
-- 
1.5.3.rc5.844.g67b3-dirty
