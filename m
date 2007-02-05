From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add --patchdepth parameter to git-am.sh
Date: Mon, 5 Feb 2007 19:24:38 +0000
Message-ID: <200702051924.39205.andyparkins@gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 20:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE9VZ-0005Jj-Jj
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 20:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933417AbXBET1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 14:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933421AbXBET1h
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 14:27:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:48320 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933419AbXBET1g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 14:27:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1390903uga
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 11:27:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Q4fupYnFOMmk1eJYqz9DIkMvzRcsXcgBgi60Y8fYZpeRCMPU8DVjs926/x5P0RAZ2nLta/RAd2v2XFCs5b5F4Y8HGGJI3tNntxp41qbf0OTHV3BoeTCqslEkrPxPLjorc9fgije7/dzFFLk3WRMXO5fBT9SkDJDkd/vzIOC6YTw=
Received: by 10.66.242.20 with SMTP id p20mr9008921ugh.1170703654619;
        Mon, 05 Feb 2007 11:27:34 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id g30sm10909820ugd.2007.02.05.11.27.32;
        Mon, 05 Feb 2007 11:27:32 -0800 (PST)
In-Reply-To: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
X-TUID: e4dd995355048259
X-UID: 218
X-Length: 2560
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38770>

If the series of patches you are applying via git-am was based in a
different directory there was no way to strip the directory (as you
would with git-apply).

This patch adds a --patchdepth option to git-am.sh whose argument is
passed as a "-p" option to git-apply.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I know git-apply isn't going anywhere, but git-applypatch is.  However, all
this talk of it made me remember this patch.

 git-am.sh |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 1252f26..cb503fc 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -60,7 +60,7 @@ fall_back_3way () {
     mkdir "$dotest/patch-merge-tmp-dir"
 
     # First see if the patch records the index info that we can use.
-    git-apply -z --index-info "$dotest/patch" \
+    git-apply $patchdepth -z --index-info "$dotest/patch" \
 	>"$dotest/patch-merge-index-info" &&
     GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
     git-update-index -z --index-info <"$dotest/patch-merge-index-info" &&
@@ -70,7 +70,7 @@ fall_back_3way () {
 
     echo Using index info to reconstruct a base tree...
     if GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
-	git-apply $binary --cached <"$dotest/patch"
+	git-apply $patchdepth $binary --cached <"$dotest/patch"
     then
 	mv "$dotest/patch-merge-base+" "$dotest/patch-merge-base"
 	mv "$dotest/patch-merge-tmp-index" "$dotest/patch-merge-index"
@@ -106,7 +106,7 @@ It does not apply to blobs recorded in its index."
 }
 
 prec=4
-dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary= ws= resolvemsg=
+dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary= ws= resolvemsg= patchdepth=
 
 while case "$#" in 0) break;; esac
 do
@@ -147,6 +147,9 @@ do
 	--resolvemsg=*)
 	resolvemsg=$(echo "$1" | sed -e "s/^--resolvemsg=//"); shift ;;
 
+	--patchdepth=*)
+	patchdepth=-p$(echo "$1" | sed -e "s/^--patchdepth=//"); shift ;;
+
 	--)
 	shift; break ;;
 	-*)
@@ -389,12 +392,12 @@ do
 	fi
 
 	echo
-	echo "Applying '$SUBJECT'"
+	echo "Applying '$SUBJECT' at depth $patchdepth"
 	echo
 
 	case "$resolved" in
 	'')
-		git-apply $binary --index $ws "$dotest/patch"
+		git-apply $patchdepth $binary --index $ws "$dotest/patch"
 		apply_status=$?
 		;;
 	t)
-- 
1.5.0.rc1.gf4b6c
