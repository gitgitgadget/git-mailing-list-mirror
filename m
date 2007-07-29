From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH 2/4] guilt-guard: Assign guards to patches in series
Date: Sun, 29 Jul 2007 00:50:16 -0700
Message-ID: <11856954181497-git-send-email-eclesh@ucla.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org, Eric Lesh <eclesh@ucla.edu>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Sun Jul 29 09:50:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF3Xy-000795-0E
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 09:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760105AbXG2Hug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 03:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760032AbXG2Huf
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 03:50:35 -0400
Received: from smtp-6.smtp.ucla.edu ([169.232.48.137]:50648 "EHLO
	smtp-6.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760059AbXG2Hua (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 03:50:30 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.47.145])
	by smtp-6.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6T7oNaw010262;
	Sun, 29 Jul 2007 00:50:23 -0700
Received: from localhost (adsl-75-26-192-134.dsl.scrm01.sbcglobal.net [75.26.192.134])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6T7oMio002265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jul 2007 00:50:23 -0700
Received: by localhost (Postfix, from userid 1000)
	id A50DA1E80A9; Sun, 29 Jul 2007 00:50:18 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <118569541814-git-send-email-eclesh@ucla.edu>
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.48.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54091>

guilt-guard will assign guards to a patch.  They work so that:

    * Patches with no guards are always pushed.

    * Patches with positive guards (i.e. +foo) are pushed *only if* the
      guard is selected.

    * Patches with negative guards (i.e. -foo) are pushed *unless* the
      guard is selected.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 Documentation/guilt-guards.txt |   40 +++++++++++++++++++++++++
 guilt                          |   58 ++++++++++++++++++++++++++++++++++++
 guilt-guards                   |   63 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/guilt-guards.txt
 create mode 100755 guilt-guards

diff --git a/Documentation/guilt-guards.txt b/Documentation/guilt-guards.txt
new file mode 100644
index 0000000..f5ac537
--- /dev/null
+++ b/Documentation/guilt-guards.txt
@@ -0,0 +1,40 @@
+guilt-guards(1)
+===============
+
+NAME
+----
+guilt-guards - Assign guards to patches
+
+SYNOPSIS
+--------
+include::usage-guilt-guards.txt[]
+
+DESCRIPTION
+-----------
+Assign guards to the specified patch, or to the patch on top of the
+stack if no patch is given on the command line.
+
+An unguarded patch is always pushed.
+
+A positive guard begins with a +. A patch with a positive guard is
+pushed *only if* the guard is selected.
+
+A negative guard begins with a -. A patch with a negative guard is
+always pushed, *unless* the guard is selected.
+
+OPTIONS
+-------
+-l|--list::
+        List all patches and their guards
+-n|--none::
+        Remove all guards from a patch
+
+Author
+------
+Written by Eric Lesh <eclesh@ucla.edu>
+
+Documentation
+-------------
+Documentation by Eric Lesh <eclesh@ucla.edu>
+
+include::footer.txt[]
diff --git a/guilt b/guilt
index 774909e..b2767ea 100755
--- a/guilt
+++ b/guilt
@@ -182,6 +182,64 @@ get_series()
 	grep -ve '^[[:space:]]*\(#.*\)*$' < "$series" | sed -e 's/[[:space:]]*#.*$//'
 }
 
+get_guarded_series()
+{
+	get_series | while read p
+	do
+		[ -z `check_guards $p` ] && echo "$p"
+	done
+}
+
+# usage: check_guards <patch>
+# Returns t if the patch should be skipped
+check_guards()
+{
+        get_guards "$1" | while read guard
+        do
+                pos=`echo $guard | grep -e "^+"`
+                guard=`echo $guard | sed -e 's/[+-]//'`
+                if [ $pos ]; then
+                        # Push +guard *only if* guard selected
+                        push=`grep -e "^$guard\$" "$guards_file" > /dev/null; echo $?`
+                        [ $push -ne 0 ] && echo t
+                else
+                        # Push -guard *unless* guard selected
+                        push=`grep -e "^$guard\$" "$guards_file" > /dev/null; echo $?`
+                        [ $push -eq 0 ] && echo t
+                fi
+        done
+}
+
+# usage: get_guards <patch>
+get_guards()
+{
+	grep -e "^$1[[:space:]]*#" < "$series" | sed -e "s/^$1 //" -e 's/#[^+-]*//g'
+}
+
+# usage: set_guards <patch> <guards>
+set_guards()
+{
+	p="$1"
+	shift
+	for x in "$@"; do
+		if [ -z $(echo "$x" | grep -e "^[+-]") ]; then
+			echo "'$x' is not a valid guard name"
+		else
+			sed -i -e "s/^\($p[[:space:]]*.*\)$/\1 #$x/" "$series"
+		fi
+	done
+}
+
+# usage: unset_guards <patch> <guards>
+unset_guards()
+{
+        p="$1"
+        shift
+        for x in "$@"; do
+            sed -i -e "/^$p[[:space:]]/s/ #$x//" "$series"
+        done
+}
+
 # usage: do_make_header <hash>
 do_make_header()
 {
diff --git a/guilt-guards b/guilt-guards
new file mode 100755
index 0000000..71df4f8
--- /dev/null
+++ b/guilt-guards
@@ -0,0 +1,63 @@
+#!/bin/sh
+#
+# Copyright (c) Eric Lesh, 2007
+#
+
+USAGE="[-l|--list] [-n|--none] [<patchname>] [+<guard>] [-<guard>]"
+. guilt
+
+print_guards()
+{
+	guards=`get_guards "$1"`
+	echo "$1: $guards"
+}
+
+if [ "$1" == "-l" ] || [ "$1" == "--list" ]; then
+	get_series | while read patch; do
+		print_guards "$patch"
+	done
+	exit 0
+elif [ "$1" == "-n" ] || [ "$1" == "--none" ]; then
+	patch="$2"
+	if [ -z "$patch" ]; then
+		patch=`get_top`
+	fi
+	unset_guards "$patch" `get_guards "$patch"`
+	exit 0
+fi
+
+case $# in
+	0)
+		if [ ! -s "$applied" ]; then
+			die "No patches applied."
+		fi
+		print_guards `get_top`
+		;;
+	1)
+		if [ -z $(echo $1 | grep -e '^[+-]') ]; then
+			if [ -z $(get_series | grep -e "^$1\$") ]; then
+				die "Patch $1 does not exist"
+			else
+				print_guards "$1"
+			fi
+		else
+			p=`get_top`
+			unset_guards "$p" `get_guards "$p"`
+			set_guards "$p" "$1"
+		fi
+		;;
+	*)
+		if [ -z $(echo $1 | grep -e '^[+-]') ]; then
+			if [ -z $(get_series | grep -e "^$1\$") ]; then
+				die "Patch $1 does not exist"
+			else
+				patch="$1"
+			fi
+			shift
+		else
+			patch=`get_top`
+		fi
+		unset_guards "$patch" `get_guards "$patch"`
+		set_guards "$patch" "$@"
+		;;
+esac
-- 
1.5.2
