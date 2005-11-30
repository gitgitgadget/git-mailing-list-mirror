From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PROBE] cg-commit: show and enable editing of changes with --review
Date: Wed, 30 Nov 2005 01:01:31 +0100
Message-ID: <20051130000131.GC5365@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 01:03:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhFQ4-0002yd-9s
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 01:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbVK3ABf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 19:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVK3ABf
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 19:01:35 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:13055 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751416AbVK3ABd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 19:01:33 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 3B8A46DFE34; Wed, 30 Nov 2005 01:00:48 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id DA24C6DFDE4; Wed, 30 Nov 2005 01:00:47 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id E287C61494; Wed, 30 Nov 2005 01:01:31 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12973>

Show changes being commited as a patch appended to the commit message
buffer. If the original patch is different from the patch extracted from
the commit message file the original patch will be reverted and the edited
patch applied before completing the commit.

Due to limitations with cg-patch this can only be used when commiting
from the project root directory. The error handling if the either the
original patch or the edited patch does not apply is not optimal, since
cg-patch will not report errors properly.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 5031c74c4716793784314f836f4ceb6bcfa6698a
tree d01b7a66054352a89c637d58c7ab6454a26ba700
parent dd872816a04f6462686e282b00d3e1523e3ecf4c
author Jonas Fonseca <fonseca@diku.dk> Wed, 30 Nov 2005 00:41:06 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Wed, 30 Nov 2005 00:41:06 +0100

 TODO      |    4 ----
 cg-commit |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/TODO b/TODO
index 777c728..cffa753 100644
--- a/TODO
+++ b/TODO
@@ -79,10 +79,6 @@ cg-*patch should be pre-1.0.)
 		  whitespace errors and stuff; hooks are good for this too,
 		  but I think it's good to have internal support for the
 		  basic stuff.
-	-- post 1.0 --
-	* Patch-altering cg-commit
-		You can already alter the list of files to be committed,
-		let's optionally show the patch and let you alter it, too.
 
 * cg-push over HTTP
 
diff --git a/cg-commit b/cg-commit
index 9f8d5d5..1a3c361 100755
--- a/cg-commit
+++ b/cg-commit
@@ -63,6 +63,12 @@
 #	Optionally, specify the exact name and email to sign off with by
 #	passing: `--signoff="Author Name <user@example.com>"`.
 #
+# --review:: Show and enable editing of changes being committed
+#	Show changes being commited as a patch appended to the commit message
+#	buffer. Changes made to the patch will be reapplied before completing
+#	the commit. Only makes sense with interactive commit message editing.
+#	Note, can only be used when commiting from the project root directory.
+#
 # FILES
 # -----
 # $GIT_DIR/author::
@@ -153,6 +159,7 @@ ignorecache=
 infoonly=
 commitalways=
 missingok=
+review=
 signoff=
 copy_commit=
 msgs=()
@@ -172,6 +179,9 @@ while optparse; do
 		force=1
 	elif optparse -q; then
 		quiet=1
+	elif optparse --review; then
+		[ "$_git_relpath" ] && die "--review can only be used when run from project root"
+		review=1
 	elif optparse -s || optparse --signoff; then
 		[ "$signoff" ] || signoff="$(git-var GIT_AUTHOR_IDENT | sed 's/> .*/>/')"
 	elif optparse --signoff=; then
@@ -187,6 +197,11 @@ done
 
 [ "$ignorecache" ] || cg-object-id HEAD >/dev/null 2>&1 || die "no previous commit; use -C for the initial commit"
 
+if [ "$review" ]; then
+	PATCH=$(mktemp -t gitci.XXXXXX)
+	PATCH2=$(mktemp -t gitci.XXXXXX)
+fi
+
 if [ "$ARGS" -o "$_git_relpath" ]; then
 	[ "$ignorecache" ] && die "-C and listing files to commit does not make sense"
 	[ -s $_git/merging ] && die "cannot commit individual files when merging"
@@ -201,6 +216,7 @@ if [ "$ARGS" -o "$_git_relpath" ]; then
 		sed 's/^\([^	]*\)\(.	.*\)\(	.*\)*$/"\2"/'))
 	customfiles=1
 
+	[ "$review" ] && < $filter | path_xargs git-diff-index -r -p HEAD > $PATCH
 	rm $filter
 
 else
@@ -227,6 +243,8 @@ else
 		fi
 	fi
 
+	[ "$review" ] && git-diff-index -r -p HEAD > $PATCH
+
 	merging=
 	[ -s $_git/merging ] && merging=$(cat $_git/merging | sed 's/^/-p /')
 fi
@@ -347,7 +365,21 @@ if [ ! "$ignorecache" ]; then
 	fi
 fi
 echo "CG: -----------------------------------------------------------------------" >>$LOGMSG
-echo "CG: vim: textwidth=75" >>$LOGMSG
+
+if [ "$review" ]; then
+	{
+		echo "CG:"
+		echo "CG: Change summary:"
+		echo "CG:"
+		git-apply --stat --summary < $PATCH | sed 's/^/CG: /'
+		echo "CG:"
+		cat $PATCH
+	} >>$LOGMSG
+
+	ftdiff="filetype=diff"
+fi
+
+echo "CG: vim: textwidth=75 $ftdiff" >>$LOGMSG
 
 cp $LOGMSG $LOGMSG2
 if tty -s; then
@@ -359,6 +391,7 @@ if tty -s; then
 				read -p 'Abort or commit? [ac] ' choice
 				if [ "$choice" = "a" ] || [ "$choice" = "q" ]; then
 					rm $LOGMSG $LOGMSG2
+					[ "$review" ] && rm $PATCH $PATCH2
 					echo "Commit message not modified, commit aborted" >&2
 					if [ "$merging" ]; then
 						cat >&2 <<__END__
@@ -400,9 +433,35 @@ else
 	cat >$LOGMSG2
 fi
 # Remove heading and trailing blank lines.
-grep -v ^CG: $LOGMSG2 | git-stripspace >$LOGMSG
+if [ ! "$review" ]; then
+	grep -v ^CG: $LOGMSG2 | git-stripspace >$LOGMSG
+else
+	sed '/^CG: Change summary:/,$d' < $LOGMSG2 | grep -v ^CG: | git-stripspace >$LOGMSG
+	sed -n '/^CG: Change summary:/,$p' < $LOGMSG2 | grep -v ^CG: > $PATCH2
+fi
 rm $LOGMSG2
 
+if [ "$review" ]; then
+	error_msg=
+	if ! cmp -s $PATCH $PATCH2; then
+		echo "Updating changes to edited patch"
+		# FIXME: Can only be run from the top level
+		# FIXME: Is very 'fragile' error handling. We should probably
+		# save the original patch in a local file for recovery?
+		if ! cg-patch -R < $PATCH; then
+			backup=$(mktemp commit-backup.XXXXXX)
+			cp $PATCH $backup
+			error_msg="unable to revert original patch, backup saved to $backup"
+		elif ! cg-patch < $PATCH2; then
+			backup=$(mktemp commit-backup.XXXXXX)
+			cp $PATCH2 $backup
+			error_msg="unable to apply edited patch, backup saved to $backup"
+		fi
+	fi
+	rm $PATCH $PATCH2
+	[ "$error_msg" ] && { rm $LOGMSG; die "$error_msg" }
+fi
+
 
 precommit_update()
 {

-- 
Jonas Fonseca
