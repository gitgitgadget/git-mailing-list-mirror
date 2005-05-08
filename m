From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 08 May 2005 17:02:30 +0200
Message-ID: <1115564550.9031.96.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-kIxjKESLEXfOBaOdNT86"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 16:56:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUnBw-0001GE-Vz
	for gcvg-git@gmane.org; Sun, 08 May 2005 16:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbVEHPCe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 11:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbVEHPCe
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 11:02:34 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:52653 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262879AbVEHPCS
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 11:02:18 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48F3ZWX003484
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 17:03:36 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-kIxjKESLEXfOBaOdNT86
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

this is a modified version of my patch that integrates the your latest
modifications to cg-commit and also fixes the cleanup of the temporary
files when we abort the operation.

Regards

Marcel


--=-kIxjKESLEXfOBaOdNT86
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

[PATCH] Make use of external editor work like CVS

The lines starting with `CG:' should be a trailer and not at the top
of the message presented in the editor. Also extend the number of `-'
up to 74 characters so that people know when they should start a new
line. If it's not a merge and no commit text is given as parameter
then add an extra empty line at the top. And don't forget to take
care of the temporary files when a commit is unneeded or canceled.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit 895bcd02ecc96bed1d35275def6dca1ca6f20e5f
tree be440e169fa3b5ec5450fa9574cd8789b0e3ab20
parent 64142a39e7a6701e69654a930de86a9fe296f8a0
author Marcel Holtmann <marcel@holtmann.org> Sun, 08 May 2005 16:58:50 +0200
committer Marcel Holtmann <marcel@holtmann.org> Sun, 08 May 2005 16:58:50 +0200

 cg-commit |   63 ++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 37 insertions(+), 26 deletions(-)

Index: cg-commit
===================================================================
--- 8bb38f8bfdc7411460c300c811da1987173f412f/cg-commit  (mode:100755)
+++ be440e169fa3b5ec5450fa9574cd8789b0e3ab20/cg-commit  (mode:100755)
@@ -61,26 +61,10 @@
 
 LOGMSG=$(mktemp -t gitci.XXXXXX)
 LOGMSG2=$(mktemp -t gitci2.XXXXXX)
-echo CG: ---------------------------------------------------------- >>$LOGMSG
-echo CG: Lines beggining with CG: will be automatically removed     >>$LOGMSG
-echo CG:                                                            >>$LOGMSG
-if [ ! "$ignorecache" ]; then
-	if [ ! "${commitfiles[*]}" ]; then
-		echo 'Nothing to commit.' >&2
-		exit 2
-	fi
-	for file in "${commitfiles[@]}"; do
-		# Prepend a letter describing whether it's addition,
-		# removal or update. Or call git status on those files.
-		echo CG: $file >>$LOGMSG
-		[ "$msgs" ] && echo $file
-	done
-	echo CG: >>$LOGMSG
-fi
 
 if [ "$merging" ]; then
-	echo -n 'Merge with ' >>$LOGMSG
-	[ "$msgs" ] && echo -n 'Merge with '
+	echo -n "Merge with " >>$LOGMSG
+	[ "$msgs" ] && echo -n "Merge with "
 	[ -s .git/merging-sym ] || cp .git/merging .git/merging-sym
 	for sym in $(cat .git/merging-sym); do
 		uri=$(cat .git/branches/$sym)
@@ -88,28 +72,55 @@
 		echo "$uri" >>$LOGMSG
 		[ "$msgs" ] && echo "$uri"
 	done
-	echo >>$LOGMSG
+else
+	first=1
 fi
-first=1
+
 for msg in "${msgs[@]}"; do
 	if [ "$first" ]; then
 		first=
 	else
 		echo >>$LOGMSG
 	fi
-	echo $msg | fmt >>$LOGMSG
+	echo $msg | fmt -s -w 74 >>$LOGMSG
 done
+
+if [ "$first" ]; then
+	echo >>$LOGMSG
+fi
+
+echo "CG: ----------------------------------------------------------------------" >>$LOGMSG
+echo "CG: Enter Log.  Lines beginning with \`CG:' are removed automatically"      >>$LOGMSG
+if [ ! "$ignorecache" ]; then
+	if [ ! "${commitfiles[*]}" ]; then
+		rm $LOGMSG $LOGMSG2
+		die 'Nothing to commit.'
+	fi
+	echo "CG: " >>$LOGMSG
+	echo "CG: Modified Files:" >>$LOGMSG
+	for file in "${commitfiles[@]}"; do
+		# Prepend a letter describing whether it's addition,
+		# removal or update. Or call git status on those files.
+		echo "CG:    $file" >>$LOGMSG
+		[ "$msgs" ] && echo "$file"
+	done
+fi
+echo "CG: ----------------------------------------------------------------------" >>$LOGMSG
+
 cp $LOGMSG $LOGMSG2
 if tty -s; then
 	if ! [ "$msgs" ]; then
-		${EDITOR:-vi} $LOGMSG2
-		[ $LOGMSG2 -nt $LOGMSG ] || die 'Commit message not modified, commit aborted'
+		${EDITOR:-vi} $LOGMSG
+		if [ ! $LOGMSG -nt $LOGMSG2 ]; then
+			rm $LOGMSG $LOGMSG2
+			die 'Commit message not modified, commit aborted.'
+		fi
 	fi
 else
-	cat >>$LOGMSG2
+	cat >>$LOGMSG
 fi
-grep -v ^CG: $LOGMSG2 >$LOGMSG
-rm $LOGMSG2
+grep -v ^CG: $LOGMSG >$LOGMSG2
+mv $LOGMSG2 $LOGMSG
 
 if [ ! "$ignorecache" ]; then
 	if [ "$customfiles" ]; then

--=-kIxjKESLEXfOBaOdNT86--

