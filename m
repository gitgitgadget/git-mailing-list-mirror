From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH 4/4] Use guards information and functions
Date: Sun, 29 Jul 2007 00:50:18 -0700
Message-ID: <1185695418227-git-send-email-eclesh@ucla.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org, Eric Lesh <eclesh@ucla.edu>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Sun Jul 29 09:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF3Xx-000795-FZ
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 09:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760093AbXG2Hud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 03:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760079AbXG2Huc
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 03:50:32 -0400
Received: from smtp-9.smtp.ucla.edu ([169.232.48.138]:42800 "EHLO
	smtp-9.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760032AbXG2Hua (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 03:50:30 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.150])
	by smtp-9.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6T7oNde002874;
	Sun, 29 Jul 2007 00:50:23 -0700
Received: from localhost (adsl-75-26-192-134.dsl.scrm01.sbcglobal.net [75.26.192.134])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6T7oMkS028346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jul 2007 00:50:23 -0700
Received: by localhost (Postfix, from userid 1000)
	id B251E1E80AC; Sun, 29 Jul 2007 00:50:18 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <118569541814-git-send-email-eclesh@ucla.edu>
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.48.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54090>

Make guilt-push respect guards. Also teach guilt-header, guilt-next,
and guilt-unapplied to grok patches that are skipped because of
guards.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 guilt-header    |    7 ++++---
 guilt-next      |    2 +-
 guilt-push      |    8 ++++----
 guilt-unapplied |    2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/guilt-header b/guilt-header
index d07e2be..ef7f55e 100755
--- a/guilt-header
+++ b/guilt-header
@@ -15,15 +15,16 @@ patch="$1"
 if [ -z "$patch" ]; then
 	# use the patch that's on the top of the stack
 
-	eidx=`wc -l < $applied`
-	if [ $eidx -eq 0 ]; then
+	patch=`get_top`
+	if [ -z "$patch" ]; then
 		die "Status file is empty"
 	fi
+	eidx=`get_series | grep -ne "^$patch\$" | cut -d: -f1`
 else
 	# use the specified patch
 
 	eidx=`get_series | grep -ne "^$patch\$" | cut -d: -f1`
-	if [ $eidx -eq 0 ]; then
+	if [ -z "$eidx" ]; then
 		die "Patch $patch is not in the series"
 	fi
 fi
diff --git a/guilt-next b/guilt-next
index f38f1cc..38f57fa 100755
--- a/guilt-next
+++ b/guilt-next
@@ -13,5 +13,5 @@ fi
 n=`wc -l < $applied`
 n=$(($n + 1))
 
-get_series | awk "{ if (NR == $n) print \$0}"
+get_guarded_series | awk "{ if (NR == $n) print \$0}"
 
diff --git a/guilt-push b/guilt-push
index ad3616b..ce928e3 100755
--- a/guilt-push
+++ b/guilt-push
@@ -24,7 +24,7 @@ if [ "$patch" = "--all" ] || [ "$patch" = "-a" ]; then
 	# we are supposed to push all patches, get the last one out of
 	# series
 
-	eidx=`get_series | wc -l`
+	eidx=`get_guarded_series | wc -l`
 	if [ $eidx -eq 0 ]; then
 		die "There are no patches to push"
 	fi
@@ -37,9 +37,9 @@ else
 	# we're supposed to push only up to a patch, make sure the patch is
 	# in the series
 
-	eidx=`get_series | grep -ne "^$patch\$" | cut -d: -f1`
+	eidx=`get_guarded_series | grep -ne "^$patch\$" | cut -d: -f1`
 	if [ -z "$eidx" ]; then
-		die "Patch $patch is not in the series"
+		die "Patch $patch is not in the series or is guarded"
 	fi
 fi
 
@@ -52,7 +52,7 @@ fi
 sidx=`wc -l < $applied`
 sidx=`expr $sidx + 1`
 
-get_series | sed -n -e "${sidx},${eidx}p" | while read p
+get_guarded_series | sed -n -e "${sidx},${eidx}p" | while read p
 do
 	echo "Applying patch..$p"
 	if [ ! -f "$GUILT_DIR/$branch/$p" ]; then
diff --git a/guilt-unapplied b/guilt-unapplied
index 192a7e5..6904360 100755
--- a/guilt-unapplied
+++ b/guilt-unapplied
@@ -13,4 +13,4 @@ fi
 n=`wc -l < $applied`
 n=`expr $n + 1`
 
-get_series | sed -n -e "$n,\$p"
+get_guarded_series | sed -n -e "$n,\$p"
-- 
1.5.2
