From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] cg-rm: Add option to remove all files which are gone from the working copy
Date: Thu, 6 Apr 2006 18:17:44 +0200
Message-ID: <20060406161744.G5527deba@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 06 18:18:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRXBD-0006ZW-Vs
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 18:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWDFQRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 12:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWDFQRx
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 12:17:53 -0400
Received: from ncs.stosberg.net ([217.195.44.246]:4757 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932187AbWDFQRw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 12:17:52 -0400
Received: from leonov (p213.54.80.25.tisdip.tiscali.de [213.54.80.25])
	by ncs.stosberg.net (Postfix) with ESMTP id D26BCAEBC040
	for <git@vger.kernel.org>; Thu,  6 Apr 2006 18:17:38 +0200 (CEST)
Received: by leonov (Postfix, from userid 500)
	id 4462EEB8A9; Thu,  6 Apr 2006 18:17:44 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1) with LMTP; Thu, 06 Apr 2006 18:11:47 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r796 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18474>

Add an -a option to cg-rm, which removes all files that have been
physically deleted.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>


---

 cg-rm |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

ac5fc0c8d9c9ccecba7cbf83a74a163bff79f8f4
diff --git a/cg-rm b/cg-rm
index 5ab5dc8..0276632 100755
--- a/cg-rm
+++ b/cg-rm
@@ -19,13 +19,18 @@ #
 # -r:: Remove files recursively
 #	If you pass cg-rm this flag and any directory names, it will try
 #	to remove files in those directories recursively.
+#
+# -a:: Remove all files which are gone from the working copy
+#	Remove all files which have been deleted in the working copy
+#	from the index.
 
-USAGE="cg-rm [-f] [-n] [-r] FILE..."
+USAGE="cg-rm [-f] [-n] [-r] [-a] FILE..."
 
 . "${COGITO_LIB}"cg-Xlib || exit 1
 
 delete=
 recursive=
+rmgone=
 while optparse; do
 	if optparse -f; then
 		delete=1
@@ -33,12 +38,14 @@ while optparse; do
 		delete=
 	elif optparse -r; then
 		recursive=1
+	elif optparse -a; then
+		rmgone=1
 	else
 		optfail
 	fi
 done
 
-[ -n "${ARGS[*]}" ] || usage
+[ -n "${ARGS[*]}" -o "$rmgone" ] || usage
 
 TMPFILE="$(mktemp -t gitrm.XXXXXX)" || exit 1
 TMPDIRFILE="$(mktemp -t gitrm.XXXXXX)" || exit 1
@@ -57,6 +64,14 @@ for file in "${ARGS[@]}"; do
 		echo "$file" >>"$TMPFILE"
 	fi
 done
+
+if [ "$rmgone" ]; then
+	cg-status -s \! -n -w >>"$TMPFILE"
+	if [ ! $(cat "$TMPFILE" | sed -n "$=") ]; then
+		rm "$TMPFILE" "$TMPDIRFILE"
+		die "no files to remove"
+	fi
+fi
 
 cat "$TMPFILE" | sed 's/^/Removing file /'
 if [ "$delete" ]; then (
-- 
1.3-rc2.GIT
