From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH 4/5] get_series: return guarded patches only
Date: Mon, 30 Jul 2007 20:11:20 -0700
Message-ID: <11858514813702-git-send-email-eclesh@ucla.edu>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org, Eric Lesh <eclesh@ucla.edu>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Tue Jul 31 05:11:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFi97-0001pK-QV
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 05:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966280AbXGaDLj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 23:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965575AbXGaDLi
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 23:11:38 -0400
Received: from smtp-6.smtp.ucla.edu ([169.232.48.137]:33766 "EHLO
	smtp-6.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760920AbXGaDLg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 23:11:36 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.150])
	by smtp-6.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BT8K008990;
	Mon, 30 Jul 2007 20:11:29 -0700
Received: from localhost (adsl-75-26-197-236.dsl.scrm01.sbcglobal.net [75.26.197.236])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BSk8013434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 20:11:29 -0700
Received: by localhost (Postfix, from userid 1000)
	id AB3AB1E80AD; Mon, 30 Jul 2007 20:11:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <1185851481190-git-send-email-eclesh@ucla.edu>
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.48.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54310>

This renames get_guarded_series to get_series, and introduces
get_full_series for when the full series is needed.  Many guilt
scripts Just Work with that change.  Those that don't are fixed up.

With this patch, guards are respected everywhere in guilt.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 guilt        |    6 +++---
 guilt-export |    2 +-
 guilt-guard  |    6 +++---
 guilt-header |    4 ++--
 guilt-push   |    4 ++--
 guilt-select |    2 +-
 guilt-series |    6 ++++--
 7 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/guilt b/guilt
index b289026..d618980 100755
--- a/guilt
+++ b/guilt
@@ -171,7 +171,7 @@ get_prev()
 	fi
 }
 
-get_series()
+get_full_series()
 {
 	# ignore all lines matching:
 	#	- empty lines
@@ -187,9 +187,9 @@ get_series()
 		" $series
 }
 
-get_guarded_series()
+get_series()
 {
-	get_series | while read p
+	get_full_series | while read p
 	do
 		check_guards "$p" && echo "$p"
 	done
diff --git a/guilt-export b/guilt-export
index 2c0a9fd..c872d7f 100755
--- a/guilt-export
+++ b/guilt-export
@@ -18,7 +18,7 @@ fi
 trap "rm -rf \"$target_dir\"" 0
 mkdir -p "$target_dir"
 
-get_series | tee "$target_dir/series" | while read p; do
+get_full_series | tee "$target_dir/series" | while read p; do
 	silent mkdir -p "`dirname $target_dir/$p`" || true
 	cp "$GUILT_DIR/$branch/$p" "$target_dir/$p"
 done
diff --git a/guilt-guard b/guilt-guard
index a0cac2e..a427e25 100755
--- a/guilt-guard
+++ b/guilt-guard
@@ -13,7 +13,7 @@ print_guards()
 }
 
 if [ "$1" == "-l" ] || [ "$1" == "--list" ]; then
-	get_series | while read patch; do
+	get_full_series | while read patch; do
 		print_guards "$patch"
 	done
 	exit 0
@@ -35,7 +35,7 @@ case $# in
 		;;
 	1)
 		if [ -z $(printf %s "$1" | grep -e '^[+-]') ]; then
-			if [ -z $(get_series | grep -e "^$1\$") ]; then
+			if [ -z $(get_full_series | grep -e "^$1\$") ]; then
 				die "Patch $1 does not exist."
 			else
 				print_guards "$1"
@@ -51,7 +51,7 @@ case $# in
 		;;
 	*)
 		if [ -z $(printf %s "$1" | grep -e '^[+-]') ]; then
-			if [ -z $(get_series | grep -e "^$1\$") ]; then
+			if [ -z $(get_full_series | grep -e "^$1\$") ]; then
 				die "Patch $1 does not exist."
 			else
 				patch="$1"
diff --git a/guilt-header b/guilt-header
index 5716265..540cf2a 100755
--- a/guilt-header
+++ b/guilt-header
@@ -31,8 +31,8 @@ esac
 [ -z "$patch" ] && die "No patches applied."
 
 # check that patch exists in the series
-ret=`get_series | grep -ne "^$patch\$" | cut -d: -f1`
-if [ $ret -eq 0 ]; then
+ret=`get_full_series | grep -ne "^$patch\$" | cut -d: -f1`
+if [ -z "$ret" ]; then
 	die "Patch $patch is not in the series"
 fi
 
diff --git a/guilt-push b/guilt-push
index ad3616b..e4004e0 100755
--- a/guilt-push
+++ b/guilt-push
@@ -26,7 +26,7 @@ if [ "$patch" = "--all" ] || [ "$patch" = "-a" ]; then
 
 	eidx=`get_series | wc -l`
 	if [ $eidx -eq 0 ]; then
-		die "There are no patches to push"
+		die "There are no patches to push."
 	fi
 elif [ -z "$patch" ]; then
 	# we are supposed to push only the next patch onto the stack
@@ -39,7 +39,7 @@ else
 
 	eidx=`get_series | grep -ne "^$patch\$" | cut -d: -f1`
 	if [ -z "$eidx" ]; then
-		die "Patch $patch is not in the series"
+		die "Patch $patch is not in the series or is guarded."
 	fi
 fi
 
diff --git a/guilt-select b/guilt-select
index 378ca98..57373c7 100755
--- a/guilt-select
+++ b/guilt-select
@@ -42,7 +42,7 @@ case $1 in
 		guilt-push "$top"
 		;;
 	-s|--series)
-		(get_series | while read patch; do
+		(get_full_series | while read patch; do
 			get_guards "$patch"
 		done) | sed -e 's/ /\n/g' | sort | uniq
 		;;
diff --git a/guilt-series b/guilt-series
index 9c34a08..85ef15d 100755
--- a/guilt-series
+++ b/guilt-series
@@ -36,12 +36,12 @@ elif [ ! -z "$gui" ]; then
 
 	gitk $range
 elif [ -z "$verbose" ]; then
-	get_series
+	get_full_series
 else
 	prefix="+"
 	top=`get_top`
 
-	get_series |
+	get_full_series |
 	while read patch; do
 		if [ -z "$top" ]; then
 			echo "  $patch"
@@ -49,6 +49,8 @@ else
 			if [ "$patch" = "$top" ]; then
 				echo "= $patch"
 				prefix=" "
+                        elif [ $(check_guards "$patch"; echo $?) -eq 1 ]; then
+				echo "  $patch"
 			else
 				echo "$prefix $patch"
 			fi
-- 
1.5.2
