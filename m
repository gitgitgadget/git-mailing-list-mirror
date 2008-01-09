From: imyousuf@gmail.com
Subject: [PATCH] - Added recurse command to git submodule
Date: Wed,  9 Jan 2008 11:51:46 +0600
Message-ID: <1199857906-26321-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 06:52:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCTrq-0005nn-G9
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 06:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbYAIFwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 00:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbYAIFwP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 00:52:15 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:46474 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbYAIFwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 00:52:14 -0500
Received: by fg-out-1718.google.com with SMTP id e21so127066fga.17
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 21:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=lbzpXw/ossFPbcN3B/QXrDaqPYeg7vSjRmL2gdcqhUU=;
        b=WqocLBSwloXri5G6daqtjQhIE5aUS40SVhjjMhyP2PpOFGVqROXmfWktcVaJvj+HwCXP35I8nuSCxEIZbJ6XYrDClUYUqd/VvKhuIEJBgJ7FIxnLFY/w9Udm6H8CSONj9hENHq7lAz+zqyF+bvTF4ayTiaLHzz2/el+ualu0LyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MXXRyToe3lNCwKAGiyfAyxIutmHRGYA9YT7g/sQ2kLnlkeAzkiYoTI9VEiZDhZzDA8pO5+xIjgD2RPEbp7XXV/xwURq5pIJERf4tDYlAAX+G/l9vuZu/XVFSSgJA/LeCmXdHIuEnVvgZ9/8RjuZkAA5EXe9SZ5cQtjReRcokUpA=
Received: by 10.86.84.5 with SMTP id h5mr278490fgb.75.1199857932881;
        Tue, 08 Jan 2008 21:52:12 -0800 (PST)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id e11sm387111fga.5.2008.01.08.21.52.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2008 21:52:12 -0800 (PST)
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69954>

From: Imran M Yousuf <imyousuf@smartitengineering.com>


 - The purpose of the recurse command in the git submodule is to recurse
 a command in its submodule at depths specified. For example if one wants
 to do a diff on its project with submodules at once, one can simply do
 git-submodule recurse diff HEAD and would see the diff for all the modules
 it contains. If during recursion it is found that a module has not been
 initialized or updated than the command also initializes and updates them.
 It is to be noted that argument specification to the command intended (in
 above example diff) to recurse will be same as its original command (i.e.
 git diff). If the original command spec changes it will have no effect on
 the recurse command. Depth of recursion can be specified simply by
 mentioning the -d <recursion depth> argument to recurse command. If not
 specified or specified to 0, it will be comprehended to recurse at all
 depth; if a positive number is specified than maximum recursion depth will
 never cross that depth. In order to see some information -v option may be
 used

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |  112 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 111 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8a29382..5cb931e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,7 +4,7 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
+USAGE='[[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]|[recurse [-v] [-d <recursion depth>] <command> <arguments> ...]]'
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -17,6 +17,9 @@ status=
 quiet=
 cached=
 command=
+recurse_verbose=0
+recursion_depth=0
+current_recursion_depth=0
 
 #
 # print stuff on stdout unless -q was specified
@@ -294,6 +297,82 @@ modules_list()
 	done
 }
 
+# Initializes the submodule if already not initialized
+initialize_sub_module() {
+	if [ ! -d "$1"/.git ]; then
+		if [ $recurse_verbose -eq 1 ]; then
+			echo Initializing and updating "$1"
+		fi
+		git-submodule init "$1"; git-submodule update "$1"
+	fi
+}
+
+# This actually traverses the module; checks
+# whether the module is initialized or not.
+# if not initialized, then done so and then the
+# intended command is evaluated. Then it
+# recursively goes into it modules.
+traverse_module() {
+	if [ $recurse_verbose -eq 1 ]; then
+		echo Current recursion depth: "$current_recursion_depth"
+	fi
+	initialize_sub_module "$1"
+	(
+		submod_path="$1"
+		shift
+		cd "$submod_path"
+		if [ $recurse_verbose -eq 1 ]; then
+			echo Working in mod "$submod_path" @ `pwd` with "$@" \("$#"\)
+		fi
+	        git "$@"
+		# Check whether submodules exists only if recursion to that depth
+		# was requested by user
+		if test "$recursion_depth" -eq 0 || test "$current_recursion_depth" -lt "$recursion_depth"
+		then
+			if [ -f .gitmodules ]; then
+		                for mod_path in `sed -n -e 's/path = //p' .gitmodules`; do
+					export current_recursion_depth=$(echo "$current_recursion_depth+1" | bc)
+		                        traverse_module "$mod_path" "$@"
+					export current_recursion_depth=$(echo "$current_recursion_depth-1" | bc)
+		                done
+			fi
+	        fi
+	)
+}
+
+# Propagates or recurses over all the submodules at any
+# depth with any git command, e.g. git-clone, git-status,
+# git-commit etc., with the arguments supplied exactly as
+# it would have been supplied to the command otherwise.
+# This actually starts the recursive propagation
+modules_recurse() {
+	project_home=`pwd`
+	echo Project Home: "$project_home"
+	if [ $recurse_verbose -eq 1 ]; then
+		if [ $recursion_depth = 0 ]; then
+			echo Recursion will go to all depths
+		else
+			echo Recursion depth specified to "$recursion_depth"
+		fi
+	fi
+	if [ -d "$project_home"/.git/ ]; then
+		if [ $recurse_verbose -eq 1 ]; then
+			echo Command to recurse: git "$@"
+		fi
+		git "$@"
+		if [ -f .gitmodules ]; then
+			for mod_path in `sed -n -e 's/path = //p' .gitmodules`; do
+				export current_recursion_depth=1
+				traverse_module $mod_path "$@"
+			done
+		fi
+	else
+		echo "$project_home" not a git repo thus exiting
+		exit
+	fi
+	unset current_recursion_depth
+}
+
 # command specifies the whole function name since 
 # one of theirs prefix is module not modules
 while test $# != 0
@@ -326,6 +405,37 @@ do
 	--cached)
 		command="modules_list"
 		;;
+	recurse)
+		command="modules_$1"
+		repeat=1
+		while test $repeat = 1
+		do
+			case "$2" in
+				-v)
+					recurse_verbose=1
+					shift
+					;;
+				-d)
+					if [ -z $3 ]; then
+						echo No \<recursion depth\> specified
+						usage
+					elif [ `expr "$3" : '[1-9][0-9]*.*'` -eq `expr "$3" : '.*'` ]; then
+						recursion_depth="$3"
+						shift
+						shift
+					else
+						echo \<recursion depth\> not an integer
+						usage
+					fi
+					;;
+				*)
+					repeat=0
+					;;
+			esac
+		done
+		shift
+		break
+		;;
 	--)
 		break
 		;;
-- 
1.5.3.7
