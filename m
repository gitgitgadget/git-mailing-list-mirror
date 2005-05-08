From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 08 May 2005 03:10:54 +0200
Message-ID: <1115514654.9031.45.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3gO82AGyYvcED6Tl1CAi"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 03:04:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUaDN-0000uj-UI
	for gcvg-git@gmane.org; Sun, 08 May 2005 03:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVEHBLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 21:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVEHBLI
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 21:11:08 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:34733 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261262AbVEHBKs
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 May 2005 21:10:48 -0400
Received: from pegasus (p5487F695.dip.t-dialin.net [84.135.246.149])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j481BnWX031720
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 03:11:49 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.83/871/Thu May  5 15:50:45 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-3gO82AGyYvcED6Tl1CAi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

I like to extend the work from Pavel and make the cg-commit really work
like we know it from CVS. Please consider applying the attached patch.

Regards

Marcel


--=-3gO82AGyYvcED6Tl1CAi
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Make use of external editor work like CVS

The lines starting with `CG:' should be a trailer and not at the top
of the message presented in the editor. Also extend the number of `-'
up to 74 characters so that people know when they should start a new
line. If it's not a merge and no commit text is given via the command
line add an extra empty line at the top.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit ad5cabd7130fc180aed0c364d4014abb49f374b0
tree ca866565063dcd89204e747e8aa0fcb483d14841
parent 09f6584daa060eda641a8e727698f935e0960e9c
author Marcel Holtmann <marcel@holtmann.org> Sun, 08 May 2005 03:03:53 +0200
committer Marcel Holtmann <marcel@holtmann.org> Sun, 08 May 2005 03:03:53 +0200

 cg-commit |   55 +++++++++++++++++++++++++++++++------------------------
 1 files changed, 31 insertions(+), 24 deletions(-)

Index: cg-commit
===================================================================
--- 5d7e8450d626a4e99f8222378a6818d03a797864/cg-commit  (mode:100755)
+++ ca866565063dcd89204e747e8aa0fcb483d14841/cg-commit  (mode:100755)
@@ -61,24 +61,9 @@
 
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
-	done
-	echo CG: >>$LOGMSG
-fi
 
 if [ "$merging" ]; then
-	echo -n 'Merge with ' >>$LOGMSG
+	echo -n "Merge with " >>$LOGMSG
 	[ -s .git/merging-sym ] || cp .git/merging .git/merging-sym
 	for sym in $(cat .git/merging-sym); do
 		uri=$(cat .git/branches/$sym)
@@ -86,28 +71,50 @@
 		echo "$uri" >>$LOGMSG
 		echo "$uri"
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
+		die 'Nothing to commit.'
+	fi
+	echo "CG: " >>$LOGMSG
+	echo "CG: Modified Files:" >>$LOGMSG
+	for file in "${commitfiles[@]}"; do
+		# Prepend a letter describing whether it's addition,
+		# removal or update. Or call git status on those files.
+		echo "CG:    $file" >>$LOGMSG
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
+		[ $LOGMSG -nt $LOGMSG2 ] || die 'Commit message not modified, commit aborted.'
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

--=-3gO82AGyYvcED6Tl1CAi--

