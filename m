From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH 3/5] guilt-select: Select guards to apply when pushing patches
Date: Mon, 30 Jul 2007 20:11:19 -0700
Message-ID: <11858514811245-git-send-email-eclesh@ucla.edu>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org, Eric Lesh <eclesh@ucla.edu>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Tue Jul 31 05:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFi9Q-0001t4-0i
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 05:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966311AbXGaDLm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 23:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965575AbXGaDLl
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 23:11:41 -0400
Received: from smtp-1.smtp.ucla.edu ([169.232.46.136]:41234 "EHLO
	smtp-1.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762032AbXGaDLg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 23:11:36 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.158])
	by smtp-1.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BT0l007064;
	Mon, 30 Jul 2007 20:11:29 -0700
Received: from localhost (adsl-75-26-197-236.dsl.scrm01.sbcglobal.net [75.26.197.236])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BSkW029090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 20:11:29 -0700
Received: by localhost (Postfix, from userid 1000)
	id A4B6D1E80AC; Mon, 30 Jul 2007 20:11:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <1185851481190-git-send-email-eclesh@ucla.edu>
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.46.136
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54311>

guilt-select chooses guards that alter which patches will be applied
with a guilt-push.  The selected guards are stored in
.git/patches/$branch/guards.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 Documentation/guilt-select.txt |   47 ++++++++++++++++++++++++++++++++++++
 Documentation/guilt.txt        |    5 +++-
 guilt                          |    1 +
 guilt-select                   |   52 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/guilt-select.txt
 create mode 100755 guilt-select

diff --git a/Documentation/guilt-select.txt b/Documentation/guilt-select.txt
new file mode 100644
index 0000000..12f19b4
--- /dev/null
+++ b/Documentation/guilt-select.txt
@@ -0,0 +1,47 @@
+guilt-select(1)
+===============
+
+NAME
+----
+guilt-select - Select guards to apply when pushing patches
+
+SYNOPSIS
+--------
+include::usage-guilt-select.txt[]
+
+DESCRIPTION
+-----------
+Select guards to apply when pushing patches.
+
+Guards are selected without the + or - prefix.  Patches are applied in
+the following way:
+
+* An unguarded patch is always applied.
+
+* A patch with a positive guard is applied *only* if the guard is
+selected with guilt-select.
+
+* A patch with a negative guard is applied *unless* the guard is
+selected with guilt-select.
+
+OPTIONS
+-------
+-n|--none::
+        Remove all selected guards
+--pop::
+        Pop back to the first guarded patch
+--reapply::
+        Pop back to first guarded patch, select a new guard, and
+        push
+-s|--series::
+        List all guards listed in the series file
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
diff --git a/Documentation/guilt.txt b/Documentation/guilt.txt
index 31dbc0e..11c2ca9 100644
--- a/Documentation/guilt.txt
+++ b/Documentation/guilt.txt
@@ -33,7 +33,10 @@ PATCHES DIRECTORY
 In Guilt, all the patches are stored in .git/patches/$branch/, where $branch
 is the name of the branch being worked on. This means that one can have a
 independent series of patches for each branch present in the repository.
-Each of these per-branch directories contains 2 special files:
+Each of these per-branch directories contains 3 special files:
+
+guards: This file contains any guards that should be applied to the
+series when pushing. It is only present when guards are selected.
 
 series: This file contains a list of all the patch filenames relative to the
 per-branch patch directory. Empty and commented out lines are ignored.
diff --git a/guilt b/guilt
index 6af590c..b289026 100755
--- a/guilt
+++ b/guilt
@@ -666,6 +666,7 @@ fi
 # very useful files
 series="$GUILT_DIR/$branch/series"
 applied="$GUILT_DIR/$branch/status"
+guards_file="$GUILT_DIR/$branch/guards"
 
 # determine an editor to use for anything interactive (fall back to vi)
 editor="vi"
diff --git a/guilt-select b/guilt-select
new file mode 100755
index 0000000..378ca98
--- /dev/null
+++ b/guilt-select
@@ -0,0 +1,52 @@
+#!/bin/sh
+#
+# Copyright (c) Eric Lesh, 2007
+#
+
+USAGE="[-n|--none|-s|--series|[--pop|--reapply] <guards...>]"
+. `dirname $0`/guilt
+
+select_guards()
+{
+	for x in "$@"; do
+		if [ $(printf %s "$x" | grep -e "^[+-]") ]; then
+			die "'$x' cannot begin with + or -."
+		fi
+	done
+	echo "$@" | sed -e 's/ /\n/g' | sort | uniq > "$guards_file"
+}
+
+if [ $# == 0 ]; then
+	if [ -s "$guards_file" ]; then
+		cat "$guards_file"
+	else
+		echo >&2 "No guards applied"
+	fi
+	exit 0
+fi
+
+case $1 in
+	-n|--none)
+		rm -f "$guards_file"
+		;;
+	--pop)
+		guilt-pop -a
+		shift
+		select_guards "$@"
+		;;
+	--reapply)
+		top=`get_top`
+		guilt-pop -a
+		shift
+		select_guards "$@"
+		guilt-push "$top"
+		;;
+	-s|--series)
+		(get_series | while read patch; do
+			get_guards "$patch"
+		done) | sed -e 's/ /\n/g' | sort | uniq
+		;;
+	*)
+		select_guards "$@"
+		;;
+esac
-- 
1.5.2
