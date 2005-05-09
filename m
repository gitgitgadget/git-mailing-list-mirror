From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Add -u option to cg-log to show only commits from a
	specific user
Date: Mon, 09 May 2005 02:49:33 +0200
Message-ID: <1115599773.8949.90.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-XhLfY7o7Ljz530iQiwv6"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 02:42:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUwM5-0007Yf-VS
	for gcvg-git@gmane.org; Mon, 09 May 2005 02:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVEIAtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 20:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbVEIAtW
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 20:49:22 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:8622 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S263018AbVEIAtJ
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 20:49:09 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j490oSWX008357
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 9 May 2005 02:50:28 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-XhLfY7o7Ljz530iQiwv6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch introduces the -u option for cg-log. Now you can give
a username or a part of a username and only commits with a matching
author or committer will be displayed.

This patch also changes the option parsing, because otherwise we are
stuck to a specific order.

Regards

Marcel


--=-XhLfY7o7Ljz530iQiwv6
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

cg-log: needs update
Index: cg-log
===================================================================
--- 00b94eea5b99d5dd1d1bbe9c9ca3502d11aec581/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -15,6 +15,9 @@
 #
 # Takes an -f option to list which files was changed.
 #
+# Takes -u"username" to list only commits where author or
+# committer contains username.
+#
 # Takes an -r followed with id resolving to a commit to start from
 # (HEAD by default), or id1:id2 representing an (id1;id2] range
 # of commits to show.
@@ -27,29 +30,39 @@
 # at least somewhere it does. Bash is broken.
 trap exit SIGPIPE
 
-if [ "$1" = "-c" ]; then
-	shift
-	# See terminfo(5), "Color Handling"
-	colheader="$(tput setaf 2)"    # Green
-	colauthor="$(tput setaf 6)"    # Cyan
-	colcommitter="$(tput setaf 5)" # Magenta
-	colfiles="$(tput setaf 4)"     # Blue
-	colsignoff="$(tput setaf 3)"   # Yellow
-	coldefault="$(tput op)"        # Restore default
-else
-	colheader=
-	colauthor=
-	colcommitter=
-	colfiles=
-	colsignoff=
-	coldefault=
-fi
-
+colheader=
+colauthor=
+colcommitter=
+colfiles=
+colsignoff=
+coldefault=
 list_files=
-if [ "$1" = "-f" ]; then
-	shift
-	list_files=1
-fi
+user=
+while [ "$1" ]; do
+	case "$1" in
+	-c)
+		# See terminfo(5), "Color Handling"
+		colheader="$(tput setaf 2)"    # Green
+		colauthor="$(tput setaf 6)"    # Cyan
+		colcommitter="$(tput setaf 5)" # Magenta
+		colfiles="$(tput setaf 4)"     # Blue
+		colsignoff="$(tput setaf 3)"   # Yellow
+		coldefault="$(tput op)"        # Restore default
+		shift
+		;;
+	-f)
+		list_files=1
+		shift
+		;;
+	-u*)
+		user="${1#-u}"
+		shift
+		;;
+	*)
+		break
+		;;
+	esac
+done
 
 list_commit_files()
 {
@@ -109,6 +122,9 @@
 		parent=$(git-cat-file commit $commit | sed -n '2s/parent //p;2Q')
 		[ "$parent" ] && [ "$(git-diff-tree -r $commit $parent "$@")" ] || continue
 	fi
+	if [ "$user" ]; then
+		git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
+	fi
 	echo $colheader""commit ${commit%:*} $coldefault;
 	git-cat-file commit $commit | \
 		while read key rest; do

--=-XhLfY7o7Ljz530iQiwv6--

