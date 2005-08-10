From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] -x (no-exclude) option for cg-status
Date: Wed, 10 Aug 2005 14:42:19 -0400
Message-ID: <1123699339.17725.13.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 10 20:44:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2vX3-0004mE-SU
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 20:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVHJSm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbVHJSm1
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 14:42:27 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:46284 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965257AbVHJSm0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 14:42:26 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E2vUo-0008Oy-R6
	for git@vger.kernel.org; Wed, 10 Aug 2005 14:40:12 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E2vWu-0002JF-5l; Wed, 10 Aug 2005 14:42:20 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7AIgJYO008878;
	Wed, 10 Aug 2005 14:42:19 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

I'm trying to reimplement my cg-clean script so that it reuses more code
from other utilities.  This patch makes it possible to call cg-status
from cg-clean.

This patch adds the "-x" option that instructs cg-status not to ignore
any files.  Also, the code has been changed to add standard includes in
a loop.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-status b/cg-status
--- a/cg-status
+++ b/cg-status
@@ -34,6 +34,9 @@
 # -w::
 #	Show the working tree file list.
 #
+# -x::
+#	Don't exclude any files from listing.
+#
 # FILES
 # -----
 # $GIT_DIR/exclude::
@@ -53,11 +56,14 @@ USAGE="cg-status [-g] [-w]"
 
 gitstatus=
 workstatus=
+noexclude=
 while optparse; do
 	if optparse -g; then
 		gitstatus=1
 	elif optparse -w; then
 		workstatus=1
+	elif optparse -x; then
+		noexclude=1
 	else
 		optfail
 	fi
@@ -116,18 +122,21 @@ fi
 
 
 if [ "$workstatus" ]; then
-	EXCLUDEFILE=$_git/exclude
 	EXCLUDE=
-	if [ -f $EXCLUDEFILE ]; then
-		EXCLUDE="$EXCLUDE --exclude-from=$EXCLUDEFILE"
+	if [ -z "$noexclude" ]; then
+		EXCLUDEFILE=$_git/exclude
+		for excl in '*.[ao]' '.*' tags '*~' '#*' ',,merge*'; do
+			EXCLUDE="$EXCLUDE --exclude=$excl"
+		done
+		if [ -f $EXCLUDEFILE ]; then
+			EXCLUDE="$EXCLUDE --exclude-from=$EXCLUDEFILE"
+		fi
+		EXCLUDE="$EXCLUDE --exclude-per-directory=.gitignore"
 	fi
 
 	git-update-cache --refresh > /dev/null
 
-	git-ls-files --others --exclude='*.[ao]' --exclude='.*' --exclude=tags \
-		--exclude='*~' --exclude='#*' \
-		--exclude=',,merge*' $EXCLUDE \
-		--exclude-per-directory=.gitignore |
+	git-ls-files --others $EXCLUDE |
 		{ if [ "$_git_relpath" ]; then sed -n "s|^$_git_relpath||p"; else cat; fi } |
 		sed 's,^,? ,'
 


-- 
Regards,
Pavel Roskin
