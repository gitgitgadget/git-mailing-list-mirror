From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Better option parsing for gitdiff.sh
Date: Tue, 19 Apr 2005 16:19:19 -0400
Message-ID: <1113941959.3684.9.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 19 22:16:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNz8J-0005A8-08
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 22:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVDSUTt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 16:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVDSUTt
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 16:19:49 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:10197
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261257AbVDSUTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 16:19:25 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id B7281EFF19; Tue, 19 Apr 2005 16:19:19 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

This patch improves option handling for gitdiff.sh.  Now "-p" doesn't
need to precede "-r", although all options still have to be placed
before the file names.  Also, the patch introduces a minimal usage info
for the script.

The patch is against current git-pasky.

Signed-off-by: Pavel Roskin <proski@gnu.org>

--- a/gitdiff.sh
+++ b/gitdiff.sh
@@ -27,6 +27,13 @@ die () {
 	exit 1
 }
 
+usage () {
+	echo "Usage:" >&2
+	echo "  gitdiff.sh -r rev1:rev2 [FILES...]" >&2
+	echo "  gitdiff.sh -r rev1 -r rev2 [FILES...]" >&2
+	exit 1
+}
+
 diffqfile () {
 	dir=$1; shift
 	file=$1; shift
@@ -59,26 +66,44 @@ diffqueue () {
 	return $ret
 }
 
-
-# FIXME: The commandline parsing is awful.
-
-if [ "$1" = "-p" ]; then
-	shift
-	parent=1
-fi
-
-if [ "$1" = "-r" ]; then
-	shift
-	id1=$(echo "$1": | cut -d : -f 1)
-	[ "$id1" != "$1" ] && id2=$(echo "$1": | cut -d : -f 2)
-	shift
-fi
-
-if [ "$1" = "-r" ]; then
-	shift
-	id2="$1"
-	shift
-fi
+# Parsing the command line
+id1_set=
+id2_set=
+while true; do
+	case $1 in
+	-p)
+		parent=1
+		shift
+		;;
+	-r)
+		if test "$id2_set"; then
+			echo "Too many revision numbers" 2>&1
+			usage
+		elif test "$id1_set"; then
+			shift
+			id2="$1"
+			id2_set=1
+			shift
+		else
+			shift
+			id1=$(echo "$1": | cut -d : -f 1)
+			id1_set=1
+			if test "$id1" != "$1"; then
+				id2=$(echo "$1": | cut -d : -f 2)
+				id2_set=1
+			fi
+			shift
+		fi
+		;;
+	-*)
+		echo "Unknown option $1" 2>&1
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
+done
 
 if [ "$parent" ]; then
 	id2="$id1"



-- 
Regards,
Pavel Roskin

