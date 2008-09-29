From: Scott Moser <smoser@brickies.net>
Subject: [PATCH] fix guilt-pop and push to fail if no relevant patches
Date: Mon, 29 Sep 2008 14:51:33 -0400
Message-ID: <1222714293-9680-1-git-send-email-smoser@brickies.net>
Cc: git@vger.kernel.org, Scott Moser <smoser@brickies.net>
To: "Josef \"Jeff\" Sipek" <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Sep 29 20:54:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkNt0-00018f-C9
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 20:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbYI2SxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 14:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbYI2SxJ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 14:53:09 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:45220 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbYI2SxI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 14:53:08 -0400
Received: from spunkymail-a16.g.dreamhost.com (balanced.mail.policyd.dreamhost.com [208.97.132.119])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 7D98717954C
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 11:53:07 -0700 (PDT)
Received: from localhost.localdomain (d14-69-66-169.try.wideopenwest.com [69.14.169.66])
	by spunkymail-a16.g.dreamhost.com (Postfix) with ESMTP id 1D1C37B2B8;
	Mon, 29 Sep 2008 11:51:36 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97047>

currently guilt-pop and guilt-push will exit with '0' if there are no more
relevant patches in the series (ie, if you've pushed or popped all of them)

This means that you cannot do something like:
  while guilt-push; do
    guilt refresh || break
  done

for reference, quilt does exit with non-zero in those cases:
  $ quilt push -a && quilt push
  File series fully applied, ends at patch my.patch
  $ echo $?
  1

  $ quilt pop -a; quilt pop
  No patch removed
  $ echo $?
  2

Signed-off-by: Scott Moser <smoser@brickies.net>
---
 guilt-pop            |    3 +--
 guilt-push           |   43 ++++++++++++++++++++++++-------------------
 regression/t-021.out |    3 +++
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/guilt-pop b/guilt-pop
index db8473e..8a83fdb 100755
--- a/guilt-pop
+++ b/guilt-pop
@@ -45,8 +45,7 @@ patch="$1"
 [ ! -z "$all" ] && patch="-a"
 
 if [ ! -s "$applied" ]; then
-	disp "No patches applied."
-	exit 0
+	die "No patches applied."
 elif [ "$patch" = "-a" ]; then
 	# we are supposed to pop all patches
 
diff --git a/guilt-push b/guilt-push
index 018f9ac..48f886b 100755
--- a/guilt-push
+++ b/guilt-push
@@ -97,22 +97,27 @@ fi
 sidx=`wc -l < $applied`
 sidx=`expr $sidx + 1`
 
-get_series | sed -n -e "${sidx},${eidx}p" | while read p
-do
-	disp "Applying patch..$p"
-	if [ ! -f "$GUILT_DIR/$branch/$p" ]; then
-		die "Patch $p does not exist. Aborting."
-	fi
-
-	push_patch "$p" $abort_flag
-
-	# bail if necessary
-	if [ $? -eq 0 ]; then
-		disp "Patch applied."
-	elif [ -z "$abort_flag" ]; then
-		die "Patch applied with rejects. Fix it up, and refresh."
-	else
-		die "To force apply this patch, use 'guilt push -f'"
-	fi
-done
-
+get_series | sed -n -e "${sidx},${eidx}p" |
+	{
+	did_patch=0
+	while read p
+	do
+		disp "Applying patch..$p"
+		if [ ! -f "$GUILT_DIR/$branch/$p" ]; then
+			die "Patch $p does not exist. Aborting."
+		fi
+
+		push_patch "$p" $abort_flag
+
+		# bail if necessary
+		if [ $? -eq 0 ]; then
+			disp "Patch applied."
+		elif [ -z "$abort_flag" ]; then
+			die "Patch applied with rejects. Fix it up, and refresh."
+		else
+			die "To force apply this patch, use 'guilt push -f'"
+		fi
+		did_patch=1
+	done
+	[ $did_patch -ge 1 ] || die "no patches to apply"
+	}
diff --git a/regression/t-021.out b/regression/t-021.out
index cd8ae96..44771cb 100644
--- a/regression/t-021.out
+++ b/regression/t-021.out
@@ -822,6 +822,7 @@ index 0000000..8baef1b
 @@ -0,0 +1 @@
 +abc
 % guilt-push --all
+no patches to apply
 % guilt-pop -n -1
 Invalid number of patches to pop.
 % list_files
@@ -908,6 +909,7 @@ index 0000000..8baef1b
 @@ -0,0 +1 @@
 +abc
 % guilt-push --all
+no patches to apply
 % guilt-pop -n 0
 No patches requested to be removed.
 % list_files
@@ -994,6 +996,7 @@ index 0000000..8baef1b
 @@ -0,0 +1 @@
 +abc
 % guilt-push --all
+no patches to apply
 % guilt-pop -n 1
 Now at remove.
 % list_files
-- 
1.5.6.3
