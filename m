From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Use cg-commit -E to invoke editor and always commit
Date: Mon, 09 May 2005 02:25:40 +0200
Message-ID: <1115598340.8949.84.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-s55CrEluiqIojgNHL5aI"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 02:18:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUvyr-0005BB-Sr
	for gcvg-git@gmane.org; Mon, 09 May 2005 02:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVEIAZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 20:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVEIAZb
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 20:25:31 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:7342 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S263016AbVEIAZR
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 20:25:17 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j490QZWX008228
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 9 May 2005 02:26:35 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-s55CrEluiqIojgNHL5aI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch introduces the -E parameter to cg-commit and then
uses it in cg-init. If you use -E instead of -e the editor is invoked
and it will do the commit even it the default commit messages has not
been changed.

Regards

Marcel


--=-s55CrEluiqIojgNHL5aI
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

cg-commit: needs update
cg-init: needs update
Index: cg-commit
===================================================================
--- 00b94eea5b99d5dd1d1bbe9c9ca3502d11aec581/cg-commit  (mode:100755)
+++ uncommitted/cg-commit  (mode:100755)
@@ -13,6 +13,8 @@
 # appended to a single commit message, each as separate paragraph.
 # -e forces the editor to be brought up even when -m parameters were
 # passed to cg-commit.
+# -E forces the editor to be brought up and it will do the commit
+# even if the default commit message is not changed.
 
 . ${COGITO_LIB}cg-Xlib
 
@@ -21,6 +23,7 @@
 
 forceeditor=
 ignorecache=
+commitalways=
 msgs=()
 while [ "$1" ]; do
 	case "$1" in
@@ -32,6 +35,11 @@
 		forceeditor=1
 		shift
 		;;
+	-E)
+		forceeditor=1
+		commitalways=1
+		shift
+		;;
 	-m*)
 		msgs=("${msgs[@]}" "${1#-m}")
 		shift
@@ -126,10 +134,10 @@
 if tty -s; then
 	if ! [ "$msgs" ] || [ "$forceeditor" ]; then
 		${EDITOR:-vi} $LOGMSG2
-	fi
-	if ! [ "$msgs" ] && ! [ $LOGMSG2 -nt $LOGMSG ]; then
-		rm $LOGMSG $LOGMSG2
-		die 'Commit message not modified, commit aborted'
+		if ! [ "$commitalways" ] && ! [ $LOGMSG2 -nt $LOGMSG ]; then
+			rm $LOGMSG $LOGMSG2
+			die 'Commit message not modified, commit aborted'
+		fi
 	fi
 else
 	cat >>$LOGMSG2
Index: cg-init
===================================================================
--- 00b94eea5b99d5dd1d1bbe9c9ca3502d11aec581/cg-init  (mode:100755)
+++ uncommitted/cg-init  (mode:100755)
@@ -32,6 +32,6 @@
 else
 	git-read-tree # Seed the dircache
 	find * | xargs cg-add
-	cg-commit -C -m"Initial commit" -e
+	cg-commit -C -m"Initial commit" -E
 fi
 exit 0

--=-s55CrEluiqIojgNHL5aI--

