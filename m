From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH 2/5] guilt-guard: Assign guards to patches in series
Date: Mon, 30 Jul 2007 20:11:18 -0700
Message-ID: <1185851481271-git-send-email-eclesh@ucla.edu>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org, Eric Lesh <eclesh@ucla.edu>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Tue Jul 31 05:12:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFi9R-0001t4-K4
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 05:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965575AbXGaDLr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 23:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966453AbXGaDLq
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 23:11:46 -0400
Received: from smtp-6.smtp.ucla.edu ([169.232.48.137]:56255 "EHLO
	smtp-6.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966010AbXGaDLi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 23:11:38 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.158])
	by smtp-6.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BTDR008992;
	Mon, 30 Jul 2007 20:11:30 -0700
Received: from localhost (adsl-75-26-197-236.dsl.scrm01.sbcglobal.net [75.26.197.236])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BSIt029091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 20:11:29 -0700
Received: by localhost (Postfix, from userid 1000)
	id A0DB01E80AB; Mon, 30 Jul 2007 20:11:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <1185851481190-git-send-email-eclesh@ucla.edu>
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.48.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54312>

guilt-guard will assign guards to a patch.  They work so that:

    * Patches with no guards are always pushed.

    * Patches with positive guards (i.e. +foo) are pushed *only if* the
      guard is selected.

    * Patches with negative guards (i.e. -foo) are pushed *unless* the
      guard is selected.

This also introduces a number of guard-related utility functions into
guilt.  get_guarded_series is used to get the list of patches that are
applicable given the current guard status.  It replaces get_series in
a later patch.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 Documentation/guilt-guard.txt |   40 +++++++++++++++++++++++
 guilt                         |   66 +++++++++++++++++++++++++++++++++++++++
 guilt-guard                   |   69 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/guilt-guard.txt
 create mode 100755 guilt-guard

diff --git a/Documentation/guilt-guard.txt b/Documentation/guilt-guard.txt
new file mode 100644
index 0000000..6290bf7
--- /dev/null
+++ b/Documentation/guilt-guard.txt
@@ -0,0 +1,40 @@
+guilt-guard(1)
+===============
+
+NAME
+----
+guilt-guard - Assign guards to patches
+
+SYNOPSIS
+--------
+include::usage-guilt-guard.txt[]
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
index 700c167..6af590c 100755
--- a/guilt
+++ b/guilt
@@ -187,6 +187,72 @@ get_series()
 		" $series
 }
 
+get_guarded_series()
+{
+	get_series | while read p
+	do
+		check_guards "$p" && echo "$p"
+	done
+}
+
+# usage: check_guards <patch>
+# Returns 0 if the patch should be pushed
+check_guards()
+{
+	get_guards "$1" | while read guard
+	do
+		pos=`printf %s $guard | grep -e "^+"`
+		guard=`printf %s $guard | sed -e 's/^[+-]//'`
+		if [ "$pos" ]; then
+			# Push +guard *only if* guard selected
+			push=`grep -e "^$guard\$" "$guards_file" >/dev/null 2>/dev/null; echo $?`
+			[ $push -ne 0 ] && return 1
+		else
+			# Push -guard *unless* guard selected
+			push=`grep -e "^$guard\$" "$guards_file" >/dev/null 2>/dev/null; echo $?`
+			[ $push -eq 0 ] && return 1
+		fi
+		return 0
+	done
+	return $?
+}
+
+# usage: get_guards <patch>
+get_guards()
+{
+	sed -n -e "\,^$1[[:space:]]*#, {
+		s,^$1[[:space:]]*,,
+		s,#[^+-]*,,g
+
+		p
+		}
+		" $series
+}
+
+# usage: set_guards <patch> <guards...>
+set_guards()
+{
+	p="$1"
+	shift
+	for x in "$@"; do
+		if [ -z $(printf %s "$x" | grep -e "^[+-]") ]; then
+			echo "'$x' is not a valid guard name"
+		else
+			sed -i -e "s,^\($p[[:space:]]*.*\)$,\1 #$x," "$series"
+		fi
+	done
+}
+
+# usage: unset_guards <patch> <guards...>
+unset_guards()
+{
+	p="$1"
+	shift
+	for x in "$@"; do
+		sed -i -e "/^$p[[:space:]]/s/ #$x//" "$series"
+	done
+}
+
 # usage: do_make_header <hash>
 do_make_header()
 {
diff --git a/guilt-guard b/guilt-guard
new file mode 100755
index 0000000..a0cac2e
--- /dev/null
+++ b/guilt-guard
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (c) Eric Lesh, 2007
+#
+
+USAGE="[-l|--list|-n|--none|[<patchname>] [(+|-)<guard>...]]"
+. `dirname $0`/guilt
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
+		if [ -z $(printf %s "$1" | grep -e '^[+-]') ]; then
+			if [ -z $(get_series | grep -e "^$1\$") ]; then
+				die "Patch $1 does not exist."
+			else
+				print_guards "$1"
+			fi
+		else
+			patch=`get_top`
+			if [ -z "$patch" ]; then
+				die "You must specify a patch."
+			fi
+			unset_guards "$patch" `get_guards "$patch"`
+			set_guards "$patch" "$1"
+		fi
+		;;
+	*)
+		if [ -z $(printf %s "$1" | grep -e '^[+-]') ]; then
+			if [ -z $(get_series | grep -e "^$1\$") ]; then
+				die "Patch $1 does not exist."
+			else
+				patch="$1"
+			fi
+			shift
+		else
+			patch=`get_top`
+			if [ -z "$patch" ]; then
+				die "You must specify a patch."
+			fi
+		fi
+		unset_guards "$patch" `get_guards "$patch"`
+		set_guards "$patch" "$@"
+		;;
+esac
-- 
1.5.2
