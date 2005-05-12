From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Use cg-commit -E to invoke editor and always commit
Date: Thu, 12 May 2005 22:43:23 +0200
Message-ID: <1115930603.18499.61.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+zhhTwVyJm+bj/GZkgcA"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 22:36:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKPb-0000Pl-2I
	for gcvg-git@gmane.org; Thu, 12 May 2005 22:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVELUnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 16:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVELUnP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 16:43:15 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:7857 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262113AbVELUm7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 16:42:59 -0400
Received: from pegasus (p5487C16D.dip.t-dialin.net [84.135.193.109])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4CKiMWX018768
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 12 May 2005 22:44:23 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.83/875/Tue May 10 13:27:59 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-+zhhTwVyJm+bj/GZkgcA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch introduces the -E parameter to cg-commit and then
uses it in cg-init. If you use -E instead of -e the editor is invoked
and it will do the commit even it the default commit messages has not
been changed.

Regards

Marcel


Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-+zhhTwVyJm+bj/GZkgcA
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

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

--=-+zhhTwVyJm+bj/GZkgcA--

